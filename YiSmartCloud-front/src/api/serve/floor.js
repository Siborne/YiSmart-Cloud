import request from '@/utils/request'

/** ???????? */
export function listFloor(query) {
  return request({
    url: '/serve/floor/list',
    method: 'get',
    params: query
  })
}

/** ???????????????? */
export function listFloorOptions() {
  return request({
    url: '/serve/floor/options',
    method: 'get'
  })
}

/** ?????? */
export function getFloor(id) {
  return request({
    url: '/serve/floor/' + id,
    method: 'get'
  })
}

/** ???? */
export function addFloor(data) {
  return request({
    url: '/serve/floor',
    method: 'post',
    data: data
  })
}

/** ???? */
export function updateFloor(data) {
  return request({
    url: '/serve/floor',
    method: 'put',
    data: data
  })
}

/** ???? */
export function delFloor(id) {
  return request({
    url: '/serve/floor/' + id,
    method: 'delete'
  })
}

/** ?????????-??-??? */
export function getRoomAndBedByBedStatus(status) {
  return request({
    url: `/serve/floor/getRoomAndBedByBedStatus/${status}`,
    method: 'get'
  })
}
