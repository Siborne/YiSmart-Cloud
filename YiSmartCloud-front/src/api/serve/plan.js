import request from '@/utils/request'

// 查询护理计划列表
export function listPlan(query) {
  return request({
    url: '/serve/plan/list',
    method: 'get',
    params: query
  })
}

// 查询护理计划详细
export function getPlan(id) {
  return request({
    url: '/serve/plan/' + id,
    method: 'get'
  })
}

// 新增护理计划
export function addPlan(data) {
  return request({
    url: '/serve/plan',
    method: 'post',
    data: data
  })
}

// 修改护理计划
export function updatePlan(data) {
  return request({
    url: '/serve/plan',
    method: 'put',
    data: data
  })
}

// 删除护理计划
export function delPlan(id) {
  return request({
    url: '/serve/plan/' + id,
    method: 'delete'
  })
}
