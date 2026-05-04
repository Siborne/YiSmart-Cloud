<template>
  <view class="main-page">
    <nav-bar title="预约" :is-show-back="true" />
    <view class="section">
      <picker mode="date" @change="onDateChange"><view class="picker">日期：{{ form.date || '请选择' }}</view></picker>
      <picker mode="selector" :range="timeList" @change="onTimeChange"><view class="picker">时间段：{{ form.time || '请选择' }}</view></picker>
      <textarea v-model="form.remark" class="input" placeholder="预约备注" />
      <button class="btn" :loading="submitting" @tap="submit">提交预约</button>
    </view>
  </view>
</template>

<script setup>
import { reactive, ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { addReservation, getAllList } from '@/api/appointment'

const submitting = ref(false)
const timeList = ref([])
const form = reactive({ date: '', time: '', remark: '' })

onShow(async () => {
  const res = await getAllList({})
  const list = res?.data || res?.rows || []
  timeList.value = list.length ? list.map((i) => i.time || i.label || JSON.stringify(i)) : ['09:00-10:00', '10:00-11:00', '14:00-15:00']
})

function onDateChange(e) { form.date = e.detail.value }
function onTimeChange(e) { form.time = timeList.value[e.detail.value] }

async function submit() {
  if (!form.date || !form.time) {
    uni.showToast({ title: '请先选择日期和时间', icon: 'none' })
    return
  }
  submitting.value = true
  try {
    const res = await addReservation({ date: form.date, time: form.time, remark: form.remark })
    if (res?.code === 200) {
      uni.showToast({ title: '预约成功', icon: 'none' })
      setTimeout(() => uni.navigateTo({ url: '/subPages/appointment/list/index' }), 300)
    } else {
      uni.showToast({ title: res?.msg || '预约失败', icon: 'none' })
    }
  } finally {
    submitting.value = false
  }
}
</script>

<style scoped>
.picker { padding: 20rpx; border: 1px solid #eee; border-radius: 10rpx; margin-bottom: 16rpx; }
.input { min-height: 120rpx; border: 1px solid #eee; border-radius: 10rpx; padding: 20rpx; }
.btn { margin-top: 20rpx; background: var(--ys-primary); color: #fff; }
</style>
