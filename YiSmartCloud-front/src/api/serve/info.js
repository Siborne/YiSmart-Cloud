import request from '@/utils/request'

// 查询在院老人信息列表（与入住办理联动）
export function listInfo(query) {
  return request({
    url: '/serve/info/list',
    method: 'get',
    params: query
  })
}

// 查询在院老人信息详细
export function getInfo(id) {
  return request({
    url: '/serve/info/' + id,
    method: 'get'
  })
}

// 新增在院老人信息
export function addInfo(data) {
  return request({
    url: '/serve/info',
    method: 'post',
    data: data
  })
}

// 修改在院老人信息
export function updateInfo(data) {
  return request({
    url: '/serve/info',
    method: 'put',
    data: data
  })
}

// 删除在院老人信息
export function delInfo(id) {
  return request({
    url: '/serve/info/' + id,
    method: 'delete'
  })
}
