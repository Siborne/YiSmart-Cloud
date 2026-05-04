import { baseUrl, notToLoginApiUrl } from './env'

export function request({ url = '', params = {}, method = 'GET' }) {
  const token = uni.getStorageSync('token')
  const isNoLoginApi = notToLoginApiUrl.includes(url)
  const header = {
    'Content-Type': 'application/json;charset=UTF-8'
  }
  // Avoid sending stale/invalid token on login-like endpoints.
  if (!isNoLoginApi && token) {
    header.authorization = token
  }

  return new Promise((resolve, reject) => {
    uni.request({
      url: baseUrl + url,
      data: params,
      method,
      header,
      success: (res) => {
        const data = res.data || {}
        if (data.code === 0 || data.code === 200) {
          resolve(data)
          return
        }
        if (data.code === 401) {
          uni.removeStorageSync('token')
          uni.removeStorageSync('nickName')
          if (!notToLoginApiUrl.includes(url)) {
            setTimeout(() => {
              uni.navigateTo({ url: '/pages/login/index' })
            }, 500)
          }
          reject(data)
          return
        }
        uni.showToast({ title: data.msg || '请求失败', icon: 'none' })
        reject(data)
      },
      fail: (err) => reject({ data: { msg: (err && err.errMsg) || 'network error' } })
    })
  })
}
