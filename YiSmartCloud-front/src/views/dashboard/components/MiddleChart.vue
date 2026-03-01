<template>
  <el-row :gutter="24" class="row-container">
    <el-col  :lg="17" :xl="17">
      <el-card title="" class="dashboard-chart-card">
        <div class="condition">
          <el-tabs v-model="tabActive" @tab-click="changeTab">
            <el-tab-pane
              v-for="(item, index) in tabData"
              :key="index"
              :value="item.id"
              :label="item.name"
              :name="index"
            >
            </el-tab-pane>
          </el-tabs>

          <div class="times">
            <ul class="date">
              <li
                v-for="(item, index) in dateData"
                :key="index"
                :class="active === index ? 'active' : ''"
                @click="changeActive(index)"
              >
                {{ item }}
              </li>
            </ul>
            <div class="dateCon">{{ startDate }} 至 {{ endDate }}</div>
          </div>
        </div>
        <div v-if="tabActive === 0">
          <EarningsEchart
            :allDateArr="allDateArr"
            :allTimeArr="allTimeArr"
            :tabActive="tabActive"
          ></EarningsEchart>
        </div>
        <div v-if="tabActive === 1">
          <EnterEchart
            :allDateArr="allDateArr"
            :allTimeArr="allTimeArr"
          ></EnterEchart>
        </div>
        <div v-if="tabActive === 2">
          <ServeEchart
            :allDateArr="allDateArr"
            :allTimeArr="allTimeArr"
          ></ServeEchart>
        </div>
      </el-card>
    </el-col>
    <el-col :lg="7" :xl="7">
      <el-card class="dashboard-chart-card">
        <template #header>常用功能</template>
        <ul class="useList">
          <router-link to="/appointment/comeVisit?toast=true">
            <span class="appointmentIcon"></span>
            <p>来访管理</p></router-link
          >

          <router-link to="/enterQuit/enterDetails">
            <span class="checkIcon"></span>
            <p>入住申请</p>
          </router-link>

          <router-link to="/enterQuit/quitDetails">
            <span class="backIcon"></span>
            <p>退住申请</p>
          </router-link>

          <router-link to="/liveIn/houseType">
            <span class="bedIcon"></span>
            <p>床位预览</p>
          </router-link>

          <router-link to="/permission/user">
            <span class="addIcon"></span>
            <p>用户管理</p>
          </router-link>

          <router-link to="/order/olist">
            <span class="orderIcon"></span>
            <p>订单管理</p>
          </router-link>

          <router-link to="/order/refund">
            <span class="refundIcon"></span>
            <p>退款管理</p>
          </router-link>

          <router-link to="/intelligence/facility">
            <span class="warnIcon"></span>
            <p>报警数据</p>
          </router-link>
        </ul>
      </el-card>
    </el-col>
  </el-row>
</template>

<script setup>
import { onMounted, ref, nextTick } from 'vue'
import * as echarts from 'echarts/core'
import {
  TooltipComponent,
  LegendComponent,
  GridComponent
} from 'echarts/components'
import { PieChart, LineChart, BarChart } from 'echarts/charts'
import { CanvasRenderer } from 'echarts/renderers'
import {
  BACKLOG_DATA_A,
  BACKLOG_DATA_B,
  BACKLOG_DATA_C,
  TODAY_NUM_A,
  TODAY_NUM_B,
  TODAY_NUM_C,
  TODAY_TIME,
  WEEK_DATA,
  WEEK_NUM_A,
  WEEK_NUM_B,
  WEEK_NUM_C,
  MONTH_NUM_A,
  MONTH_NUM_B,
  MONTH_NUM_C,
  TODAY_EARNING_NUM_A,
  TODAY_EARNING_NUM_B,
  TODAY_EARNING_NUM_C,
  WEEK_EARNING_NUM_A,
  WEEK_EARNING_NUM_B,
  WEEK_EARNING_NUM_C,
  MONTH_EARNING_NUM_A,
  MONTH_EARNING_NUM_B,
  MONTH_EARNING_NUM_C,
  TODAY_SERVE_NUM_A,
  TODAY_SERVE_NUM_B,
  TODAY_SERVE_NUM_C,
  WEEK_SERVE_NUM_A,
  WEEK_SERVE_NUM_B,
  WEEK_SERVE_NUM_C,
  MONTH_SERVE_NUM_A,
  MONTH_SERVE_NUM_B,
  MONTH_SERVE_NUM_C
} from '../constants'
import { getMonthInfo, getDateInfo } from '@/utils/date'
import EarningsEchart from './EarningsEchart.vue'
import EnterEchart from './EnterEchart.vue'
import ServeEchart from './ServeEchart.vue'

echarts.use([
  TooltipComponent,
  LegendComponent,
  PieChart,
  GridComponent,
  LineChart,
  BarChart,
  CanvasRenderer
])
const dateData = ref(['今日', '本周', '本月'])
const tabData = ref([
  { id: 0, name: '收益情况' },
  { id: 1, name: '入退情况' },
  { id: 2, name: '服务情况' }
])

const active = ref(1)
const tabActive = ref(0)
const days = ref([])
const startDate = ref()
const endDate = ref()
const todayNumData = ref(TODAY_NUM_A) // 收益今日
const weekNumData = ref(WEEK_NUM_A) // 收益周
const monNumData = ref(MONTH_NUM_A) // 收益月
const todayEarningData = ref(TODAY_EARNING_NUM_A) // 入退今日
const weekEarningData = ref(WEEK_EARNING_NUM_A) // 入退周
const montyEarningData = ref(MONTH_EARNING_NUM_A) // 入退月
const todayServeData = ref(TODAY_SERVE_NUM_A) // 服务情况今日
const weekServeData = ref(WEEK_SERVE_NUM_A) // 服务情况周
const montyServeData = ref(MONTH_SERVE_NUM_A) // 服务情况月
const backlogData = ref(BACKLOG_DATA_A) // 待办事项
const allDateArr = ref([])
const allTimeArr = ref([])
const renderCharts = () => {
  if (tabActive.value === 0) {
    allDateArr.value = weekNumData.value
    allTimeArr.value = WEEK_DATA
  } else if (tabActive.value === 1) {
    allDateArr.value = todayEarningData.value
    allTimeArr.value = TODAY_TIME
  } else {
    allDateArr.value = todayServeData.value
    allTimeArr.value = TODAY_TIME
  }
  console.log(allDateArr.value)
  console.log(allTimeArr.value)
}

onMounted(() => {
  getDate()
  nextTick(() => {
    // 3套数据3天出现一次
    const date = getMonthInfo(new Date())
    const num = (date.surplusDay + 1) % 3
    if (num === 1) {
      todayNumData.value = TODAY_NUM_A
      weekNumData.value = WEEK_NUM_A
      monNumData.value = MONTH_NUM_A
      todayEarningData.value = TODAY_EARNING_NUM_A // 入退今日
      weekEarningData.value = WEEK_EARNING_NUM_A
      montyEarningData.value = MONTH_EARNING_NUM_A
      todayServeData.value = TODAY_SERVE_NUM_A // 服务今日
      weekServeData.value = WEEK_SERVE_NUM_A
      montyServeData.value = MONTH_SERVE_NUM_A
      backlogData.value = BACKLOG_DATA_A
    } else if (num === 2) {
      todayNumData.value = TODAY_NUM_B
      weekNumData.value = WEEK_NUM_B
      monNumData.value = MONTH_NUM_B
      todayEarningData.value = TODAY_EARNING_NUM_B
      weekEarningData.value = WEEK_EARNING_NUM_B
      montyEarningData.value = MONTH_EARNING_NUM_B
      todayServeData.value = TODAY_SERVE_NUM_B
      weekServeData.value = WEEK_SERVE_NUM_B
      montyServeData.value = MONTH_SERVE_NUM_B
      backlogData.value = BACKLOG_DATA_B
    } else {
      todayNumData.value = TODAY_NUM_C
      weekNumData.value = WEEK_NUM_C
      monNumData.value = MONTH_NUM_C
      todayEarningData.value = TODAY_EARNING_NUM_C
      weekEarningData.value = WEEK_EARNING_NUM_C
      montyEarningData.value = MONTH_EARNING_NUM_C
      todayServeData.value = TODAY_SERVE_NUM_C
      weekServeData.value = WEEK_SERVE_NUM_C
      montyServeData.value = MONTH_SERVE_NUM_C
      backlogData.value = BACKLOG_DATA_C
    }

    renderCharts()
  })
})
// 触发 tab
const changeTab = () => {
  active.value = 1
  nextTick(() => {
    getDataInfo()
  })
}
const getDataInfo = () => {
  const dayArr = [] // 天数
  let timeArr = [] // 日、周、月份
  let dateArr = [] // 数据
  let todayData = null // 今天数据
  let weekData = null // 周数据
  let montyData = null // 月数据
  if (tabActive.value === 0) {
    todayData = todayNumData.value
    weekData = weekNumData.value
    montyData = monNumData.value
  } else if (tabActive.value === 1) {
    todayData = todayEarningData.value
    weekData = weekEarningData.value
    montyData = montyEarningData.value
  } else {
    todayData = todayServeData.value
    weekData = weekServeData.value
    montyData = montyServeData.value
  }
  if (active.value === 0) {
    getDate()
    timeArr = TODAY_TIME
    dateArr = todayData
  } else if (active.value === 1) {
    startDate.value = getStartDayOfWeek(new Date())
    endDate.value = getEndDayOfWeek(new Date())
    timeArr = WEEK_DATA
    dateArr = weekData
  } else {
    const date = getMonty()
    startDate.value = getDateInfo(date.firstDay)
    endDate.value = getDateInfo(date.lastDay)
    const month = getMonthInfo(new Date())
    days.value = month.days

    for (let i = 0; i < days.value; i++) {
      dayArr.push(i + 1)
    }
    timeArr = dayArr
    dateArr = montyData
  }
  allDateArr.value = dateArr
  allTimeArr.value = timeArr
  console.log(allDateArr.value,allTimeArr.value)
}
// 触发本日、本周、本月
const changeActive = (i) => {
  active.value = i
  getDataInfo()
}
// 获取本日
const getDate = () => {
  startDate.value = getDateInfo(new Date())
  endDate.value = getDateInfo(new Date())
}
// 获得本周的开始时间：
const getStartDayOfWeek = (time) => {
  const now = new Date(time) // 当前日期
  const nowDayOfWeek = now.getDay() // 今天本周的第几天
  const day = nowDayOfWeek || 7
  const nowDay = now.getDate() // 当前日
  const nowMonth = now.getMonth() // 当前月
  return formatDate(new Date(now.getFullYear(), nowMonth, nowDay + 0 - day)) // 0代表从周日至周六；1代表周一至周日
}
// 获得本周的结束时间：
const getEndDayOfWeek = (time) => {
  const now = new Date(time) // 当前日期
  const nowDayOfWeek = now.getDay() // 今天本周的第几天
  const day = nowDayOfWeek || 7
  const nowDay = now.getDate() // 当前日
  const nowMonth = now.getMonth() // 当前月
  return formatDate(new Date(now.getFullYear(), nowMonth, nowDay + 6 - day)) // 6代表从周日至周六；7代表周一至周日
}
// 日期格式化
const formatDate = (date) => {
  const myyear = date.getFullYear()
  let mymonth = date.getMonth() + 1
  let myweekday = date.getDate()
  if (mymonth < 10) {
    mymonth = `0${mymonth}`
  }
  if (myweekday < 10) {
    myweekday = `0${myweekday}`
  }
  return `${myyear}-${mymonth}-${myweekday}`
}
// 本月的开始结束时间
const getMonty = () => {
  const today = new Date()
  // 获取当前月份的第一天
  const firstDay = new Date(today.getFullYear(), today.getMonth(), 1)
  // 获取当前月份的最后一天
  const lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0)
  const date = {
    firstDay,
    lastDay
  }
  return date
}
</script>
