# 变更背景/目的

微信小程序登录页在点击“微信快速登录”后无明显反馈，用户侧表现为“按钮无反应”。排查发现 `getPhoneNumber` 回调在未拿到 `detail.code` 时存在静默返回，导致页面没有提示信息。

# 变更文件清单

- `mp-weixin/pages/login/index.js`
- `mp-weixin/app.json`
- `mp-weixin/index2.js`
- `mp-weixin/components/Navbar/index.js`
- `mp-weixin/pages/index/index.js`
- `mp-weixin/utils/request.js`

# 关键改动说明

- 调整手机号授权结果判断：由严格匹配 `getPhoneNumber:ok` 改为包含 `ok` 的兼容判断，降低回调文案细微变化导致的误判风险。
- 拆分错误分支：
  - 非 `ok` 场景下，保留拒绝授权提示，并补充通用失败提示。
  - `ok` 但缺少 `phoneCode` 场景下新增明确提示“未获取到手机号凭证，请在真机重试”，避免静默返回。
- 回滚此前误加的小程序配置 `requiredPrivateInfos: ["getPhoneNumber"]`。该字段不接受 `getPhoneNumber`，会导致模拟器报 `app.json requiredPrivateInfos` 配置错误并启动失败。
- 修复 `components/uni-phone/index` 组件事件绑定异常：原编译产物将 `uni-popup` 的 `change` 事件绑定到不存在的 `_ctx.change`，运行时报 `does not have a method "e2"`；改为本地空处理函数，消除运行时异常。
- 修复返回按钮在首屏时的异常：`navigateBack` 在第一页会失败，现增加 `fail` 兜底为 `switchTab('/pages/index/index')`，避免抛出 `cannot navigate back at first page`。
- 修复首页接口超时未捕获：`getHotList` 增加 `try/catch`，请求超时时给出可见提示，不再向上抛出未捕获 `timeout`。
- 优化请求失败文案提取：网络失败时优先使用 `err.errMsg`，避免返回空消息。

# 影响范围（接口、数据库、前端、兼容性）

- 前端（微信小程序）登录交互提示增强。
- 不涉及后端接口协议变更。
- 不涉及数据库变更。
- 兼容性影响低，仅优化错误反馈逻辑。

# 验证方式（已执行/未执行及原因）

- 已执行：静态代码检查（`ReadLints`）通过，无新增告警。
- 未执行：真机登录流程回归（当前会话未连接微信开发者工具真机调试环境）。
