<template>
  <view class="main-page">
    <nav-bar :title="pageTitle" :is-show-back="true" />
    <view class="section">
      <picker mode="date" :value="form.date" @change="onDateChange"><view class="picker">日期：{{ form.date || '请选择' }}</view></picker>
      <picker mode="selector" :range="timeList" @change="onTimeChange"><view class="picker">时间段：{{ form.time || '请选择' }}</view></picker>
      <input v-model="form.name" class="input-line" maxlength="20" placeholder="请输入预约人姓名" />
      <input v-model="form.mobile" class="input-line" type="number" maxlength="11" placeholder="请输入手机号" />
      <input v-model="form.visitor" class="input-line" maxlength="20" placeholder="请输入被探访老人姓名" />
      <textarea v-model="form.remark" class="input" maxlength="500" placeholder="预约备注（选填）" />
      <button class="btn" :loading="submitting" @tap="submit">提交预约</button>
    </view>
  </view>
</template>

<script setup>
import { computed, reactive, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { addReservation, getSlotList } from '@/api/appointment'

const submitting = ref(false)
const timeList = ref([])
const slotList = ref([])
const type = ref(0)
const form = reactive({ date: '', time: '', name: '', mobile: '', visitor: '', remark: '' })

const pageTitle = computed(() => (type.value === 1 ? '探访预约' : '参观预约'))

onLoad((query = {}) => {
  type.value = Number(query.type) === 1 ? 1 : 0
  form.date = formatDate(new Date())
  fetchSlots()
})

function formatDate(date) {
  const y = date.getFullYear()
  const m = `${date.getMonth() + 1}`.padStart(2, '0')
  const d = `${date.getDate()}`.padStart(2, '0')
  return `${y}-${m}-${d}`
}

function formatTimeLabel(timeText) {
  const source = String(timeText || '')
  if (!source) return ''
  const timePart = source.includes(' ') ? source.split(' ')[1] : source
  return timePart ? timePart.slice(0, 5) : source
}

async function fetchSlots() {
  try {
    const res = await getSlotList({ date: form.date })
    const list = Array.isArray(res?.data) ? res.data : []
    const remainMap = new Map()
    list.forEach((item) => {
      remainMap.set(String(item.time || ''), Number(item.count || 0))
    })
    const allSlots = buildAllSlots(form.date)
    slotList.value = allSlots.map((timeValue) => {
      const remain = remainMap.has(timeValue) ? remainMap.get(timeValue) : 6
      return {
        value: timeValue,
        label: `${formatTimeLabel(timeValue)}（剩余${remain}）`,
        remain
      }
    })
    timeList.value = slotList.value.map((item) => item.label)
    if (!slotList.value.length) {
      form.time = ''
    }
  } catch (error) {
    slotList.value = []
    timeList.value = []
    form.time = ''
    const msg = error && error.data && error.data.msg ? error.data.msg : '时间段加载失败'
    uni.showToast({ title: msg, icon: 'none' })
  }
}

function onDateChange(e) {
  form.date = e.detail.value
  form.time = ''
  fetchSlots()
}

function onTimeChange(e) {
  const idx = Number(e.detail.value)
  const slot = slotList.value[idx]
  if (!slot) {
    form.time = ''
    return
  }
  if (Number(slot.remain) <= 0) {
    uni.showToast({ title: '当前时间段已约满', icon: 'none' })
    return
  }
  form.time = slot.value
}

async function submit() {
  if (!form.name) {
    uni.showToast({ title: '请输入预约人姓名', icon: 'none' })
    return
  }
  if (!/^1\d{10}$/.test(String(form.mobile || '').trim())) {
    uni.showToast({ title: '请输入11位手机号', icon: 'none' })
    return
  }
  if (!form.visitor) {
    uni.showToast({ title: '请输入被探访老人姓名', icon: 'none' })
    return
  }
  if (!form.date || !form.time) {
    uni.showToast({ title: '请先选择日期和时间', icon: 'none' })
    return
  }
  submitting.value = true
  try {
    const res = await addReservation({
      type: type.value,
      time: form.time,
      mobile: String(form.mobile || '').trim(),
      name: String(form.name || '').trim(),
      visitor: String(form.visitor || '').trim(),
      remark: String(form.remark || '').trim()
    })
    if (res?.code === 200) {
      uni.showToast({ title: '预约成功', icon: 'none' })
      setTimeout(() => uni.navigateTo({ url: '/pages/subPages/appointment/list/index' }), 300)
    } else {
      uni.showToast({ title: res?.msg || '预约失败', icon: 'none' })
    }
  } finally {
    submitting.value = false
  }
}

function buildAllSlots(dateText) {
  const result = []
  const prefix = String(dateText || '')
  if (!prefix) return result
  let hour = 8
  let minute = 0
  while (hour < 17 || (hour === 17 && minute <= 30)) {
    const hh = `${hour}`.padStart(2, '0')
    const mm = `${minute}`.padStart(2, '0')
    result.push(`${prefix} ${hh}:${mm}:00`)
    minute += 30
    if (minute >= 60) {
      minute = 0
      hour += 1
    }
  }
  return result
}
</script>

<style scoped>
.picker { padding: 20rpx; border: 1px solid #eee; border-radius: 10rpx; margin-bottom: 16rpx; }
.input-line {
  height: 76rpx;
  border: 1px solid #eee;
  border-radius: 10rpx;
  padding: 0 20rpx;
  margin-bottom: 16rpx;
  background: #fff;
}
.input { min-height: 120rpx; border: 1px solid #eee; border-radius: 10rpx; padding: 20rpx; }
.btn { margin-top: 20rpx; background: var(--ys-primary); color: #fff; }
</style>
