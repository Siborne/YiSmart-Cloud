import request from '@/utils/request'

// 查询费用账单明细列表
export function listDetail(query) {
  return request({
    url: '/serve/detail/list',
    method: 'get',
    params: query
  })
}

// 查询费用账单明细详细
export function getDetail(id) {
  return request({
    url: '/serve/detail/' + id,
    method: 'get'
  })
}

// 新增费用账单明细
export function addDetail(data) {
  return request({
    url: '/serve/detail',
    method: 'post',
    data: data
  })
}

// 修改费用账单明细
export function updateDetail(data) {
  return request({
    url: '/serve/detail',
    method: 'put',
    data: data
  })
}

// 删除费用账单明细
export function delDetail(id) {
  return request({
    url: '/serve/detail/' + id,
    method: 'delete'
  })
}
