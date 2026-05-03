"use strict";
const utils_request = require("../../utils/request.js");
const getOrderList = (params) => utils_request.request({
  url: "/orders/order/page",
  method: "get",
  params
});
const getOrderDetail = (id) => utils_request.request({
  url: `/orders/${id}`,
  method: "get"
});
const cancelOrder = (params) => utils_request.request({
  url: `/orders/${params.orderId}/cancel?reason=` + params.reason,
  method: "post"
});
const orderDelete = (id) => utils_request.request({
  url: `/orders/${id}`,
  method: "delete"
});
const orderRefund = (params) => utils_request.request({
  url: `/orders/refund`,
  method: "post",
  params
});
exports.cancelOrder = cancelOrder;
exports.getOrderDetail = getOrderDetail;
exports.getOrderList = getOrderList;
exports.orderDelete = orderDelete;
exports.orderRefund = orderRefund;
