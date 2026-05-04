import request from '@/utils/request'

// 查询房间信息列表
export function listRoom(query) {
  return request({
    url: '/serve/room/list',
    method: 'get',
    params: query
  })
}

// 查询房间信息详细
export function getRoom(id) {
  return request({
    url: '/serve/room/' + id,
    method: 'get'
  })
}

// 新增房间信息
export function addRoom(data) {
  return request({
    url: '/serve/room',
    method: 'post',
    data: data
  })
}

// 修改房间信息
export function updateRoom(data) {
  return request({
    url: '/serve/room',
    method: 'put',
    data: data
  })
}

// 删除房间信息
export function delRoom(id) {
  return request({
    url: '/serve/room/' + id,
    method: 'delete'
  })
}
