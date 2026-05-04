import { request } from '@/utils/request'
export const addReservation = (params) => request({ url: '/member/reservation', method: 'POST', params })
export const getSlotList = (params) => request({ url: '/member/reservation/countByTime', method: 'GET', params })
export const getList = (params) => request({ url: '/member/reservation/page', method: 'GET', params })
export const cancelReservation = (id) => request({ url: `/member/reservation/${id}/cancel`, method: 'PUT' })
export const cancelCount = () => request({ url: '/member/reservation/cancelled-count', method: 'GET' })
