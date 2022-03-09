<template>
<div class="search">
    <add v-if="currView=='add'" @close="currView='index'" @submited="submited" />
    <edit v-if="currView=='edit'" @close="currView='index'" @submited="submited" :data="formData" />
    <Card v-show="currView=='index'">
        <Row @keydown.enter.native="handleSearch">
            <Form ref="searchForm" :model="searchForm" inline :label-width="70" class="search-form">
                <Form-item label="商品名称" prop="name">
                    <Input type="text" v-model="searchForm.name" placeholder="请输入商品名称" clearable style="width: 200px" />
                </Form-item>
                <Form-item label="商品单价" prop="unitPrice">
                    <Input type="text" v-model="searchForm.unitPrice" placeholder="请输入商品单价" clearable style="width: 200px" />
                </Form-item>
                <span v-if="drop">
                    <Form-item label="库存" prop="stock">
                        <Input type="text" v-model="searchForm.stock" placeholder="请输入库存" clearable style="width: 200px" />
                    </Form-item>
                    <Form-item label="商品分类" prop="type">
                        <Select v-model="searchForm.type">
                            <Option value="水果">水果</Option>
                            <Option value="零食">零食</Option>
                            <Option value="玩具">玩具</Option>
                        </Select>
                        <!-- <Input type="text" v-model="searchForm.type" placeholder="请输入商品分类" clearable style="width: 200px"/> -->
                    </Form-item>
                    <FormItem label="供应商" prop="supplierId">
                        <Select v-model="searchForm.supplierId" clearable style="width:200px">
                            <Option v-for="(item, i) in this.supplierList" :key="i" :value="item.id">{{item.name}}</Option>
                        </Select>
                    </FormItem>
                </span>
                <Form-item style="margin-left:-35px;" class="br">
                    <Button @click="handleSearch" type="primary" icon="ios-search" ghost>搜索</Button>
                    <Button @click="handleReset" type="warning" ghost>重置</Button>
                    <a class="drop-down" @click="dropDown">
                        {{dropDownContent}}
                        <Icon :type="dropDownIcon"></Icon>
                    </a>
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
    getCommodityList,
    deleteCommodity
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
            drop: false,
            dropDownContent: "展开",
            dropDownIcon: "ios-arrow-down",
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
                    title: "商品名称",
                    key: "name",
                    minWidth: 120,
                    sortable: true,
                },
                {
                    title: "商品单价",
                    key: "unitPrice",
                    minWidth: 120,
                    sortable: true,
                },
                {
                    title: "库存",
                    key: "stock",
                    minWidth: 120,
                    sortable: true,
                },
                {
                    title: "商品分类",
                    key: "type",
                    minWidth: 120,
                    sortable: true,
                },
                {
                    title: "供应商",
                    key: "supplierName",
                    minWidth: 120,
                    sortable: true,
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
            total: 0
        };
    },
    methods: {
        init() {
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
        clearSelectAll() {
            this.$refs.table.selectAll(false);
        },
        changeSelect(e) {
            this.selectList = e;
            this.selectCount = e.length;
        },
        getDataList() {
            this.loading = true;
            getCommodityList(this.searchForm).then(res => {
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
                    deleteCommodity({
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
                    deleteCommodity({
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
