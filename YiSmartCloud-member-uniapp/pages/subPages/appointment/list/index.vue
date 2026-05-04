<template>
  <view class="main-page">
    <nav-bar title="预约记录" :is-show-back="true" />
    <view class="section" v-if="loading">加载中...</view>
    <view class="section" v-else>
      <empty-page v-if="!list.length" text="暂无预约记录" />
      <view class="item" v-for="item in list" :key="item.id || item.reservationId">
        <view class="title">{{ formatTime(item.time) }}</view>
        <view class="sub">类型：{{ getTypeLabel(item.type) }}</view>
        <view class="sub">状态：{{ getStatusLabel(item.status) }}</view>
        <view class="sub">预约人：{{ item.name || '-' }}（{{ item.mobile || '-' }}）</view>
        <view class="sub">探访对象：{{ item.visitor || '-' }}</view>
        <button v-if="Number(item.status) === 0" size="mini" class="mini" @tap="cancel(item)">取消预约</button>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { getList, cancelReservation } from '@/api/appointment'

const list = ref([])
const loading = ref(true)
const TYPE_MAP = {
  0: '参观预约',
  1: '探访预约'
}
const STATUS_MAP = {
  0: '待报道',
  1: '已完成',
  2: '已取消',
  3: '已过期'
}

async function load() {
  loading.value = true
  const res = await getList({ pageNum: 1, pageSize: 50 })
  list.value = res?.rows || res?.data || []
  loading.value = false
}

onShow(load)

function getTypeLabel(type) {
  return TYPE_MAP[Number(type)] || '未知'
}

function getStatusLabel(status) {
  return STATUS_MAP[Number(status)] || '未知'
}

function formatTime(value) {
  if (!value) return '-'
  return String(value).replace('T', ' ')
}

async function cancel(item) {
  const id = item.id || item.reservationId
  if (!id) return
  const res = await cancelReservation(id)
  uni.showToast({ title: res?.code === 200 ? '已取消' : (res?.msg || '取消失败'), icon: 'none' })
  load()
}
</script>

<style scoped>
.item { padding: 16rpx 0; border-bottom: 1px solid #f2f2f2; }
.title { font-size: 30rpx; color: #303030; font-weight: 600; }
.sub { margin-top: 8rpx; color: #999; font-size: 24rpx; }
.mini { margin-top: 12rpx; }
</style>
