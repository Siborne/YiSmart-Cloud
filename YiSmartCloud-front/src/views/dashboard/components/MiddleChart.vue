<template>
  <el-row :gutter="24" class="row-container">
    <el-col :lg="17" :xl="17">
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
import { onMounted, ref, nextTick, watch } from 'vue'
import {
  TODAY_NUM_A,
  TODAY_TIME,
  WEEK_DATA,
  WEEK_NUM_A,
  MONTH_NUM_A,
  TODAY_EARNING_NUM_A,
  WEEK_EARNING_NUM_A,
  MONTH_EARNING_NUM_A,
  TODAY_SERVE_NUM_A,
  WEEK_SERVE_NUM_A,
  MONTH_SERVE_NUM_A
} from '../constants'
import { getMonthInfo, getDateInfo } from '@/utils/date'
import EarningsEchart from './EarningsEchart.vue'
import EnterEchart from './EnterEchart.vue'
import ServeEchart from './ServeEchart.vue'

const props = defineProps({
  dashboard: {
    type: Object,
    default: null
  }
})

function num(v) {
  if (v === null || v === undefined) {
    return 0
  }
  const n = Number(v)
  return Number.isFinite(n) ? n : 0
}

function dualFromApi(dual) {
  if (!dual || !dual.incomeData) {
    return null
  }
  return {
    incomeData: dual.incomeData.map(num),
    refundData: (dual.refundData || []).map(num)
  }
}

function serveLineFromApi(serve, key) {
  if (!serve || !serve[key]) {
    return null
  }
  return serve[key].map(num)
}

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
const todayNumData = ref(TODAY_NUM_A)
const weekNumData = ref(WEEK_NUM_A)
const monNumData = ref(MONTH_NUM_A)
const todayEarningData = ref(TODAY_EARNING_NUM_A)
const weekEarningData = ref(WEEK_EARNING_NUM_A)
const montyEarningData = ref(MONTH_EARNING_NUM_A)
const todayServeData = ref(TODAY_SERVE_NUM_A)
const weekServeData = ref(WEEK_SERVE_NUM_A)
const montyServeData = ref(MONTH_SERVE_NUM_A)
const allDateArr = ref([])
const allTimeArr = ref([])

function applyDashboardToState() {
  const t = props.dashboard?.trends
  if (!t) {
    return
  }
  const eToday = dualFromApi(t.earnings?.today)
  if (eToday) {
    todayNumData.value = eToday
  }
  const eWeek = dualFromApi(t.earnings?.week)
  if (eWeek) {
    weekNumData.value = eWeek
  }
  const eMonth = dualFromApi(t.earnings?.month)
  if (eMonth) {
    monNumData.value = eMonth
  }

  const cToday = dualFromApi(t.checkIn?.today)
  if (cToday) {
    todayEarningData.value = cToday
  }
  const cWeek = dualFromApi(t.checkIn?.week)
  if (cWeek) {
    weekEarningData.value = cWeek
  }
  const cMonth = dualFromApi(t.checkIn?.month)
  if (cMonth) {
    montyEarningData.value = cMonth
  }

  const st = serveLineFromApi(t.serve, 'today')
  if (st) {
    todayServeData.value = st
  }
  const sw = serveLineFromApi(t.serve, 'week')
  if (sw) {
    weekServeData.value = sw
  }
  const sm = serveLineFromApi(t.serve, 'month')
  if (sm) {
    montyServeData.value = sm
  }
}

function pickTimes(period) {
  const t = props.dashboard?.trends
  if (!t) {
    return null
  }
  if (tabActive.value === 0) {
    const d = t.earnings?.[period]
    return d?.times?.length ? d.times : null
  }
  if (tabActive.value === 1) {
    const d = t.checkIn?.[period]
    return d?.times?.length ? d.times : null
  }
  const s = t.serve
  if (period === 'today') {
    return s?.todayTimes?.length ? s.todayTimes : null
  }
  if (period === 'week') {
    return s?.weekTimes?.length ? s.weekTimes : null
  }
  return s?.monthTimes?.length ? s.monthTimes : null
}

const getDataInfo = () => {
  const dayArr = []
  let timeArr = []
  let dateArr = null
  let todayData = null
  let weekData = null
  let montyData = null
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
    timeArr = pickTimes('today') || TODAY_TIME
    dateArr = todayData
  } else if (active.value === 1) {
    startDate.value = getStartDayOfWeek(new Date())
    endDate.value = getEndDayOfWeek(new Date())
    timeArr = pickTimes('week') || WEEK_DATA
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
    timeArr = pickTimes('month') || dayArr
    dateArr = montyData
  }
  allDateArr.value = dateArr
  allTimeArr.value = timeArr
}

watch(
  () => props.dashboard,
  () => {
    applyDashboardToState()
    nextTick(() => getDataInfo())
  },
  { deep: true }
)

onMounted(() => {
  applyDashboardToState()
  nextTick(() => getDataInfo())
})

const changeTab = () => {
  active.value = 1
  nextTick(() => getDataInfo())
}

const changeActive = (i) => {
  active.value = i
  getDataInfo()
}

const getDate = () => {
  startDate.value = getDateInfo(new Date())
  endDate.value = getDateInfo(new Date())
}

const getStartDayOfWeek = (time) => {
  const now = new Date(time)
  const nowDayOfWeek = now.getDay()
  const day = nowDayOfWeek || 7
  const nowDay = now.getDate()
  const nowMonth = now.getMonth()
  return formatDate(new Date(now.getFullYear(), nowMonth, nowDay + 0 - day))
}

const getEndDayOfWeek = (time) => {
  const now = new Date(time)
  const nowDayOfWeek = now.getDay()
  const day = nowDayOfWeek || 7
  const nowDay = now.getDate()
  const nowMonth = now.getMonth()
  return formatDate(new Date(now.getFullYear(), nowMonth, nowDay + 6 - day))
}

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

const getMonty = () => {
  const today = new Date()
  const firstDay = new Date(today.getFullYear(), today.getMonth(), 1)
  const lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0)
  return { firstDay, lastDay }
}
</script>
