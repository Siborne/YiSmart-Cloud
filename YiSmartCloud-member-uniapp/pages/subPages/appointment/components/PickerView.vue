<template>
  <view class="main-page">
    <nav-bar title="时间选择" :is-show-back="true" />
    <view class="section">
      <view class="item" v-for="(item, index) in list" :key="index" @tap="choose(item)">{{ item }}</view>
    </view>
  </view>
</template>

<script setup>
const list = ['09:00-10:00', '10:00-11:00', '14:00-15:00', '15:00-16:00']

function choose(item) {
  uni.showToast({ title: `已选 ${item}`, icon: 'none' })
  setTimeout(() => uni.navigateBack({ delta: 1 }), 300)
}
</script>

<style scoped>
.item { padding: 20rpx 0; border-bottom: 1px solid #f2f2f2; }
</style>
