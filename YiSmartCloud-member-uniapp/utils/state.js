function getGlobalData() {
  const app = getApp && getApp()
  if (!app.globalData) app.globalData = {}
  return app.globalData
}

export function getFootStatus() {
  return Number(uni.getStorageSync('footStatus') || 0)
}

export function setFootStatus(status) {
  uni.setStorageSync('footStatus', Number(status || 0))
  const globalData = getGlobalData()
  globalData.footStatus = Number(status || 0)
}

export function getRouter() {
  const globalData = getGlobalData()
  return globalData.router || uni.getStorageSync('router') || ''
}

export function setRouter(route) {
  uni.setStorageSync('router', route || '')
  const globalData = getGlobalData()
  globalData.router = route || ''
}
