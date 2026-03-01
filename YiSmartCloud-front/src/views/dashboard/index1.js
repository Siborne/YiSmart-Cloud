import dayjs from 'dayjs'
import { getChartListColor } from '@/utils/color'
import { getRandomArray } from '@/utils/charts'
/** 首页 dashboard 折线图 */
export function constructInitDashboardDataset(type) {
  const dateArray= [
    '周一',
    '周二',
    '周三',
    '周四',
    '周五',
    '周六',
    '周日'
  ]
  const datasetAxis = {
    xAxis: {
      type: 'category',
      show: false,
      data: dateArray
    },
    yAxis: {
      show: false,
      type: 'value'
    },
    grid: {
      top: 0,
      left: 0,
      right: 0,
      bottom: 0
    }
  }

  if (type === 'line') {
    const lineDataset = {
      ...datasetAxis,
      color: ['#fff'],
      series: [
        {
          data: [150, 230, 224, 218, 135, 147, 260],
          type,
          showSymbol: true,
          symbol: 'circle',
          symbolSize: 0,
          markPoint: {
            data: [
              { type: 'max', name: '最大值' },
              { type: 'min', name: '最小值' }
            ]
          },
          lineStyle: {
            width: 2
          }
        }
      ]
    }
    return lineDataset
  }
  const barDataset = {
    ...datasetAxis,
    color: getChartListColor(),
    series: [
      {
        data: [
          100,
          130,
          184,
          218,
          {
            value: 135,
            itemStyle: {
              opacity: 0.2
            }
          },
          {
            value: 118,
            itemStyle: {
              opacity: 0.2
            }
          },
          {
            value: 60,
            itemStyle: {
              opacity: 0.2
            }
          }
        ],
        type,
        barWidth: 9
      }
    ]
  }
  return barDataset
}

/** 柱状图数据源 */
export function constructInitDataset({
  dateTime = [],
  placeholderColor,
  borderColor
}) {
  const divideNum = 10
  const timeArray = []
  const inArray = []
  const outArray = []
  for (let i = 0; i < divideNum; i++) {
    if (dateTime.length > 0) {
      const dateAbsTime=
        (new Date(dateTime[1]).getTime() - new Date(dateTime[0]).getTime()) /
        divideNum
      const enhandTime=
        new Date(dateTime[0]).getTime() + dateAbsTime * i
      timeArray.push(dayjs(enhandTime).format('YYYY-MM-DD'))
    } else {
      timeArray.push(
        dayjs()
          .subtract(divideNum - i, 'day')
          .format('YYYY-MM-DD')
      )
    }

    inArray.push(getRandomArray().toString())
    outArray.push(getRandomArray().toString())
  }

  const dataset = {
    color: getChartListColor(),
    tooltip: {
      trigger: 'item'
    },
    xAxis: {
      type: 'category',
      data: timeArray,
      axisLabel: {
        color: placeholderColor
      },
      axisLine: {
        lineStyle: {
          color: getChartListColor()[1],
          width: 1
        }
      }
    },
    yAxis: {
      type: 'value',
      axisLabel: {
        color: placeholderColor
      },
      splitLine: {
        lineStyle: {
          color: borderColor
        }
      }
    },
    grid: {
      top: '5%',
      left: '25px',
      right: 0,
      bottom: '60px'
    },
    legend: {
      icon: 'rect',
      itemWidth: 12,
      itemHeight: 4,
      itemGap: 48,
      textStyle: {
        fontSize: 12,
        color: placeholderColor
      },
      left: 'center',
      bottom: '0',
      orient: 'horizontal',
      data: ['本月', '上月']
    },
    series: [
      {
        name: '本月',
        data: outArray,
        type: 'bar'
      },
      {
        name: '上月',
        data: inArray,
        type: 'bar'
      }
    ]
  }

  return dataset
}

/**
 *  线性图表数据源
 */
export function getLineChartDataSet({ borderColor }, data, time) {
  const dataSet = {
    color: ['#4D8DFF', '#00B8A0'],
    tooltip: {
      trigger: 'axis',
      formatter(params) {
        let relVal = params[0].name
        for (let i = 0, l = params.length; i < l; i++) {
          relVal += `<br/>${params[i].marker}${params[i].seriesName} ${params[i].value}元`
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
      data: time,
      boundaryGap: false,
      axisLabel: {
        color: '#595959'
      },
      axisLine: {
        lineStyle: {
          width: 1,
          color: borderColor
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
          color: borderColor
        }
      }
    },
    series: [
      {
        name: '收入金额',
        data: data.incomeData,
        type: 'line',
        smooth: true
      },
      {
        name: '退款金额',
        data: data.refundData,
        type: 'line',
        smooth: true
      }
    ]
  }
  return dataSet
}
// 入退情况
/**
 *  柱状图表数据源
 */
export function getIncomeChartDataSet({ borderColor }, data, time) {
  const dataSet = {
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
      data: time,
      axisLabel: {
        color: '#595959'
      },
      axisLine: {
        lineStyle: {
          width: 1,
          color: borderColor
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
          color: borderColor
        }
      }
    },
    series: [
      {
        name: '入住人数',
        data: data.incomeData,
        type: 'bar',
        smooth: true,
        barWidth: '10px'
      },
      {
        name: '退住人数',
        data: data.refundData,
        type: 'bar',
        smooth: true,
        barWidth: '10px'
      }
    ]
  }
  return dataSet
}
/**
 *  线性图表数据源
 */
export function getServeChartDataSet({ borderColor }, data, time) {
  const dataSet = {
    color: ['#00B8A0'],
    tooltip: {
      trigger: 'axis',
      formatter(params) {
        let relVal = params[0].name
        for (let i = 0, l = params.length; i < l; i++) {
          relVal += `<br/>${params[i].marker}${params[i].seriesName} ${params[i].value}次`
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
      data: time,
      boundaryGap: false,
      axisLabel: {
        color: '#595959'
      },
      axisLine: {
        lineStyle: {
          width: 1,
          color: borderColor
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
          color: borderColor
        }
      }
    },
    series: [
      {
        name: '收入金额',
        data,
        type: 'line',
        smooth: true
      }
    ]
  }
  return dataSet
}
/**
 * 获取饼图数据
 *
 * @export
 * @param {number} [num=1]
 * @returns {*}
 */
export function getOldPieChartDataSet({ textColor, containerColor }, data) {
  return {
    color: getChartListColor(),
    tooltip: {
      trigger: 'item',
      formatter: '{b}: {c} 人'
    },
    grid: {
      top: '0',
      right: '0'
    },
    legend: false, // 隐藏图例
    series: [
      {
        name: '销售渠道',
        type: 'pie',
        radius: ['65%', '80%'],
        avoidLabelOverlap: true,
        itemStyle: {
          borderColor: containerColor,
          borderWidth: 1
        },
        label: {
          show: true,
          position: 'center',
          formatter: [`{value|${data.total}人}`, '{name|老人数量}'].join('\n'),
          rich: {
            value: {
              color: textColor,
              fontSize: 18,
              fontWeight: 'normal',
              lineHeight: 46
            },
            name: {
              color: '#909399',
              fontSize: 14,
              lineHeight: 14
            }
          }
        },
        labelLine: {
          show: false
        },
        data: data.data
      }
    ]
  }
}
// 床位数量
export function getBedPieChartDataSet({ textColor, containerColor }, data) {
  return {
    color: ['#d7f1ed', '#689FFF'],
    tooltip: {
      trigger: 'item',
      formatter: '{b}: {c} 个'
    },
    grid: {
      top: '0',
      right: '0'
    },
    legend: false, // 隐藏图例
    series: [
      {
        name: '床位数量',
        type: 'pie',
        radius: ['65%', '80%'],
        avoidLabelOverlap: true,
        itemStyle: {
          borderColor: containerColor,
          borderWidth: 1
        },
        label: {
          show: true,
          position: 'center',
          formatter: [`{value|${data.total}个}`, '{name|床位数量}'].join('\n'),
          rich: {
            value: {
              color: textColor,
              fontSize: 18,
              fontWeight: 'normal',
              lineHeight: 46
            },
            name: {
              color: '#909399',
              fontSize: 14,
              lineHeight: 14
            }
          }
        },
        labelLine: {
          show: false
        },
        data: data.data
      }
    ]
  }
}
// 服务数量
export function getservePieChartDataSet({ textColor, containerColor }, data) {
  return {
    color: ['#d7f1ed', '#ADA5EE'],
    tooltip: {
      trigger: 'item',
      formatter: '{b}: {c} w笔'
    },
    grid: {
      top: '0',
      right: '0'
    },
    legend: false, // 隐藏图例
    series: [
      {
        name: '床服务单数量',
        type: 'pie',
        radius: ['65%', '80%'],
        avoidLabelOverlap: true,
        itemStyle: {
          borderColor: containerColor,
          borderWidth: 1
        },
        label: {
          show: true,
          position: 'center',
          formatter: [`{value|${data.total}w笔}`, '{name|服务单数量}'].join(
            '\n'
          ),
          rich: {
            value: {
              color: textColor,
              fontSize: 18,
              fontWeight: 'normal',
              lineHeight: 46
            },
            name: {
              color: '#909399',
              fontSize: 14,
              lineHeight: 14
            }
          }
        },
        labelLine: {
          show: false
        },
        data: data.data
      }
    ]
  }
}
// 员工数量
export function getStaffPieChartDataSet({ textColor, containerColor }, data) {
  return {
    color: ['#d7f1ed', '#FFB056'],
    tooltip: {
      trigger: 'item',
      formatter: '{b}: {c} 人'
    },
    grid: {
      top: '0',
      right: '0'
    },
    legend: false, // 隐藏图例
    series: [
      {
        name: '员工数量',
        type: 'pie',
        radius: ['65%', '80%'],
        avoidLabelOverlap: true,
        itemStyle: {
          borderColor: containerColor,
          borderWidth: 1
        },
        label: {
          show: true,
          position: 'center',
          formatter: [`{value|${data.total}人}`, '{name|员工数量}'].join('\n'),
          rich: {
            value: {
              color: textColor,
              fontSize: 18,
              fontWeight: 'normal',
              lineHeight: 46
            },
            name: {
              color: '#909399',
              fontSize: 14,
              lineHeight: 14
            }
          }
        },
        labelLine: {
          show: false
        },
        data: data.data
      }
    ]
  }
}
// 收入金额
export function getMoneyPieChartDataSet({ textColor, containerColor }, data) {
  return {
    color: ['#d7f1ed', '#FE8585'],
    tooltip: {
      trigger: 'item',
      formatter: '{b}: {c} w元'
    },
    grid: {
      top: '0',
      right: '0'
    },
    legend: false, // 隐藏图例
    series: [
      {
        name: '收入金额',
        type: 'pie',
        radius: ['65%', '80%'],
        avoidLabelOverlap: true,
        itemStyle: {
          borderColor: containerColor,
          borderWidth: 1
        },
        label: {
          show: true,
          position: 'center',
          formatter: [`{value|${data.total}w元}`, '{name|收入金额}'].join('\n'),
          rich: {
            value: {
              color: textColor,
              fontSize: 18,
              fontWeight: 'normal',
              lineHeight: 46
            },
            name: {
              color: '#909399',
              fontSize: 14,
              lineHeight: 14
            }
          }
        },
        labelLine: {
          show: false
        },
        data: data.data
      }
    ]
  }
}

// 老人等级分布
export const getElderRankDistribution=(data)=> {
  return {
    color: ['#47CBBA', '#9891df', '#8EBEF3', '#FFB057', '#FE6E6E'],
    tooltip: {
      trigger: 'item',
      formatter(params) {
        return `<div>
          ${params.name}<br/>
          <div>${params.marker} <span style="font-weight:bold;">${params.value}人 &nbsp;  ${params.percent}% </span></div>
        </div>`
      }
    },

    legend: {
      icon: 'circle',
      itemHeight: 6,
      orient: 'vertical',
      left: '60%',
      top: 'center',
      align: 'left'
    },
    grid: {
      top: '10%',
      bottom: '5%'
    },
    series: [
      {
        name: '',
        type: 'pie',
        radius: ['30%', '60%'],
        center: ['30%', '50%'], // 控制饼图生成在盒子的哪个位置，[左右,上下]
        label: {
          show: false,
          position: 'center'
        },
        labelLine: {
          show: false
        },
        startAngle: 225, // 起始角度
        data
      }
    ]
  }
}

// 老人年龄分布
export const getElderAgeDistribution=(data)=> {
  const xAxisData = ['60岁以下', '60-70岁', '71-80岁', '81-90岁', '90岁以上']
  return {
    color: ['#27C2AE', '#FE6E6E'],
    legend: {
      data: ['男', '女'],
      icon: 'circle',
      itemHeight: 6,
      top: 'bottom'
    },
    tooltip: {
      trigger: 'item',
      formatter(params) {
        return `<div>
          ${params.name}<br/>
          <div>${params.marker}<span style="font-weight:bold;">${params.seriesName}&nbsp;${params.value}人</span></div>
        </div>`
      }
    },
    xAxis: {
      data: xAxisData,
      axisLine: { onZero: true },
      splitLine: { show: false },
      splitArea: { show: false },
      axisLabel: {
        // x轴文字的配置
        show: true,
        interval: 0 // 使x轴文字显示全
      }
    },
    yAxis: {},
    grid: {
      left: '15%',
      top: '10%',
      bottom: '25%'
    },
    series: [
      {
        name: '男',
        type: 'bar',
        barWidth: 20,
        stack: 'one',
        data: data.man
      },
      {
        name: '女',
        type: 'bar',
        barWidth: 20,
        stack: 'one',
        data: data.woman
      }
    ]
  }
}
