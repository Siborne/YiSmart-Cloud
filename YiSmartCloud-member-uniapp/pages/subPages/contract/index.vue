<template>
  <view class="main-page">
    <nav-bar title="合同" :is-show-back="true" />
    <view class="section" v-if="loading">加载中...</view>
    <view class="section" v-else>
      <empty-page v-if="!list.length" text="暂无合同" />
      <view class="item" v-for="item in list" :key="item.id || item.contractId">
        <view>{{ item.contractName || item.name || '合同' }}</view>
        <view class="sub">状态：{{ item.statusName || item.status || '-' }}</view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { getContractList } from '@/api/contract'

const list = ref([])
const loading = ref(true)

onShow(async () => {
  loading.value = true
  const res = await getContractList({ pageNum: 1, pageSize: 50 })
  list.value = res?.rows || res?.data || []
  loading.value = false
})
</script>

<style scoped>
.item { padding: 16rpx 0; border-bottom: 1px solid #f2f2f2; }
.sub { margin-top: 8rpx; color: #999; }
</style>
