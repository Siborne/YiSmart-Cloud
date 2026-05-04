import { request } from '@/utils/request'
export const getElderList = (params) => request({ url: '/member/user/list-by-page', method: 'GET', params })
export const getAllElderList = (params) => request({ url: '/member/user/my', method: 'GET', params })
export const elderBinging = (params) => request({ url: '/member/user/add', method: 'POST', params })
export const deviceDetail = (iotId) => request({ url: `/member/user/queryServiceProperties/${iotId}`, method: 'GET' })
export const elderdeleteById = (id) => request({ url: `/member/user/deleteById?id=${id}`, method: 'DELETE' })
export const elderBloodPresh = (params) => request({ url: '/member/user/queryDeviceDataListByDay', method: 'GET', params })
export const elderBloodPreshPing = (params) => request({ url: '/member/user/queryDeviceDataListByWeek', method: 'GET', params })
export const getUnusualDataApi = (params) => request({ url: '/member/user/queryDeviceDataListByDay', method: 'GET', params })
