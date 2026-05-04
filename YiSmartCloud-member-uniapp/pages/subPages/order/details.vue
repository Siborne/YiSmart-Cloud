<template>
  <view class="main-page ys-page-tint">
    <nav-bar title="订单详情" :is-show-back="true" />
    <view v-if="loading" class="section">
      <view class="ys-loading-wrap">
        <view class="ys-loading-dot" />
        <text class="ys-loading-text">加载中，请稍候</text>
      </view>
    </view>
    <view v-else-if="!id" class="section">
      <empty-page text="未找到订单" hint="请从订单列表重新进入" />
    </view>
    <view v-else class="detail-stack">
      <view class="section card-block">
        <view class="group-title">订单信息</view>
        <view class="row">
          <text class="k">订单号</text>
          <text class="v">{{ detail.orderNo || detail.id || '—' }}</text>
        </view>
      </view>
      <view class="section card-block">
        <view class="group-title">状态</view>
        <view class="row row--tag">
          <text class="status-tag" :class="statusClass(detail)">{{ detail.statusName || detail.status || '—' }}</text>
        </view>
      </view>
      <view class="section card-block">
        <view class="group-title">金额</view>
        <view class="amount-big">¥{{ detail.amount ?? detail.price ?? '—' }}</view>
      </view>
      <view class="section">
        <view class="footer-actions">
          <button class="ys-btn-outline action-del" @tap="remove">删除</button>
          <button class="action-refund" @tap="refund">申请退款</button>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { reactive, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getOrderDetail, orderDelete, orderRefund } from '@/api/order'

const loading = ref(true)
const id = ref('')
const detail = reactive({})

onLoad(async (options) => {
  id.value = options?.id || ''
  if (!id.value) {
    loading.value = false
    return
  }
  try {
    const res = await getOrderDetail(id.value)
    Object.assign(detail, res?.data || {})
  } finally {
    loading.value = false
  }
})

function statusClass(d) {
  const n = String(d.statusName || d.status || '')
  if (/待支付|未支付/.test(n)) return 'status-tag--pay'
  if (/完成|已完/.test(n)) return 'status-tag--done'
  if (/待执行|执行|进行|服务中|待服务/.test(n)) return 'status-tag--prog'
  if (/退款|取消|关闭/.test(n)) return 'status-tag--warn'
  return 'status-tag--default'
}

async function remove() {
  const res = await orderDelete(id.value)
  uni.showToast({ title: res?.code === 200 ? '已删除' : res?.msg || '删除失败', icon: 'none' })
}

async function refund() {
  const res = await orderRefund({ orderId: id.value })
  uni.showToast({ title: res?.code === 200 ? '已提交退款' : res?.msg || '提交失败', icon: 'none' })
}
</script>

<style scoped>
.detail-stack {
  padding-bottom: 32rpx;
}
.card-block {
  margin-bottom: 16rpx;
}
.group-title {
  font-size: 26rpx;
  font-weight: 600;
  color: var(--ys-text-muted);
  margin-bottom: 16rpx;
}
.row {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 16rpx;
}
.row--tag {
  justify-content: flex-start;
}
.k {
  font-size: 28rpx;
  color: var(--ys-text-secondary);
  flex-shrink: 0;
}
.v {
  font-size: 28rpx;
  color: var(--ys-text);
  text-align: right;
  word-break: break-all;
}
.status-tag {
  font-size: 24rpx;
  padding: 8rpx 20rpx;
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
.amount-big {
  font-size: 48rpx;
  font-weight: 700;
  color: var(--ys-primary-dark);
  letter-spacing: 1rpx;
}
.footer-actions {
  display: flex;
  gap: 20rpx;
  align-items: stretch;
}
.action-del {
  flex: 1;
  height: 88rpx;
  line-height: 88rpx;
  margin: 0;
}
.action-refund {
  flex: 1;
  height: 88rpx;
  line-height: 88rpx;
  margin: 0;
  padding: 0;
  border-radius: var(--ys-radius);
  background: var(--ys-danger-soft);
  color: var(--ys-danger);
  font-size: 30rpx;
  font-weight: 600;
  border: 2rpx solid rgba(221, 82, 77, 0.45);
}
</style>
