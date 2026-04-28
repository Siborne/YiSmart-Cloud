import request from '@/utils/request'

// 查询入住配置列表
export function listCheckInConfig(query) {
  return request({
    url: '/serve/checkInConfig/list',
    method: 'get',
    params: query
  })
}

// 查询入住配置详细
export function getCheckInConfig(id) {
  return request({
    url: '/serve/checkInConfig/' + id,
    method: 'get'
  })
}

// 新增入住配置
export function addCheckInConfig(data) {
  return request({
    url: '/serve/checkInConfig',
    method: 'post',
    data: data
  })
}

// 修改入住配置
export function updateCheckInConfig(data) {
  return request({
    url: '/serve/checkInConfig',
    method: 'put',
    data: data
  })
}

// 删除入住配置
export function delCheckInConfig(id) {
  return request({
    url: '/serve/checkInConfig/' + id,
    method: 'delete'
  })
}
