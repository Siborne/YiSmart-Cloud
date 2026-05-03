"use strict";
const utils_request = require("../../utils/request.js");
const addReservation = (params) => utils_request.request({
  url: `/reservation`,
  method: "post",
  params
});
const getAllList = (params) => utils_request.request({
  url: "/reservation/countByTime",
  method: "get",
  params
});
const getList = (params) => utils_request.request({
  url: "/reservation/page",
  method: "get",
  params
});
const cancelReservation = (id) => utils_request.request({
  url: `/reservation/${id}/cancel`,
  method: "put"
});
const cancelCount = () => utils_request.request({
  url: `/reservation/cancelled-count`,
  method: "get"
});
exports.addReservation = addReservation;
exports.cancelCount = cancelCount;
exports.cancelReservation = cancelReservation;
exports.getAllList = getAllList;
exports.getList = getList;
