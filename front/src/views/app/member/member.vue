<template>
  <div class="search">
    <Card>
      <Tabs v-model="tabName" :animated="false" @on-click="changeTab">
        <TabPane label="全部平台" name="all"></TabPane>
        <TabPane label="PC/H5" name="0"></TabPane>
        <TabPane label="Android" name="1"></TabPane>
        <TabPane label="IOS" name="2"></TabPane>
        <TabPane label="微信小程序" name="3"></TabPane>
        <TabPane label="支付宝小程序" name="4"></TabPane>
        <TabPane label="QQ小程序" name="5"></TabPane>
        <TabPane label="字节小程序" name="6"></TabPane>
        <TabPane label="百度小程序" name="7"></TabPane>
      </Tabs>
      <Row v-show="openSearch" @keydown.enter.native="handleSearch">
        <Form ref="searchForm" :model="searchForm" inline :label-width="70">
          <Form-item label="用户名" prop="username">
            <Input
              type="text"
              v-model="searchForm.username"
              placeholder="请输入用户名/UID"
              clearable
              style="width: 200px"
            />
          </Form-item>
          <Form-item label="昵称" prop="nickname">
            <Input
              type="text"
              v-model="searchForm.nickname"
              placeholder="请输入昵称"
              clearable
              style="width: 200px"
            />
          </Form-item>
          <span v-if="drop">
            <Form-item label="手机" prop="mobile">
              <Input
                type="text"
                v-model="searchForm.mobile"
                placeholder="请输入手机"
                clearable
                style="width: 200px"
              />
            </Form-item>
            <Form-item label="邮箱" prop="email">
              <Input
                type="text"
                v-model="searchForm.email"
                placeholder="请输入邮箱"
                clearable
                style="width: 200px"
              />
            </Form-item>
            <Form-item label="邀请码" prop="inviteCode">
              <Input
                type="text"
                v-model="searchForm.inviteCode"
                placeholder="请输入邀请码"
                clearable
                style="width: 200px"
              />
            </Form-item>
            <Form-item label="注册时间" prop="createTime">
              <DatePicker
                v-model="selectDate"
                type="daterange"
                format="yyyy-MM-dd"
                clearable
                @on-change="selectDateRange"
                placeholder="选择起始时间"
                style="width: 200px"
              ></DatePicker>
            </Form-item>
          </span>
          <Form-item style="margin-left:-35px;" class="br">
            <Button @click="handleSearch" type="primary" icon="ios-search">搜索</Button>
            <Button @click="handleReset">重置</Button>
            <a class="drop-down" @click="dropDown">
              {{dropDownContent}}
              <Icon :type="dropDownIcon"></Icon>
            </a>
          </Form-item>
        </Form>
      </Row>
      <Row class="operation">
        <Button @click="add" type="primary" icon="md-add">添加</Button>
        <Button @click="delAll" icon="md-trash">批量删除</Button>
        <Button @click="getDataList" icon="md-refresh">刷新</Button>
        <Button type="dashed" @click="openSearch=!openSearch">{{openSearch ? "关闭搜索" : "开启搜索"}}</Button>
        <Button type="dashed" @click="openTip=!openTip">{{openTip ? "关闭提示" : "开启提示"}}</Button>
      </Row>
      <Row v-show="openTip">
        <Alert show-icon>
          已选择
          <span class="select-count">{{selectCount}}</span> 项
          <a class="select-clear" @click="clearSelectAll">清空</a>
        </Alert>
      </Row>
      <Row>
        <Table
          :loading="loading"
          border
          :columns="columns"
          :data="data"
          ref="table"
          sortable="custom"
          @on-sort-change="changeSort"
          @on-selection-change="changeSelect"
        ></Table>
      </Row>
      <Row type="flex" justify="end" class="page">
        <Page
          :current="searchForm.pageNumber"
          :total="total"
          :page-size="searchForm.pageSize"
          @on-change="changePage"
          @on-page-size-change="changePageSize"
          :page-size-opts="[10,20,50]"
          size="small"
          show-total
          show-elevator
          show-sizer
        ></Page>
      </Row>
    </Card>

    <addEdit :data="form" :type="showType" v-model="showUser" @on-submit="getDataList" />
    <invite :transferData="transferData" v-model="showInvite" />
  </div>
</template>

<script>
// 根据你的实际请求api.js位置路径修改
import { getMemberList, statusMember, deleteMember } from "@/api/app";
import addEdit from "./addEdit.vue";
import invite from "./invite.vue";
export default {
  name: "member",
  components: {
    addEdit,
    invite
  },
  data() {
    return {
      showInvite: false,
      transferData: {},
      showUser: false,
      showType: "0",
      tabName: "all",
      openSearch: true, // 显示搜索
      openTip: true, // 显示提示
      loading: true, // 表单加载状态
      modalType: 0, // 添加或编辑标识
      modalVisible: false, // 添加或编辑显示
      modalTitle: "", // 添加或编辑标题
      drop: false,
      dropDownContent: "展开",
      dropDownIcon: "ios-arrow-down",
      searchForm: {
        // 搜索框初始化对象
        type: "",
        status: "",
        vipStatus: "",
        pageNumber: 1, // 当前页数
        pageSize: 10, // 页面大小
        sort: "createTime", // 默认排序字段
        order: "desc", // 默认排序方式
        startDate: "", // 起始时间
        endDate: "" // 终止时间
      },
      form: {},
      selectDate: null,
      selectList: [], // 多选数据
      selectCount: 0, // 多选计数
      columns: [
        // 表头
        {
          type: "selection",
          width: 60,
          align: "center",
          fixed: "left"
        },
        {
          type: "index",
          width: 60,
          align: "center",
          fixed: "left"
        },
        {
          title: "用户名/UID",
          key: "username",
          width: 185,
          sortable: true,
          fixed: "left"
        },
        {
          title: "昵称",
          key: "nickname",
          sortable: true,
          minWidth: 120,
          fixed: "left",
          render: (h, params) => {
            return h(
              "a",
              {
                on: {
                  click: () => {
                    this.showDetail(params.row);
                  }
                }
              },
              params.row.nickname
            );
          }
        },
        {
          title: "头像",
          key: "avatar",
          width: 80,
          align: "center",
          render: (h, params) => {
            return h("Avatar", {
              props: {
                src: params.row.avatar
              }
            });
          }
        },
        {
          title: "手机",
          key: "mobile",
          sortable: true,
          width: 125
        },
        {
          title: "地区",
          key: "address",
          sortable: true,
          tooltip: true,
          minWidth: 130
        },
        {
          title: "类型",
          key: "type",
          align: "center",
          width: 110,
          render: (h, params) => {
            let re = "",
              color = "";
            if (params.row.type == 1) {
              re = "VIP";
              color = "red";
            } else if (params.row.type == 0) {
              re = "普通会员";
              color = "blue";
            }
            return h("div", [
              h(
                "Tag",
                {
                  props: {
                    color: color
                  }
                },
                re
              )
            ]);
          },
          filters: [
            {
              label: "普通会员",
              value: 0
            },
            {
              label: "VIP",
              value: 1
            }
          ],
          filterMultiple: false,
          filterRemote: e => {
            let v = "";
            if (e.length > 0) {
              v = e[0];
            }
            this.searchForm.type = v;
            this.getDataList();
          }
        },
        {
          title: "VIP状态",
          key: "vipStatus",
          width: 110,
          align: "center",
          render: (h, params) => {
            let re = "",
              color = "";
            if (params.row.vipStatus == 0) {
              re = "未开通";
              color = "default";
            } else if (params.row.vipStatus == 1) {
              re = "已开通";
              color = "green";
            } else if (params.row.vipStatus == 2) {
              re = "已过期";
              color = "orange";
            }
            return h("div", [
              h(
                "Tag",
                {
                  props: {
                    color: color
                  }
                },
                re
              )
            ]);
          },
          filters: [
            {
              label: "未开通",
              value: 0
            },
            {
              label: "已开通",
              value: 1
            },
            {
              label: "已过期",
              value: 2
            }
          ],
          filterMultiple: false,
          filterRemote: e => {
            let v = "";
            if (e.length > 0) {
              v = e[0];
            }
            this.searchForm.vipStatus = v;
            this.getDataList();
          }
        },
        {
          title: "VIP开通时间",
          key: "vipStartTime",
          width: 170,
          sortable: true
        },
        {
          title: "VIP到期时间",
          key: "vipEndTime",
          width: 170,
          sortable: true
        },
        {
          title: "注册时间",
          key: "createTime",
          width: 170,
          sortable: true,
          sortType: "desc"
        },
        {
          title: "状态",
          key: "status",
          align: "center",
          width: 110,
          render: (h, params) => {
            if (params.row.status == 0) {
              return h("div", [
                h("Badge", {
                  props: {
                    status: "success",
                    text: "正常启用"
                  }
                })
              ]);
            } else if (params.row.status == -1) {
              return h("div", [
                h("Badge", {
                  props: {
                    status: "error",
                    text: "禁用"
                  }
                })
              ]);
            }
          },
          filters: [
            {
              label: "正常启用",
              value: 0
            },
            {
              label: "禁用",
              value: -1
            }
          ],
          filterMultiple: false,
          filterRemote: e => {
            let v = "";
            if (e.length > 0) {
              v = e[0];
            }
            this.searchForm.status = v;
            this.getUserList();
          }
        },
        {
          title: "注册平台",
          key: "platform",
          align: "center",
          width: 100,
          render: (h, params) => {
            let re = "",
              platform = params.row.platform;
            if (platform == 0) {
              re = "H5/PC";
            } else if (platform == 1) {
              re = "Android";
            } else if (platform == 2) {
              re = "IOS";
            } else if (platform == 3) {
              re = "微信小程序";
            } else if (platform == 4) {
              re = "支付宝小程序";
            } else if (platform == 5) {
              re = "QQ小程序";
            } else if (platform == 6) {
              re = "字节小程序";
            } else if (platform == 7) {
              re = "百度小程序";
            } else {
              re = "未知";
            }
            return h("div", re);
          }
        },
        {
          title: "邀请人UID",
          key: "inviteBy",
          minWidth: 185,
          sortable: true
        },
        {
          title: "操作",
          key: "action",
          align: "center",
          width: 200,
          fixed: "right",
          render: (h, params) => {
            let button;
            if (params.row.status == 0) {
              button = h(
                "DropdownItem",
                { props: { name: "disable" } },
                "禁用"
              );
            } else {
              button = h("DropdownItem", { props: { name: "enable" } }, "启用");
            }
            return h("div", [
              h(
                "Button",
                {
                  props: {
                    type: "primary",
                    size: "small",
                    icon: "ios-create-outline"
                  },
                  style: {
                    marginRight: "5px"
                  },
                  on: {
                    click: () => {
                      this.edit(params.row);
                    }
                  }
                },
                "编辑"
              ),
              h(
                "Dropdown",
                {
                  props: { transfer: true },
                  on: {
                    "on-click": v => {
                      this.changeDropDown(params.row, v);
                    }
                  }
                },
                [
                  h(
                    "Button",
                    {
                      props: { size: "small" },
                      style: {
                        height: "23.5px"
                      }
                    },
                    [
                      "更多操作",
                      h("Icon", {
                        props: {
                          type: "ios-arrow-down"
                        }
                      })
                    ]
                  ),
                  h("DropdownMenu", { slot: "list" }, [
                    h(
                      "DropdownItem",
                      { props: { name: "invite" } },
                      "邀请记录"
                    ),
                    h(
                      "DropdownItem",
                      { props: { name: "vip" } },
                      "VIP开通记录"
                    ),
                    h(
                      "DropdownItem",
                      { props: { name: "recharge" } },
                      "充值记录"
                    ),
                    button,
                    h("DropdownItem", { props: { name: "remove" } }, "删除")
                  ])
                ]
              )
            ]);
          }
        }
      ],
      data: [], // 表单数据
      total: 0 // 表单数据总数
    };
  },
  methods: {
    init() {
      this.getDataList();
    },
    changeTab(v) {
      if (v == "all") {
        v = "";
      }
      this.searchForm.platform = v;
      this.getDataList();
    },
    changeDropDown(row, v) {
      if (v == "enable") {
        this.changeStatus(row, true);
      } else if (v == "disable") {
        this.changeStatus(row, false);
      } else if (v == "remove") {
        this.remove(row);
      } else if (v == "invite") {
        this.transferData = row;
        this.showInvite = true;
      } else {
        this.$Modal.info({
        title: "待开发，获取PLUS版永久更新~",
        content: "支付链接: http://xpay.exrick.cn/pay?xboot"
      });
      }
    },
    changePage(v) {
      this.searchForm.pageNumber = v;
      this.getDataList();
      this.clearSelectAll();
    },
    changePageSize(v) {
      this.searchForm.pageSize = v;
      this.getDataList();
    },
    handleSearch() {
      this.searchForm.pageNumber = 1;
      this.searchForm.pageSize = 10;
      this.getDataList();
    },
    handleReset() {
      this.$refs.searchForm.resetFields();
      this.searchForm.pageNumber = 1;
      this.searchForm.pageSize = 10;
      this.selectDate = null;
      this.searchForm.startDate = "";
      this.searchForm.endDate = "";
      // 重新加载数据
      this.getDataList();
    },
    changeSort(e) {
      this.searchForm.sort = e.key;
      this.searchForm.order = e.order;
      if (e.order === "normal") {
        this.searchForm.order = "";
      }
      this.getDataList();
    },
    clearSelectAll() {
      this.$refs.table.selectAll(false);
    },
    changeSelect(e) {
      this.selectList = e;
      this.selectCount = e.length;
    },
    selectDateRange(v) {
      if (v) {
        this.searchForm.startDate = v[0];
        this.searchForm.endDate = v[1];
      }
    },
    dropDown() {
      if (this.drop) {
        this.dropDownContent = "展开";
        this.dropDownIcon = "ios-arrow-down";
      } else {
        this.dropDownContent = "收起";
        this.dropDownIcon = "ios-arrow-up";
      }
      this.drop = !this.drop;
    },
    getDataList() {
      this.loading = true;
      getMemberList(this.searchForm).then(res => {
        this.loading = false;
        if (res.success) {
          this.data = res.result.content;
          this.total = res.result.totalElements;
        }
      });
    },
    showDetail(v) {
      // 转换null为""
      for (let attr in v) {
        if (v[attr] == null) {
          v[attr] = "";
        }
      }
      let str = JSON.stringify(v);
      let data = JSON.parse(str);
      this.form = data;
      this.showType = "0";
      this.showUser = true;
    },
    add() {
      this.showType = "2";
      this.showUser = true;
    },
    edit(v) {
      // 转换null为""
      for (let attr in v) {
        if (v[attr] === null) {
          v[attr] = "";
        }
      }
      let str = JSON.stringify(v);
      let data = JSON.parse(str);
      this.form = data;
      this.showType = "1";
      this.showUser = true;
    },
    changeStatus(v, enable) {
      let operation = "启用";
      if (!enable) {
        operation = "禁用";
      }
      this.$Modal.confirm({
        title: "确认" + operation,
        content: "您确认要" + operation + "用户 " + v.nickname + " ?",
        loading: true,
        onOk: () => {
          statusMember({ userId: v.id, enable }).then(res => {
            this.$Modal.remove();
            if (res.success) {
              this.$Message.success("操作成功");
              this.getDataList();
            }
          });
        }
      });
    },
    remove(v) {
      this.$Modal.confirm({
        title: "确认删除",
        // 记得确认修改此处
        content: "您确认要删除用户 " + v.nickname + " ?",
        loading: true,
        onOk: () => {
          // 删除
          deleteMember({ ids: v.id }).then(res => {
            this.$Modal.remove();
            if (res.success) {
              this.$Message.success("操作成功");
              this.getDataList();
            }
          });
        }
      });
    },
    delAll() {
      if (this.selectCount <= 0) {
        this.$Message.warning("您还未选择要删除的数据");
        return;
      }
      this.$Modal.confirm({
        title: "确认删除",
        content: "您确认要删除所选的 " + this.selectCount + " 条数据?",
        loading: true,
        onOk: () => {
          let ids = "";
          this.selectList.forEach(function(e) {
            ids += e.id + ",";
          });
          ids = ids.substring(0, ids.length - 1);
          // 批量删除
          deleteMember({ ids: ids }).then(res => {
            this.$Modal.remove();
            if (res.success) {
              this.$Message.success("操作成功");
              this.clearSelectAll();
              this.getDataList();
            }
          });
        }
      });
    }
  },
  mounted() {
    this.init();
  }
};
</script>
<style lang="less">
@import "../../../styles/table-common.less";
</style>