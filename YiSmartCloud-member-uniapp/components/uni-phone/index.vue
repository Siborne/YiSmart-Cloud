<template>
  <view>
    <view v-if="visible" class="mask" @tap="close"></view>
    <view v-if="visible" class="panel">
      <view class="title">联系电话</view>
      <view class="number">400-800-8888</view>
      <button class="btn" @tap="close">关闭</button>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'

const visible = ref(false)
const popup = {
  open: () => {
    visible.value = true
  },
  close: () => {
    visible.value = false
  }
}
defineExpose({ popup })

function close() {
  visible.value = false
}
</script>

<style scoped>
.mask { position: fixed; inset: 0; background: rgba(0, 0, 0, 0.35); z-index: 98; }
.panel { position: fixed; left: 40rpx; right: 40rpx; top: 35%; background: #fff; border-radius: 16rpx; z-index: 99; padding: 32rpx; text-align: center; }
.title { font-size: 30rpx; font-weight: 600; }
.number { margin: 24rpx 0; color: var(--ys-primary); font-size: 40rpx; }
.btn { background: var(--ys-primary); color: #fff; }
</style>
