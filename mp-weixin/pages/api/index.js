"use strict";
const utils_request = require("../../utils/request.js");
const getHotHoust = (params) => utils_request.request({
  url: "/member/roomTypes",
  method: "get",
  params
});
exports.getHotHoust = getHotHoust;
