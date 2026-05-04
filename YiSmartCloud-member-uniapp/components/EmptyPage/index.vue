<template>
  <view class="empty">
    <image class="img" src="/static/zwnr2x.png" mode="widthFix" />
    <text class="title">{{ text }}</text>
    <text v-if="hint" class="hint">{{ hint }}</text>
  </view>
</template>

<script setup>
defineProps({
  text: { type: String, default: '暂无内容' },
  hint: { type: String, default: '' }
})
</script>

<style scoped>
.empty {
  padding: 48rpx 32rpx 56rpx;
  text-align: center;
}
.img {
  width: 240rpx;
  max-width: 70%;
  margin: 0 auto 28rpx;
  display: block;
  opacity: 0.92;
}
.title {
  display: block;
  font-size: 28rpx;
  color: var(--ys-text-secondary, #555);
  font-weight: 500;
  line-height: 1.5;
}
.hint {
  display: block;
  margin-top: 12rpx;
  font-size: 24rpx;
  color: var(--ys-text-muted, #8b8b8b);
  line-height: 1.45;
}
</style>
