"use strict";
// 根地址：业务路径在 pages/api 中写全（/member/...、/serve/member/user/login）
const baseUrl = "http://172.16.17.191:8080";
const notToLoginApiUrl = ["/serve/member/user/login"];
exports.baseUrl = baseUrl;
exports.notToLoginApiUrl = notToLoginApiUrl;
