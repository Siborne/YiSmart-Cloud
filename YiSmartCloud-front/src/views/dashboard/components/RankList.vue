<template>
  <el-row :gutter="12">
    <el-col :lg="7" :xl="8">
      <el-card class="dashboard-rank-card">
        <template #header>
          <div class="timeTie">
            <div>老人等级分布</div>
            <div>
              数据更新:{{
                new Date().getFullYear() +
                '-' +
                Number(new Date().getMonth() + 1) +
                '-' +
                new Date().getDate()
              }}
            </div>
          </div>
        </template>
        <div ref="elderRankContainer" style="height: 240px"></div>
      </el-card>
    </el-col>
    <el-col :lg="7" :xl="8">
      <el-card class="dashboard-rank-card">
        <template #header>
          <div class="timeTie">
            <div>老人年龄分布</div>
            <div>
              数据更新:{{
                new Date().getFullYear() +
                '-' +
                Number(new Date().getMonth() + 1) +
                '-' +
                new Date().getDate()
              }}
            </div>
          </div>
        </template>
        <div ref="elderAgeContainer" style="height: 220px"></div>
      </el-card>
    </el-col>
    <el-col :lg="10" :xl="8">
      <el-card class="dashboard-rank-card">
        <template #header>
          <div class="timeTie">
            <div>预约总览</div>
            <div>
              <span class="goToday" @click="goToday">回到今日</span
              >{{ selectTime }}
            </div>
          </div>
        </template>
        <div class="dateSelete">
          <span
            class="pre"
            :class="isToday ? 'forbidActive' : ''"
            @click="getPreWeek"
          ></span>
          <span class="next" @click="getNextWeek"></span>
          <ul>
            <li v-for="(item, index) in dataObj" :key="index">
              <p>
                <span>{{ item.week }}</span>
              </p>
              <p @click="handleDay(item, index)">
                <span :class="dayActive === index ? 'dayActive' : ''">{{
                  item.day
                }}</span>
              </p>
            </li>
          </ul>
        </div>
        <div class="subscribeCon">
          <ul>
            <li v-for="(item, index) in subscribeData" :key="index">
              <span
                class="typeIcon"
                :class="item.type === 1 ? 'icon3' : 'icon1'"
                >{{ item.type === 1 ? '参观' : '预约' }}</span
              >
              <span class="time">{{ item.time }}</span>
              <span>预约人：{{ item.name }}</span>
              <span>手机号：{{ item.phone }}</span>
            </li>
          </ul>
        </div>
      </el-card>
    </el-col>
  </el-row>
</template>

<script setup>
import { onMounted, ref, watch, nextTick, onBeforeUnmount } from 'vue'
import * as echarts from 'echarts/core'
import { getWeekDate, getDateInfo } from '@/utils/date'
import { SUBSCRIBE_DATA, ELDER_RANK_DATA_A, ELDER_AGE_DATA_A } from '../constants'
import { getElderAgeDistribution, getElderRankDistribution } from '../index1'

const props = defineProps({
  dashboard: {
    type: Object,
    default: null
  }
})

const dataObj = ref([])
const isToday = ref(false)
const selectTime = ref('')
const dayActive = ref(0)
const subscribeData = ref([])
let rankChart = null
let ageChart = null
const elderRankContainer = ref()
const elderAgeContainer = ref()

const elderRankData = ref([...ELDER_RANK_DATA_A])
const elderAgeData = ref({ ...ELDER_AGE_DATA_A })

function applyDashboardCharts() {
  const d = props.dashboard
  if (d?.elderRank?.length) {
    elderRankData.value = d.elderRank.map((x) => ({
      name: x.name,
      value: Number(x.value)
    }))
  }
  if (d?.elderAge?.man?.length === 5 && d?.elderAge?.woman?.length === 5) {
    elderAgeData.value = {
      man: d.elderAge.man.map((n) => Number(n)),
      woman: d.elderAge.woman.map((n) => Number(n))
    }
  }
}

function visitsForDate(dateStr) {
  const m = props.dashboard?.visitsByDate
  if (m && m[dateStr]?.length) {
    return m[dateStr]
  }
  const day = Number(dateStr.split('-')[2] || 0)
  const mock = SUBSCRIBE_DATA[day]
  return mock || []
}

const renderRankCharts = () => {
  if (elderRankContainer.value) {
    if (rankChart) {
      rankChart.dispose()
    }
    rankChart = echarts.init(elderRankContainer.value)
    rankChart.setOption(getElderRankDistribution(elderRankData.value))
  }
  if (elderAgeContainer.value) {
    if (ageChart) {
      ageChart.dispose()
    }
    ageChart = echarts.init(elderAgeContainer.value)
    ageChart.setOption(getElderAgeDistribution(elderAgeData.value))
  }
}

watch(
  () => props.dashboard,
  () => {
    applyDashboardCharts()
    nextTick(() => {
      renderRankCharts()
      syncSubscribeFromSelection()
    })
  },
  { deep: true }
)

onMounted(() => {
  dataObj.value = getWeekDate({ baselineDate: new Date() })
  selectTime.value = time()
  subscribeData.value = visitsForDate(selectTime.value)
  isChick(dataObj.value)
  applyDashboardCharts()
  window.addEventListener('resize', handleResize)
  nextTick(() => renderRankCharts())
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', handleResize)
  rankChart?.dispose()
  ageChart?.dispose()
})

const handleResize = () => {
  rankChart?.resize()
  ageChart?.resize()
}

function syncSubscribeFromSelection() {
  subscribeData.value = visitsForDate(selectTime.value)
}

const isChick = (date) => {
  const today = time()
  const selectDate = date[0].dateStr
  const todayStr = new Date(today).getTime()
  const selectStr = new Date(selectDate).getTime()
  if (selectStr <= todayStr) {
    isToday.value = true
  } else {
    isToday.value = false
  }
  dataObj.value.forEach((obj, i) => {
    if (obj.dateStr === selectTime.value) {
      dayActive.value = i
      subscribeData.value = visitsForDate(obj.dateStr)
    }
    if (isToday.value) {
      selectTime.value = time()
      subscribeData.value = visitsForDate(selectTime.value)
    }
  })
}

const getPreWeek = () => {
  if (!isToday.value) {
    dayActive.value = 0
    dataObj.value = getWeekDate({
      baselineDate: new Date(dataObj.value[0].dateStr),
      range: -7
    })
    selectTime.value = dataObj.value[0].dateStr
    isChick(dataObj.value)
  }
}

const getNextWeek = () => {
  dayActive.value = 0
  dataObj.value = getWeekDate({
    baselineDate: new Date(dataObj.value[0].dateStr),
    range: 7
  })
  isChick(dataObj.value)
  selectTime.value = dataObj.value[0].dateStr
  subscribeData.value = visitsForDate(dataObj.value[0].dateStr)
}

const handleDay = (item, i) => {
  dayActive.value = i
  selectTime.value = item.dateStr
  subscribeData.value = visitsForDate(item.dateStr)
}

const goToday = () => {
  dataObj.value = getWeekDate({ baselineDate: new Date() })
  selectTime.value = time()
  isChick(dataObj.value)
}

const time = () => {
  return getDateInfo(new Date())
}
</script>
