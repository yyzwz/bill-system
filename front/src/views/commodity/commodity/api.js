// 统一请求路径前缀在libs/axios.js中修改
import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

// 分页获取数据
export const getCommodityList = (params) => {
    return getRequest('/commodity/getByPage', params)
}
// 添加
export const addCommodity = (params) => {
    return postRequest('/commodity/insertOrUpdate', params)
}
// 编辑
export const editCommodity = (params) => {
    return postRequest('/commodity/insertOrUpdate', params)
}
// 删除
export const deleteCommodity = (params) => {
    return postRequest('/commodity/delByIds', params)
}
// 获取所有供应商
export const getAllSupplierList = (params) => {
    return getRequest('/supplier/getAll', params)
}