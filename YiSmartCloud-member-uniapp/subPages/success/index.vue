<template>
  <view class="main-page">
    <nav-bar title="操作成功" :is-show-back="true" />
    <view class="section success">
      <image src="/static/success.png" class="icon" mode="widthFix" />
      <view class="txt">操作已完成</view>
      <view class="from">来源：{{ from || '业务流程' }}</view>
      <button class="btn" @tap="toOrder">查看订单</button>
      <button class="btn ghost" @tap="toHome">返回首页</button>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'

const from = ref('')

onLoad((options) => {
  from.value = options?.from || ''
})

function toOrder() { uni.reLaunch({ url: '/subPages/order/index' }) }
function toHome() { uni.reLaunch({ url: '/pages/index/index' }) }
</script>

<style scoped>
.success { text-align: center; }
.icon { width: 160rpx; margin: 30rpx auto; display: block; }
.txt { font-size: 34rpx; font-weight: 600; }
.from { margin-top: 10rpx; color: #999; }
.btn { margin-top: 16rpx; background: var(--ys-primary); color: #fff; }
.ghost { background: #fff; color: var(--ys-primary); border: 1px solid var(--ys-primary); }
</style>
