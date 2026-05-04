import { request } from '@/utils/request'
export const getServiceList = (params) => request({ url: '/member/orders/project/page', method: 'GET', params })
export const getServiceDetail = (id) => request({ url: `/member/orders/project/${id}`, method: 'GET' })
export const createServiceOrder = (params) => request({ url: '/member/orders', method: 'POST', params })
export const checkServiceOrder = (params) => request({ url: '/member/orders/check', method: 'POST', params })

// Backward-compatible aliases.
export const goodsDetail = getServiceDetail
export const goodsPay = createServiceOrder
export const goodsViseiOrder = checkServiceOrder
