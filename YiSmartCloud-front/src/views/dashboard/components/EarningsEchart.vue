<template>
  <div id="main" ref="EcharRef" class="monitorContainer"></div>
</template>

<script setup>
import { ref, watch, nextTick,onMounted } from 'vue';
import * as echarts from 'echarts';
import { number } from 'echarts/core';

const props = defineProps({
  allDateArr: {
    type: Array,
    default: () => [],
  },
  allTimeArr: {
    type: Array,
    default: () => [],
  },
  tabActive: {
    type: Number,
    default: 0,
  },
});
// 创建一个erchart线图
const EcharRef = ref(null);
const baseData = ref([]);
const baseTime = ref([]);
// 监听器，监听父级传递的visible值，控制弹窗显示隐藏
watch(props, (val) => {
  baseData.value = val.allDateArr;
  baseTime.value = val.allTimeArr;
  setOption();
});
onMounted(()=>{
  baseData.value = props.allDateArr;
  baseTime.value = props.allTimeArr;
  setOption();
})
const setOption = () => {
  const chartDom = document.getElementById('main');
  const myChart = echarts.init(chartDom);
  let option = null;
  nextTick(() => {
    option = {
      color: ['#4D8DFF', '#00B8A0'],
      tooltip: {
        trigger: 'axis',
        formatter(params) {
          let relVal = params[0].name;
          for (let i = 0, l = params.length; i < l; i++) {
            relVal += `<br/>${params[i].marker}${params[i].seriesName} ${params[i].value}元`;
          }
          return relVal;
        },
      },
      grid: {
        left: '0',
        right: '20px',
        top: '30px',
        bottom: '0',
        containLabel: true,
      },
      legend: false, // 隐藏图例
      xAxis: {
        type: 'category',
        data: baseTime.value,
        boundaryGap: false,
        axisLabel: {
          color: '#595959',
        },
        axisLine: {
          lineStyle: {
            width: 1,
            color: '#dcdcdc',
          },
        },
      },
      yAxis: {
        type: 'value',
        axisLabel: {
          color: '#595959',
        },
        // nameGap: 15, // 坐标轴名称与轴线间距离
        // min: 0,
        // max: 100,
        splitLine: {
          lineStyle: {
            type: 'dashed', // 线的类型
            color: '#dcdcdc',
          },
        },
      },
      series: [
        {
          name: '收入金额',
          data: baseData.value.incomeData,
          type: 'line',
          smooth: true,
        },
        {
          name: '退款金额',
          data: baseData.value.refundData,
          type: 'line',
          smooth: true,
        },
      ],
    };

    myChart.setOption(option);
  });
};
</script>
