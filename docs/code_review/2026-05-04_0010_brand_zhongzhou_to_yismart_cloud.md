# 变更记录：品牌文案「中州养老」→「颐智云」/ YiSmartCloud

## 变更背景/目的

全仓库扫描含「中州养老」的展示文案与工程标识，统一为项目品牌「颐智云」（用户可见中文）及英文标识 **YiSmartCloud**（与仓库/模块命名一致；用户消息中的 YiSmartCould 视为笔误）。

## 变更文件清单

- `mp-weixin/app.json`
- `mp-weixin/pages/index/index.json`
- `mp-weixin/pages/index/index.js`
- `mp-weixin/pages/login/index.wxml`
- `mp-weixin/subPages/introduce/index.wxml`
- `mp-weixin/subPages/order/details.wxml`
- `mp-weixin/common/vendor.js`（默认导航标题、`appName` 元数据）
- `mp-weixin/project.private.config.json`（`projectname`）

## 关键改动说明

| 原内容 | 新内容 |
|--------|--------|
| 全局默认 `navigationBarTitleText`、首页分享 `title` 等「中州养老」 | 「颐智云」 |
| 登录弹窗：会员注册、服务条款、隐私政策中的「中州养老」 | 「颐智云」（如《颐智云服务条款》《颐智云隐私政策》、颐智云会员） |
| 订单详情：「中州养老机构将竭诚为您服务」 | 「颐智云将竭诚为您服务」 |
| `vendor.js` 内 `appName: "zhyl-xcx"` | `appName: "YiSmartCloud"` |
| `project.private.config.json` 的 `projectname` | `YiSmartCloud-mp-weixin` |

## 未改动项（说明）

- 大量 `.js` 内 `__file` 指向旧本机路径 `.../project-zhyl-xcx-uniapp-java...`：为 uni-app 编译器注入的调试元数据，非用户可见；若需清除需在 **uni-app 源码工程** 重新发行到 `mp-weixin`，本仓库未包含该源码。
- `YiSmartCloud-background`、`YiSmartCloud-front`、`README.md` 等经检索 **无**「中州」字样。

## 影响范围

- 微信小程序端展示与 uni 运行时上报的 `appName` 字符串；**不涉及**后端接口路径或数据库。
- 若服务端或统计系统曾依赖 `appName === "zhyl-xcx"`，需同步调整（当前未发现引用）。

## 验证方式

- 已用全文检索确认仓库内无「中州」残留。
- 未在微信开发者工具内实机预览（原因：本地环境未作为必跑项）。
