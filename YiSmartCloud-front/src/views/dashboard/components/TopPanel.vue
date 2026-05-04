<template>
  <el-row :gutter="24">
    <el-col :lg="17" :xl="17">
      <el-card>
        <template #header>
          <div class="tit">
            <span>数据概览</span
            ><span class="time">数据更新：{{ newDate }}</span>
          </div>
        </template>
        <div class="dataCon">
          <div
            id="oldContainer"
            ref="oldContainer"
            class="dashboard-chart-container"
          />
          <div
            id="bedContainer"
            ref="bedContainer"
            class="dashboard-chart-container"
          />
          <div
            id="serveContainer"
            ref="serveContainer"
            class="dashboard-chart-container"
          />
          <div
            id="staffContainer"
            ref="staffContainer"
            class="dashboard-chart-container"
          />
          <div
            id="moneyContainer"
            ref="moneyContainer"
            class="dashboard-chart-container"
          />
        </div>
      </el-card>
    </el-col>
    <el-col :lg="7" :xl="7">
      <el-card>
        <div class="roleCon">
          <div class="head"> 
            <div class="img">
              <img :src="baseData.user?.avatar || baseData.avatar || avatar" />
            </div>
            <div class="rText">
              <p>Hello！{{ baseData.user?.nickName || baseData.nickName }}</p>
              <p>今天也是元气满满的一天！</p>
            </div>
          </div>
          <div class="userInfo">
            <p class="userTit">
              <i class="icon1"></i>

              <span class="textOverflow"
                ><el-tooltip :content="baseData.user.email" show-arrow>
                  <span>{{ baseData.user.email }}</span>
                </el-tooltip></span
              >
            </p>
            <p>
              <i class="icon2"></i>
              <span>{{ baseData.user.userName }}</span>
            </p>
            <p v-if="baseData.user.dept"><i class="icon3"></i>{{ baseData.user.dept.deptName }} / {{ baseData.postGroup }}</p>
            <p><i class="icon4"></i>{{ baseData.roleGroup }}</p>
          </div>
          <div class="hFoot">
            <div class="fTit">下属员工</div>
            <ul class="imgItem">
              <li>
                <span><img src="../../../assets/images/img1.png" /></span>
              </li>
              <li>
                <span><img src="../../../assets/images/img2.png" /></span>
              </li>
              <li>
                <span><img src="../../../assets/images/img3.png" /></span>
              </li>
              <li>
                <span><img src="../../../assets/images/img4.png" /></span>
              </li>
              <li>
                <span><img src="../../../assets/images/img5.png" /></span>
              </li>
              <li>
                <span><img src="../../../assets/images/img6.png" /></span>
              </li>
              <li><span>+3</span></li>
            </ul>
          </div>
        </div>
      </el-card>
    </el-col>
  </el-row>
</template>

<script setup>
import { onMounted, computed, ref, watch, nextTick } from 'vue'

import * as echarts from 'echarts/core'
import {
  TooltipComponent,
  LegendComponent,
  GridComponent
} from 'echarts/components'
import { PieChart, LineChart } from 'echarts/charts'
import { CanvasRenderer } from 'echarts/renderers'
import useSettingStore from '@/store/modules/setColor'
import { getDateInfo } from '@/utils/date'
import {
  OLDMAN_NUM_A,
  BED_NUM_A,
  SERVE_NUM_A,
  STAFF_NUM_A,
  MONEY_NUM_A
} from '../constants'
import {
  getOldPieChartDataSet,
  getBedPieChartDataSet,
  getservePieChartDataSet,
  getStaffPieChartDataSet,
  getMoneyPieChartDataSet
} from '../index1'

const avatar = ref(
  'https://yjy-oss-videos.oss-accelerate.aliyuncs.com/grzxhz.jpg'
)
echarts.use([
  TooltipComponent,
  LegendComponent,
  PieChart,
  GridComponent,
  LineChart,
  CanvasRenderer
])

const store = useSettingStore()
const newDate = getDateInfo(new Date())
const chartColors = computed(() => store.chartColors)
// 获取父组件值、方法
const props = defineProps({
  baseData: {
    type: Object,
    default: () => ({})
  },
  roleListData: {
    type: String,
    default: ''
  },
  /** 后端 /serve/dashboard/summary */
  dashboard: {
    type: Object,
    default: null
  }
})

function normalizePie(bundle, fallback) {
  if (!bundle || !Array.isArray(bundle.data)) {
    return fallback
  }
  const data = bundle.data.map((d) => ({
    name: d.name,
    value: Number(d.value)
  }))
  const total =
    bundle.total !== undefined && bundle.total !== null
      ? Number(bundle.total)
      : data.reduce((s, x) => s + x.value, 0)
  return { total, data }
}
// monitorChart
let oldContainer = null // 老人
let bedContainer = null // 床位
let serveContainer = null // 服务
let staffContainer = null // 员工
let moneyContainer = null // 收入
let countChart = null
// 老人数量（默认占位，接口返回后覆盖）
const oldNumData = ref(OLDMAN_NUM_A)
const bedNumData = ref(BED_NUM_A)
const serveNumData = ref(SERVE_NUM_A)
const staffNumData = ref(STAFF_NUM_A)
const moneyNumData = ref(MONEY_NUM_A)
const renderCountChart = () => {
  if (!oldContainer) {
    oldContainer = document.getElementById('oldContainer')
  }
  countChart = echarts.init(oldContainer)
  countChart.setOption(
    getOldPieChartDataSet((chartColors).value, oldNumData.value)
  )
}
// 床位数量
const bedCountChart = () => {
  if (!bedContainer) {
    bedContainer = document.getElementById('bedContainer')
  }
  countChart = echarts.init(bedContainer)
  countChart.setOption(
    getBedPieChartDataSet((chartColors).value, bedNumData.value)
  )
}
// 服务数量
const serveCountChart = () => {
  if (!serveContainer) {
    serveContainer = document.getElementById('serveContainer')
  }
  countChart = echarts.init(serveContainer)
  countChart.setOption(
    getservePieChartDataSet((chartColors).value, serveNumData.value)
  )
}
// 员工数量
const staffCountChart = () => {
  if (!staffContainer) {
    staffContainer = document.getElementById('staffContainer')
  }
  countChart = echarts.init(staffContainer)
  countChart.setOption(
    getStaffPieChartDataSet((chartColors).value, staffNumData.value)
  )
}
// 收入金额
const moneyCountChart = () => {
  if (!moneyContainer) {
    moneyContainer = document.getElementById('moneyContainer')
  }
  countChart = echarts.init(moneyContainer)
  countChart.setOption(
    getMoneyPieChartDataSet((chartColors).value, moneyNumData.value)
  )
}
const renderCharts = () => {
  renderCountChart()
  bedCountChart()
  serveCountChart()
  staffCountChart()
  moneyCountChart()
}

function applyDashboard(d) {
  if (!d) {
    return
  }
  oldNumData.value = normalizePie(d.elder, OLDMAN_NUM_A)
  bedNumData.value = normalizePie(d.bed, BED_NUM_A)
  serveNumData.value = normalizePie(d.service, SERVE_NUM_A)
  staffNumData.value = normalizePie(d.staff, STAFF_NUM_A)
  moneyNumData.value = normalizePie(d.money, MONEY_NUM_A)
}

watch(
  () => props.dashboard,
  (d) => {
    applyDashboard(d)
    nextTick(() => renderCharts())
  },
  { deep: true }
)

onMounted(() => {
  applyDashboard(props.dashboard)
  renderCharts()
})
</script>

<style lang="scss" scoped>
.dashboard-chart-card {
  padding: 8px;

  :deep(.t-card__header) {
    padding-bottom: 24px;
  }

  :deep(.t-card__title) {
    font-size: 20px;
    font-weight: 500;
  }
}
</style>
