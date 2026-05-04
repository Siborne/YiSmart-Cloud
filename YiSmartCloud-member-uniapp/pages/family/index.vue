<template>
  <view class="main-page">
    <nav-bar title="家人" :is-show-back="false" />
    <view class="section">
      <view class="row-head">
        <text>家人列表</text>
        <button size="mini" @tap="toBinding">去绑定</button>
      </view>
      <empty-page v-if="!list.length" text="暂无家人数据" />
      <view v-for="item in list" :key="item.id || item.userId" class="row-item">
        <view>{{ item.name || item.userName || '家人' }}</view>
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
</script>

<style scoped>
.row-head { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20rpx; }
.row-item { padding: 16rpx 0; border-bottom: 1px solid #f2f2f2; }
</style>
