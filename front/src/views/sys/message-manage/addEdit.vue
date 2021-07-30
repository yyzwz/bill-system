<style lang="less">
@import "../../../styles/single-common.less";
</style>
<template>
  <div>
    <Card>
      <div slot="title">
        <div class="edit-head">
          <a @click="close" class="back-title">
            <Icon type="ios-arrow-back" />返回
          </a>
          <div class="head-name">{{type==0?"发送新消息":"编辑消息"}}</div>
          <span></span>
          <a @click="close" class="window-close">
            <Icon type="ios-close" size="31" class="ivu-icon-ios-close" />
          </a>
        </div>
      </div>
      <Row>
        <Form
          ref="form"
          :model="form"
          :label-width="90"
          :rules="formValidate"
          style="position:relative"
        >
          <FormItem label="消息类型" prop="type">
            <Select v-model="form.type" placeholder="请选择" style="width:250px">
              <Option
                v-for="(item, i) in dictMessageType"
                :key="i"
                :value="item.value"
              >{{item.title}}</Option>
            </Select>
          </FormItem>
          <FormItem label="标题" prop="title">
            <Input v-model="form.title" style="width:600px" />
          </FormItem>
          <FormItem label="内容" prop="content" class="form-wangEditor">
            <editor v-model="form.content"></editor>
          </FormItem>
          <FormItem label="新创建账号也推送" prop="createSend">
            <i-switch size="large" v-model="form.createSend">
              <span slot="open">开启</span>
              <span slot="close">关闭</span>
            </i-switch>
          </FormItem>
          <div v-if="type==0">
            <FormItem label="发送范围">
              <RadioGroup v-model="form.range">
                <Radio :label="0">全体用户</Radio>
                <Radio :label="1">指定用户成员</Radio>
              </RadioGroup>
            </FormItem>
            <div>
              <FormItem label="选择用户" v-if="form.range==1">
                <user-choose text="选择发送用户" @on-change="handleSelectUser" ref="user"></user-choose>
              </FormItem>
            </div>
          </div>
          <Form-item class="br">
            <Button
              type="primary"
              :loading="submitLoading"
              @click="handelSubmit"
              style="width:100px"
            >提交</Button>
            <Button @click="close">取消</Button>
          </Form-item>
          <Spin size="large" fix v-if="loading"></Spin>
        </Form>
      </Row>
    </Card>
  </div>
</template>

<script>
import { getMessageDataById, addMessage, editMessage } from "@/api/index";
import editor from "@/views/my-components/xboot/editor";
import userChoose from "@/views/my-components/xboot/user-choose";
export default {
  name: "add_edit_message",
  components: {
    userChoose,
    editor
  },
  props: {
    transferData: Object
  },
  data() {
    return {
      type: 0,
      loading: false, // 表单加载状态
      selectUsers: [],
      userModalVisible: false,
      modalTitle: "", // 添加或编辑标题
      form: {
        // 添加或编辑表单对象初始化数据
        title: "",
        content: "",
        type: "",
        range: 0
      },
      formValidate: {
        // 表单验证规则
        type: [
          { required: true, message: "消息类型不能为空", trigger: "blur" }
        ],
        title: [{ required: true, message: "标题不能为空", trigger: "blur" }],
        content: [{ required: true, message: "内容不能为空", trigger: "blur" }]
      },
      submitLoading: false, // 添加或编辑提交状态
      dictMessageType: this.$store.state.dict.messageType,
      backRoute: ""
    };
  },
  methods: {
    init() {
      this.type = this.transferData.type;
      if (this.type == 1) {
        this.form.id = this.transferData.id;
        this.getData();
      }
    },
    getData() {
      this.loading = true;
      getMessageDataById(this.form.id).then(res => {
        this.loading = false;
        if (res.success) {
          // 转换null为""
          let v = res.result;
          for (let attr in v) {
            if (v[attr] == null) {
              v[attr] = "";
            }
          }
          let str = JSON.stringify(v);
          let data = JSON.parse(str);
          this.form = data;
        }
      });
    },
    handelSubmit() {
      this.$refs.form.validate(valid => {
        if (valid) {
          this.submitLoading = true;
          if (this.type == 0) {
            // 添加 避免编辑后传入id等数据 记得删除
            delete this.form.id;
            // 用户id数据
            let ids = [];
            this.selectUsers.forEach(e => {
              ids += e.id + ",";
            });
            if (ids.length > 0) {
              ids = ids.substring(0, ids.length - 1);
            }
            this.form.userIds = ids;
            addMessage(this.form).then(res => {
              this.submitLoading = false;
              if (res.success) {
                this.$Message.success("操作成功");
                this.submited();
              }
            });
          } else if (this.type == 1) {
            // 编辑
            editMessage(this.form).then(res => {
              this.submitLoading = false;
              if (res.success) {
                this.$Message.success("操作成功");
                this.submited();
              }
            });
          }
        }
      });
    },
    handleSelectUser(v) {
      this.selectUsers = v;
    },
    close() {
      this.$emit("close", true);
    },
    submited() {
      this.$emit("submited", true);
    }
  },
  mounted() {
    this.init();
  }
};
</script>