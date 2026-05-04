export function tostTip(title) {
  uni.showToast({ title: title || '提示', icon: 'none', duration: 1500 })
}

export function decimalsReplenish(value) {
  return Number(value || 0).toFixed(2)
}

export function warnBlank(val) {
  const data = val && val.detail && val.detail.value !== undefined ? val.detail.value : val
  return String(data || '').replace(/\s/g, '')
}
