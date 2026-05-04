<template>
  <view class="main-page login-page">
    <nav-bar title="登录" :is-show-back="true" :handle-to-link="handleBack" />
    <view class="section login-card">
      <image class="logo" src="/static/logo.png" mode="widthFix" />
      <view class="tips">最基础模式：手机号登录 / 注册</view>
      <input v-model="phone" class="phone-input" type="number" maxlength="11" placeholder="请输入手机号" />
      <input v-model="nickName" class="phone-input" maxlength="20" placeholder="请输入昵称（注册可填）" />
      <button class="btn" :loading="loginLoading" @tap="handleBasicLogin">登录</button>
      <button class="register-btn" :loading="registerLoading" @tap="handleRegister">注册并登录</button>
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
.login-card { margin-top: 120rpx; text-align: center; }
.logo { width: 180rpx; margin: 40rpx auto; display: block; }
.tips { margin-top: 24rpx; color: #8d8d8d; font-size: 24rpx; }
.phone-input {
  margin-top: 16rpx;
  background: #fff;
  border: 1px solid #ececec;
  border-radius: 10rpx;
  height: 78rpx;
  line-height: 78rpx;
  text-align: left;
  padding: 0 20rpx;
}
.btn {
  margin-top: 14rpx;
  background: var(--ys-primary);
  color: #fff;
}
.register-btn {
  margin-top: 14rpx;
  background: #fff;
  color: var(--ys-primary);
  border: 1px solid var(--ys-primary);
}
</style>
