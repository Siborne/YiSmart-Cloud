<template>
  <view class="main-page">
    <nav-bar title="绑定家人" :is-show-back="true" />
    <view class="section">
      <input v-model="form.name" class="input" placeholder="请输入家人姓名" />
      <input v-model="form.phone" class="input" placeholder="请输入手机号" type="number" maxlength="11" />
      <button class="btn" :loading="submitting" @tap="submit">提交绑定</button>
    </view>
  </view>
</template>

<script setup>
import { reactive, ref } from 'vue'
import { elderBinging } from '@/api/family'

const submitting = ref(false)
const form = reactive({ name: '', phone: '' })

async function submit() {
  if (!form.name || !form.phone) {
    uni.showToast({ title: '请填写完整信息', icon: 'none' })
    return
  }
  submitting.value = true
  try {
    const res = await elderBinging({ elderName: form.name, phone: form.phone })
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
.input { background: #fff; border: 1px solid #eee; border-radius: 10rpx; padding: 20rpx; margin-bottom: 20rpx; }
.btn { background: var(--ys-primary); color: #fff; }
</style>
