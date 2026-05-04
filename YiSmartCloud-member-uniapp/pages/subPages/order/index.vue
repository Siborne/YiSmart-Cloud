<template>
  <view class="main-page">
    <nav-bar title="订单" :is-show-back="true" />
    <view class="section" v-if="loading">加载中...</view>
    <view class="section" v-else>
      <empty-page v-if="!list.length" text="暂无订单" />
      <view class="item" v-for="item in list" :key="item.id || item.orderId">
        <view>{{ item.orderNo || item.id || '订单' }}</view>
        <view class="sub">状态：{{ item.statusName || item.status || '-' }}</view>
        <view class="ops">
          <button size="mini" @tap="toDetail(item)">详情</button>
          <button size="mini" @tap="toCancel(item)">取消</button>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { getOrderList } from '@/api/order'

const loading = ref(true)
const list = ref([])

onShow(async () => {
  loading.value = true
  const res = await getOrderList({ pageNum: 1, pageSize: 50 })
  list.value = res?.rows || res?.data || []
  loading.value = false
})

function toDetail(item) {
  const id = item.id || item.orderId
  uni.navigateTo({ url: `/pages/subPages/order/details?id=${id}` })
}

function toCancel(item) {
  const id = item.id || item.orderId
  uni.navigateTo({ url: `/pages/subPages/order/cancel?id=${id}` })
}
</script>

<style scoped>
.item { padding: 16rpx 0; border-bottom: 1px solid #f2f2f2; }
.sub { margin-top: 8rpx; color: #999; }
.ops { margin-top: 10rpx; display: flex; gap: 12rpx; }
</style>
