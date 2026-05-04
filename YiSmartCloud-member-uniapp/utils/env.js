export const baseUrl = process.env.NODE_ENV === 'development'
  ? 'http://127.0.0.1:8080'
  : 'http://127.0.0.1:8080'

export const notToLoginApiUrl = [
  '/serve/member/user/login',
  '/serve/member/user/basic-login',
  '/serve/member/user/register'
]
