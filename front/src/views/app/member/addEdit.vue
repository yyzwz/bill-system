<template>
  <div class="user-edit">
    <!-- Drawer抽屉 -->
    <Drawer :title="title" v-model="visible" width="720" draggable :mask-closable="type=='0'">
      <div :style="{maxHeight: maxHeight}" class="drawer-content">
        <div class="user-title">
          <div class="info-title">基本信息</div>
          <Avatar :src="form.avatar" size="large" v-show="type!='2'" />
        </div>
        <Form label-colon v-show="type!='2'">
          <Row :gutter="32">
            <Col span="12">
              <FormItem label="用户名/UID">
                {{form.username}}
                <Tooltip trigger="hover" placement="right" content="账户已禁用">
                  <Icon
                    v-show="form.status==-1"
                    type="md-lock"
                    size="18"
                    style="margin-left:10px;cursor:pointer"
                  />
                </Tooltip>
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="邀请码">{{form.inviteCode}}</FormItem>
            </Col>
          </Row>
        </Form>
        <Form ref="form" :model="form" :rules="formValidate" label-position="top">
          <Row :gutter="32">
            <Col span="12">
              <FormItem label="昵称" prop="nickname">
                <Input v-model="form.nickname" />
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="手机号" prop="mobile">
                <Input v-model="form.mobile" />
              </FormItem>
            </Col>
          </Row>
          <Row :gutter="32">
            <Col span="12">
              <FormItem label="邮箱" prop="email">
                <Input v-model="form.email" />
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="性别">
                <Select v-model="form.sex">
                  <Option value="男">男</Option>
                  <Option value="女">女</Option>
                </Select>
              </FormItem>
            </Col>
          </Row>
          <Row :gutter="32">
            <Col span="12">
              <FormItem label="头像">
                <upload-pic-input v-model="form.avatar"></upload-pic-input>
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="生日">
                <DatePicker
                  v-model="form.birth"
                  @on-change="changeBirth"
                  style="display: block"
                  type="date"
                ></DatePicker>
              </FormItem>
            </Col>
          </Row>
          <Row :gutter="32">
            <Col span="12">
              <FormItem label="地区">
                <Input v-model="form.address" />
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="定位">
                <Input v-model="form.position" />
              </FormItem>
            </Col>
          </Row>
          <Row :gutter="32">
            <Col span="12">
              <FormItem label="积分">
                <InputNumber :min="0" v-model="form.grade" style="width: 100%"></InputNumber>
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="个人简介">
                <Input v-model="form.description" />
              </FormItem>
            </Col>
          </Row>
          <Divider />
          <p class="info-header">VIP信息</p>
          <Row :gutter="32">
            <Col span="12">
              <FormItem label="用户类型">
                <Select v-model="form.type" transfer placeholder="请选择">
                  <Option :value="0">普通会员</Option>
                  <Option :value="1">VIP</Option>
                </Select>
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="VIP状态">
                <Select v-model="form.vipStatus" transfer placeholder="请选择">
                  <Option :value="0">未开通</Option>
                  <Option :value="1">已开通</Option>
                  <Option :value="2">已过期</Option>
                </Select>
              </FormItem>
            </Col>
          </Row>
          <Row :gutter="32">
            <Col span="12">
              <FormItem label="VIP开通时间">
                <DatePicker
                  v-model="form.vipStartTime"
                  @on-change="changeVipStartTime"
                  style="display: block"
                  type="datetime"
                ></DatePicker>
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="VIP到期时间">
                <DatePicker
                  v-model="form.vipEndTime"
                  @on-change="changeVipEndTime"
                  style="display: block"
                  type="datetime"
                ></DatePicker>
              </FormItem>
            </Col>
          </Row>
          <Divider />
          <p class="info-header">其他信息</p>
          <Row :gutter="32">
            <Col span="12">
              <FormItem label="角色权限（可直接输入回车添加）">
                <Select
                  v-model="permissions"
                  multiple
                  filterable
                  allow-create
                  @on-create="handleCreate"
                  transfer
                  placeholder="请选择或输入添加"
                >
                  <Option v-for="(item, i) in permissionList" :value="item" :key="i">{{ item }}</Option>
                </Select>
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="注册平台">
                <Select v-model="form.platform" transfer placeholder="请选择">
                  <Option :value="0">PC/H5</Option>
                  <Option :value="1">Android</Option>
                  <Option :value="2">IOS</Option>
                  <Option :value="3">微信小程序</Option>
                  <Option :value="4">支付宝小程序</Option>
                  <Option :value="5">QQ小程序</Option>
                  <Option :value="6">字节小程序</Option>
                  <Option :value="7">百度小程序</Option>
                  <Option :value="-1">未知</Option>
                </Select>
              </FormItem>
            </Col>
          </Row>
        </Form>
        <div style="height: 50px"></div>
      </div>
      <div class="drawer-footer br" v-show="type!='0'">
        <Button type="primary" :loading="submitLoading" @click="submit">提交</Button>
        <Button @click="visible = false">取消</Button>
      </div>
    </Drawer>
  </div>
</template>

<script>
import { addMember, editMember } from "@/api/app";
import { validateMobile, validatePassword } from "@/libs/validate";
import uploadPicInput from "@/views/my-components/xboot/upload-pic-input";
import SetPassword from "@/views/my-components/xboot/set-password";
export default {
  name: "user",
  components: {
    uploadPicInput,
    SetPassword
  },
  props: {
    value: {
      type: Boolean,
      default: false
    },
    data: {
      type: Object
    },
    type: {
      type: String,
      default: "0"
    }
  },
  data() {
    return {
      permissions: [],
      permissionList: [],
      visible: this.value,
      title: "",
      submitLoading: false,
      maxHeight: 510,
      form: {},
      formValidate: {
        // 表单验证规则
        nickname: [{ required: true, message: "请输入昵称", trigger: "blur" }],
        mobile: [
          { required: true, message: "请输入手机号", trigger: "blur" },
          { validator: validateMobile, trigger: "blur" }
        ],
        password: [
          { required: true, message: "请输入密码", trigger: "blur" },
          { validator: validatePassword, trigger: "blur" }
        ],
        email: [{ type: "email", message: "邮箱格式不正确" }]
      }
    };
  },
  methods: {
    init() {},
    changeBirth(v, d) {
      this.form.birth = v;
    },
    changeVipStartTime(v, d) {
      this.form.vipStartTime = v;
    },
    changeVipEndTime(v, d) {
      this.form.vipEndTime = v;
    },
    handleCreatev(v) {
      this.permissionList.push({
        v
      });
    },
    submit() {
      this.$refs.form.validate(valid => {
        if (valid) {
          this.form.permissions = this.permissions.join(",");
          if (typeof this.form.birth == "object") {
            this.form.birth = this.format(this.form.birth, "yyyy-MM-dd");
          }
          if (typeof this.form.vipStartTime == "object") {
            this.form.vipStartTime = this.format(
              this.form.vipStartTime,
              "yyyy-MM-dd HH:mm:ss"
            );
          }
          if (typeof this.form.vipEndTime == "object") {
            this.form.vipEndTime = this.format(
              this.form.vipEndTime,
              "yyyy-MM-dd HH:mm:ss"
            );
          }
          if (this.type == "1") {
            // 编辑
            this.submitLoading = true;
            editMember(this.form).then(res => {
              this.submitLoading = false;
              if (res.success) {
                this.$Message.success("操作成功");
                this.$emit("on-submit", true);
                this.visible = false;
              }
            });
          } else {
            // 添加
            this.submitLoading = true;
            addMember(this.form).then(res => {
              this.submitLoading = false;
              if (res.success) {
                this.$Message.success("操作成功");
                this.$emit("on-submit", true);
                this.visible = false;
              }
            });
          }
        }
      });
    },
    setCurrentValue(value) {
      if (value === this.visible) {
        return;
      }
      if (this.type == "1") {
        this.title = "编辑会员";
        this.maxHeight =
          Number(document.documentElement.clientHeight - 121) + "px";
      } else if (this.type == "2") {
        this.title = "添加会员";
        this.maxHeight =
          Number(document.documentElement.clientHeight - 121) + "px";
      } else {
        this.title = "会员详情";
        this.maxHeight = "100%";
      }
      // 清空数据
      this.$refs.form.resetFields();
      this.permissions = [];
      this.permissionList = [];
      if (this.type == "0" || this.type == "1") {
        // 回显数据
        let data = this.data;
        // 权限
        if (data.permissions) {
          this.permissions = data.permissions.split(",");
          this.permissionList = data.permissions.split(",");
        }
        // 回显
        this.form = data;
      } else {
        this.permissions = ["MEMBER"];
        this.permissionList = ["MEMBER"];
        // 添加
        this.form = {
          type: 0,
          grade: 0,
          vipStatus: 0,
          platform: -1
        };
      }
      this.visible = value;
    }
  },
  watch: {
    value(val) {
      this.setCurrentValue(val);
    },
    visible(value) {
      this.$emit("input", value);
    }
  },
  mounted() {
    this.init();
  }
};
</script>

<style lang="less">
@import "../../../styles/table-common.less";
.drawer-content {
  overflow: auto;
}
.drawer-content::-webkit-scrollbar {
  display: none;
}
.user-title {
  display: flex;
  align-items: center;
  margin-bottom: 16px;
  .info-title {
    font-size: 16px;
    color: rgba(0, 0, 0, 0.85);
    display: block;
    margin-right: 16px;
  }
}
.info-header {
  font-size: 16px;
  color: rgba(0, 0, 0, 0.85);
  display: block;
  margin-bottom: 16px;
}
</style>

