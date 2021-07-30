<style lang="less" scoped>
.page {
  margin-top: 2vh;
}
</style>
<template>
  <div>
    <Drawer :title="`${queryUser} 邀请新用户记录`" v-model="visible" width="800" draggable class="search">
      <Row>
        <Form ref="searchForm" :model="searchForm" inline :label-width="60">
          <Form-item label="用户名" prop="username">
            <Input
              type="text"
              v-model="searchForm.username"
              placeholder="请输入用户名/UID"
              clearable
              style="width: 200px"
            />
          </Form-item>
          <Form-item label="手机" prop="mobile">
            <Input
              type="text"
              v-model="searchForm.mobile"
              placeholder="请输入手机"
              clearable
              style="width: 200px"
            />
          </Form-item>
          <Form-item style="margin-left:-35px;" class="br">
            <Button @click="getDataList" type="primary" icon="ios-search">搜索</Button>
            <Button @click="handleReset">重置</Button>
          </Form-item>
        </Form>
      </Row>
      <Row>
        <Table
          :loading="loading"
          border
          :columns="columns"
          :data="data"
          ref="table"
          sortable="custom"
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
    </Drawer>
  </div>
</template>

<script>
import { getMemberList } from "@/api/app";
export default {
  name: "invite",
  props: {
    value: {
      type: Boolean,
      default: false
    },
    transferData: {
      type: Object
    }
  },
  data() {
    return {
      queryUser: "",
      visible: this.value,
      loading: true, // 表单加载状态
      searchForm: {
        pageNumber: 1, // 当前页数
        pageSize: 10, // 页面大小
        sort: "createTime",
        order: "desc",
        type: "",
        status: "",
        vipStatus: "",
        username: "",
        nickname: "",
        mobile: "",
        inviteBy: ""
      },
      columns: [
        // 表头
        {
          type: "index",
          width: 60,
          align: "center"
        },
        {
          title: "用户名/UID",
          key: "username",
          minWidth: 185,
          sortable: true
        },
        {
          title: "昵称",
          key: "nickname",
          sortable: true,
          minWidth: 120
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
        }
      ],
      data: [], // 表单数据
      total: 0 // 表单数据总数
    };
  },
  methods: {
    init() {},
    changePage(v) {
      this.searchForm.pageNumber = v;
      this.getDataList();
      this.clearSelectAll();
    },
    changePageSize(v) {
      this.searchForm.pageSize = v;
      this.getDataList();
    },
    changeSort(e) {
      this.searchForm.sort = e.key;
      this.searchForm.order = e.order;
      if (e.order == "normal") {
        this.searchForm.order = "";
      }
    },
    handleReset() {
      this.$refs.searchForm.resetFields();
      this.searchForm.inviteBy = this.transferData.id;
      // 重新加载数据
      this.getDataList();
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
    setCurrentValue(value) {
      if (value === this.visible) {
        return;
      }
      this.queryUser = this.transferData.nickname;
      this.searchForm.inviteBy = this.transferData.username;
      this.getDataList();
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
  mounted() {}
};
</script>