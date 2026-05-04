"use strict";
const utils_request = require("../../utils/request.js");
const login = (params) => utils_request.request({
  url: "/serve/member/user/login",
  method: "post",
  params
});
exports.login = login;
