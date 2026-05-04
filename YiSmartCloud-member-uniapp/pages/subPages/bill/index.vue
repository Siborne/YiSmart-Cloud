<template>
  <view class="main-page">
    <nav-bar title="账单" :is-show-back="true" />
    <view class="section" v-if="loading">加载中...</view>
    <view class="section" v-else>
      <empty-page v-if="!list.length" text="暂无账单" />
      <view class="item" v-for="item in list" :key="item.id || item.billId">
        <view>{{ item.billName || item.name || '账单项目' }}</view>
        <view class="sub">金额：{{ item.amount || item.price || '-' }}</view>
        <view class="ops">
          <button size="mini" @tap="detail(item)">详情</button>
          <button size="mini" type="primary" @tap="pay(item)">支付</button>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { getBillList, getBillDetail, billPay } from '@/api/bill'

const list = ref([])
const loading = ref(true)

async function load() {
  loading.value = true
  const res = await getBillList({ pageNum: 1, pageSize: 50 })
  list.value = res?.rows || res?.data || []
  loading.value = false
}

onShow(load)

async function detail(item) {
  const id = item.id || item.billId
  if (!id) return
  const res = await getBillDetail(id)
  uni.showModal({ title: '账单详情', content: JSON.stringify(res?.data || {}), showCancel: false })
}

async function pay(item) {
  const id = item.id || item.billId
  const res = await billPay({ id })
  if (res?.code === 200) {
    uni.navigateTo({ url: '/pages/subPages/success/index?from=bill' })
  } else {
    uni.showToast({ title: res?.msg || '支付失败', icon: 'none' })
  }
}
</script>

<style scoped>
.item { padding: 16rpx 0; border-bottom: 1px solid #f2f2f2; }
.sub { margin-top: 8rpx; color: #999; }
.ops { margin-top: 12rpx; display: flex; gap: 12rpx; }
</style>
