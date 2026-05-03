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

// 查询楼层列表
export function listFloor(query) {
  return request({
    url: '/serve/floor/list',
    method: 'get',
    params: query
  })
}

// 查询楼层下拉
export function listFloorOptions() {
  return request({
    url: '/serve/floor/options',
    method: 'get'
  })
}

// 查询楼层详情
export function getFloor(id) {
  return request({
    url: '/serve/floor/' + id,
    method: 'get'
  })
}

// 新增楼层
export function addFloor(data) {
  return request({
    url: '/serve/floor',
    method: 'post',
    data: data
  })
}

// 修改楼层
export function updateFloor(data) {
  return request({
    url: '/serve/floor',
    method: 'put',
    data: data
  })
}

// 删除楼层
export function delFloor(id) {
  return request({
    url: '/serve/floor/' + id,
    method: 'delete'
  })
}
