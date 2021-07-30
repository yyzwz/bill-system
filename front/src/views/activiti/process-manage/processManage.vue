<style lang="less">
@import "../../../styles/table-common.less";
@import "./processManage.less";
</style>
<template>
  <div class="search">
    <processNodeEdit
      v-if="showProcessNodeEdit"
      @close="showProcessNodeEdit=false"
      :nodeEditData="nodeEditData"
      @submited="getDataList"
    />
    <Card v-show="!showProcessNodeEdit">
      <Row v-show="openSearch" @keydown.enter.native="handleSearch">
        <Form ref="searchForm" :model="searchForm" inline :label-width="70">
          <Form-item label="流程名称" prop="name">
            <Input
              type="text"
              v-model="searchForm.name"
              placeholder="请输入名称"
              clearable
              style="width: 200px"
            />
          </Form-item>
          <Form-item label="标识Key" prop="processKey">
            <Input
              type="text"
              v-model="searchForm.processKey"
              placeholder="请输入标识"
              clearable
              style="width: 200px"
            />
          </Form-item>
          <Form-item label="部署时间">
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
          <Form-item style="margin-left:-35px;" class="br">
            <Button @click="handleSearch" type="primary" icon="ios-search">搜索</Button>
            <Button @click="handleReset">重置</Button>
          </Form-item>
        </Form>
      </Row>
      <Row class="operation">
        <Button @click="deploy" type="primary" icon="md-cloud-upload">部署流程文件</Button>
        <Button @click="delAll" icon="md-trash">批量删除</Button>
        <Button @click="getDataList" icon="md-refresh">刷新</Button>
        <i-switch
          size="large"
          v-model="searchForm.showLatest"
          @on-change="changeLatest"
          style="margin:0 5px"
        >
          <span slot="open">最新</span>
          <span slot="close">全部</span>
        </i-switch>
        <Button type="dashed" @click="openSearch=!openSearch">{{openSearch ? "关闭搜索" : "开启搜索"}}</Button>
        <Button type="dashed" @click="openTip=!openTip">{{openTip ? "关闭提示" : "开启提示"}}</Button>
      </Row>
      <Row v-show="openTip">
        <Alert show-icon>
          已选择
          <span class="select-count">{{selectCount}}</span> 项
          <a class="select-clear" @click="clearSelectAll">清空</a>
          <span style="margin-left:20px">说明：当有多个相同标识的流程时，默认仅显示其最新版本</span>
        </Alert>
      </Row>
      <Row>
        <Table
          :loading="loading"
          border
          :columns="columns"
          :data="data"
          sortable="custom"
          @on-sort-change="changeSort"
          @on-selection-change="showSelect"
          ref="table"
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

    <!-- 部署流程文件 -->
    <Modal title="部署流程文件" footer-hide v-model="modalVisible" :mask-closable="false" :width="500">
      <Upload
        :action="deployByFileUrl"
        :headers="accessToken"
        :on-success="handleSuccess"
        :on-error="handleError"
        :format="['zip','bar','bpmn','xml']"
        :max-size="5120"
        :on-format-error="handleFormatError"
        :on-exceeded-size="handleMaxSize"
        type="drag"
        ref="up"
      >
        <div style="padding: 20px 0">
          <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
          <p>点击这里或将文件拖拽到这里上传</p>请选择BPMN文件，仅支持zip、bpmn20.xml、bar、bpmn格式文件
        </div>
      </Upload>
    </Modal>
    <!-- 图片预览 -->
    <Modal :title="viewTitle" v-model="viewImage" draggable width="800">
      <img :src="diagramUrl" alt="无效的图片链接" style="width: 100%;margin: 0 auto;display: block;" />
      <div slot="footer">
        <Button @click="viewImage=false" style="margin-right:5px">关闭</Button>
        <Button :to="diagramUrl" target="_blank" type="primary">下载</Button>
      </div>
    </Modal>
  </div>
</template>

<script>
import {
  getProcessDataList,
  updateInfo,
  updateStatus,
  deployByFile,
  exportResource,
  convertToModel,
  deleteProcess,
  initActCategory,
  loadActCategory,
  searchActCategory
} from "@/api/activiti";
import { getDictDataByType } from "@/api/index";
import processNodeEdit from "./processNodeEdit.vue";
export default {
  name: "process-manage",
  components: {
    processNodeEdit
  },
  data() {
    return {
      showProcessNodeEdit: false,
      nodeEditData: {},
      openSearch: true,
      openTip: true,
      accessToken: {},
      deployByFileUrl: "",
      loading: true, // 表单加载状态
      selectCount: 0, // 多选计数
      selectList: [], // 多选数据
      modalVisible: false,
      viewImage: false,
      viewTitle: "流程图片预览",
      diagramUrl: "",
      searchForm: {
        // 搜索框对应data对象
        showLatest: true,
        name: "",
        processKey: "",
        status: "",
        pageNumber: 1, // 当前页数
        pageSize: 10, // 页面大小
        sort: "createTime", // 默认排序字段
        order: "desc", // 默认排序方式
        startDate: "", // 起始时间
        endDate: "" // 终止时间
      },
      selectDate: null, // 选择日期绑定modal
      columns: [
        // 表头
        {
          type: "selection",
          width: 60,
          align: "center"
        },
        {
          type: "index",
          width: 60,
          align: "center"
        },
        {
          title: "名称",
          key: "name",
          minWidth: 150,
          sortable: true
        },
        {
          title: "标识Key",
          key: "processKey",
          width: 130,
          sortable: true
        },
        {
          title: "版本",
          key: "version",
          width: 90,
          align: "center",
          sortable: true,
          render: (h, params) => {
            let re = "";
            if (params.row.version) {
              re = "v." + params.row.version;
            }
            return h("div", re);
          }
        },
        {
          title: "流程图片",
          key: "diagramName",
          width: 160,
          sortable: true,
          render: (h, params) => {
            return h("div", [
              h(
                "a",
                {
                  on: {
                    click: () => {
                      this.showResource(1, params.row);
                    }
                  }
                },
                params.row.diagramName
              )
            ]);
          }
        },
        {
          title: "流程XML",
          key: "xmlName",
          width: 160,
          sortable: true,
          render: (h, params) => {
            return h("div", [
              h(
                "a",
                {
                  on: {
                    click: () => {
                      this.showResource(0, params.row);
                    }
                  }
                },
                params.row.xmlName
              )
            ]);
          }
        },
        {
          title: "关联表单路由名",
          key: "routeName",
          width: 160,
          sortable: true,
          render: (h, params) => {
            let re = "";
            this.dictForm.forEach(e => {
              if (e.value == params.row.routeName) {
                re = `${e.title} (${e.value})`;
              }
            });
            return h("div", re);
          }
        },
        {
          title: "数据库业务表",
          key: "businessTable",
          width: 170,
          sortable: true,
          render: (h, params) => {
            let re = "";
            this.dictTable.forEach(e => {
              if (e.value == params.row.businessTable) {
                re = `${e.title} (${e.value})`;
              }
            });
            return h("div", re);
          }
        },
        {
          title: "所属分类",
          key: "categoryTitle",
          width: 130,
          sortable: true
        },
        {
          title: "状态",
          key: "status",
          align: "center",
          width: 130,
          render: (h, params) => {
            if (params.row.status == 1) {
              return h("div", [
                h("Badge", {
                  props: {
                    status: "success",
                    text: "已激活"
                  }
                })
              ]);
            } else if (params.row.status == 0) {
              return h("div", [
                h("Badge", {
                  props: {
                    status: "error",
                    text: "已挂起"
                  }
                })
              ]);
            }
          },
          filters: [
            {
              label: "已激活",
              value: 1
            },
            {
              label: "已挂起",
              value: 0
            }
          ],
          filterMultiple: false,
          filterMethod(value, row) {
            if (value == 0) {
              return row.status == 0;
            } else if (value == 1) {
              return row.status == 1;
            }
          }
        },
        {
          title: "备注描述",
          key: "description",
          width: 150,
          sortable: true
        },
        {
          title: "部署时间",
          key: "createTime",
          width: 180,
          sortable: true,
          sortType: "desc"
        },
        {
          title: "更新时间",
          key: "updateTime",
          width: 180,
          sortable: true
        },
        {
          title: "操作",
          key: "action",
          width: 320,
          align: "center",
          fixed: "right",
          render: (h, params) => {
            let suspendOrActive = "";
            if (params.row.status == 0) {
              // 挂起可激活
              suspendOrActive = h(
                "Button",
                {
                  props: {
                    type: "success",
                    size: "small",
                    icon: "md-play"
                  },
                  style: {
                    marginRight: "5px"
                  },
                  on: {
                    click: () => {
                      this.editStatus(1, params.row);
                    }
                  }
                },
                "激活"
              );
            } else {
              // 激活可挂起
              suspendOrActive = h(
                "Button",
                {
                  props: {
                    type: "warning",
                    size: "small",
                    icon: "md-pause"
                  },
                  style: {
                    marginRight: "5px"
                  },
                  on: {
                    click: () => {
                      this.editStatus(0, params.row);
                    }
                  }
                },
                "挂起"
              );
            }
            return h("div", [
              suspendOrActive,
              h(
                "Button",
                {
                  props: {
                    type: "primary",
                    size: "small",
                    icon: "ios-construct"
                  },
                  style: {
                    marginRight: "5px"
                  },
                  on: {
                    click: () => {
                      this.editNode(params.row);
                    }
                  }
                },
                "流程配置"
              ),
              h(
                "Button",
                {
                  props: {
                    size: "small"
                  },
                  style: {
                    marginRight: "5px"
                  },
                  on: {
                    click: () => {
                      this.convert(params.row);
                    }
                  }
                },
                "转模型"
              ),
              h(
                "Button",
                {
                  props: {
                    type: "error",
                    size: "small"
                  },
                  on: {
                    click: () => {
                      this.remove(params.row);
                    }
                  }
                },
                "删除"
              )
            ]);
          }
        }
      ],
      data: [], // 表单数据
      total: 0, // 表单数据总数
      dictTable: [],
      dictForm: []
    };
  },
  methods: {
    init() {
      this.accessToken = {
        accessToken: this.getStore("accessToken")
      };
      this.deployByFileUrl = deployByFile;
      this.getDataList();
      this.getDictDataType();
    },
    getDictDataType() {
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
    changeLatest(){
      this.searchForm.pageNumber = 1;
      this.getDataList();
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
    selectDateRange(v) {
      if (v) {
        this.searchForm.startDate = v[0];
        this.searchForm.endDate = v[1];
      }
    },
    getDataList() {
      this.loading = true;
      getProcessDataList(this.searchForm).then(res => {
        this.loading = false;
        if (res.success) {
          this.data = res.result.content;
          this.total = res.result.totalElements;
        }
      });
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
      if (e.order == "normal") {
        this.searchForm.order = "";
      }
      this.getDataList();
    },
    deploy(v) {
      this.modalVisible = true;
    },
    handleFormatError(file) {
      this.$Notice.warning({
        title: "不支持的文件格式",
        desc:
          "所选文件‘ " +
          file.name +
          " ’格式不正确, 请选择 .zip .bar .bpmn .bpmn20.xml格式文件"
      });
    },
    handleMaxSize(file) {
      this.$Notice.warning({
        title: "文件大小过大",
        desc: "所选文件‘ " + file.name + " ’大小过大, 不得超过 5M."
      });
    },
    handleSuccess(res, file) {
      if (res.success) {
        this.$Message.success("部署成功，请继续编辑完善流程信息");
        this.modalVisible = false;
        this.getDataList();
      } else {
        this.$Message.error(res.message);
      }
    },
    handleError(error, file, fileList) {
      this.$Message.error(error.toString());
    },
    editNode(v) {
      this.nodeEditData = v;
      this.showProcessNodeEdit = true;
    },
    editStatus(status, v) {
      let operation = "";
      if (status == 0) {
        operation = "暂停挂起";
      } else {
        operation = "激活运行";
      }
      this.$Modal.confirm({
        title: "确认" + operation,
        content: `您确认要${operation}流程${v.name}?`,
        loading: true,
        onOk: () => {
          let params = {
            status: status,
            id: v.id
          };
          updateStatus(params).then(res => {
            this.$Modal.remove();
            if (res.success) {
              this.$Message.success("操作成功");
              this.getDataList();
            }
          });
        }
      });
    },
    convert(v) {
      let that = this;
      this.$Modal.confirm({
        title: "确认转化",
        content: "您确认要转化流程 " + v.name + " 为模型?",
        loading: true,
        onOk: () => {
          convertToModel(v.id).then(res => {
            this.$Modal.remove();
            if (res.success) {
              setTimeout(function() {
                that.showJump();
              }, 300);
            }
          });
        }
      });
    },
    showJump() {
      this.$Modal.confirm({
        title: "转化成功",
        content: "是否立即跳转查看该模型?",
        onOk: () => {
          this.$router.push({
            name: "model-manage"
          });
        }
      });
    },
    showResource(type, v) {
      if (type == 0) {
        window.open(
          `${exportResource}?id=${
            v.id
          }&type=${type}&accessToken=${this.getStore("accessToken")}`
        );
      } else if (type == 1) {
        this.viewTitle = "流程图片预览(" + v.diagramName + ")";
        this.diagramUrl = `${exportResource}?id=${
          v.id
        }&type=${type}&accessToken=${this.getStore("accessToken")}`;
        this.viewImage = true;
      }
    },
    remove(v) {
      this.$Modal.confirm({
        title: "确认删除",
        content: "您确认要删除流程 " + v.name + " ?",
        loading: true,
        onOk: () => {
          deleteProcess({ids: v.id}).then(res => {
            this.$Modal.remove();
            if (res.success) {
              this.$Message.success("操作成功");
              this.getDataList();
            }
          });
        }
      });
    },
    showSelect(e) {
      this.selectList = e;
      this.selectCount = e.length;
    },
    clearSelectAll() {
      this.$refs.table.selectAll(false);
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
          deleteProcess({ids: ids}).then(res => {
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
  },
  watch: {
    // 监听路由变化
    $route(to, from) {
      if (to.name == "process-manage") {
        this.getDataList();
      }
    }
  }
};
</script>