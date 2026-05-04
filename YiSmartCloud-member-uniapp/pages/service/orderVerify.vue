<template>
  <view class="main-page">
    <nav-bar title="订单确认" :is-show-back="true" />
    <view class="section">
      <view>服务ID：{{ form.projectId || '-' }}</view>
      <input v-model="form.count" class="input" type="number" placeholder="请输入数量" />
      <textarea v-model="form.remark" class="input area" placeholder="备注（选填）" />
      <button class="btn" :loading="submitting" @tap="submit">确认下单</button>
    </view>
  </view>
</template>

<script setup>
import { reactive, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { goodsPay, goodsViseiOrder } from '@/api/service'

const submitting = ref(false)
const form = reactive({ projectId: '', count: '1', remark: '' })

onLoad((options) => {
  form.projectId = options?.id || ''
})

async function submit() {
  if (!form.projectId) {
    uni.showToast({ title: '缺少服务ID', icon: 'none' })
    return
  }
  submitting.value = true
  try {
    const verifyRes = await goodsViseiOrder({ projectId: form.projectId, count: Number(form.count || 1) })
    if (verifyRes?.code !== 200) {
      uni.showToast({ title: verifyRes?.msg || '校验失败', icon: 'none' })
      return
    }
    const payRes = await goodsPay({ projectId: form.projectId, count: Number(form.count || 1), remark: form.remark })
    if (payRes?.code === 200) {
      uni.redirectTo({ url: '/pages/subPages/success/index?from=service' })
    } else {
      uni.showToast({ title: payRes?.msg || '下单失败', icon: 'none' })
    }
  } finally {
    submitting.value = false
  }
}
</script>

<style scoped>
.input { background: #fff; border: 1px solid #eee; border-radius: 10rpx; padding: 20rpx; margin-top: 20rpx; }
.area { min-height: 120rpx; }
.btn { margin-top: 20rpx; background: var(--ys-primary); color: #fff; }
</style>
