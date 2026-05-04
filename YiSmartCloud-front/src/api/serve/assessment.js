import request from '@/utils/request'

// 查询健康评估列表
export function listAssessment(query) {
  return request({
    url: '/serve/assessment/list',
    method: 'get',
    params: query
  })
}

// 查询健康评估详细
export function getAssessment(id) {
  return request({
    url: '/serve/assessment/' + id,
    method: 'get'
  })
}

// 新增健康评估
export function addAssessment(data) {
  return request({
    url: '/serve/assessment',
    method: 'post',
    data: data
  })
}

// 修改健康评估
export function updateAssessment(data) {
  return request({
    url: '/serve/assessment',
    method: 'put',
    data: data
  })
}

// 删除健康评估
export function delAssessment(id) {
  return request({
    url: '/serve/assessment/' + id,
    method: 'delete'
  })
}

/** 上传体检报告 PDF（multipart：file + idCardNo） */
export function uploadAssessmentReport(formData) {
  return request({
    url: '/serve/assessment/upload',
    method: 'post',
    data: formData
  })
}

/** 提交千帆分析并入库（同步，耗时长） */
export function analyzeAssessment(data) {
  return request({
    url: '/serve/assessment/analyze',
    method: 'post',
    data: data,
    timeout: 180000
  })
}

/** 异步排队分析（立即返回，完成后在详情查看） */
export function analyzeAssessmentAsync(data) {
  return request({
    url: '/serve/assessment/analyze-async',
    method: 'post',
    data: data,
    timeout: 60000
  })
}
