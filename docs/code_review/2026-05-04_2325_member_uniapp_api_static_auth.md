# 变更记录：member-uniapp 接口修正、静态资源迁移、登录跳转

## 变更背景 / 目的

用户反馈 UniApp 端“接口是错的”，并要求复用 `mp-weixin/static` 资源，同时实现未登录自动跳转登录页。

## 变更文件清单

- 接口修正：
  - `YiSmartCloud-member-uniapp/src/api/appointment.js`
  - `YiSmartCloud-member-uniapp/src/api/bill.js`
  - `YiSmartCloud-member-uniapp/src/api/family.js`
- 登录跳转能力：
  - `YiSmartCloud-member-uniapp/src/utils/auth.js`（新增）
  - `YiSmartCloud-member-uniapp/src/pages/login/index.vue`
  - `YiSmartCloud-member-uniapp/src/components/Foot/FootTab.vue`
  - `YiSmartCloud-member-uniapp/src/pages/family/index.vue`
  - `YiSmartCloud-member-uniapp/src/pages/family/binding.vue`
  - `YiSmartCloud-member-uniapp/src/pages/service/index.vue`
  - `YiSmartCloud-member-uniapp/src/pages/service/details.vue`
  - `YiSmartCloud-member-uniapp/src/pages/my/index.vue`
  - `YiSmartCloud-member-uniapp/src/subPages/appointment/list/index.vue`
  - `YiSmartCloud-member-uniapp/src/subPages/bill/index.vue`
  - `YiSmartCloud-member-uniapp/src/subPages/contract/index.vue`
  - `YiSmartCloud-member-uniapp/src/subPages/order/index.vue`
  - `YiSmartCloud-member-uniapp/src/subPages/order/details.vue`
  - `YiSmartCloud-member-uniapp/src/subPages/order/cancel.vue`
  - `YiSmartCloud-member-uniapp/src/subPages/pay/index.vue`
- 静态资源迁移：
  - `YiSmartCloud-member-uniapp/scripts/sync-static.mjs`（新增）
  - `YiSmartCloud-member-uniapp/package.json`（新增 `sync-static` 脚本）
  - 同步产物：`YiSmartCloud-member-uniapp/src/static/*`
- 文档更新：
  - `YiSmartCloud-member-uniapp/README.md`

## 关键改动说明

1. **接口修正（对齐当前后端控制器与占位兼容接口）**
   - `getAllList`：`/reservation/countByTime` -> `/member/reservation/countByTime`
   - `getBillDetail`：`/bill/{id}` -> `/member/bill/{id}`
   - 家属相关接口统一改为 `/member/user/*`，替换历史 `/user/*` 路径。

2. **未登录自动跳转登录页**
   - 新增 `requireLogin(backRoute)`：未登录时 `reLaunch('/pages/login/index')`，并缓存目标页。
   - 登录成功后读取缓存目标并回跳。
   - 对关键业务页（服务/亲友/我的、预约/账单/合同/订单/支付等）增加进入时登录校验。

3. **迁移并利用旧小程序静态资源**
   - 新增 `npm run sync-static`：将 `mp-weixin/static` 同步到 `src/static`。
   - 底部导航 `FootTab` 改为使用同步后的图标：`home/homeHover`、`serve/serveHover`、`family/familyHover`、`my/myHover`。

## 影响范围

- 前端 UniApp 会员端接口调用路径与鉴权体验。
- 不涉及后端代码或数据库结构变更。

## 验证方式

- 已执行：`npm run sync-static`（同步 56 个静态资源条目）。
- 已执行：`npm run ensure-utf8`（转换并统一编码）。
- 已执行：`npm run build:mp-weixin`（编译通过）。
