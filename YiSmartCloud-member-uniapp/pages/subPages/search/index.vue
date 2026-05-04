<template>
  <view class="main-page">
    <nav-bar title="搜索服务" :is-show-back="true" :is-show-search="true" :params="{ name: keyword }" />
    <view class="section">
      <input v-model="keyword" class="input" placeholder="请输入服务关键字" confirm-type="search" @confirm="search" />
      <button size="mini" @tap="search">搜索</button>
    </view>
    <view class="section" v-if="loading">搜索中...</view>
    <view class="section" v-else>
      <empty-page v-if="!list.length" text="暂无结果" />
      <view class="item" v-for="item in list" :key="item.id || item.projectId" @tap="toDetail(item)">
        {{ item.projectName || item.name || '服务项' }}
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getServiceList } from '@/api/service'

const keyword = ref('')
const list = ref([])
const loading = ref(false)

onLoad((options) => {
  keyword.value = options?.name || ''
  if (keyword.value) search()
})

async function search() {
  loading.value = true
  const res = await getServiceList({ pageNum: 1, pageSize: 50, name: keyword.value })
  list.value = res?.rows || res?.data || []
  loading.value = false
}

function toDetail(item) {
  const id = item.id || item.projectId
  uni.navigateTo({ url: `/pages/service/details?id=${id}` })
}
</script>

<style scoped>
.input { border: 1px solid #eee; border-radius: 10rpx; padding: 18rpx; margin-bottom: 12rpx; }
.item { padding: 16rpx 0; border-bottom: 1px solid #f2f2f2; }
</style>
