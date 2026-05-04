<template>
  <view class="main-page home-page">
    <view class="top-wrap" :style="{ paddingTop: statusBarHeight + 'px' }">
      <view class="top-bar">
        <view class="brand">颐智云</view>
        <view class="capsule">
          <view class="capsule-dots">
            <view class="dot"></view>
            <view class="dot"></view>
            <view class="dot"></view>
          </view>
          <view class="capsule-circle"></view>
        </view>
      </view>
      <view class="banner-wrap">
        <image class="banner" src="/static/banner.png" mode="aspectFill" />
      </view>
    </view>

    <view class="content">
      <view class="consult-card">
        <image class="consult-avatar" src="/static/head.png" mode="aspectFill" />
        <view class="consult-text">
          <view class="title">入驻咨询</view>
          <view class="sub">贴心服务 欢迎咨询</view>
        </view>
        <button size="mini" class="consult-btn" @tap="handlePhone">立即咨询</button>
      </view>

      <view class="reserve-grid">
        <view class="reserve-card" @tap="toAppointment(1)">
          <image class="reserve-icon" src="/static/icon-cgyy.png" mode="aspectFit" />
          <view class="reserve-title">探访预约</view>
          <view class="reserve-sub">老人家属预约拜访</view>
        </view>
        <view class="reserve-card" @tap="toAppointment(0)">
          <image class="reserve-icon" src="/static/icon-szlr.png" mode="aspectFit" />
          <view class="reserve-title">参观预约</view>
          <view class="reserve-sub">预约参观养老院</view>
        </view>
      </view>

      <view class="quick-grid">
        <view class="quick-item" @tap="toIntroduce">
          <image class="quick-icon" src="/static/icon-yly.png" mode="aspectFit" />
          <view class="quick-text">养老院介绍</view>
        </view>
        <view class="quick-item" @tap="toBinding">
          <image class="quick-icon" src="/static/icon-bdjr.png" mode="aspectFit" />
          <view class="quick-text">绑定家人</view>
        </view>
        <view class="quick-item" @tap="toOrder">
          <image class="quick-icon" src="/static/icon-wdfw.png" mode="aspectFit" />
          <view class="quick-text">我的订单</view>
        </view>
        <view class="quick-item" @tap="toBill">
          <image class="quick-icon" src="/static/icon-wdzd.png" mode="aspectFit" />
          <view class="quick-text">我的账单</view>
        </view>
      </view>

      <view class="room-section">
        <view class="section-title">热门房型</view>
        <empty-page v-if="!list.length" text="暂无房型数据" />
        <view v-for="item in list" :key="item.id || item.roomTypeId" class="room-item" @tap="toService">
          <view class="name">{{ resolveRoomName(item) }}</view>
          <view class="desc">{{ resolveRoomDesc(item) }}</view>
        </view>
      </view>
    </view>

    <uni-footer page-path="/pages/index/index" />
    <uni-phone ref="phoneRef" />
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onShow, onLoad } from '@dcloudio/uni-app'
import { getHotHouse } from '@/api/index'

const list = ref([])
const phoneRef = ref(null)
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
  fetchList()
})

async function fetchList() {
  try {
    const res = await getHotHouse({ status: 1, availableOnly: true })
    list.value = Array.isArray(res.data) ? res.data : []
  } catch (error) {
    const msg = error && error.data && error.data.msg ? error.data.msg : '请求失败'
    uni.showToast({ title: msg, icon: 'none' })
  }
}

function roomTypeText(roomType) {
  if (Number(roomType) === 1) return '单人间'
  if (Number(roomType) === 2) return '双人间'
  if (Number(roomType) === 3) return '多人间'
  return ''
}

function resolveRoomName(item) {
  const roomNo = item && item.roomNo ? `房间 ${item.roomNo}` : ''
  const typeText = roomTypeText(item && item.roomType)
  return roomNo || typeText || '可预约房型'
}

function resolveRoomDesc(item) {
  const desc = item && item.roomDesc ? item.roomDesc : ''
  const fee = item && item.bedFee !== undefined && item.bedFee !== null ? `床位费：${item.bedFee}` : ''
  return desc || fee || '该房型当前有可预约床位'
}

function toService() {
  uni.reLaunch({ url: '/pages/service/index' })
}

function toAppointment(type) {
  uni.navigateTo({ url: `/pages/subPages/appointment/index?type=${Number(type) === 1 ? 1 : 0}` })
}

function toIntroduce() {
  uni.navigateTo({ url: '/pages/subPages/introduce/index' })
}

function toBinding() {
  uni.navigateTo({ url: '/pages/family/binding' })
}

function toOrder() {
  uni.navigateTo({ url: '/pages/subPages/order/index' })
}

function toBill() {
  uni.navigateTo({ url: '/pages/subPages/bill/index' })
}

function handlePhone() {
  if (phoneRef.value && phoneRef.value.popup && phoneRef.value.popup.open) {
    phoneRef.value.popup.open()
  }
}
</script>

<style scoped>
.home-page { background: #f4f4f4; }
.top-wrap {
  background: linear-gradient(180deg, #ff8657 0%, #ff8353 100%);
  padding-left: 22rpx;
  padding-right: 22rpx;
  padding-bottom: 22rpx;
}
.top-bar { height: 86rpx; display: flex; align-items: center; justify-content: space-between; }
.brand { color: #fff; font-size: 30rpx; font-weight: 700; letter-spacing: 1rpx; }
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
.banner-wrap { border-radius: 22rpx; overflow: hidden; }
.banner { width: 100%; height: 214rpx; display: block; }

.content { padding: 18rpx 22rpx 120rpx; }
.consult-card {
  background: #efe8e5;
  border-radius: 22rpx;
  padding: 18rpx 20rpx;
  display: flex;
  align-items: center;
}
.consult-avatar { width: 84rpx; height: 84rpx; border-radius: 50%; }
.consult-text { flex: 1; margin-left: 18rpx; }
.title { font-size: 36rpx; font-weight: 700; color: #c06643; line-height: 1.1; }
.sub { margin-top: 8rpx; color: #8a8a8a; font-size: 24rpx; }
.consult-btn {
  background: #ff7447;
  color: #fff;
  border-radius: 26rpx;
  padding: 0 18rpx;
  font-size: 24rpx;
  height: 54rpx;
  line-height: 54rpx;
}

.reserve-grid { margin-top: 16rpx; display: grid; grid-template-columns: 1fr 1fr; gap: 14rpx; }
.reserve-card { background: #edf1f2; border-radius: 18rpx; padding: 16rpx 16rpx 14rpx; }
.reserve-icon { width: 52rpx; height: 52rpx; }
.reserve-title { margin-top: 8rpx; font-size: 34rpx; font-weight: 700; color: #2f2f2f; line-height: 1.1; }
.reserve-sub { margin-top: 4rpx; font-size: 24rpx; color: #9a9a9a; }

.quick-grid { margin-top: 18rpx; display: grid; grid-template-columns: repeat(4, 1fr); gap: 8rpx; }
.quick-item { text-align: center; }
.quick-icon { width: 54rpx; height: 54rpx; }
.quick-text { margin-top: 6rpx; font-size: 26rpx; color: #737373; }

.room-section { margin-top: 14rpx; background: transparent; border-radius: 0; padding: 0; }
.section-title { font-weight: 700; margin-bottom: 10rpx; font-size: 34rpx; color: #2d2d2d; }
.room-item { padding: 16rpx 0; border-bottom: 1px solid #f2f2f2; background: #fff; }
.room-item:last-child { border-bottom: 0; }
.name { font-weight: 600; }
.desc { margin-top: 6rpx; color: #808080; font-size: 24rpx; }
</style>
