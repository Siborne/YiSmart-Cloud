# 变更背景/目的

将微信手机号登录 demo 从主包页面调整到分包目录，避免测试页暴露在主包 `pages`，并对齐 uni-app 分包规范。

# 变更文件清单

- `YiSmartCloud-member-uniapp/pages/subPages/test/wechat-phone-demo.vue`（新增）
- `YiSmartCloud-member-uniapp/pages/test/wechat-phone-demo.vue`（删除）
- `YiSmartCloud-member-uniapp/pages.json`
- `YiSmartCloud-member-uniapp/pages/login/index.vue`

# 关键改动说明

- 将 demo 页面物理位置从 `pages/test` 移至 `pages/subPages/test`。
- `pages.json` 中移除主包页面声明 `pages/test/wechat-phone-demo`。
- 在 `subPackages`（`root: pages/subPages`）中新增分包页面 `test/wechat-phone-demo`。
- 登录页“进入微信手机号Demo”按钮跳转地址改为 `/pages/subPages/test/wechat-phone-demo`。

# 影响范围（接口、数据库、前端、兼容性）

- 前端：仅页面路由归属调整，不改变 demo 业务逻辑。
- 接口：无变更。
- 数据库：无变更。
- 兼容性：更符合 uni-app 分包组织规范，主包体积与页面暴露范围更可控。

# 验证方式（已执行/未执行及原因）

- 已执行：对变更文件做静态诊断检查，无新增告警。
- 未执行：微信开发者工具真机点击跳转与授权流程回归（当前会话未直接运行小程序）。
