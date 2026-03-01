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
        <template  #header>
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
// 导入样式
import { onMounted, ref } from 'vue'
import * as echarts from 'echarts/core'
import { getWeekDate, getDateInfo, getMonthInfo } from '@/utils/date'
import {
  BACKLOG_DATA_A,
  BACKLOG_DATA_B,
  BACKLOG_DATA_C,
  SUBSCRIBE_DATA,
  ELDER_RANK_DATA_A,
  ELDER_RANK_DATA_B,
  ELDER_RANK_DATA_C,
  ELDER_AGE_DATA_A,
  ELDER_AGE_DATA_B,
  ELDER_AGE_DATA_C
} from '../constants'
import { getElderAgeDistribution, getElderRankDistribution } from '../index1'

const dataObj = ref([])
const isToday = ref(false)
const selectTime = ref('')
const dayActive = ref(0)
const subscribeData = ref([]) // 触发每天的数据
const subDataArr = ref([]) // 一月的数据
const backlogData = ref(BACKLOG_DATA_A) // 待办事项
let myChart=null
const elderRankContainer = ref() // 老人等级
const elderAgeContainer = ref() // 老人年龄

const elderRankData = ref(ELDER_RANK_DATA_A)
const elderAgeData = ref(ELDER_AGE_DATA_A)
const dades = ref([])
onMounted(() => {
  // 设置一周的日期
  dataObj.value = getWeekDate({ baselineDate: new Date() })

  selectTime.value = time()
  subDataArr.value = [...SUBSCRIBE_DATA, ...SUBSCRIBE_DATA]
  subscribeData.value = subDataArr.value[0]
  isChick(dataObj.value)
  // 3套数据3天出现一次
  const date = getMonthInfo(new Date())
  const num = (date.surplusDay + 1) % 3
  if (num === 1) {
    backlogData.value = BACKLOG_DATA_A

    elderRankData.value = ELDER_RANK_DATA_A
    elderAgeData.value = ELDER_AGE_DATA_A
  } else if (num === 2) {
    backlogData.value = BACKLOG_DATA_B

    elderRankData.value = ELDER_RANK_DATA_B
    elderAgeData.value = ELDER_AGE_DATA_B
  } else {
    backlogData.value = BACKLOG_DATA_C

    elderRankData.value = ELDER_RANK_DATA_C
    elderAgeData.value = ELDER_AGE_DATA_C
  }

  window.addEventListener('resize', handleResize)
  dades.value = JSON.parse(JSON.stringify(subscribeData.value))
  elderRankChart()
  elderAgeChart()
})

const handleResize = () => {
  myChart.resize()
}

// 老人等级分布
const elderRankChart = () => {
  myChart = echarts.init(elderRankContainer.value)
  myChart.setOption(getElderRankDistribution(elderRankData.value))
}

// 老人年龄分布
const elderAgeChart = () => {
  myChart = echarts.init(elderAgeContainer.value)
  myChart.setOption(getElderAgeDistribution(elderAgeData.value))
}

// 是否可以触发上一周
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
  // 是否与当前时间相等，设置天的当前状态与要显示的数据
  dataObj.value.forEach((obj, i) => {
    if (obj.dateStr === selectTime.value) {
      dayActive.value = i
      subscribeData.value = subDataArr.value[obj.day]
    }
    // 如果上一页不能触发了，显示当前的时间
    if (isToday.value) {
      selectTime.value = time()
      subscribeData.value = subDataArr.value[obj.day]
    }
  })
}
// 上一周
const getPreWeek = () => {
  // 获取以当天为基准日期的下星期数据
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
// 下一周
const getNextWeek = () => {
  dayActive.value = 0
  // 获取以当天为基准日期的下星期数据
  dataObj.value = getWeekDate({
    baselineDate: new Date(dataObj.value[0].dateStr),
    range: 7
  })

  isChick(dataObj.value)
  selectTime.value = dataObj.value[0].dateStr // 把一周的第一天设置为当前日期
  subscribeData.value = subDataArr.value[dataObj.value[0].day]
}
// 触发当天显示的数据
const handleDay = (item, i) => {
  const newDate = getDateInfo(new Date())
  dayActive.value = i
  selectTime.value = item.dateStr
  const newDateArr = dataObj.value.filter((n) => n.dateStr === newDate)
  if (newDateArr.length > 0 && newDateArr[0].dateStr === item.dateStr) {
    subscribeData.value = dades.value
  } else {
    subscribeData.value = subDataArr.value[item.day]
  }
}
// 回到今天
const goToday = () => {
  dataObj.value = getWeekDate({ baselineDate: new Date() })
  isChick(dataObj.value)
}
// 当前时间
const time = () => {
  return getDateInfo(new Date())
}
</script>
