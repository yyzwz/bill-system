<style lang="less">
@import "../../../styles/tree-common.less";
@import "../../../styles/single-common.less";
@import "./processManage.less";
</style>
<template>
  <div class="search">
    <Card style="min-height: 600px">
      <div slot="title">
        <div class="edit-head">
          <a @click="close" class="back-title">
            <Icon type="ios-arrow-back" />返回
          </a>
          <div class="head-name">{{processName}} 流程配置</div>
          <span></span>
          <a @click="close" class="window-close">
            <Icon type="ios-close" size="31" class="ivu-icon-ios-close" />
          </a>
        </div>
      </div>
      <div style="display:flex;justify-content:center;margin: 10px 0 30px 0;">
        <Steps :current="current" style="width: 400px">
          <Step title="基本配置"></Step>
          <Step title="节点审批人配置"></Step>
        </Steps>
      </div>
      <Row type="flex" justify="center" v-show="current==0">
        <Col :xs="24" :md="24" :lg="16" :xl="9">
          <Form
            ref="basicForm"
            :model="basicForm"
            label-position="left"
            :label-width="110"
            :rules="formValidate"
          >
            <FormItem label="关联表单路由" prop="routeName">
              <Select v-model="basicForm.routeName" placeholder="请选择关联业务表单前端路由名" clearable @on-change="handelSubmitEdit">
                <Option
                  v-for="(item, i) in dictForm"
                  :key="i"
                  :value="item.value"
                  :label="item.title"
                >
                  <span style="margin-right:10px;">{{ item.title }}</span>
                  <span style="color:#ccc;">{{ item.value }}</span>
                </Option>
              </Select>
            </FormItem>
            <FormItem label="关联业务表" prop="businessTable">
              <Select v-model="basicForm.businessTable" placeholder="请选择关联数据库业务表" clearable @on-change="handelSubmitEdit">
                <Option
                  v-for="(item, i) in dictTable"
                  :key="i"
                  :value="item.value"
                  :label="item.title"
                >
                  <span style="margin-right:10px;">{{ item.title }}</span>
                  <span style="color:#ccc;">{{ item.value }}</span>
                </Option>
              </Select>
            </FormItem>
            <FormItem label="流程分类">
              <div style="display:flex;">
                <Input
                  v-model="categoryTitle"
                  readonly
                  clearable
                  @on-clear="clearSelectCat"
                  style="margin-right:10px;"
                />
                <Poptip trigger="click" placement="right" title="选择类别" width="250">
                  <Button icon="md-list">选择分类</Button>
                  <div slot="content">
                    <Input
                      v-model="searchKey"
                      suffix="ios-search"
                      @on-change="searchCat"
                      placeholder="输入分类名搜索"
                      clearable
                    />
                    <div class="tree-list">
                      <Tree :data="dataCat" :load-data="loadDataTree" :render="renderCatContent"></Tree>
                      <Spin size="large" fix v-if="catLoading"></Spin>
                    </div>
                  </div>
                </Poptip>
              </div>
            </FormItem>
            <FormItem label="备注描述" prop="description">
              <Input v-model="basicForm.description" type="textarea" :rows="4" @on-blur="handelSubmitEdit"/>
            </FormItem>
            <FormItem class="br">
              <Button type="warning" @click="current=1">
                下一步
                <Icon type="ios-arrow-forward" />
              </Button>
              <Button @click="close">关闭</Button>
            </FormItem>
          </Form>
        </Col>
      </Row>
      <Row type="flex" justify="start" v-if="current==1">
        <Col :md="8" :lg="8" :xl="6">
          <Alert show-icon>
            当前选择编辑：
            <span class="select-title">{{editTitle}}</span>
            <a class="select-clear" v-if="form.id" @click="cancelEdit">取消选择</a>
          </Alert>
          <div class="tree-bar">
            <Tree ref="tree" :data="data" :render="renderContent" @on-select-change="selectTree"></Tree>
            <Spin size="large" fix v-if="loading"></Spin>
          </div>
        </Col>
        <Col :md="15" :lg="13" :xl="10" style="margin-left:10px;">
          <Alert
            type="warning"
            show-icon
            style="margin-left: 1vw"
          >温馨提示：若流程运行至未分配审批人员的审批节点时，流程将自动中断取消</Alert>
          <Form ref="form" :model="form" :label-width="90" style="position:relative">
            <FormItem label="节点名称" prop="title">
              {{form.title}}
              <Tooltip
                content="配置可看到该流程的所属用户，默认所有人可发起"
                placement="right"
                transfer
                max-width="280"
                style="display: inline-block !important;"
              >
                <Icon
                  type="md-help-circle"
                  size="20"
                  color="#c5c5c5"
                  style="margin-left:5px;cursor:pointer;"
                  v-show="form.type==0"
                />
              </Tooltip>
            </FormItem>
            <Form-item label="节点类型" prop="type">
              <Select v-model="form.type" disabled style="width: 300px">
                <Option
                  v-for="(item, i) in dictNodeType"
                  :key="i"
                  :value="item.value"
                >{{item.title}}</Option>
              </Select>
            </Form-item>
            <div v-show="form.type==0">
              <FormItem label="可发起人员">
                <Checkbox v-model="allUser">
                  <Icon type="md-contacts" style="margin:0 2px 0 0"></Icon>
                  <span>所有人</span>
                </Checkbox>
                <Checkbox v-model="chooseRole" @on-change="clickRole" :disabled="allUser">
                  <Icon type="md-people" size="14" style="margin:0 2px 0 0"></Icon>
                  <span>指定角色</span>
                </Checkbox>
                <Checkbox
                  v-model="chooseDepartment"
                  @on-change="clickDepartment"
                  :disabled="allUser"
                >
                  <Icon type="ios-people" style="margin:0 2px 0 0"></Icon>
                  <span>指定部门</span>
                </Checkbox>
                <Checkbox v-model="chooseUser" @on-change="clickUser" :disabled="allUser">
                  <Icon type="md-person" style="margin:0 2px 0 0"></Icon>
                  <span>指定人员</span>
                </Checkbox>
              </FormItem>
            </div>
            <div v-show="form.type==1">
              <FormItem label="可审批人员">
                <Checkbox v-model="chooseRole" @on-change="clickRole" :disabled="form.customUser">
                  <Icon type="md-people" size="14" style="margin:0 2px 0 0"></Icon>
                  <span>指定角色</span>
                </Checkbox>
                <Checkbox
                  v-model="chooseDepartment"
                  @on-change="clickDepartment"
                  :disabled="form.customUser"
                >
                  <Icon type="ios-people" style="margin:0 2px 0 0"></Icon>
                  <span>指定部门负责人</span>
                </Checkbox>
                <Checkbox v-model="chooseUser" @on-change="clickUser" :disabled="form.customUser">
                  <Icon type="md-person" style="margin:0 2px 0 0"></Icon>
                  <span>指定人员</span>
                </Checkbox>
                <Checkbox v-model="form.customUser">
                  <Icon type="md-contacts" style="margin:0 2px 0 0"></Icon>
                  <span>审批人自选</span>
                  <Tooltip
                    content="审批人任意自选用户，请勿在网关后设置"
                    placement="right"
                    transfer
                    max-width="280"
                    style="display: inline-block !important;"
                  >
                    <Icon
                      type="md-help-circle"
                      size="20"
                      color="#c5c5c5"
                      style="margin-left:10px;cursor:pointer;"
                    />
                  </Tooltip>
                </Checkbox>
                <Checkbox v-model="form.chooseDepHeader" :disabled="form.customUser">
                  <Icon type="md-person" style="margin:0 2px 0 0"></Icon>
                  <span>连续多级部门负责人</span>
                  <Tooltip
                    content="自动获取发起人或上一审批人的部门负责人"
                    placement="right"
                    transfer
                    max-width="280"
                    style="display: inline-block !important;"
                  >
                    <Icon
                      type="md-help-circle"
                      size="20"
                      color="#c5c5c5"
                      style="margin-left:10px;cursor:pointer;"
                    />
                  </Tooltip>
                </Checkbox>
              </FormItem>
            </div>
            <FormItem
              label="选择角色"
              v-show="chooseRole&&((form.type==0&&!allUser)||(form.type==1&&!form.customUser))"
            >
              <Select v-model="form.roles" multiple>
                <Option v-for="item in roleList" :value="item.id" :key="item.id" :label="item.name">
                  <span style="margin-right:10px;">{{ item.name }}</span>
                  <span style="color:#ccc;">{{ item.description }}</span>
                </Option>
              </Select>
            </FormItem>
            <div v-show="chooseDepartment&&((form.type==0&&!allUser)||(form.type==1&&!form.customUser))">
              <FormItem label="选择部门">
                <department-tree-choose
                  multiple
                  width="250px"
                  @on-change="handleSelectDepTree"
                  ref="depTree"
                ></department-tree-choose>
              </FormItem>
            </div>
            <div v-show="chooseUser&&((form.type==0&&!allUser)||(form.type==1&&!form.customUser))">
              <FormItem label="选择用户">
                <user-choose @on-change="handleSelectUser" ref="user"></user-choose>
              </FormItem>
            </div>
            <Form-item class="br">
              <Button
                type="primary"
                :loading="submitLoading"
                @click="handelSubmit"
                icon="ios-create-outline"
                :disabled="form.type!=0&&form.type!=1"
              >保存并提交</Button>
              <Button type="warning" icon="ios-arrow-back" @click="current=0">上一步</Button>
              <Button @click="close">关闭</Button>
            </Form-item>
            <Spin size="large" fix v-if="nodeLoading"></Spin>
          </Form>
        </Col>
      </Row>
    </Card>
  </div>
</template>

<script>
import {
  getProcessNode,
  editStartUser,
  editNodeUser,
  updateInfo,
  initActCategory,
  loadActCategory,
  searchActCategory
} from "@/api/activiti";
import { getAllRoleList, getDictDataByType } from "@/api/index";
import userChoose from "@/views/my-components/xboot/user-choose";
import departmentTreeChoose from "@/views/my-components/xboot/department-tree-choose";
export default {
  name: "process_node_edit",
  components: {
    userChoose,
    departmentTreeChoose
  },
  props: {
    nodeEditData: Object
  },
  data() {
    return {
      loading: false, // 表单加载状态
      nodeLoading: false,
      data: [],
      editTitle: "",
      selectUsers: [],
      dataCat: [],
      catLoading: false,
      searchKey: "",
      basicForm: {
        routeName: "",
        businessTable: "",
        description: ""
      },
      formValidate: {
        routeName: [{ required: true, message: "不能为空", trigger: "blur" }],
        businessTable: [
          { required: true, message: "不能为空", trigger: "blur" }
        ]
      },
      categoryTitle: "",
      dictTable: [],
      dictForm: [],
      form: {
        // 添加或编辑表单对象初始化数据
        title: "",
        content: "",
        type: null,
        roles: [],
        departmentIds: [],
        chooseDepHeader: false,
        customUser: false
      },
      roleList: [],
      submitLoading: false, // 添加或编辑提交状态
      chooseRole: false,
      chooseUser: false,
      chooseDepartment: false,
      allUser: true,
      current: 0,
      dictNodeType: [],
      processName: "",
      processId: ""
    };
  },
  methods: {
    init() {
      this.getDictDataType();
      this.getRoleList();
      this.initCategoryTreeData();
      this.processId = this.nodeEditData.id;
      this.processName = this.nodeEditData.name;
      this.basicForm.id = this.nodeEditData.id;
      this.basicForm.routeName = this.nodeEditData.routeName;
      this.basicForm.businessTable = this.nodeEditData.businessTable;
      this.basicForm.description = this.nodeEditData.description;
      this.basicForm.categoryId = this.nodeEditData.categoryId;
      this.categoryTitle = this.nodeEditData.categoryTitle;
      let allUser = this.nodeEditData.allUser + "";
      if (allUser == "false") {
        this.allUser = false;
      } else {
        this.allUser = true;
      }
    },
    getDictDataType() {
      getDictDataByType("process_node_type").then(res => {
        if (res.success) {
          this.dictNodeType = res.result;
          this.getData();
        }
      });
      getDictDataByType("business_table").then(res => {
        if (res.success) {
          this.dictTable = res.result;
        }
      });
      getDictDataByType("business_form").then(res => {
        if (res.success) {
          this.dictForm = res.result;
        }
      });
    },
    renderCatContent(h, { root, node, data }) {
      let icon = "";
      if (data.type == "0") {
        icon = "md-folder-open";
      } else if (data.type == "1") {
        icon = "ios-bookmark-outline";
      }
      return h(
        "span",
        {
          style: {
            display: "inline-block",
            cursor: "pointer"
          },
          on: {
            click: () => {
              this.selectCatTree(data);
            }
          }
        },
        [
          h("span", [
            h("Icon", {
              props: {
                type: icon,
                size: "16"
              },
              style: {
                "margin-right": "8px",
                "margin-bottom": "3px"
              }
            }),
            h("span", data.title)
          ])
        ]
      );
    },
    initCategoryTreeData() {
      initActCategory().then(res => {
        if (res.success) {
          res.result.forEach(function(e) {
            if (e.isParent) {
              e.loading = false;
              e.children = [];
            }
            if (e.status == -1) {
              e.title = "[已禁用] " + e.title;
              e.disabled = true;
            }
          });
          this.dataCat = res.result;
        }
      });
    },
    loadDataTree(item, callback) {
      loadActCategory(item.id).then(res => {
        if (res.success) {
          res.result.forEach(function(e) {
            if (e.isParent) {
              e.loading = false;
              e.children = [];
            }
            if (e.status == -1) {
              e.title = "[已禁用] " + e.title;
              e.disabled = true;
            }
          });
          callback(res.result);
        }
      });
    },
    searchCat() {
      // 搜索部门
      if (this.searchKey) {
        this.catLoading = true;
        searchActCategory({ title: this.searchKey }).then(res => {
          this.catLoading = false;
          if (res.success) {
            res.result.forEach(function(e) {
              if (e.status == -1) {
                e.title = "[已禁用] " + e.title;
                e.disabled = true;
              }
            });
            this.dataCat = res.result;
          }
        });
      } else {
        this.initCategoryTreeData();
      }
    },
    selectCatTree(v) {
      if (v) {
        // 转换null为""
        for (let attr in v) {
          if (v[attr] == null) {
            v[attr] = "";
          }
        }
        let str = JSON.stringify(v);
        let data = JSON.parse(str);
        if (data.type == 0) {
          this.$Message.warning("请选择一个类别");
          return;
        }
        this.basicForm.categoryId = data.id;
        this.categoryTitle = data.title;
        this.handelSubmitEdit();
      }
    },
    clearSelectCat() {
      this.basicForm.categoryId = "";
      this.categoryTitle = "";
      this.handelSubmitEdit();
    },
    handelSubmitEdit() {
      this.$refs.basicForm.validate(valid => {
        if (valid) {
          updateInfo(this.basicForm).then(res => {
            if (res.success) {
              this.$Message.success("操作成功");
              this.$emit("submited", true);
            }
          });
        }
      });
    },
    getRoleList() {
      getAllRoleList().then(res => {
        if (res.success) {
          this.roleList = res.result;
        }
      });
    },
    getData() {
      this.loading = true;
      getProcessNode(this.processId).then(res => {
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
          data.forEach(e => {
            this.dictNodeType.forEach(t => {
              t.value = Number(t.value);
              if (!e.title && e.type == t.value) {
                e.title = t.title;
              }
            });
          });
          this.data = data;
        }
      });
    },
    renderContent(h, { root, node, data }) {
      let color = "",
        word = "",
        title = data.title;
      if (data.type == 0) {
        color = "#47cb89";
        word = "开";
        title = title + "【谁可以发起】";
      } else if (data.type == 1) {
        color = "#2db7f5";
        word = "审";
      } else if (data.type == 2) {
        word = "结";
      } else {
        color = "#f90";
        word = "其他";
      }
      return h("span", [
        h("span", [
          h(
            "Avatar",
            {
              props: {
                size: "small"
              },
              style: {
                background: color,
                "margin-right": "5px"
              }
            },
            word
          ),
          h("span", title)
        ])
      ]);
    },
    selectTree(v) {
      if (v.length > 0) {
        // 转换null为""
        for (let attr in v[0]) {
          if (v[0][attr] == null) {
            v[0][attr] = "";
          }
        }
        let str = JSON.stringify(v[0]);
        let data = JSON.parse(str);
        this.selectUsers = data.users;
        this.editTitle = data.title;
        // 回显用户
        if (data.users && data.users.length > 0) {
          this.chooseUser = true;
          this.$refs.user.setData(data.users);
        } else {
          this.chooseUser = false;
          this.$refs.user.setData([]);
        }
        // 回显角色
        if (data.roles && data.roles.length > 0) {
          this.chooseRole = true;
          let roleIds = [];
          data.roles.forEach(e => {
            roleIds.push(e.id);
          });
          data.roles = roleIds;
        } else {
          this.chooseRole = false;
        }
        // 回显部门
        if (data.departments && data.departments.length > 0) {
          this.chooseDepartment = true;
          let departmentIds = [],
            title = "";
          data.departments.forEach(e => {
            departmentIds.push(e.id);
            if (title == "") {
              title = e.title;
            } else {
              title = title + "、" + e.title;
            }
          });
          this.$refs.depTree.setData(departmentIds, title);
          data.departmentIds = departmentIds;
        } else {
          this.chooseDepartment = false;
          this.$refs.depTree.setData([], "");
        }
        this.form = data;
      } else {
        this.cancelEdit();
      }
    },
    cancelEdit() {
      let data = this.$refs.tree.getSelectedNodes()[0];
      if (data) {
        data.selected = false;
      }
      this.$refs.form.resetFields();
      this.form.id = "";
      delete this.form.id;
      this.editTitle = "";
    },
    handelSubmit() {
      this.submitLoading = true;
      // 用户id数据
      let ids = [];
      this.selectUsers.forEach(e => {
        ids += e.id + ",";
      });
      if (ids.length > 0) {
        ids = ids.substring(0, ids.length - 1);
      }
      this.form.nodeId = this.form.id;
      if (this.chooseUser) {
        if (ids && ids.length > 0) {
          this.form.userIds = ids;
        }
      }
      if (this.chooseRole) {
        if (this.form.roles && this.form.roles.length > 0) {
          this.form.roleIds = this.form.roles;
        }
      }
      if (this.form.type == 0) {
        this.form.nodeId = this.processId;
        this.form.allUser = this.allUser;
        editStartUser(this.form).then(res => {
          this.submitLoading = false;
          if (res.success) {
            this.$Message.success("操作成功");
            this.getData();
            this.$emit("submited", true);
          }
        });
      } else {
        editNodeUser(this.form).then(res => {
          this.submitLoading = false;
          if (res.success) {
            this.$Message.success("操作成功");
            this.getData();
          }
        });
      }
    },
    clickRole(v) {
      this.chooseRole = v;
    },
    clickUser(v) {
      this.chooseUser = v;
    },
    clickDepartment(v) {
      this.chooseDepartment = v;
    },
    handleSelectUser(v) {
      this.selectUsers = v;
    },
    handleSelectDepTree(v) {
      this.form.departmentIds = v;
    },
    close() {
      this.$emit("close", true);
    }
  },
  mounted() {
    this.init();
  }
};
</script>