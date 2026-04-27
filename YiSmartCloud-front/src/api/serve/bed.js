import request from '@/utils/request'

// 查询床位信息列表
export function listBed(query) {
  return request({
    url: '/serve/bed/list',
    method: 'get',
    params: query
  })
}

// 查询床位信息详细
export function getBed(id) {
  return request({
    url: '/serve/bed/' + id,
    method: 'get'
  })
}

// 新增床位信息
export function addBed(data) {
  return request({
    url: '/serve/bed',
    method: 'post',
    data: data
  })
}

// 修改床位信息
export function updateBed(data) {
  return request({
    url: '/serve/bed',
    method: 'put',
    data: data
  })
}

// 删除床位信息
export function delBed(id) {
  return request({
    url: '/serve/bed/' + id,
    method: 'delete'
  })
}
