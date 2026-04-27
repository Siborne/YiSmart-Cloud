import request from '@/utils/request'

// 查询访客预约记录列表
export function listRecord(query) {
  return request({
    url: '/serve/visitRecord/list',
    method: 'get',
    params: query
  })
}

// 查询访客预约记录详细
export function getRecord(id) {
  return request({
    url: '/serve/visitRecord/' + id,
    method: 'get'
  })
}

// 新增访客预约记录
export function addRecord(data) {
  return request({
    url: '/serve/visitRecord',
    method: 'post',
    data: data
  })
}

// 修改访客预约记录
export function updateRecord(data) {
  return request({
    url: '/serve/visitRecord',
    method: 'put',
    data: data
  })
}

// 删除访客预约记录
export function delRecord(id) {
  return request({
    url: '/serve/visitRecord/' + id,
    method: 'delete'
  })
}
