<template>
  <view class="main-page">
    <nav-bar title="商品详情" :is-show-back="true" />
    <view class="section" v-if="loading">加载中...</view>
    <view v-else class="detail-wrap">
      <image class="cover" :src="detail.image || fallbackImage" mode="aspectFill" />
      <view class="info-card">
        <view class="name">{{ detail.name || '服务项目' }}</view>
        <view class="desc">{{ detail.nursingRequirement || '无' }}</view>
        <view class="price-line">￥{{ toPrice(detail.price) }} <text class="unit">/{{ detail.unit || '次' }}</text></view>
      </view>

      <view class="form-card">
        <picker mode="selector" :range="familyRange" @change="onFamilyChange">
          <view class="form-row">
            <view class="label">服务家人 <text class="required">必填</text></view>
            <view class="value">{{ selectedFamilyName || '请选择' }}</view>
          </view>
        </picker>
        <picker mode="date" :value="expectDate" @change="onDateChange">
          <view class="form-row">
            <view class="label">期望服务日期 <text class="required">必填</text></view>
            <view class="value">{{ expectDate || '请选择' }}</view>
          </view>
        </picker>
        <picker mode="time" :value="expectTime" @change="onTimeChange">
          <view class="form-row no-border">
            <view class="label">期望服务时间 <text class="required">必填</text></view>
            <view class="value">{{ expectTime || '请选择' }}</view>
          </view>
        </picker>
      </view>
    </view>

    <view class="footer-buy">
      <button class="buy-btn" :loading="submitting" @tap="submitOrder">立即购买</button>
    </view>
  </view>
</template>

<script setup>
import { computed, reactive, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getServiceDetail, checkServiceOrder, createServiceOrder } from '@/api/service'
import { getAllElderList } from '@/api/family'

const loading = ref(true)
const submitting = ref(false)
const detail = reactive({})
const id = ref('')
const fallbackImage = '/static/banner.png'
const familyList = ref([])
const familyIndex = ref(-1)
const expectDate = ref('')
const expectTime = ref('')

const familyRange = computed(() => familyList.value.map((item) => item.name || item.userName || item.nickName || `家人${item.id}`))
const selectedFamilyName = computed(() => {
  if (familyIndex.value < 0) return ''
  return familyRange.value[familyIndex.value] || ''
})

onLoad(async (options) => {
  id.value = options?.id || ''
  const now = new Date()
  expectDate.value = `${now.getFullYear()}-${`${now.getMonth() + 1}`.padStart(2, '0')}-${`${now.getDate()}`.padStart(2, '0')}`
  expectTime.value = '09:00'
  if (!id.value) {
    loading.value = false
    return
  }
  await Promise.all([fetchDetail(), fetchFamilyList()])
  loading.value = false
})

async function fetchDetail() {
  const res = await getServiceDetail(id.value)
  Object.assign(detail, res?.data || {})
}

async function fetchFamilyList() {
  const res = await getAllElderList({ pageNum: 1, pageSize: 20 })
  const rows = Array.isArray(res?.rows) ? res.rows : (Array.isArray(res?.data) ? res.data : [])
  familyList.value = rows
  if (rows.length) {
    familyIndex.value = 0
  }
}

function onFamilyChange(e) {
  familyIndex.value = Number(e.detail.value)
}

function onDateChange(e) {
  expectDate.value = e.detail.value
}

function onTimeChange(e) {
  expectTime.value = e.detail.value
}

function toPrice(value) {
  return Number(value || 0).toFixed(2)
}

function buildExpectedServiceTime() {
  if (!expectDate.value || !expectTime.value) return ''
  return `${expectDate.value} ${expectTime.value}:00`
}

async function submitOrder() {
  const family = familyList.value[familyIndex.value]
  if (!family || !family.id) {
    uni.showToast({ title: '请选择服务家人', icon: 'none' })
    return
  }
  const expectedServiceTime = buildExpectedServiceTime()
  if (!expectedServiceTime) {
    uni.showToast({ title: '请选择期望服务时间', icon: 'none' })
    return
  }
  submitting.value = true
  try {
    const payload = {
      projectId: Number(id.value),
      familyMemberId: Number(family.id),
      count: 1,
      expectedServiceTime
    }
    const verifyRes = await checkServiceOrder(payload)
    if (verifyRes?.code !== 200) {
      uni.showToast({ title: verifyRes?.msg || '下单校验失败', icon: 'none' })
      return
    }
    const payRes = await createServiceOrder(payload)
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
.detail-wrap {
  padding-bottom: 160rpx;
}
.cover {
  width: 100%;
  height: 420rpx;
  display: block;
}
.info-card {
  background: #fff;
  padding: 20rpx 24rpx;
}
.name {
  font-size: 36rpx;
  font-weight: 700;
  color: #1f1f1f;
}
.desc {
  margin-top: 12rpx;
  color: #757575;
  line-height: 1.55;
  font-size: 25rpx;
}
.price-line {
  margin-top: 16rpx;
  color: #ff623d;
  font-size: 42rpx;
  font-weight: 700;
}
.unit {
  margin-left: 6rpx;
  font-size: 24rpx;
  color: #8e8e8e;
  font-weight: 500;
}
.form-card {
  margin: 18rpx 24rpx 0;
  background: #fff;
  border-radius: 18rpx;
  padding: 0 24rpx;
}
.form-row {
  min-height: 92rpx;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1px solid #f3f3f3;
}
.form-row.no-border {
  border-bottom: 0;
}
.label {
  font-size: 28rpx;
  color: #2c2c2c;
}
.value {
  font-size: 26rpx;
  color: #939393;
}
.required {
  margin-left: 8rpx;
  font-size: 20rpx;
  color: #ff5f42;
}
.footer-buy {
  position: fixed;
  left: 0;
  right: 0;
  bottom: 0;
  background: #fff;
  padding: 14rpx 40rpx 24rpx;
}
.buy-btn {
  height: 84rpx;
  line-height: 84rpx;
  border-radius: 42rpx;
  background: #ff623d;
  color: #fff;
  font-size: 32rpx;
  font-weight: 700;
}
</style>
