<!-- 首页 -->
<template>
  <div class="container home-wrapper">
    <!-- 顶部 card  -->
    <top-panel
      class="row-container"
      :baseData="baseData"
    />
    <!-- 中部图表  -->
    <MiddleChart class="row-container"></MiddleChart>
    <!-- 列表排名 -->
    <rank-list class="row-container" />
  </div>
</template>

<script setup>
import { onMounted, ref, reactive } from 'vue';
import TopPanel from './components/TopPanel.vue';
import MiddleChart from './components/MiddleChart.vue';
import RankList from './components/RankList.vue';
import { getUserProfile } from '@/api/system/user';

const baseData = reactive({
  user: {},
  roleGroup: {},
  postGroup: {},
}); // 用户信息
const roleListData = ref(''); // 角色
const getpersonalData = async () => {
  const res = await getUserProfile();
  baseData.user = res.data;
  baseData.roleGroup = res.roleGroup;
  baseData.postGroup = res.postGroup;
};
onMounted(() => {
  getpersonalData();
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
