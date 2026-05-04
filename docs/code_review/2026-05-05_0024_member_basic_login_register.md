# 变更背景/目的

根据需求将家属端登录改为最基础的手机号登录/注册流程，不再依赖微信手机号授权链路进行主流程登录。

# 变更文件清单

- `YiSmartCloud-member-uniapp/pages/login/index.vue`
- `YiSmartCloud-member-uniapp/api/login.js`
- `YiSmartCloud-member-uniapp/utils/env.js`
- `YiSmartCloud-member-uniapp/pages.json`
- `YiSmartCloud-member-uniapp/pages/subPages/test/wechat-phone-demo.vue`（删除）
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/mebber/FamilyMemberController.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/IFamilyMemberService.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/FamilyMemberServiceImpl.java`
- `YiSmartCloud-background/YiSmartCloud-framework/src/main/java/org/FlyingSparrow/YiSmartCloud/framework/config/SecurityConfig.java`

# 关键改动说明

- 前端登录页移除微信授权入口与测试入口，改为：
  - 手机号输入
  - 可选昵称输入（注册时使用）
  - “登录”按钮（调用基础登录）
  - “注册并登录”按钮（调用注册接口并直接拿 token）
- 新增前端 API：
  - `POST /serve/member/user/basic-login`
  - `POST /serve/member/user/register`
- 后端新增基础接口：
  - `basic-login`：仅手机号登录，账号不存在时提示先注册。
  - `register`：手机号注册，已注册时提示直接登录。
- `SecurityConfig` 放行上述新接口（`/serve/member/user/*` 与 `/member/user/*` 双路径）。
- 删除微信手机号 demo 页面与对应分包路由，避免继续暴露微信调试页面。

# 影响范围（接口、数据库、前端、兼容性）

- 前端：登录主流程切到手机号登录/注册。
- 后端：新增两个会员端匿名接口。
- 数据库：未新增字段或表，复用 `family_member`。
- 兼容性：保留原 `login` / `dev-login` 接口，不影响已有联调入口。

# 验证方式（已执行/未执行及原因）

- 已执行：对本次改动文件执行静态诊断检查，无新增 lint 报错。
- 未执行：后端启动与联调请求（当前会话未执行完整启动与接口回归）。
