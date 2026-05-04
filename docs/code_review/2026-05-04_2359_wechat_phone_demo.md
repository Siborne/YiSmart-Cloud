# 变更背景/目的

补充一个可直接验证“微信登录 + 获取手机号”的前端 demo 页面，便于联调和排查小程序登录链路。

# 变更文件清单

- `YiSmartCloud-member-uniapp/pages/test/wechat-phone-demo.vue`
- `YiSmartCloud-member-uniapp/pages.json`

# 关键改动说明

- 新增测试页面 `pages/test/wechat-phone-demo`：
  - 使用 `open-type="getPhoneNumber"` 获取手机号凭证 `phoneCode`。
  - 在授权成功后调用 `uni.login` 获取微信登录凭证 `jsCode`。
  - 调用现有后端接口 `POST /serve/member/user/login`，请求参数为 `code + phoneCode + nickName`。
  - 将 `phoneCode`、`jsCode` 和接口返回结果在页面展示，便于肉眼核对。
- 在 `pages.json` 注册 demo 页面路由，可直接跳转测试。

# 影响范围（接口、数据库、前端、兼容性）

- 前端：新增一个测试页面，不影响现有业务页面逻辑。
- 接口：复用现有登录接口，无协议变更。
- 数据库：无变更。
- 兼容性：该 demo 仅在微信小程序环境下可完整验证。

# 验证方式（已执行/未执行及原因）

- 已执行：代码静态检查（`ReadLints`）针对新增/修改文件检查无新增告警。
- 未执行：微信开发者工具/真机实际授权验证（当前会话未接入运行环境）。
