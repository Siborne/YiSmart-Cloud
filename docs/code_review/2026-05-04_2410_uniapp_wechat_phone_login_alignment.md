# UniApp 对齐 mp-weixin 手机号登录处理

## 变更背景/目的
- 用户已在 `mp-weixin` 修复了微信手机号登录流程，希望 UniApp 端参考并对齐同类处理逻辑。
- 目标是提升 `getPhoneNumber` 事件兼容性，减少授权通过但前端误判失败的问题。

## 变更文件清单
- `YiSmartCloud-member-uniapp/pages/login/index.vue`

## 关键改动说明
- `decryptPhoneNumber` 授权成功判定逻辑对齐：
  - 同时检查 `e.detail.errMsg` 与 `e.target.errMsg`
  - 只要任一为 `getPhoneNumber:ok` 即视为授权成功
- 保持 `phoneCode` 必填校验，避免空凭证继续请求后端。
- 登录请求参数补齐昵称：
  - 新增 `resolveNickName()`，通过 `uni.getUserInfo` 获取 `nickName`
  - 获取失败时降级为空串，不阻断登录流程

## 影响范围
- 前端：微信快速登录成功判定更稳，参数更接近小程序端实现。
- 后端接口：无变更（继续调用 `/serve/member/user/login`）。

## 验证方式
- 已执行：lints 检查通过，无新增报错。
- 未执行：微信开发者工具/真机手工回归（授权通过、拒绝授权、无 phoneCode 三种分支）。
