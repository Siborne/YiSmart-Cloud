"use strict";
const utils_request = require("../../utils/request.js");
const getContractList = (params) => utils_request.request({
  url: "/member/contract/list",
  method: "get",
  params
});
exports.getContractList = getContractList;
