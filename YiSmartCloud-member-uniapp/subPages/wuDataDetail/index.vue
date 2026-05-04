<template>
  <view class="main-page">
    <nav-bar title="健康详情" :is-show-back="true" />
    <view class="section" v-if="loading">加载中...</view>
    <view class="section" v-else>
      <view class="title">按日数据</view>
      <view class="row" v-for="(item, idx) in dayList" :key="`d-${idx}`">{{ JSON.stringify(item) }}</view>
      <view class="title mt">按周数据</view>
      <view class="row" v-for="(item, idx) in weekList" :key="`w-${idx}`">{{ JSON.stringify(item) }}</view>
      <empty-page v-if="!dayList.length && !weekList.length" text="暂无健康数据" />
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { elderBloodPresh, elderBloodPreshPing } from '@/api/family'

const loading = ref(true)
const dayList = ref([])
const weekList = ref([])

onLoad(async (options) => {
  const iotId = options?.iotId || ''
  const dayRes = await elderBloodPresh({ iotId })
  const weekRes = await elderBloodPreshPing({ iotId })
  dayList.value = dayRes?.data || dayRes?.rows || []
  weekList.value = weekRes?.data || weekRes?.rows || []
  loading.value = false
})
</script>

<style scoped>
.title { font-weight: 600; }
.mt { margin-top: 20rpx; }
.row { margin-top: 10rpx; color: #666; font-size: 24rpx; word-break: break-all; }
</style>
