<template>
  <div class="app-container assessment-detail" v-loading="loading">
    <el-page-header @back="goBack" content="健康管理" class="mb16" />

    <el-alert
      v-if="isFailed"
      type="error"
      :closable="false"
      show-icon
      class="mb16"
      :title="'AI 分析失败：' + (row.analysisError || '未知原因')"
    />

    <el-alert
      v-if="isPending"
      type="info"
      :closable="false"
      show-icon
      class="mb16"
      title="AI 正在分析报告，完成后本页会自动刷新；您可先处理其它事务。"
    >
      <el-progress :percentage="100" :indeterminate="true" :duration="2.5" :show-text="false" style="max-width: 280px; margin-top: 10px" />
    </el-alert>

    <el-card shadow="never" class="mb16">
      <template #header><span class="card-title">基本信息</span></template>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="姓名">{{ row.elderName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="身份证号">{{ row.idCard || '-' }}</el-descriptions-item>
        <el-descriptions-item label="出生日期">{{ birthDisplay }}</el-descriptions-item>
        <el-descriptions-item label="年龄">{{ row.age != null ? row.age : '-' }}</el-descriptions-item>
        <el-descriptions-item label="性别">{{ genderLabel }}</el-descriptions-item>
        <el-descriptions-item label="体检机构">{{ row.physicalExamInstitution || '-' }}</el-descriptions-item>
        <el-descriptions-item label="总检日期">{{ row.totalCheckDate || '-' }}</el-descriptions-item>
        <el-descriptions-item label="体检报告">
          <el-link v-if="row.physicalReportUrl" type="primary" :href="row.physicalReportUrl" target="_blank">查看 PDF</el-link>
          <span v-else>-</span>
        </el-descriptions-item>
      </el-descriptions>
    </el-card>

    <template v-if="!isPending">
      <el-card shadow="never" class="mb16">
        <template #header><span class="card-title">体检总结</span></template>
        <el-descriptions :column="2" border>
          <el-descriptions-item label="健康评分">{{ row.healthScore || '-' }}</el-descriptions-item>
          <el-descriptions-item label="风险等级">{{ riskLabel }}</el-descriptions-item>
          <el-descriptions-item label="是否建议入住">{{ admissionLabel }}</el-descriptions-item>
          <el-descriptions-item label="推荐护理等级">{{ row.nursingLevelName || '-' }}</el-descriptions-item>
          <el-descriptions-item label="评估时间" :span="2">{{ assessmentTimeStr }}</el-descriptions-item>
          <el-descriptions-item label="报告总结" :span="2">{{ row.reportSummary || '-' }}</el-descriptions-item>
        </el-descriptions>
      </el-card>

      <el-card shadow="never" class="mb16 chart-card">
        <template #header><span class="card-title">疾病风险</span></template>
        <el-row :gutter="20">
          <el-col :xs="24" :lg="12">
            <div ref="ageChartRef" class="chart-box chart-box--pad" />
            <div class="chart-caption">不同年龄组健康指数分布（示意），<span class="accent">高亮柱</span>为当前老人所属年龄段；竖线为当前区间标记。</div>
          </el-col>
          <el-col :xs="24" :lg="12">
            <div ref="radarChartRef" class="chart-box chart-box--pad" />
            <div class="chart-caption">人体各系统健康指数（AI）</div>
          </el-col>
        </el-row>
      </el-card>

      <el-card shadow="never" class="mb16">
        <template #header><span class="card-title">异常分析</span></template>
        <el-table :data="abnormalRows" border stripe empty-text="暂无异常项">
          <el-table-column type="expand">
            <template #default="props">
              <div class="expand-block">
                <p><strong>异常解读：</strong>{{ props.row.interpret || '-' }}</p>
                <p><strong>AI 建议：</strong>{{ props.row.advice || '-' }}</p>
              </div>
            </template>
          </el-table-column>
          <el-table-column label="结论" prop="conclusion" min-width="120" show-overflow-tooltip />
          <el-table-column label="体检项目" prop="examinationItem" min-width="140" show-overflow-tooltip />
          <el-table-column label="检查结果" prop="result" min-width="120" show-overflow-tooltip />
          <el-table-column label="参考值" prop="referenceValue" min-width="100" show-overflow-tooltip />
          <el-table-column label="单位" prop="unit" width="80" />
        </el-table>
      </el-card>
    </template>

    <div v-if="!isPending" class="detail-footer-actions">
      <el-button type="primary" size="large" @click="goCheckIn" v-hasPermi="['serve:checkIn:add']">办理入住</el-button>
      <span class="footer-hint">将携带当前老人姓名与身份证号跳转至入住申请</span>
    </div>
  </div>
</template>

<script setup name="HealthAssessmentDetail">
import * as echarts from 'echarts'
import { getAssessment } from '@/api/serve/assessment'

const { proxy } = getCurrentInstance()
const route = useRoute()
const router = useRouter()

const loading = ref(true)
const row = ref({})
const ageChartRef = ref(null)
const radarChartRef = ref(null)
let ageChart
let radarChart
let pollTimer = null

const isPending = computed(() => row.value && row.value.analysisStatus === 0)
const isFailed = computed(() => row.value && row.value.analysisStatus === 2)

const abnormalRows = computed(() => {
  const r = row.value
  if (!r || isPending.value) {
    return []
  }
  let ai = null
  if (r.aiResultJson) {
    try {
      ai = JSON.parse(r.aiResultJson)
    } catch (e) {
      ai = null
    }
  }
  if (ai && Array.isArray(ai.abnormalData)) {
    return ai.abnormalData
  }
  if (r.abnormalAnalysis) {
    try {
      const arr = JSON.parse(r.abnormalAnalysis)
      return Array.isArray(arr) ? arr : []
    } catch (e) {
      return []
    }
  }
  return []
})

const riskLabel = computed(() => {
  const code = row.value.riskLevel
  const map = {
    healthy: '健康',
    caution: '提示',
    risk: '风险',
    danger: '危险',
    severeDanger: '严重危险'
  }
  return map[code] || code || '-'
})

const admissionLabel = computed(() => {
  const v = row.value.suggestionForAdmission
  if (v === 0 || v === '0') {
    return '建议'
  }
  if (v === 1 || v === '1') {
    return '不建议'
  }
  return '-'
})

const genderLabel = computed(() => {
  const g = row.value.gender
  if (g === 0 || g === '0') {
    return '男'
  }
  if (g === 1 || g === '1') {
    return '女'
  }
  return '-'
})

const birthDisplay = computed(() => {
  const b = row.value.birthDate
  if (!b) {
    return '-'
  }
  return proxy.parseTime(b, '{y}-{m}-{d}')
})

const assessmentTimeStr = computed(() => {
  const t = row.value.assessmentTime
  if (!t) {
    return '-'
  }
  return proxy.parseTime(t, '{y}-{m}-{d} {h}:{i}:{s}')
})

function parseAgeFromId(idCard) {
  if (!idCard || idCard.length !== 18) {
    return 60
  }
  const y = parseInt(idCard.substr(6, 4), 10)
  const m = parseInt(idCard.substr(10, 2), 10)
  const d = parseInt(idCard.substr(12, 2), 10)
  if (!y || !m || !d) {
    return 60
  }
  const birth = new Date(y, m - 1, d)
  const now = new Date()
  let age = now.getFullYear() - birth.getFullYear()
  const md = now.getMonth() * 100 + now.getDate() - (birth.getMonth() * 100 + birth.getDate())
  if (md < 0) {
    age--
  }
  return age > 0 ? age : 0
}

function ageBandIndex(age) {
  if (age >= 90) {
    return 4
  }
  if (age >= 80) {
    return 3
  }
  if (age >= 70) {
    return 2
  }
  if (age >= 60) {
    return 1
  }
  return 0
}

const AGE_CATEGORIES = ['50-59岁', '60-69岁', '70-79岁', '80-89岁', '90岁及以上']

const MOCK_AGE_STACK = [
  { healthy: 8, caution: 22, risk: 28, danger: 25, severeDanger: 17 },
  { healthy: 6, caution: 18, risk: 32, danger: 28, severeDanger: 16 },
  { healthy: 5, caution: 15, risk: 30, danger: 32, severeDanger: 18 },
  { healthy: 4, caution: 12, risk: 26, danger: 35, severeDanger: 23 },
  { healthy: 3, caution: 10, risk: 22, danger: 33, severeDanger: 32 }
]

function barGradient(topColor, bottomColor) {
  return new echarts.graphic.LinearGradient(0, 0, 0, 1, [
    { offset: 0, color: topColor },
    { offset: 1, color: bottomColor }
  ])
}

function buildAgeChartOption(highlightIndex) {
  const radius = [4, 4, 0, 0]
  const mkSeries = (name, key, top, bottom) => ({
    name,
    type: 'bar',
    stack: 'total',
    barMaxWidth: 36,
    itemStyle: {
      borderRadius: radius,
      color: barGradient(top, bottom)
    },
    emphasis: {
      focus: 'series',
      itemStyle: { shadowBlur: 10, shadowColor: 'rgba(0,0,0,0.18)' }
    },
    data: MOCK_AGE_STACK.map((r, i) => ({
      value: r[key],
      itemStyle: i === highlightIndex
        ? {
            borderColor: '#f56c6c',
            borderWidth: 2,
            shadowBlur: 12,
            shadowColor: 'rgba(245,108,108,0.45)'
          }
        : {}
    }))
  })

  const series = [
    mkSeries('健康', 'healthy', '#7fd67a', '#52a352'),
    mkSeries('提示', 'caution', '#ffd88a', '#e6a23c'),
    mkSeries('风险', 'risk', '#ff9a8b', '#f56c6c'),
    mkSeries('危险', 'danger', '#ff7b7b', '#c0392b'),
    mkSeries('严重危险', 'severeDanger', '#c77dff', '#7b1fa2')
  ]

  const cat = AGE_CATEGORIES[highlightIndex]
  series.push({
    name: 'ageMark',
    type: 'line',
    xAxisIndex: 0,
    yAxisIndex: 0,
    data: [],
    silent: true,
    showInLegend: false,
    symbol: 'none',
    lineStyle: { width: 0 },
    markLine: {
      symbol: ['none', 'arrow'],
      animation: true,
      lineStyle: { color: '#f56c6c', width: 2, type: 'solid' },
      label: {
        show: true,
        formatter: '当前：' + cat,
        color: '#f56c6c',
        fontWeight: 'bold',
        distance: 8
      },
      data: [{ xAxis: cat }]
    }
  })

  return {
    textStyle: { fontFamily: 'system-ui, sans-serif' },
    tooltip: {
      trigger: 'axis',
      axisPointer: { type: 'shadow' },
      backgroundColor: 'rgba(255,255,255,0.96)',
      borderColor: '#e4e7ed',
      textStyle: { color: '#303133' }
    },
    legend: { top: 4, textStyle: { color: '#606266' } },
    grid: { left: '3%', right: '3%', bottom: '6%', top: 48, containLabel: true },
    xAxis: {
      type: 'category',
      data: AGE_CATEGORIES,
      axisLine: { lineStyle: { color: '#dcdfe6' } },
      axisLabel: {
        color: '#606266',
        formatter(value) {
          return value === cat ? '{hl|' + value + '}' : value
        },
        rich: {
          hl: { color: '#f56c6c', fontWeight: 'bold' }
        }
      }
    },
    yAxis: {
      type: 'value',
      max: 100,
      splitLine: { lineStyle: { type: 'dashed', color: '#ebeef5' } },
      axisLabel: { formatter: '{value}%', color: '#909399' }
    },
    series
  }
}

function systemScoresFromRow() {
  const r = row.value
  let sys = null
  if (r.aiResultJson) {
    try {
      const ai = JSON.parse(r.aiResultJson)
      sys = ai.systemScore
    } catch (e) {
      sys = null
    }
  }
  if (!sys && r.systemScore) {
    try {
      sys = JSON.parse(r.systemScore)
    } catch (e) {
      sys = null
    }
  }
  if (!sys) {
    return null
  }
  return [
    { name: '呼吸系统', value: sys.breathingSystem ?? 0 },
    { name: '消化系统', value: sys.digestiveSystem ?? 0 },
    { name: '内分泌系统', value: sys.endocrineSystem ?? 0 },
    { name: '免疫系统', value: sys.immuneSystem ?? 0 },
    { name: '循环系统', value: sys.circulatorySystem ?? 0 },
    { name: '泌尿系统', value: sys.urinarySystem ?? 0 },
    { name: '运动系统', value: sys.motionSystem ?? 0 },
    { name: '感官系统', value: sys.senseSystem ?? 0 }
  ]
}

function buildRadarOption() {
  const scores = systemScoresFromRow()
  if (!scores) {
    return {
      title: { text: '暂无系统分值', left: 'center', top: 'middle', textStyle: { color: '#909399' } }
    }
  }
  const indicator = scores.map(s => ({ name: s.name, max: 100 }))
  const dataVals = scores.map(s => s.value)
  const avg = dataVals.length ? (dataVals.reduce((a, b) => a + b, 0) / dataVals.length).toFixed(2) : '0'
  const area = new echarts.graphic.RadialGradient(0.5, 0.5, 0.75, [
    { offset: 0, color: 'rgba(64, 158, 255, 0.45)' },
    { offset: 1, color: 'rgba(103, 194, 58, 0.12)' }
  ])
  return {
    textStyle: { fontFamily: 'system-ui, sans-serif' },
    tooltip: {
      backgroundColor: 'rgba(255,255,255,0.96)',
      borderColor: '#e4e7ed'
    },
    radar: {
      indicator,
      center: ['50%', '52%'],
      radius: '62%',
      splitNumber: 4,
      axisName: { color: '#606266', fontSize: 11 },
      splitLine: { lineStyle: { color: ['#ebeef5', '#ebeef5', '#e4e7ed', '#dcdfe6'] } },
      splitArea: {
        show: true,
        areaStyle: {
          color: ['rgba(250,250,250,0.9)', 'rgba(245,247,250,0.95)', 'rgba(255,255,255,0.85)', 'rgba(245,247,250,0.9)']
        }
      },
      axisLine: { lineStyle: { color: '#dcdfe6' } }
    },
    series: [{
      type: 'radar',
      data: [{
        value: dataVals,
        name: '系统得分',
        areaStyle: { color: area },
        lineStyle: { width: 2.5, color: '#409eff' },
        itemStyle: { color: '#409eff', borderColor: '#fff', borderWidth: 1 },
        symbolSize: 6
      }]
    }],
    title: {
      text: '中心综合约 ' + avg + ' 分',
      left: 'center',
      bottom: 4,
      textStyle: { fontSize: 13, color: '#409eff', fontWeight: 600 }
    }
  }
}

function initCharts() {
  nextTick(() => {
    if (isPending.value) {
      disposeCharts()
      return
    }
    const age = parseAgeFromId(row.value.idCard)
    const idx = ageBandIndex(age)
    if (ageChartRef.value) {
      if (!ageChart) {
        ageChart = echarts.init(ageChartRef.value, undefined, { renderer: 'canvas' })
      }
      ageChart.setOption(buildAgeChartOption(idx), true)
    }
    if (radarChartRef.value) {
      if (!radarChart) {
        radarChart = echarts.init(radarChartRef.value, undefined, { renderer: 'canvas' })
      }
      radarChart.setOption(buildRadarOption(), true)
    }
  })
}

function disposeCharts() {
  if (ageChart) {
    ageChart.dispose()
    ageChart = null
  }
  if (radarChart) {
    radarChart.dispose()
    radarChart = null
  }
}

function stopPolling() {
  if (pollTimer) {
    clearInterval(pollTimer)
    pollTimer = null
  }
}

function isAssessmentDetailRoute() {
  return route.name === "HealthAssessmentDetail"
}

function resolveAssessmentId() {
  const raw = route.params.id
  if (raw == null || raw === "" || String(raw) === "undefined") {
    return null
  }
  const n = Number(raw)
  return Number.isFinite(n) && n > 0 ? String(n) : null
}

function startPolling() {
  stopPolling()
  const id = resolveAssessmentId()
  if (!id || !isAssessmentDetailRoute()) {
    return
  }
  pollTimer = setInterval(() => {
    getAssessment(id).then(res => {
      row.value = res.data || {}
      if (row.value.analysisStatus !== 0) {
        stopPolling()
        initCharts()
      }
    }).catch(() => {})
  }, 3000)
}

function goBack() {
  router.back()
}

function goCheckIn() {
  const q = {
    fromHealth: '1',
    elderName: row.value.elderName || '',
    idCard: row.value.idCard || ''
  }
  router.push({ path: '/serve/checkIn-apply/index', query: q })
}

function load() {
  if (!isAssessmentDetailRoute()) {
    loading.value = false
    return
  }
  const id = resolveAssessmentId()
  if (!id) {
    loading.value = false
    return
  }
  loading.value = true
  getAssessment(id)
    .then(res => {
      row.value = res.data || {}
      loading.value = false
      if (row.value.analysisStatus === 0) {
        startPolling()
      } else {
        stopPolling()
      }
      initCharts()
    })
    .catch(() => {
      loading.value = false
    })
}

function onResize() {
  ageChart && ageChart.resize()
  radarChart && radarChart.resize()
}

onMounted(() => {
  window.addEventListener('resize', onResize)
})

onBeforeUnmount(() => {
  stopPolling()
  window.removeEventListener('resize', onResize)
  disposeCharts()
})

watch(
  () => [route.name, route.params.id],
  () => {
    if (!isAssessmentDetailRoute()) {
      stopPolling()
      disposeCharts()
      return
    }
    if (!resolveAssessmentId()) {
      stopPolling()
      disposeCharts()
      return
    }
    disposeCharts()
    stopPolling()
    load()
  },
  { immediate: true }
)
</script>

<style scoped>
.mb16 {
  margin-bottom: 16px;
}
.card-title {
  font-weight: 600;
}
.chart-card {
  background: linear-gradient(180deg, #fafcff 0%, #ffffff 40%);
  border: 1px solid #ebeef5;
}
.chart-box {
  width: 100%;
  height: 340px;
}
.chart-box--pad {
  padding: 4px 0 0;
}
.chart-caption {
  text-align: center;
  font-size: 12px;
  color: #909399;
  margin-top: 10px;
}
.chart-caption .accent {
  color: #f56c6c;
  font-weight: 600;
}
.expand-block {
  padding: 8px 48px 12px 48px;
  line-height: 1.6;
  color: #606266;
}
.assessment-detail :deep(.el-page-header__content) {
  font-size: 16px;
}
.detail-footer-actions {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 20px 0 8px;
  margin-top: 8px;
  border-top: 1px solid #ebeef5;
}
.footer-hint {
  font-size: 13px;
  color: #909399;
}
</style>
