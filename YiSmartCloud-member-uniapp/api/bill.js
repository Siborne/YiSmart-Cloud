import { request } from '@/utils/request'
export const getBillList = (params) => request({ url: '/member/bill/page/', method: 'GET', params })
export const getBillDetail = (id) => request({ url: `/member/bill/${id}`, method: 'GET' })
export const billPay = (params) => request({ url: '/member/bill', method: 'PUT', params })
