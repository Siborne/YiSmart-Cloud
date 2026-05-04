<template>
  <view class="main-page ys-page-tint">
    <nav-bar title="订单" :is-show-back="true" />
    <view v-if="loading" class="section">
      <view class="ys-loading-wrap">
        <view class="ys-loading-dot" />
        <text class="ys-loading-text">加载中，请稍候</text>
      </view>
    </view>
    <view v-else class="order-body">
      <view class="section" v-if="!list.length">
        <empty-page text="暂无订单" hint="预约或购买服务后，订单将显示在这里" />
      </view>
      <view v-else class="order-list">
        <view class="order-card" v-for="item in list" :key="item.id || item.orderId">
          <view class="order-top">
            <text class="order-no">单号 {{ item.orderNo || item.id || '—' }}</text>
            <text class="status-tag" :class="statusClass(item)">{{ item.statusName || item.status || '—' }}</text>
          </view>
          <view class="order-meta">
            <text v-if="formatAmount(item)" class="amount">¥{{ formatAmount(item) }}</text>
            <text v-if="item.createTime" class="time">{{ item.createTime }}</text>
          </view>
          <view class="ops">
            <button class="ys-btn-ghost" @tap="toCancel(item)">取消</button>
            <button class="ys-btn-ghost ys-btn-ghost--primary" @tap="toDetail(item)">详情</button>
          </view>
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
  try {
    const res = await getOrderList({ pageNum: 1, pageSize: 50 })
    list.value = res?.rows || res?.data || []
  } finally {
    loading.value = false
  }
})

function formatAmount(item) {
  const v = item.amount ?? item.price
  if (v === null || v === undefined || v === '') return ''
  return String(v)
}

function statusClass(item) {
  const n = String(item.statusName || item.status || '')
  if (/待支付|未支付/.test(n)) return 'status-tag--pay'
  if (/完成|已完/.test(n)) return 'status-tag--done'
  if (/待执行|执行|进行|服务中|待服务/.test(n)) return 'status-tag--prog'
  if (/退款|取消|关闭/.test(n)) return 'status-tag--warn'
  return 'status-tag--default'
}

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
.order-body {
  padding-bottom: 24rpx;
}
.order-list {
  padding: 0 20rpx;
}
.order-card {
  background: var(--ys-card);
  border-radius: var(--ys-radius-lg);
  box-shadow: var(--ys-shadow);
  padding: 22rpx 24rpx;
  margin-bottom: 20rpx;
}
.order-top {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 16rpx;
}
.order-no {
  flex: 1;
  min-width: 0;
  font-size: 28rpx;
  font-weight: 600;
  color: var(--ys-text);
  letter-spacing: 0.5rpx;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.status-tag {
  flex-shrink: 0;
  font-size: 22rpx;
  padding: 6rpx 16rpx;
  border-radius: 999rpx;
  font-weight: 500;
}
.status-tag--pay {
  color: var(--ys-primary-dark);
  background: rgba(255, 132, 85, 0.14);
}
.status-tag--done {
  color: var(--ys-success);
  background: var(--ys-success-soft);
}
.status-tag--prog {
  color: #b8860b;
  background: var(--ys-warning-soft);
}
.status-tag--warn {
  color: var(--ys-danger);
  background: var(--ys-danger-soft);
}
.status-tag--default {
  color: var(--ys-text-muted);
  background: var(--ys-bg);
}
.order-meta {
  margin-top: 14rpx;
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 16rpx;
}
.amount {
  font-size: 32rpx;
  font-weight: 700;
  color: var(--ys-primary-dark);
}
.time {
  font-size: 24rpx;
  color: var(--ys-text-muted);
}
.ops {
  margin-top: 20rpx;
  display: flex;
  justify-content: flex-end;
  gap: 16rpx;
}
</style>
