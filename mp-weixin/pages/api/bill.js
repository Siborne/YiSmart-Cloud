"use strict";
const utils_request = require("../../utils/request.js");
const getBillList = (params) => utils_request.request({
  url: "/bill/page/",
  method: "get",
  params
});
const getBillDetail = (id) => utils_request.request({
  url: `/bill/${id}`,
  method: "get"
});
const billPay = (params) => utils_request.request({
  url: `/bill`,
  method: "put",
  params
});
exports.billPay = billPay;
exports.getBillDetail = getBillDetail;
exports.getBillList = getBillList;
