import request from '@/utils/request'

// 查询老人档案列表
export function listInfo(query) {
  return request({
    url: '/serve/info/list',
    method: 'get',
    params: query
  })
}

// 查询老人档案详细
export function getInfo(id) {
  return request({
    url: '/serve/info/' + id,
    method: 'get'
  })
}

// 新增老人档案
export function addInfo(data) {
  return request({
    url: '/serve/info',
    method: 'post',
    data: data
  })
}

// 修改老人档案
export function updateInfo(data) {
  return request({
    url: '/serve/info',
    method: 'put',
    data: data
  })
}

// 删除老人档案
export function delInfo(id) {
  return request({
    url: '/serve/info/' + id,
    method: 'delete'
  })
}
