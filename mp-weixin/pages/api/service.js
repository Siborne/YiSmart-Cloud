"use strict";
const utils_request = require("../../utils/request.js");
const getServiceList = (params) => utils_request.request({
  url: "/orders/project/page",
  method: "get",
  params
});
const goodsDetail = (id) => utils_request.request({
  url: `/orders/project/${id}`,
  method: "get"
});
const goodsPay = (params) => utils_request.request({
  url: `/orders`,
  method: "post",
  params
});
const goodsViseiOrder = (params) => utils_request.request({
  url: `/orders/check`,
  method: "post",
  params
});
exports.getServiceList = getServiceList;
exports.goodsDetail = goodsDetail;
exports.goodsPay = goodsPay;
exports.goodsViseiOrder = goodsViseiOrder;
