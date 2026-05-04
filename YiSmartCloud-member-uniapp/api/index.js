import { request } from '@/utils/request'
export const getHotHoust = (params) => request({ url: '/member/room', method: 'GET', params })
export const getHotHouse = (params) => request({ url: '/member/room', method: 'GET', params })
