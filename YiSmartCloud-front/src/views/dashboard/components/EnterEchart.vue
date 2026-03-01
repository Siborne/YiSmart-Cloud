<template>
  <div id="chart" ref="EcharRef" class="monitorContainer"></div>
</template>

<script setup>
import { ref, watch, nextTick,onMounted } from 'vue'
import * as echarts from 'echarts'

const props = defineProps({
  allDateArr: {
    type: Array,
    default: () => []
  },
  allTimeArr: {
    type: Array,
    default: () => []
  }
})
// 创建一个erchart线图
const EcharRef = ref(null)
const baseData = ref([])
const baseTime = ref([])
// 监听器，监听父级传递的visible值，控制弹窗显示隐藏
watch(props, (val) => {
  baseData.value = val.allDateArr
  baseTime.value = val.allTimeArr
  setOption()
})
onMounted(()=>{
  baseData.value = props.allDateArr;
  baseTime.value = props.allTimeArr;
  setOption();
})
const setOption = () => {
  const chartDom = document.getElementById('chart')
  const myChart = echarts.init(chartDom)
  let option = null
  nextTick(() => {
    setTimeout(() => {
      option = {
        color: ['#4D8DFF', '#00B8A0'],
        tooltip: {
          trigger: 'axis',
          formatter(params) {
            let relVal = params[0].name
            for (let i = 0, l = params.length; i < l; i++) {
              relVal += `<br/>${params[i].marker}${params[i].seriesName} ${params[i].value}人`
            }
            return relVal
          }
        },
        grid: {
          left: '0',
          right: '20px',
          top: '30px',
          bottom: '0',
          containLabel: true
        },
        legend: false, // 隐藏图例
        xAxis: {
          type: 'category',
          data: baseTime.value,
          axisLabel: {
            color: '#595959'
          },
          axisLine: {
            lineStyle: {
              width: 1,
              color: '#dcdcdc'
            }
          }
        },
        yAxis: {
          type: 'value',
          axisLabel: {
            color: '#595959'
          },
          splitLine: {
            lineStyle: {
              type: 'dashed', // 线的类型
              color: '#dcdcdc'
            }
          }
        },
        series: [
          {
            name: '入住人数',
            data: baseData.value.incomeData,
            type: 'bar',
            smooth: true,
            barWidth: '10px'
          },
          {
            name: '退住人数',
            data: baseData.value.refundData,
            type: 'bar',
            smooth: true,
            barWidth: '10px'
          }
        ]
      }

      myChart.setOption(option)
    }, 10)
  })
}
</script>
