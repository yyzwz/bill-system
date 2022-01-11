<template>
  <div>
    <Card>
      <div slot="title">
        <div class="edit-head">
          <a @click="close" class="back-title">
            <Icon type="ios-arrow-back" />返回
          </a>
          <div class="head-name">添加</div>
          <span></span>
          <a @click="close" class="window-close">
            <Icon type="ios-close" size="31" class="ivu-icon-ios-close" />
          </a>
        </div>
      </div>
      <Form ref="form" :model="form" :label-width="100" :rules="formValidate" label-position="left" >          <FormItem label="商品名称" prop="name"  >
            <Input v-model="form.name" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="商品单价" prop="unitPrice"  >
            <Input v-model="form.unitPrice" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="库存" prop="stock"  >
            <Input v-model="form.stock" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="商品分类" prop="type"  >
            <!-- <Input v-model="form.type" clearable style="width:570px"/> -->
            <Select v-model="form.type">
              <Option value="水果">水果</Option>
              <Option value="零食">零食</Option>
              <Option value="玩具">玩具</Option>
            </Select>
          </FormItem>
          <FormItem label="供应商" prop="supplierId"  >
            <Select v-model="form.supplierId" clearable style="width:570px">
              <Option
                v-for="(item, i) in this.supplierList"
                :key="i"
                :value="item.id"
              >{{item.name}}</Option>
            </Select>
          </FormItem>
          <Form-item class="br">
            <Button
              @click="handleSubmit"
              :loading="submitLoading"
              type="primary"
            >提交并保存</Button>
            <Button @click="handleReset">重置</Button>
            <Button type="dashed" @click="close">关闭</Button>
          </Form-item>
        </Form>
    </Card>
  </div>
</template>

<script>
// 根据你的实际请求api.js位置路径修改
import { addCommodity , getAllSupplierList } from "./api.js";
export default {
  name: "add",
  components: {
    },
  data() {
    return {
      submitLoading: false, // 表单提交状态
      form: { // 添加或编辑表单对象初始化数据
        name: "",
        unitPrice: "",
        stock: "",
        type: "",
        supplierId: "",
      },
      // 表单验证规则
      formValidate: {
      },
      supplierList: []
    };
  },
  methods: {
    init() {
      var that = this;
      getAllSupplierList().then(res => {
        that.supplierList = res.result;
      })
    },
    handleReset() {
      this.$refs.form.resetFields();
    },
    handleSubmit() {
      this.$refs.form.validate(valid => {
        if (valid) {
          addCommodity(this.form).then(res => {
            this.submitLoading = false;
            if (res.success) {
              this.$Message.success("操作成功");
              this.submited();
            }
          });
        }
      });
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
<style lang="less">
// 建议引入通用样式 具体路径自行修改 可删除下面样式代码
// @import "../../../styles/single-common.less";
.edit-head {
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: relative;

    .back-title {
        color: #515a6e;
        display: flex;
        align-items: center;
    }

    .head-name {
        display: inline-block;
        height: 20px;
        line-height: 20px;
        font-size: 16px;
        color: #17233d;
        font-weight: 500;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .window-close {
        z-index: 1;
        font-size: 12px;
        position: absolute;
        right: 0px;
        top: -5px;
        overflow: hidden;
        cursor: pointer;

        .ivu-icon-ios-close {
            color: #999;
            transition: color .2s ease;
        }
    }

    .window-close .ivu-icon-ios-close:hover {
        color: #444;
    }
}
</style>