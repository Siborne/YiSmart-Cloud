import { request } from '@/utils/request'
export const getOrderList = (params) => request({ url: '/member/orders/order/page', method: 'GET', params })
export const getOrderDetail = (id) => request({ url: `/member/orders/${id}`, method: 'GET' })
export const cancelOrder = (params) => request({ url: `/member/orders/${params.orderId}/cancel?reason=${params.reason || ''}`, method: 'POST' })
export const orderDelete = (id) => request({ url: `/member/orders/${id}`, method: 'DELETE' })
export const orderRefund = (params) => request({ url: '/member/orders/refund', method: 'POST', params })
