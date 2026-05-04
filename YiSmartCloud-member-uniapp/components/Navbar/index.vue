<template>
  <view class="nav-wrap" :style="{ paddingTop: `${capsuleTop}px` }">
    <view class="nav-inner" :style="{ height: `${capsuleHeight}px` }">
      <view v-if="isShowBack" class="left" @tap="handleTo">
        <image class="back-icon" :src="src || '/static/arrows.png'" mode="aspectFit" />
      </view>
      <view class="title">{{ title }}</view>
      <view v-if="isShowSearch" class="search" @tap="handleSearch">搜索</view>
    </view>
  </view>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const props = defineProps({
  title: { type: String, default: '' },
  handleToLink: { type: Function, default: null },
  src: { type: String, default: '/static/arrows.png' },
  isShowBack: { type: Boolean, default: false },
  isShowSearch: { type: Boolean, default: false },
  params: { type: Object, default: () => ({}) }
})

const capsuleTop = ref(0)
const capsuleHeight = ref(32)

onMounted(() => {
  try {
    const rect = uni.getMenuButtonBoundingClientRect()
    capsuleTop.value = rect.top
    capsuleHeight.value = rect.height
  } catch (e) {
    capsuleTop.value = 8
    capsuleHeight.value = 32
  }
})

const handleTo = () => {
  if (props.handleToLink) {
    props.handleToLink()
    return
  }
  uni.navigateBack({
    fail: () => {
      // Current project uses custom bottom nav, not native tabBar.
      uni.reLaunch({ url: '/pages/index/index' })
    }
  })
}

const handleSearch = () => {
  const params = props.params || {}
  const name = params.name || ''
  uni.navigateTo({ url: `/pages/subPages/search/index?name=${name}` })
}
</script>

<style scoped>
.nav-wrap { background: #f8f8f8; position: sticky; top: 0; z-index: 20; }
.nav-inner { display: flex; align-items: center; justify-content: center; padding: 6px 12px; position: relative; }
.left { position: absolute; left: 12px; top: 50%; transform: translateY(-50%); }
.back-icon { width: 20px; height: 20px; }
.title { font-size: 17px; font-weight: 600; color: #222; }
.search { position: absolute; right: 12px; color: #666; font-size: 14px; }
</style>
