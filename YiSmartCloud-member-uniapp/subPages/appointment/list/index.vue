<template>
  <view class="main-page">
    <nav-bar title="预约记录" :is-show-back="true" />
    <view class="section" v-if="loading">加载中...</view>
    <view class="section" v-else>
      <empty-page v-if="!list.length" text="暂无预约记录" />
      <view class="item" v-for="item in list" :key="item.id || item.reservationId">
        <view>{{ item.date || item.reserveDate || '-' }} {{ item.time || item.timeSlot || '' }}</view>
        <view class="sub">{{ item.statusName || item.status || '待处理' }}</view>
        <button size="mini" class="mini" @tap="cancel(item)">取消预约</button>
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

async function load() {
  loading.value = true
  const res = await getList({ pageNum: 1, pageSize: 50 })
  list.value = res?.rows || res?.data || []
  loading.value = false
}

onShow(load)

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
.sub { margin-top: 8rpx; color: #999; font-size: 24rpx; }
.mini { margin-top: 12rpx; }
</style>
