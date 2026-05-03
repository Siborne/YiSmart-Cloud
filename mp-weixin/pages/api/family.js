"use strict";
const utils_request = require("../../utils/request.js");
const getElderList = (params) => utils_request.request({
  url: "/user/list-by-page",
  method: "get",
  params
});
const getAllElderList = (params) => utils_request.request({
  url: "/user/my",
  method: "get",
  params
});
const elderBinging = (params) => utils_request.request({
  url: `/user/add`,
  method: "post",
  params
});
const deviceDetail = (iotId) => utils_request.request({
  url: `/user/queryServiceProperties/` + iotId,
  method: "get"
});
const elderdeleteById = (id) => utils_request.request({
  url: `/user/deleteById?id=` + id,
  method: "delete"
});
const elderBloodPresh = (params) => utils_request.request({
  url: `/user/queryDeviceDataListByDay`,
  method: "get",
  params
});
const elderBloodPreshPing = (params) => utils_request.request({
  url: `/user/queryDeviceDataListByWeek`,
  method: "get",
  params
});
const getUnusualDataApi = (params) => utils_request.request({
  url: `/user/queryDeviceDataListByDay`,
  method: "get",
  params
});
exports.deviceDetail = deviceDetail;
exports.elderBinging = elderBinging;
exports.elderBloodPresh = elderBloodPresh;
exports.elderBloodPreshPing = elderBloodPreshPing;
exports.elderdeleteById = elderdeleteById;
exports.getAllElderList = getAllElderList;
exports.getElderList = getElderList;
exports.getUnusualDataApi = getUnusualDataApi;
