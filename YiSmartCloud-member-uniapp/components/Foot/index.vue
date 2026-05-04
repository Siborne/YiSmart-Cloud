<template>
  <view class="foot-wrap">
    <view v-for="(item, index) in tabbar" :key="item.pagePath" class="tab" :class="{ active: currentPage === index }" @tap="changeTab(item, index)">
      <image :src="currentPage === index ? item.selectedIconPath : item.iconPath" class="icon" />
      <text>{{ item.text }}</text>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { getFootStatus, setFootStatus, setRouter } from '@/utils/state'

const props = defineProps({ pagePath: { type: String, required: true } })
const currentPage = ref(0)
const tabbar = [
  { pagePath: '/pages/index/index', text: '首页', iconPath: '/static/home.png', selectedIconPath: '/static/homeHover.png' },
  { pagePath: '/pages/family/index', text: '家人', iconPath: '/static/family.png', selectedIconPath: '/static/familyHover.png' },
  { pagePath: '/pages/service/index', text: '服务', iconPath: '/static/serve.png', selectedIconPath: '/static/serveHover.png' },
  { pagePath: '/pages/my/index', text: '我的', iconPath: '/static/my.png', selectedIconPath: '/static/myHover.png' }
]

onShow(() => {
  currentPage.value = getFootStatus()
})

function changeTab(item, index) {
  currentPage.value = index
  setFootStatus(index)
  const token = uni.getStorageSync('token')
  if (!token && index === 1) {
    setRouter(props.pagePath.replace(/^\//, ''))
    uni.navigateTo({ url: '/pages/login/index' })
    return
  }
  uni.reLaunch({ url: item.pagePath })
}
</script>

<style scoped>
.foot-wrap { position: fixed; left: 0; right: 0; bottom: 0; height: 56px; display: flex; background: #fff; border-top: 1px solid #f0f0f0; z-index: 100; }
.tab { flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; font-size: 12px; color: #808080; }
.tab.active { color: var(--ys-primary); font-weight: 600; }
.icon { width: 22px; height: 22px; margin-bottom: 2px; }
</style>
