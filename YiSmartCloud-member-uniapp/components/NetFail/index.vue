<template>
  <view class="net-fail">
    <image class="icon" src="/static/wuwang.png" mode="widthFix" />
    <text class="title">{{ title }}</text>
    <text class="hint">{{ hint }}</text>
    <button v-if="showRetry" class="retry ys-btn-primary" @tap="onRetry">重新加载</button>
  </view>
</template>

<script setup>
defineProps({
  title: { type: String, default: '网络异常' },
  hint: { type: String, default: '请检查网络连接或稍后再试' },
  showRetry: { type: Boolean, default: false }
})

const emit = defineEmits(['retry'])

function onRetry() {
  emit('retry')
}
</script>

<style scoped>
.net-fail {
  padding: 48rpx 32rpx 56rpx;
  text-align: center;
}
.icon {
  width: 200rpx;
  max-width: 65%;
  margin: 0 auto 24rpx;
  display: block;
  opacity: 0.9;
}
.title {
  display: block;
  font-size: 30rpx;
  font-weight: 600;
  color: var(--ys-text, #222);
  line-height: 1.45;
}
.hint {
  display: block;
  margin-top: 12rpx;
  font-size: 24rpx;
  color: var(--ys-text-muted, #8b8b8b);
  line-height: 1.5;
  padding: 0 16rpx;
}
.retry {
  margin-top: 36rpx;
  width: 70%;
  max-width: 420rpx;
}
</style>
