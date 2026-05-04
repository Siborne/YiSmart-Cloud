# UniApp 全量复刻执行记录

## 变更背景/目的
- 按 `mp-weixin` 现状在 `YiSmartCloud-member-uniapp` 执行全量 1:1 复刻。
- 全量复用 `mp-weixin/static` 资源，并将 UniApp 接口路径统一对齐到后端现有 `/member/*`、`/serve/member/*` 规范。
- 对后端历史缺失路径补充兼容占位，避免旧路径调用 404。

## 变更文件清单
- `YiSmartCloud-member-uniapp/pages.json`
- `YiSmartCloud-member-uniapp/App.vue`
- `YiSmartCloud-member-uniapp/main.js`
- `YiSmartCloud-member-uniapp/static/**`（与 `mp-weixin/static/**` 全量同步）
- `YiSmartCloud-member-uniapp/utils/env.js`
- `YiSmartCloud-member-uniapp/utils/request.js`
- `YiSmartCloud-member-uniapp/utils/state.js`
- `YiSmartCloud-member-uniapp/utils/index.js`
- `YiSmartCloud-member-uniapp/api/login.js`
- `YiSmartCloud-member-uniapp/api/index.js`
- `YiSmartCloud-member-uniapp/api/appointment.js`
- `YiSmartCloud-member-uniapp/api/bill.js`
- `YiSmartCloud-member-uniapp/api/contract.js`
- `YiSmartCloud-member-uniapp/api/family.js`
- `YiSmartCloud-member-uniapp/api/order.js`
- `YiSmartCloud-member-uniapp/api/service.js`
- `YiSmartCloud-member-uniapp/components/Navbar/index.vue`
- `YiSmartCloud-member-uniapp/components/Foot/index.vue`
- `YiSmartCloud-member-uniapp/components/NetFail/index.vue`
- `YiSmartCloud-member-uniapp/components/EmptyPage/index.vue`
- `YiSmartCloud-member-uniapp/components/uni-phone/index.vue`
- `YiSmartCloud-member-uniapp/pages/**`（主包页面骨架与核心页）
- `YiSmartCloud-member-uniapp/subPages/**`（分包页面骨架）
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/mebber/MemberProgramStubController.java`

## 关键改动说明
- 路由对齐：
  - 将 `pages.json` 扩展为与 `mp-weixin/app.json` 对齐的主包+分包结构。
  - 补齐所有路由对应的 `.vue` 页面文件，确保路由不缺失。
- 静态资源对齐：
  - `YiSmartCloud-member-uniapp/static` 与 `mp-weixin/static` 文件名和数量全量一致（56 个文件）。
- 请求与接口对齐：
  - 新增 `utils/request.js`、`utils/env.js`、`api/*`，形成统一请求层。
  - 将历史错误路径在 UniApp 侧改为后端规范路径：
    - `/reservation/countByTime` -> `/member/reservation/countByTime`
    - `/bill/{id}` -> `/member/bill/{id}`
    - `/user/my` -> `/member/user/my`
    - `/user/add` -> `/member/user/add`
    - `/user/queryDeviceDataListByDay` -> `/member/user/queryDeviceDataListByDay`
- 公共组件与核心页：
  - 新增 `Navbar`、`Foot`、`NetFail`、`EmptyPage`、`uni-phone` 组件。
  - 实现首页/登录/家人/服务/我的核心页面初版逻辑，并接入 API。
- 后端兼容补口：
  - 在 `MemberProgramStubController` 补充历史路径占位映射：
    - `GET /reservation/countByTime`
    - `GET /bill/{id}`
    - `GET /user/my`
    - `POST /user/add`
    - `GET /user/queryDeviceDataListByDay`

## 影响范围
- 接口：
  - UniApp 新增一套 member 端 API 调用层；后端新增历史路径兼容映射，降低旧端调用风险。
- 数据库：
  - 本次未改动数据库结构与 SQL。
- 前端：
  - `YiSmartCloud-member-uniapp` 从初始化脚手架升级为可导航、可请求、可登录的完整业务骨架。
- 兼容性：
  - 新前端走规范路径；后端兼容历史错误路径，支持过渡期并行。

## 验证方式
- 已执行：
  - 路由完整性校验（`pages.json` 中全部路由均存在对应 `.vue` 文件，缺失数为 0）。
  - 静态资源一致性校验（`mp-weixin/static` 与 `member-uniapp/static` 文件清单一致，均为 56）。
- 未执行：
  - 微信开发者工具真机联调与完整业务冒烟（当前会话未启动构建/运行环境）。
  - 后端模块编译与接口联调回归（建议下一步执行）。
