<template>
  <view class="main-page my-page">
    <view class="top-wrap" :style="{ paddingTop: statusBarHeight + 'px' }">
      <view class="top-bar">
        <view></view>
        <view class="capsule">
          <view class="capsule-dots">
            <view class="dot"></view>
            <view class="dot"></view>
            <view class="dot"></view>
          </view>
          <view class="capsule-circle"></view>
        </view>
      </view>
      <view class="user-row" @tap="toLogin">
        <image class="avatar" src="/static/head.png" mode="aspectFill" />
        <view class="name">{{ nickName || '立即登录' }}</view>
      </view>
    </view>

    <view class="content">
      <view class="card">
        <view class="card-head">
          <view class="card-title">我的订单</view>
          <view class="card-more" @tap="toOrder">
            <text>查看全部</text>
            <image class="right-arrow mini" src="/static/arrows.png" mode="aspectFit" />
          </view>
        </view>
        <view class="order-grid">
          <view class="order-item" @tap="toOrder">
            <image class="order-icon" src="/static/icon-dzf.png" mode="aspectFit" />
            <view class="order-text">待支付</view>
          </view>
          <view class="order-item" @tap="toOrder">
            <image class="order-icon" src="/static/icon-dfw.png" mode="aspectFit" />
            <view class="order-text">待执行</view>
          </view>
          <view class="order-item" @tap="toOrder">
            <image class="order-icon" src="/static/icon-dwc.png" mode="aspectFit" />
            <view class="order-text">已执行</view>
          </view>
          <view class="order-item" @tap="toOrder">
            <image class="order-icon" src="/static/icon-yzx.png" mode="aspectFit" />
            <view class="order-text">已完成</view>
          </view>
        </view>
      </view>

      <view class="card menu-card">
        <view class="menu-item" @tap="toAppointment">
          <view>我的预约</view>
          <image class="right-arrow" src="/static/arrows.png" mode="aspectFit" />
        </view>
        <view class="menu-item" @tap="toContract">
          <view>我的合同</view>
          <image class="right-arrow" src="/static/arrows.png" mode="aspectFit" />
        </view>
        <view class="menu-item" @tap="toBill">
          <view>我的账单</view>
          <image class="right-arrow" src="/static/arrows.png" mode="aspectFit" />
        </view>
      </view>
    </view>

    <uni-footer page-path="/pages/my/index" />
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onShow, onLoad } from '@dcloudio/uni-app'

const nickName = ref('')
const statusBarHeight = ref(24)

onLoad(() => {
  try {
    const info = uni.getSystemInfoSync()
    statusBarHeight.value = info.statusBarHeight || 24
  } catch (e) {
    statusBarHeight.value = 24
  }
})

onShow(() => {
  nickName.value = uni.getStorageSync('nickName') || ''
})

function toLogin() {
  if (!uni.getStorageSync('token')) {
    uni.navigateTo({ url: '/pages/login/index' })
  }
}

function toOrder() {
  uni.navigateTo({ url: '/pages/subPages/order/index' })
}

function toAppointment() {
  uni.navigateTo({ url: '/pages/subPages/appointment/list/index' })
}

function toContract() {
  uni.navigateTo({ url: '/pages/subPages/contract/index' })
}

function toBill() {
  uni.navigateTo({ url: '/pages/subPages/bill/index' })
}
</script>

<style scoped>
.my-page { background: #f3f3f5; min-height: 100vh; }
.top-wrap {
  background: linear-gradient(180deg, #ff8e61 0%, #ff7f4f 100%);
  padding: 0 24rpx 30rpx;
  border-bottom-left-radius: 36rpx;
  border-bottom-right-radius: 36rpx;
}
.top-bar { height: 84rpx; display: flex; justify-content: space-between; align-items: center; }
.capsule {
  width: 118rpx;
  height: 52rpx;
  border-radius: 26rpx;
  background: rgba(255, 255, 255, 0.82);
  display: flex;
  align-items: center;
  justify-content: space-around;
}
.capsule-dots { display: flex; gap: 5rpx; align-items: center; }
.dot { width: 6rpx; height: 6rpx; border-radius: 50%; background: #212121; }
.capsule-circle { width: 18rpx; height: 18rpx; border: 3rpx solid #212121; border-radius: 50%; }

.user-row { margin-top: 8rpx; display: flex; align-items: center; }
.avatar { width: 88rpx; height: 88rpx; border-radius: 50%; border: 4rpx solid rgba(255, 255, 255, 0.9); }
.name { margin-left: 20rpx; font-size: 34rpx; color: #fff; font-weight: 700; }

.content { padding: 18rpx 22rpx 120rpx; margin-top: -8rpx; }
.card { background: #fff; border-radius: 18rpx; padding: 18rpx 20rpx; margin-bottom: 16rpx; }
.card-head { display: flex; justify-content: space-between; align-items: center; }
.card-title { font-size: 31rpx; font-weight: 700; color: #333; }
.card-more { font-size: 24rpx; color: #8b8b8b; display: flex; align-items: center; }
.order-grid { margin-top: 16rpx; display: grid; grid-template-columns: repeat(4, 1fr); gap: 8rpx; }
.order-item { text-align: center; }
.order-icon { width: 46rpx; height: 46rpx; }
.order-text { margin-top: 10rpx; font-size: 24rpx; color: #555; }

.menu-card { padding-top: 8rpx; padding-bottom: 8rpx; }
.menu-item {
  min-height: 82rpx;
  border-bottom: 1px solid #f1f1f1;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 30rpx;
  color: #303030;
}
.menu-item:last-child { border-bottom: 0; }
.right-arrow {
  width: 22rpx;
  height: 22rpx;
  transform: rotate(180deg);
  opacity: 0.55;
}
.right-arrow.mini {
  width: 18rpx;
  height: 18rpx;
  margin-left: 6rpx;
}
</style>
