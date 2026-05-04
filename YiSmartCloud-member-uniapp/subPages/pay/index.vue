<template>
  <view class="main-page">
    <nav-bar title="支付" :is-show-back="true" />
    <view class="section">
      <view>订单ID：{{ orderId || '-' }}</view>
      <view class="mt">金额：{{ amount || '-' }}</view>
      <button class="btn" :loading="loading" @tap="pay">确认支付</button>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'

const orderId = ref('')
const amount = ref('')
const loading = ref(false)

onLoad((options) => {
  orderId.value = options?.orderId || ''
  amount.value = options?.amount || ''
})

function pay() {
  loading.value = true
  setTimeout(() => {
    loading.value = false
    uni.redirectTo({ url: '/subPages/success/index?from=pay' })
  }, 500)
}
</script>

<style scoped>
.mt { margin-top: 10rpx; color: #666; }
.btn { margin-top: 20rpx; background: var(--ys-primary); color: #fff; }
</style>
