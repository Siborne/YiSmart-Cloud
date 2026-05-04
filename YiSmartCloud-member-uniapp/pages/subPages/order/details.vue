<template>
  <view class="main-page">
    <nav-bar title="订单详情" :is-show-back="true" />
    <view class="section" v-if="loading">加载中...</view>
    <view class="section" v-else>
      <view class="line">订单号：{{ detail.orderNo || detail.id || '-' }}</view>
      <view class="line">状态：{{ detail.statusName || detail.status || '-' }}</view>
      <view class="line">金额：{{ detail.amount || detail.price || '-' }}</view>
      <view class="ops">
        <button size="mini" @tap="remove">删除</button>
        <button size="mini" type="warn" @tap="refund">申请退款</button>
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
  const res = await getOrderDetail(id.value)
  Object.assign(detail, res?.data || {})
  loading.value = false
})

async function remove() {
  const res = await orderDelete(id.value)
  uni.showToast({ title: res?.code === 200 ? '已删除' : (res?.msg || '删除失败'), icon: 'none' })
}

async function refund() {
  const res = await orderRefund({ orderId: id.value })
  uni.showToast({ title: res?.code === 200 ? '已提交退款' : (res?.msg || '提交失败'), icon: 'none' })
}
</script>

<style scoped>
.line { margin-bottom: 12rpx; }
.ops { margin-top: 20rpx; display: flex; gap: 12rpx; }
</style>
