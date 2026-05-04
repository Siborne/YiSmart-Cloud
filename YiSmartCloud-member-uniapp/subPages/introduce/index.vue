<template>
  <view class="main-page">
    <nav-bar title="机构介绍" :is-show-back="true" />
    <view class="section"><image class="banner" src="/static/map.jpg" mode="widthFix" /></view>
    <view class="section">
      <view>颐智云养老服务机构，提供专业照护、健康管理与生活服务。</view>
      <view class="mt">服务热线：400-800-8888</view>
      <view class="mt">地址：本地联调环境</view>
    </view>
  </view>
</template>

<style scoped>
.banner { width: 100%; border-radius: 10rpx; }
.mt { margin-top: 12rpx; color: #666; }
</style>
