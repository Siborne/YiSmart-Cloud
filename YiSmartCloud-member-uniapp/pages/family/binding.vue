<template>
  <view class="main-page ys-page-tint bind-page">
    <nav-bar title="绑定家人" :is-show-back="true" />
    <view class="section bind-card">
      <view class="lead">
        <text class="lead-title">添加家人信息</text>
        <text class="lead-sub">绑定后即可在小程序内查看与管理关联服务</text>
      </view>
      <view class="field-block">
        <text class="label">姓名</text>
        <input v-model="form.name" class="ys-field" placeholder="请输入家人真实姓名" />
      </view>
      <view class="field-block">
        <text class="label">手机号</text>
        <input
          v-model="form.phone"
          class="ys-field"
          placeholder="请输入11位手机号码"
          type="number"
          maxlength="11"
        />
      </view>
      <button class="ys-btn-primary submit" :disabled="!canSubmit" :loading="submitting" @tap="submit">
        提交绑定
      </button>
    </view>
  </view>
</template>

<script setup>
import { reactive, ref, computed } from 'vue'
import { elderBinging } from '@/api/family'

const submitting = ref(false)
const form = reactive({ name: '', phone: '' })

const canSubmit = computed(() => {
  const phone = String(form.phone || '').replace(/\D/g, '')
  return String(form.name || '').trim().length > 0 && /^1\d{10}$/.test(phone)
})

async function submit() {
  if (!canSubmit.value) {
    uni.showToast({ title: '请填写完整信息', icon: 'none' })
    return
  }
  submitting.value = true
  try {
    const res = await elderBinging({
      elderName: String(form.name || '').trim(),
      phone: String(form.phone || '').replace(/\D/g, '')
    })
    if (res?.code === 200) {
      uni.showToast({ title: '绑定成功', icon: 'none' })
      setTimeout(() => uni.navigateBack({ delta: 1 }), 300)
    } else {
      uni.showToast({ title: res?.msg || '绑定失败', icon: 'none' })
    }
  } finally {
    submitting.value = false
  }
}
</script>

<style scoped>
.bind-page {
  padding-bottom: calc(120rpx + env(safe-area-inset-bottom));
}
.bind-card {
  margin-top: 8rpx;
}
.lead {
  margin-bottom: 28rpx;
}
.lead-title {
  display: block;
  font-size: 32rpx;
  font-weight: 700;
  color: var(--ys-text);
}
.lead-sub {
  display: block;
  margin-top: 10rpx;
  font-size: 24rpx;
  color: var(--ys-text-muted);
  line-height: 1.45;
}
.field-block {
  margin-bottom: 24rpx;
}
.label {
  display: block;
  font-size: 26rpx;
  color: var(--ys-text-secondary);
  margin-bottom: 12rpx;
  font-weight: 500;
}
.submit {
  width: 100%;
  margin-top: 12rpx;
}
</style>
