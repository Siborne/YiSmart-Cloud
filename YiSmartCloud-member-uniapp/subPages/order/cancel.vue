<template>
  <view class="main-page">
    <nav-bar title="取消订单" :is-show-back="true" />
    <view class="section">
      <view>订单ID：{{ orderId }}</view>
      <textarea v-model="reason" class="input" placeholder="请输入取消原因" />
      <button class="btn" :loading="loading" @tap="submit">确认取消</button>
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
      setTimeout(() => uni.redirectTo({ url: '/subPages/order/index' }), 300)
    } else {
      uni.showToast({ title: res?.msg || '取消失败', icon: 'none' })
    }
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.input { min-height: 120rpx; margin-top: 20rpx; border: 1px solid #eee; border-radius: 10rpx; padding: 20rpx; }
.btn { margin-top: 20rpx; background: var(--ys-primary); color: #fff; }
</style>
