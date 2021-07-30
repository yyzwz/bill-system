// 统一请求路径前缀在libs/axios.js中修改
import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

// 分页获取数据
export const getBillList = (params) => {
    return getRequest('/bill/getByPage', params)
}
// 添加
export const addBill = (params) => {
    return postRequest('/bill/insert', params)
}
// 编辑
export const editBill = (params) => {
    return postRequest('/bill/update', params)
}
// 删除
export const deleteBill = (params) => {
    return postRequest('/bill/delByIds', params)
}
// 获取所有供应商
export const getAllSupplierList = (params) => {
    return getRequest('/supplier/getAll', params)
}

// 获取所有供应商
export const getAllCommodityList = (params) => {
    return getRequest('/commodity/getAll', params)
}