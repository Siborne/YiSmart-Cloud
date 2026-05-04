# 小程序登录失败兜底：前后端联动实现

## 变更背景/目的
- 用户反馈 UniApp 端微信手机号授权弹窗不可用，导致登录流程被阻断。
- 目标是在保留微信授权登录的前提下，提供可联调的“开发兜底登录”能力。

## 变更文件清单
- `YiSmartCloud-member-uniapp/pages/login/index.vue`
- `YiSmartCloud-member-uniapp/api/login.js`
- `YiSmartCloud-member-uniapp/utils/env.js`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/dto/DevLoginRequestDto.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/IFamilyMemberService.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/FamilyMemberServiceImpl.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/mebber/FamilyMemberController.java`
- `YiSmartCloud-background/YiSmartCloud-framework/src/main/java/org/FlyingSparrow/YiSmartCloud/framework/config/SecurityConfig.java`

## 关键改动说明
- 前端：
  - 登录页新增“开发调试登录”入口（手机号 + 按钮），微信授权失败时可直接走兜底登录。
  - 新增 API：`POST /serve/member/user/dev-login`。
  - `notToLoginApiUrl` 增加 `dev-login`，避免 401 时重复跳转干扰。
- 后端：
  - 新增 DTO：`DevLoginRequestDto`（`phone`、`nickName`）。
  - `IFamilyMemberService` 新增 `devLogin`。
  - `FamilyMemberServiceImpl` 实现 `devLogin`：
    - 校验手机号格式（`^1\\d{10}$`）
    - 依据手机号 upsert `FamilyMember`（无记录则创建并生成 `dev_openid_xxx`）
    - 复用统一 JWT 发放逻辑返回 `LoginVo`
  - `FamilyMemberController` 新增 `/dev-login` 接口，默认通过配置 `wechat.dev-login-enabled` 控制开关（默认 true）。
  - `SecurityConfig` 放行 `/serve/member/user/dev-login`。

## 影响范围
- 前端登录流程：微信授权不可用时可继续联调，不再被单点阻断。
- 后端鉴权：新增开发登录接口匿名放行。
- 生产风险控制：可通过 `wechat.dev-login-enabled` 关闭开发登录入口。

## 验证方式
- 已执行：
  - lints 检查通过（前后端改动文件无新增报错）。
- 未执行：
  - 本地启动后端后在小程序端实测两条链路：
    - 微信快速登录（授权成功）
    - 开发调试登录（手机号兜底）
