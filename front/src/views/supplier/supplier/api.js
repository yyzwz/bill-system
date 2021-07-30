// 统一请求路径前缀在libs/axios.js中修改
import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

// 分页获取数据
export const getSupplierList = (params) => {
    return getRequest('/supplier/getByPage', params)
}
// 添加
export const addSupplier = (params) => {
    return postRequest('/supplier/insertOrUpdate', params)
}
// 编辑
export const editSupplier = (params) => {
    return postRequest('/supplier/insertOrUpdate', params)
}
// 删除
export const deleteSupplier = (params) => {
    return postRequest('/supplier/delByIds', params)
}