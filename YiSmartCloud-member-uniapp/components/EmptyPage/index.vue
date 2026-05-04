<template>
  <view class="empty">
    <image class="img" src="/static/zwnr2x.png" mode="widthFix" />
    <text>{{ text }}</text>
  </view>
</template>

<script setup>
defineProps({ text: { type: String, default: '暂无内容' } })
</script>

<style scoped>
.empty { padding: 40rpx; text-align: center; color: #b2b2b2; }
.img { width: 220rpx; margin: 20rpx auto; display: block; }
</style>
