<template>
  <view class="main-page intro-page">
    <nav-bar title="养老院介绍" :is-show-back="true" />

    <view class="map-wrap">
      <image class="map-image" src="/static/map.jpg" mode="aspectFill" />
    </view>

    <view class="info-card">
      <view class="org-name">颐智云</view>
      <view class="org-address">北京市神州去宜居街道188号</view>

      <view class="line-list">
        <view class="line-item">
          <image class="line-icon" src="/static/icon-jg.png" mode="aspectFit" />
          <view class="line-text">机构类别：护理型养老机构</view>
        </view>
        <view class="line-item">
          <image class="line-icon" src="/static/icon-zdmj.png" mode="aspectFit" />
          <view class="line-text">占地面积：50,000平方米</view>
        </view>
        <view class="line-item">
          <image class="line-icon" src="/static/icon-bdjr.png" mode="aspectFit" />
          <view class="line-text">收住老人：特困人员、低保、残疾、部分失能、完全失能，能力完好，其他</view>
        </view>
        <view class="line-item">
          <image class="line-icon" src="/static/icon-cwzs.png" mode="aspectFit" />
          <view class="line-text">床位总数：500张</view>
        </view>
        <view class="line-item">
          <image class="line-icon" src="/static/icon-sj.png" mode="aspectFit" />
          <view class="line-text">营业时间：08:00-18:00</view>
        </view>
      </view>

      <view class="gallery">
        <image class="gallery-img" src="/static/pic-01.png" mode="aspectFill" />
        <image class="gallery-img" src="/static/pic-02.png" mode="aspectFill" />
        <image class="gallery-img" src="/static/pic-03.png" mode="aspectFill" />
      </view>

      <button class="consult-btn" @tap="handlePhone">致电咨询</button>
    </view>

    <uni-phone ref="phoneRef" />
  </view>
</template>

<script setup>
import { ref } from 'vue'

const phoneRef = ref(null)

function handlePhone() {
  if (phoneRef.value && phoneRef.value.popup && phoneRef.value.popup.open) {
    phoneRef.value.popup.open()
  }
}
</script>

<style scoped>
.intro-page { background: #f4f4f4; min-height: 100vh; padding-bottom: 40rpx; }
.map-wrap { height: 260rpx; overflow: hidden; }
.map-image { width: 100%; height: 100%; display: block; }

.info-card {
  margin: 0 20rpx;
  background: #fff;
  border-radius: 0 0 16rpx 16rpx;
  padding: 24rpx;
}
.org-name { font-size: 34rpx; font-weight: 700; color: #222; }
.org-address { margin-top: 8rpx; color: #8c8c8c; font-size: 24rpx; }

.line-list { margin-top: 20rpx; border-top: 1px solid #f0f0f0; }
.line-item {
  padding: 16rpx 0;
  display: flex;
  align-items: flex-start;
  border-bottom: 1px solid #f4f4f4;
}
.line-icon { width: 28rpx; height: 28rpx; margin-right: 14rpx; margin-top: 4rpx; flex-shrink: 0; }
.line-text { color: #626262; font-size: 24rpx; line-height: 1.6; }

.gallery { margin-top: 22rpx; display: grid; grid-template-columns: repeat(3, 1fr); gap: 12rpx; }
.gallery-img { width: 100%; height: 120rpx; border-radius: 10rpx; }

.consult-btn {
  margin-top: 26rpx;
  background: #ff6f43;
  color: #fff;
  border-radius: 36rpx;
  font-size: 30rpx;
  height: 76rpx;
  line-height: 76rpx;
}
</style>
