<template>
  <view class="main-page ys-page-tint family-page">
    <nav-bar title="家人" :is-show-back="false" />
    <view class="section family-section">
      <view class="row-head">
        <view class="head-text">
          <text class="head-title">家人列表</text>
          <text class="head-sub">已绑定的家人账号</text>
        </view>
        <button class="ys-btn-pill bind-pill" @tap="toBinding">去绑定</button>
      </view>
      <empty-page
        v-if="!list.length"
        text="暂无家人数据"
        hint="绑定家人后，可共同参与照护与服务相关事项"
      />
      <view v-else class="list">
        <view v-for="item in list" :key="item.id || item.userId" class="member-card">
          <view class="avatar">{{ displayInitial(item) }}</view>
          <view class="info">
            <view class="name">{{ item.name || item.userName || '家人' }}</view>
            <view class="tag-row">
              <text class="tag">已绑定</text>
            </view>
          </view>
        </view>
      </view>
    </view>
    <uni-footer page-path="/pages/family/index" />
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { getElderList } from '@/api/family'
import { setRouter } from '@/utils/state'

const list = ref([])

onShow(() => {
  const token = uni.getStorageSync('token')
  if (!token) {
    setRouter('pages/family/index')
    uni.navigateTo({ url: '/pages/login/index' })
    return
  }
  fetchList()
})

async function fetchList() {
  const res = await getElderList({ pageNum: 1, pageSize: 20 })
  list.value = res?.rows || []
}

function toBinding() {
  uni.navigateTo({ url: '/pages/family/binding' })
}

function displayInitial(item) {
  const name = item.name || item.userName || '家'
  const s = String(name).trim()
  return s ? s.slice(0, 1) : '家'
}
</script>

<style scoped>
.family-page {
  min-height: 100vh;
}
.family-section {
  margin-top: 8rpx;
}
.row-head {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 8rpx;
}
.head-text {
  flex: 1;
  min-width: 0;
  padding-right: 16rpx;
}
.head-title {
  display: block;
  font-size: 32rpx;
  font-weight: 700;
  color: var(--ys-text);
}
.head-sub {
  display: block;
  margin-top: 8rpx;
  font-size: 24rpx;
  color: var(--ys-text-muted);
}
.bind-pill {
  flex-shrink: 0;
  background: linear-gradient(180deg, var(--ys-primary) 0%, var(--ys-primary-dark) 100%);
  color: #fff;
  box-shadow: 0 8rpx 20rpx rgba(255, 132, 85, 0.35);
}
.list {
  margin-top: 16rpx;
}
.member-card {
  display: flex;
  align-items: center;
  padding: 22rpx 20rpx;
  background: var(--ys-bg);
  border-radius: var(--ys-radius-lg);
  border: 2rpx solid var(--ys-border);
  margin-bottom: 16rpx;
}
.member-card:last-child {
  margin-bottom: 0;
}
.avatar {
  width: 88rpx;
  height: 88rpx;
  border-radius: 50%;
  background: linear-gradient(145deg, var(--ys-primary-light) 0%, var(--ys-primary) 100%);
  color: #fff;
  font-size: 36rpx;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}
.info {
  margin-left: 22rpx;
  flex: 1;
  min-width: 0;
}
.name {
  font-size: 30rpx;
  font-weight: 600;
  color: var(--ys-text);
}
.tag-row {
  margin-top: 10rpx;
}
.tag {
  display: inline-block;
  font-size: 22rpx;
  color: var(--ys-primary-dark);
  background: rgba(255, 132, 85, 0.12);
  padding: 4rpx 16rpx;
  border-radius: 999rpx;
}
</style>
