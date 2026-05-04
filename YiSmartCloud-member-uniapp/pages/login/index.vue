<template>
  <view class="main-page ys-page-tint login-page">
    <nav-bar title="登录" :is-show-back="true" :handle-to-link="handleBack" />
    <view class="section login-card">
      <image class="logo" src="/static/logo.png" mode="widthFix" />
      <view class="brand-title">颐智云</view>
      <view class="tips">使用手机号快速登录；新用户可一键注册</view>
      <view class="field-block">
        <text class="label">手机号</text>
        <input v-model="phone" class="ys-field" type="number" maxlength="11" placeholder="请输入11位手机号" />
      </view>
      <view class="field-block">
        <text class="label">昵称（选填）</text>
        <input v-model="nickName" class="ys-field" maxlength="20" placeholder="注册时可填写，方便称呼" />
      </view>
      <button class="ys-btn-primary btn-block" :loading="loginLoading" @tap="handleBasicLogin">登录</button>
      <button class="ys-btn-outline btn-block outline" :loading="registerLoading" @tap="handleRegister">注册并登录</button>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { basicLogin, register } from '@/api/login'
import { getRouter } from '@/utils/state'

const phone = ref('')
const nickName = ref('')
const loginLoading = ref(false)
const registerLoading = ref(false)

function handleBack() {
  uni.navigateBack({ delta: 1 })
}

function sanitizePhone(raw) {
  return String(raw || '').replace(/\D/g, '')
}

function navigateAfterLogin() {
  const router = getRouter()
  if (router) {
    uni.redirectTo({ url: `/${router}` })
  } else {
    uni.reLaunch({ url: '/pages/index/index' })
  }
}

function saveLoginInfo(data) {
  uni.setStorageSync('token', data.token)
  uni.setStorageSync('nickName', data.nickName || '')
}

function validatePhoneValue() {
  const normalized = sanitizePhone(phone.value)
  phone.value = normalized
  if (!/^1\d{10}$/.test(normalized)) {
    uni.showToast({ title: '请输入11位手机号', icon: 'none' })
    return ''
  }
  return normalized
}

async function handleBasicLogin() {
  const normalized = validatePhoneValue()
  if (!normalized) {
    return
  }
  loginLoading.value = true
  try {
    const res = await basicLogin({ phone: normalized })
    if (res && res.code === 200 && res.data && res.data.token) {
      saveLoginInfo(res.data)
      uni.showToast({ title: '登录成功', icon: 'none' })
      navigateAfterLogin()
    } else {
      uni.showToast({ title: (res && res.msg) || '登录失败', icon: 'none' })
    }
  } catch (error) {
    const msg = error && error.data && error.data.msg ? error.data.msg : '登录失败'
    uni.showToast({ title: msg, icon: 'none' })
  } finally {
    loginLoading.value = false
  }
}

async function handleRegister() {
  const normalized = validatePhoneValue()
  if (!normalized) {
    return
  }
  registerLoading.value = true
  try {
    const res = await register({
      phone: normalized,
      nickName: String(nickName.value || '').trim()
    })
    if (res && res.code === 200 && res.data && res.data.token) {
      saveLoginInfo(res.data)
      uni.showToast({ title: '注册成功', icon: 'none' })
      navigateAfterLogin()
    } else {
      uni.showToast({ title: (res && res.msg) || '注册失败', icon: 'none' })
    }
  } catch (error) {
    const msg = error && error.data && error.data.msg ? error.data.msg : '注册失败'
    uni.showToast({ title: msg, icon: 'none' })
  } finally {
    registerLoading.value = false
  }
}
</script>

<style scoped>
.login-page {
  padding-bottom: calc(48rpx + env(safe-area-inset-bottom));
}
.login-card {
  margin-top: 24rpx;
  text-align: center;
}
.logo {
  width: 160rpx;
  margin: 16rpx auto 8rpx;
  display: block;
}
.brand-title {
  font-size: 36rpx;
  font-weight: 700;
  color: var(--ys-text);
  letter-spacing: 2rpx;
}
.tips {
  margin: 16rpx 8rpx 8rpx;
  color: var(--ys-text-muted);
  font-size: 24rpx;
  line-height: 1.45;
  text-align: center;
}
.field-block {
  margin-top: 28rpx;
  text-align: left;
}
.label {
  display: block;
  font-size: 26rpx;
  color: var(--ys-text-secondary);
  margin-bottom: 12rpx;
  font-weight: 500;
}
.btn-block {
  width: 100%;
  margin-top: 32rpx;
}
.outline {
  margin-top: 20rpx;
}
</style>
