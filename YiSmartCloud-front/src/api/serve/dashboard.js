import request from '@/utils/request'

/** 管理端首页汇总（真实统计数据） */
export function getDashboardSummary() {
  return request({
    url: '/serve/dashboard/summary',
    method: 'get'
  })
}
