# 变更记录：家属端 UniApp 源码工程（从零搭建）

## 变更背景 / 目的

仓库内 `mp-weixin` 为历史 uni-app **编译产物**，缺少可维护的 `.vue` 源码。新增 `YiSmartCloud-member-uniapp`（Vue3 + Vite + Pinia），路由与 `pages/api` 契约对齐旧小程序与后端会员接口；第一期仅编译微信小程序。

## 变更文件清单

- 新增目录：`YiSmartCloud-member-uniapp/`（`package.json`、`vite.config.js`、`index.html`、`src/**`、`.env.example`、`.env.development`、`.gitignore`、`README.md`）
- 修改：根目录 [`README.md`](../README.md)（仓库结构说明与「7.1 微信小程序」小节）、[`AGENTS.md`](../AGENTS.md)（目录表与家属端说明）

## 关键改动说明

- `src/pages.json`：主包与 `subPackages` 与 `mp-weixin/app.json` 路径一致。
- `src/utils/request.js`：`VITE_API_BASE` + `Authorization: Bearer` + `401` 处理 + 登录白名单 `/serve/member/user/login`。
- `src/api/*`：迁移旧编译产物中的接口路径（login、首页房型、预约、服务、订单、账单、合同、家属等）。
- MVP 页面：登录（微信 `getPhoneNumber` + `uni.login`）、首页房型列表、我的、亲友/服务列表与详情（需登录）、自定义底栏 `FootTab`；其余分包页为占位或简单列表联调。
- 构建验证：本地已执行 `npm install`、`npm run build:mp-weixin` 成功。

## 影响范围

- **接口**：无后端改动；客户端头字段与 RuoYi 默认 `token.header=Authorization` 对齐。
- **数据库**：无。
- **前端**：新增独立 npm 工程；根 README 文档更新。
- **兼容性**：与现有 `mp-weixin` 页面路径对齐，便于对照与逐步替换编译产物。

## 验证方式

- 已执行：`npm run build:mp-weixin`（通过）。
- 未执行：真机微信登录（依赖有效 `wechat.appId` / `appSecret` 与小程序后台配置）。
