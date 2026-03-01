import dayjs from 'dayjs'

/**
 * 获取表头数据
 *
 * @export
 * @param {string[]} dateTime
 * @param {number} divideNum
 * @returns {string[]}
 */
export function getDateArray(
  dateTime= [],
  divideNum = 10
) {
  const timeArray = []
  if (dateTime.length > 0) {
    for (let i = 0; i < divideNum; i++) {
      const dateAbsTime =
        (dayjs(dateTime[1]).valueOf() - dayjs(dateTime[0]).valueOf()) /
        divideNum
      const enhandTime = dayjs(dateTime[0]).valueOf() + dateAbsTime * i
      timeArray.push(dayjs(enhandTime).format('YYYY-MM-DD'))
    }
  }

  return timeArray
}

/**
 * 获取随机数
 *
 * @param {number} [num=100]
 * @returns
 *
 * @memberOf DashboardBase
 */
export function getRandomArray(num = 100) {
  let resultNum = Number((Math.random() * num).toFixed(0))

  if (resultNum <= 1) {
    resultNum = 1
  }

  return resultNum
}
