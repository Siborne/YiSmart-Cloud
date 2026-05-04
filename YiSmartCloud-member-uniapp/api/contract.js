import { request } from '@/utils/request'
export const getContractList = (params) => request({ url: '/member/contract/list', method: 'GET', params })
