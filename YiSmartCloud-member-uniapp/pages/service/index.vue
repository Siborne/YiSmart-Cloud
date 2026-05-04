<template>
  <view class="main-page">
    <nav-bar title="服务下单" :is-show-back="false" />
    <view class="section">
      <view class="search-wrap">
        <input
          v-model="query.name"
          class="search-input"
          maxlength="20"
          confirm-type="search"
          placeholder="请输入服务关键字"
          @confirm="handleSearch"
        />
      </view>
      <empty-page v-if="!list.length" text="暂无服务项目" />
      <view class="service-grid">
        <view v-for="item in list" :key="item.id || item.projectId" class="service-item" @tap="toDetail(item)">
          <image class="cover" :src="item.image || fallbackImage" mode="aspectFill" />
          <view class="body">
            <view class="name">{{ item.name || item.projectName || '服务项目' }}</view>
            <view class="desc">{{ item.nursingRequirement || '无' }}</view>
            <view class="price-row">
              <text class="price">￥{{ toPrice(item.price) }}</text>
              <text class="unit">/{{ item.unit || '次' }}</text>
            </view>
          </view>
        </view>
      </view>
    </view>
    <uni-footer page-path="/pages/service/index" />
  </view>
</template>

<script setup>
import { reactive, ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { getServiceList } from '@/api/service'

const list = ref([])
const query = reactive({ pageNum: 1, pageSize: 20, status: 1, name: '' })
const fallbackImage = '/static/banner.png'

onShow(async () => {
  await fetchList()
})

async function fetchList() {
  const res = await getServiceList({ ...query })
  list.value = res?.rows || []
}

function handleSearch() {
  query.pageNum = 1
  fetchList()
}

function toPrice(value) {
  const n = Number(value || 0)
  return n.toFixed(2)
}

function toDetail(item) {
  const id = item.id || item.projectId || ''
  uni.navigateTo({ url: `/pages/service/details?id=${id}` })
}
</script>

<style scoped>
.search-wrap {
  margin-bottom: 20rpx;
  background: #f3f3f6;
  border-radius: 24rpx;
  padding: 0 24rpx;
}
.search-input {
  height: 72rpx;
  line-height: 72rpx;
  font-size: 26rpx;
}
.service-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 18rpx;
}
.service-item {
  background: #fff;
  border-radius: 16rpx;
  overflow: hidden;
}
.cover {
  width: 100%;
  height: 220rpx;
  display: block;
}
.body {
  padding: 14rpx 16rpx 18rpx;
}
.name {
  font-size: 30rpx;
  font-weight: 600;
  color: #222;
}
.desc {
  margin-top: 6rpx;
  font-size: 24rpx;
  color: #9b9b9b;
  min-height: 34rpx;
}
.price-row {
  margin-top: 10rpx;
  display: flex;
  align-items: baseline;
}
.price {
  color: #ff623d;
  font-size: 38rpx;
  font-weight: 700;
}
.unit {
  margin-left: 8rpx;
  color: #8e8e8e;
  font-size: 24rpx;
}
</style>
