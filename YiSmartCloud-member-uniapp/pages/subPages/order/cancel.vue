<template>
  <view class="main-page ys-page-tint cancel-page">
    <nav-bar title="取消订单" :is-show-back="true" />
    <view class="section cancel-card">
      <view class="group-title">订单编号</view>
      <view class="readonly-strip">{{ orderId || '—' }}</view>
      <view class="group-title field-spaced">取消原因</view>
      <textarea v-model="reason" class="ys-field-area" placeholder="请说明取消原因，便于我们改进服务" />
      <button class="ys-btn-primary submit" :loading="loading" @tap="submit">确认取消</button>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { cancelOrder } from '@/api/order'

const orderId = ref('')
const reason = ref('')
const loading = ref(false)

onLoad((options) => {
  orderId.value = options?.id || ''
})

async function submit() {
  if (!orderId.value) {
    uni.showToast({ title: '缺少订单ID', icon: 'none' })
    return
  }
  loading.value = true
  try {
    const res = await cancelOrder({ orderId: orderId.value, reason: reason.value || '用户取消' })
    if (res?.code === 200) {
      uni.showToast({ title: '已取消', icon: 'none' })
      setTimeout(() => uni.redirectTo({ url: '/pages/subPages/order/index' }), 300)
    } else {
      uni.showToast({ title: res?.msg || '取消失败', icon: 'none' })
    }
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.cancel-page {
  padding-bottom: calc(40rpx + env(safe-area-inset-bottom));
}
.cancel-card {
  margin-top: 8rpx;
}
.group-title {
  font-size: 26rpx;
  font-weight: 600;
  color: var(--ys-text-secondary);
  margin-bottom: 12rpx;
}
.field-spaced {
  margin-top: 28rpx;
}
.readonly-strip {
  padding: 22rpx 24rpx;
  background: var(--ys-bg);
  border-radius: var(--ys-radius);
  border: 2rpx solid var(--ys-border);
  font-size: 28rpx;
  color: var(--ys-text);
  word-break: break-all;
}
.submit {
  width: 100%;
  margin-top: 32rpx;
}
</style>
