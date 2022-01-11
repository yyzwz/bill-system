<template>
  <div class="login">
    <Row
      type="flex"
      justify="center"
      align="middle"
      @keydown.enter.native="submitLogin"
      style="height:100%"
    >
      <Col class="layout">
        <div>
          <Header />
          <Row v-if="!socialLogining">
            <Tabs v-model="tabName">
              <TabPane label="账号密码登录" name="username" icon="md-person">
                <Form
                  ref="usernameLoginForm"
                  :model="form"
                  :rules="rules"
                  class="form"
                  v-if="tabName=='username'"
                >
                  <FormItem prop="username">
                    <Input
                      v-model="form.username"
                      prefix="ios-contact"
                      size="large"
                      clearable
                      placeholder="请输入您的工号"
                      autocomplete="off"
                    />
                  </FormItem>
                  <FormItem prop="password">
                    <Input
                      type="password"
                      v-model="form.password"
                      prefix="ios-lock"
                      size="large"
                      password
                      placeholder="请输入您的密码"
                      autocomplete="off"
                    />
                  </FormItem>
                  <FormItem prop="imgCode">
                    <Row
                      type="flex"
                      justify="space-between"
                      style="align-items: center;overflow: hidden;"
                    >
                      <Input
                        v-model="form.imgCode"
                        size="large"
                        clearable
                        placeholder="请输入右侧的验证码"
                        :maxlength="10"
                        class="input-verify"
                      />
                      <div class="code-image" style="position:relative;font-size:12px">
                        <Spin v-if="loadingCaptcha" fix></Spin>
                        <img
                          :src="captchaImg"
                          @click="getCaptchaImg"
                          alt="加载验证码失败"
                          style="width:110px;cursor:pointer;display:block"
                        />
                      </div>
                    </Row>
                  </FormItem>
                </Form>
              </TabPane>
              <TabPane label="手机号登录" name="mobile" icon="ios-phone-portrait">
                <Form
                  ref="mobileLoginForm"
                  :model="form"
                  :rules="rules"
                  class="form"
                  v-if="tabName=='mobile'"
                >
                  <FormItem prop="mobile">
                    <Input
                      v-model="form.mobile"
                      prefix="ios-phone-portrait"
                      size="large"
                      clearable
                      placeholder="请输入手机号"
                    />
                  </FormItem>
                  <FormItem prop="code" :error="errorCode">
                    <Row type="flex" justify="space-between">
                      <Input
                        v-model="form.code"
                        prefix="ios-mail-outline"
                        size="large"
                        clearable
                        placeholder="请输入短信验证码"
                        :maxlength="6"
                        class="input-verify"
                      />
                      <CountDownButton
                        ref="countDown"
                        @on-click="sendSmsCode"
                        :autoCountDown="false"
                        size="large"
                        :loading="sending"
                        :text="getSms"
                      />
                    </Row>
                  </FormItem>
                </Form>
              </TabPane>
            </Tabs>

            <Row type="flex" justify="space-between" align="middle">
              <Checkbox v-model="saveLogin" size="large">自动登录</Checkbox>
            </Row>
            <Row>
              <Button
                class="login-btn"
                type="primary"
                size="large"
                :loading="loading"
                @click="submitLogin"
                long
              >
                <span v-if="!loading">登录</span>
                <span v-else>正在登录</span>
              </Button>
            </Row>
          </Row>
          <div v-if="socialLogining">
            <RectLoading />
          </div>
        </div>
        <Footer />
      </Col>
      <LangSwitch />
    </Row>
  </div>
</template>

<script>
import {
  login,
  userInfo,
  sendLoginTxSms,
  sendLoginInTxSms,
  initCaptcha,
  drawCodeImage,
} from "@/api/index";
import { validateMobile } from "@/libs/validate";
import Cookies from "js-cookie";
import Header from "@/views/main-components/header";
import Footer from "@/views/main-components/footer";
import LangSwitch from "@/views/main-components/lang-switch";
import RectLoading from "@/views/my-components/zwz/rect-loading";
import CountDownButton from "@/views/my-components/zwz/count-down-button";
import util from "@/libs/util.js";
export default {
  components: {
    CountDownButton,
    RectLoading,
    LangSwitch,
    Header,
    Footer
  },
  data() {
    return {
      captchaId: "",
      captchaImg: "",
      loadingCaptcha: true,
      socialLogining: true,
      error: false,
      tabName: "username",
      saveLogin: true,
      getSms: "获取验证码",
      loading: false,
      sending: false,
      errorCode: "",
      form: {
        username: "admin",
        password: "123456",
        mobile: "17857054385",
        code: ""
      },
      rules: {
        username: [
          {
            required: true,
            message: "账号不能为空",
            trigger: "blur"
          }
        ],
        password: [
          {
            required: true,
            message: "密码不能为空",
            trigger: "blur"
          }
        ],
        imgCode: [
          {
            required: true,
            message: "验证码不能为空",
            trigger: "blur"
          }
        ],
        mobile: [
          {
            required: true,
            message: "手机号不能为空",
            trigger: "blur"
          },
          {
            validator: validateMobile,
            trigger: "blur"
          }
        ]
      }
    };
  },
  methods: {
    // 获取图片验证码
    getCaptchaImg() {
      this.loadingCaptcha = true;
      initCaptcha().then(res => {
        this.loadingCaptcha = false;
        if (res.success) {
          this.captchaId = res.result;
          this.captchaImg = drawCodeImage + this.captchaId;
        }
      });
    },
    // 获取手机验证码
    sendSmsCode() {
      var that = this;
      that.$refs.mobileLoginForm.validate(valid => {
        if (valid) {
          that.sending = true;
          that.getSms = "发送中";
          sendLoginTxSms({mobile:that.form.mobile}).then(res => {
            that.getSms = "获取验证码";
            that.sending = false;
            if (res.success) {
              that.$Message.success("发送短信验证码成功");
              // 开始倒计时
              that.$refs.countDown.startCountDown();
            }
          });
        }
      });
    },
    // 登入后保存用户信息到Cookies
    afterLogin(res) {
      let accessToken = res.result;
      this.setStore("accessToken", accessToken);
      Cookies.set("accessToken", accessToken);
      userInfo().then(res => {
        if (res.success) {
          delete res.result.permissions;
          let roles = [];
          res.result.roles.forEach(e => {
            roles.push(e.name);
          });
          this.setStore("roles", roles);
          this.setStore("saveLogin", this.saveLogin);
          if (this.saveLogin) {
            Cookies.set("userInfo", JSON.stringify(res.result), {
              expires: 7 // 保存7天
            });
          } else {
            Cookies.set("userInfo", JSON.stringify(res.result));
          }
          this.setStore("userInfo", res.result);
          this.$store.commit("setAvatarPath", res.result.avatar);
          // 加载菜单
          util.initRouter(this);
          this.$router.push({
            name: "home_index"
          });
        } else {
          this.loading = false;
        }
      });
    },
    // 登陆按钮事件
    submitLogin() {
      var that = this;
      // 密码登入
      if (this.tabName == "username") {
        this.$refs.usernameLoginForm.validate(valid => {
          if (valid) {
            this.loading = true;
            login({
              username: this.form.username,
              password: this.form.password,
              code: this.form.imgCode,
              captchaId: this.captchaId,
              saveLogin: this.saveLogin
            }).then(res => {
              if (res.success) {
                this.afterLogin(res);
              } else {
                this.loading = false;
                this.getCaptchaImg();
              }
            });
          }
        });
      }
      // 手机号登入
      else if (this.tabName == "mobile") {
        this.$refs.mobileLoginForm.validate(valid => {
          if (valid) {
            if (this.form.code == "") {
              this.errorCode = "验证码不能为空";
              return;
            } else {
              this.errorCode = "";
            }
            this.loading = true;
            this.form.saveLogin = this.saveLogin;
            sendLoginInTxSms({mobile:this.form.mobile,code:this.form.code}).then(res => {
              if (res.result) {
                that.afterLogin(res);
              } else {
                that.$Message.error("验证码错误");
                that.loading = false;
              }
            });
          }
        });
      }
    }
  },
  mounted() {
    this.socialLogining = false;
    this.getCaptchaImg();
  }
};
</script>

<style lang="less">
@import "./login.less";
</style>
