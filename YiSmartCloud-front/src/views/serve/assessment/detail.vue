<template>
  <div class="app-container assessment-detail" v-loading="loading">
    <el-page-header @back="goBack" content="健康管理" class="mb16" />

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

    <el-card shadow="never" class="mb16">
      <template #header><span class="card-title">疾病风险</span></template>
      <el-row :gutter="16">
        <el-col :xs="24" :lg="12">
          <div ref="ageChartRef" class="chart-box" />
          <div class="chart-caption">不同年龄组健康指数分布（示意）</div>
        </el-col>
        <el-col :xs="24" :lg="12">
          <div ref="radarChartRef" class="chart-box" />
          <div class="chart-caption">人体各系统健康指数（AI）</div>
        </el-col>
      </el-row>
    </el-card>

    <el-card shadow="never">
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

const abnormalRows = computed(() => {
  const r = row.value
  if (!r) {
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

/** 各年龄段示意堆叠数据（非真实统计） */
const MOCK_AGE_STACK = [
  { healthy: 8, caution: 22, risk: 28, danger: 25, severeDanger: 17 },
  { healthy: 6, caution: 18, risk: 32, danger: 28, severeDanger: 16 },
  { healthy: 5, caution: 15, risk: 30, danger: 32, severeDanger: 18 },
  { healthy: 4, caution: 12, risk: 26, danger: 35, severeDanger: 23 },
  { healthy: 3, caution: 10, risk: 22, danger: 33, severeDanger: 32 }
]

function buildAgeChartOption(highlightIndex) {
  const series = [
    { name: '健康', type: 'bar', stack: 'total', emphasis: { focus: 'series' }, data: MOCK_AGE_STACK.map(r => r.healthy), itemStyle: { color: '#67c23a' } },
    { name: '提示', type: 'bar', stack: 'total', data: MOCK_AGE_STACK.map(r => r.caution), itemStyle: { color: '#e6a23c' } },
    { name: '风险', type: 'bar', stack: 'total', data: MOCK_AGE_STACK.map(r => r.risk), itemStyle: { color: '#f56c6c' } },
    { name: '危险', type: 'bar', stack: 'total', data: MOCK_AGE_STACK.map(r => r.danger), itemStyle: { color: '#c0392b' } },
    { name: '严重危险', type: 'bar', stack: 'total', data: MOCK_AGE_STACK.map(r => r.severeDanger), itemStyle: { color: '#7b1fa2' } }
  ]
  return {
    tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
    legend: { top: 0 },
    grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
    xAxis: { type: 'category', data: AGE_CATEGORIES },
    yAxis: { type: 'value', max: 100, axisLabel: { formatter: '{value}%' } },
    series,
    graphic: highlightIndex >= 0 && highlightIndex < AGE_CATEGORIES.length
      ? [{
          type: 'text',
          right: 20,
          top: 40,
          style: { text: '当前年龄段：' + AGE_CATEGORIES[highlightIndex], fill: '#f56c6c', fontSize: 12 }
        }]
      : []
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
    return { title: { text: '暂无系统分值', left: 'center', top: 'middle' } }
  }
  const indicator = scores.map(s => ({ name: s.name, max: 100 }))
  const dataVals = scores.map(s => s.value)
  const avg = dataVals.length ? (dataVals.reduce((a, b) => a + b, 0) / dataVals.length).toFixed(2) : '0'
  return {
    tooltip: {},
    radar: {
      indicator,
      center: ['50%', '52%'],
      radius: '58%'
    },
    series: [{
      type: 'radar',
      data: [{ value: dataVals, name: '系统得分', areaStyle: { opacity: 0.15 } }]
    }],
    title: {
      text: '中心综合约 ' + avg + ' 分',
      left: 'center',
      bottom: 0,
      textStyle: { fontSize: 12, color: '#606266' }
    }
  }
}

function initCharts() {
  nextTick(() => {
    const age = parseAgeFromId(row.value.idCard)
    const idx = ageBandIndex(age)
    if (ageChartRef.value) {
      if (!ageChart) {
        ageChart = echarts.init(ageChartRef.value)
      }
      ageChart.setOption(buildAgeChartOption(idx), true)
    }
    if (radarChartRef.value) {
      if (!radarChart) {
        radarChart = echarts.init(radarChartRef.value)
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

function goBack() {
  router.back()
}

function load() {
  const id = route.params.id
  loading.value = true
  getAssessment(id).then(res => {
    row.value = res.data || {}
    loading.value = false
    initCharts()
  }).catch(() => {
    loading.value = false
  })
}

function onResize() {
  ageChart && ageChart.resize()
  radarChart && radarChart.resize()
}

onMounted(() => {
  load()
  window.addEventListener('resize', onResize)
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', onResize)
  disposeCharts()
})

watch(() => route.params.id, () => {
  disposeCharts()
  load()
})
</script>

<style scoped>
.mb16 {
  margin-bottom: 16px;
}
.card-title {
  font-weight: 600;
}
.chart-box {
  width: 100%;
  height: 320px;
}
.chart-caption {
  text-align: center;
  font-size: 12px;
  color: #909399;
  margin-top: 8px;
}
.expand-block {
  padding: 8px 48px 12px 48px;
  line-height: 1.6;
  color: #606266;
}
.assessment-detail :deep(.el-page-header__content) {
  font-size: 16px;
}
</style>
