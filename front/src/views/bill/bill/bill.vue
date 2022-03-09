<template>
<div class="search">
    <add v-if="currView=='add'" @close="currView='index'" @submited="submited" />
    <edit v-if="currView=='edit'" @close="currView='index'" @submited="submited" :data="formData" />
    <Card v-show="currView=='index'">
        <Row v-show="openSearch" @keydown.enter.native="handleSearch">
            <Form ref="searchForm" :model="searchForm" inline :label-width="70">
                <Form-item label="供应商" prop="supplierId">
                    <Select v-model="searchForm.supplierId" clearable style="width:200px" placeholder="请输入供应商">
                        <Option v-for="(item, i) in this.supplierList" :key="i" :value="item.id">{{item.name}}</Option>
                    </Select>
                    <!-- <Input type="text" v-model="searchForm.supplierId" placeholder="请输入供应商ID" clearable style="width: 200px"/> -->
                </Form-item>
                <Form-item label="商品" prop="commodityId">
                    <Select v-model="searchForm.commodityId" clearable style="width:200px" placeholder="请输入商品名称">
                        <Option v-for="(item, i) in this.commodityList" :key="i" :value="item.id">{{item.name}}</Option>
                    </Select>
                    <!-- <Input type="text" v-model="searchForm.commodityId" placeholder="请输入商品ID" clearable style="width: 200px"/> -->
                </Form-item>
                <Form-item label="负责员工" prop="userId">
                    <Input type="text" v-model="searchForm.userName" placeholder="请输入负责员工项目" clearable style="width: 200px" />
                </Form-item>
                <Form-item style="margin-left:-35px;" class="br">
                    <Button @click="handleSearch" type="primary" icon="ios-search" ghost>搜索</Button>
                    <Button @click="handleReset" type="warning" ghost>重置</Button>
                </Form-item>
            </Form>
        </Row>
        <Row class="operation">
            <Button @click="add" type="primary" icon="md-add" ghost>添加</Button>
            <Button @click="delAll" type="error" icon="md-trash" ghost>批量删除</Button>
            <Button @click="getDataList" type="success" icon="md-refresh" ghost>刷新</Button>
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
            <Table :loading="loading" border :columns="columns" :data="data" ref="table" sortable="custom" @on-sort-change="changeSort" @on-selection-change="changeSelect"></Table>
        </Row>
        <Row type="flex" justify="end" class="page">
            <Page :current="searchForm.pageNumber" :total="total" :page-size="searchForm.pageSize" @on-change="changePage" @on-page-size-change="changePageSize" :page-size-opts="[10,20,50]" size="small" show-total show-elevator show-sizer></Page>
        </Row>
    </Card>
</div>
</template>

<script>
import {
    getBillList,
    deleteBill,
    getAllSupplierList,
    getAllCommodityList
} from "./api.js";
import add from "./add.vue";
import edit from "./edit.vue";
export default {
    name: "single-window",
    components: {
        add,
        edit
    },
    data() {
        return {
            openSearch: true,
            openTip: true,
            formData: {},
            currView: "index",
            loading: true,
            searchForm: {
                pageNumber: 1,
                pageSize: 10,
                sort: "createTime",
                order: "desc",
            },
            selectList: [],
            selectCount: 0,
            columns: [
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
                    title: "商品",
                    key: "commodityName",
                    minWidth: 120,
                    sortable: false,
                },
                {
                    title: "数量",
                    key: "number",
                    minWidth: 120,
                    sortable: false,
                },
                {
                    title: "单价",
                    key: "price",
                    minWidth: 120,
                    sortable: false,
                },
                {
                    title: "总价",
                    key: "sum",
                    minWidth: 120,
                    sortable: false,
                },
                {
                    title: "进货时间",
                    key: "dateTime",
                    minWidth: 120,
                    sortable: false,
                },
                {
                    title: "供应商",
                    key: "supplierName",
                    minWidth: 120,
                    sortable: false,
                },
                {
                    title: "负责员工",
                    key: "userName",
                    minWidth: 120,
                    sortable: false,
                },
                {
                    title: "操作",
                    key: "action",
                    align: "center",
                    width: 200,
                    render: (h, params) => {
                        return h("div", [
                            h(
                                "Button", {
                                    props: {
                                        type: "primary",
                                        size: "small",
                                        icon: "ios-create-outline",
                                        ghost: true
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
                                "Button", {
                                    props: {
                                        type: "error",
                                        size: "small",
                                        icon: "md-trash",
                                        ghost: true
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
            data: [],
            pageNumber: 1,
            pageSize: 10,
            total: 0,
            commodityList: [],
            supplierList: []
        };
    },
    methods: {
        init() {
            getAllSupplierList().then(res => {
                this.supplierList = res.result;
            });
            getAllCommodityList().then(res => {
                this.commodityList = res.result;
            })
            this.getDataList();
        },
        submited() {
            this.currView = "index";
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
        handleSearch() {
            this.searchForm.pageNumber = 1;
            this.searchForm.pageSize = 10;
            this.getDataList();
        },
        handleReset() {
            this.$refs.searchForm.resetFields();
            this.searchForm.pageNumber = 1;
            this.searchForm.pageSize = 10;
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
        getDataList() {
            this.loading = true;
            getBillList(this.searchForm).then(res => {
                this.loading = false;
                if (res.success) {
                    this.data = res.result.records;
                    this.total = res.result.total;
                }
            });
        },
        add() {
            this.currView = "add";
        },
        edit(v) {
            for (let attr in v) {
                if (v[attr] == null) {
                    v[attr] = "";
                }
            }
            let str = JSON.stringify(v);
            let data = JSON.parse(str);
            this.formData = data;
            this.currView = "edit";
        },
        remove(v) {
            this.$Modal.confirm({
                title: "确认删除",
                content: "您确认要删除 ?",
                loading: true,
                onOk: () => {
                    deleteBill({
                        ids: v.id
                    }).then(res => {
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
                    this.selectList.forEach(function (e) {
                        ids += e.id + ",";
                    });
                    ids = ids.substring(0, ids.length - 1);
                    deleteBill({
                        ids: ids
                    }).then(res => {
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
.search {
    .operation {
        margin-bottom: 2vh;
    }

    .select-count {
        font-weight: 600;
        color: #40a9ff;
    }

    .select-clear {
        margin-left: 10px;
    }

    .page {
        margin-top: 2vh;
    }

    .drop-down {
        margin-left: 5px;
    }
}
</style>
