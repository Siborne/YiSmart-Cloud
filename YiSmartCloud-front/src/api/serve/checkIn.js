import request from '@/utils/request'

// 查询入住登记列表
export function listCheckIn(query) {
  return request({
    url: '/serve/checkIn/list',
    method: 'get',
    params: query
  })
}

// 查询入住登记详细
export function getCheckIn(id) {
  return request({
    url: '/serve/checkIn/' + id,
    method: 'get'
  })
}

// 查询入住详情（与申请页同结构的聚合数据）
export function getCheckInDetail(id) {
  return request({
    url: '/serve/checkIn/detail/' + id,
    method: 'get'
  })
}

// 新增入住登记
export function addCheckIn(data) {
  return request({
    url: '/serve/checkIn',
    method: 'post',
    data: data
  })
}

// 申请入住（聚合表单）
export function applyCheckIn(data) {
  return request({
    url: '/serve/checkIn/apply',
    method: 'post',
    data: data
  })
}

// 修改入住登记
export function updateCheckIn(data) {
  return request({
    url: '/serve/checkIn',
    method: 'put',
    data: data
  })
}

// 删除入住登记
export function delCheckIn(id) {
  return request({
    url: '/serve/checkIn/' + id,
    method: 'delete'
  })
}
