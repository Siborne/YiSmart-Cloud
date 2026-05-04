<template>
  <view class="main-page">
    <nav-bar title="健康档案" :is-show-back="true" />
    <view class="section" v-if="loading">加载中...</view>
    <view class="section" v-else>
      <empty-page v-if="!list.length" text="暂无健康档案" />
      <view class="item" v-for="item in list" :key="item.id || item.userId" @tap="toDetail(item)">
        <view>{{ item.userName || item.name || '老人' }}</view>
        <view class="sub">点击查看健康趋势</view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { getAllElderList } from '@/api/family'

const list = ref([])
const loading = ref(true)

onShow(async () => {
  loading.value = true
  const res = await getAllElderList({ pageNum: 1, pageSize: 50 })
  list.value = res?.rows || res?.data || []
  loading.value = false
})

function toDetail(item) {
  const id = item.iotId || item.id || item.userId || ''
  uni.navigateTo({ url: `/pages/subPages/wuDataDetail/index?iotId=${id}` })
}
</script>

<style scoped>
.item { padding: 18rpx 0; border-bottom: 1px solid #f2f2f2; }
.sub { margin-top: 6rpx; color: #999; font-size: 24rpx; }
</style>
