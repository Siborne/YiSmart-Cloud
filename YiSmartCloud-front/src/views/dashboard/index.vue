<!-- 首页 -->
<template>
  <div class="container home-wrapper">
    <!-- 顶部 card  -->
    <top-panel
      class="row-container"
      :baseData="baseData"
      :dashboard="dashboard"
    />
    <!-- 中部图表  -->
    <MiddleChart class="row-container" :dashboard="dashboard" />
    <!-- 列表排名 -->
    <rank-list
      class="row-container"
      :dashboard="dashboard"
    />
  </div>
</template>

<script setup>
import { onMounted, ref, reactive } from 'vue';
import TopPanel from './components/TopPanel.vue';
import MiddleChart from './components/MiddleChart.vue';
import RankList from './components/RankList.vue';
import { getUserProfile } from '@/api/system/user';
import { getDashboardSummary } from '@/api/serve/dashboard';

const baseData = reactive({
  user: {},
  roleGroup: {},
  postGroup: {},
}); // 用户信息
const dashboard = ref(null);

const getpersonalData = async () => {
  const res = await getUserProfile();
  baseData.user = res.data;
  baseData.roleGroup = res.roleGroup;
  baseData.postGroup = res.postGroup;
};

const loadDashboard = async () => {
  try {
    const res = await getDashboardSummary();
    dashboard.value = res.data;
  } catch (e) {
    console.warn('首页统计数据加载失败', e);
  }
};

onMounted(() => {
  getpersonalData();
  loadDashboard();
});
</script>
<style lang="scss" src="./index.scss"></style>
<style scoped>
.row-container:not(:last-child) {
  margin-bottom: 16px;
}
:deep(.el-card__body) {
  padding-top: 0 !important;
}
:deep(a) {
  cursor: pointer;
}
:deep(a:active) {
  color: #1c55cf;
}
:deep(a:hover) {
  color: rgba(0, 97, 253, 0.8);
}
</style>
