import request from '@/utils/request'

// 按床位状态查询楼层-房间-床位树
export function getRoomAndBedByBedStatus(status) {
  return request({
    url: `/serve/floor/getRoomAndBedByBedStatus/${status}`,
    method: 'get'
  })
}
