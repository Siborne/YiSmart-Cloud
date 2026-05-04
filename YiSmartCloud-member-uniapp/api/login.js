import { request } from '@/utils/request'
export const login = (params) => request({ url: '/serve/member/user/login', method: 'POST', params })
export const basicLogin = (params) => request({ url: '/serve/member/user/basic-login', method: 'POST', params })
export const register = (params) => request({ url: '/serve/member/user/register', method: 'POST', params })
