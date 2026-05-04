# 变更背景/目的

按要求清理家属端“测试/调试登录”相关代码，仅保留基础手机号登录与注册能力，并统一本次改动文件编码为 UTF-8。

# 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/dto/MemberAuthRequestDto.java`（新增）
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/dto/DevLoginRequestDto.java`（删除）
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/mebber/FamilyMemberController.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/IFamilyMemberService.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/FamilyMemberServiceImpl.java`
- `YiSmartCloud-background/YiSmartCloud-framework/src/main/java/org/FlyingSparrow/YiSmartCloud/framework/config/SecurityConfig.java`
- `YiSmartCloud-member-uniapp/api/login.js`
- `YiSmartCloud-member-uniapp/utils/env.js`

# 关键改动说明

- 删除后端 `dev-login` 调试接口及其服务实现，移除相关安全放行配置。
- 将基础登录/注册入参 DTO 从 `DevLoginRequestDto` 替换为更通用的 `MemberAuthRequestDto`。
- 删除前端 `devLogin` API 与白名单项，避免继续保留测试登录路径。
- 复核工程后确认不再存在 `dev-login`、`DevLoginRequestDto`、`wechat-phone-demo` 等测试代码引用。

# 影响范围（接口、数据库、前端、兼容性）

- 前端：不再提供调试登录 API，仅基础登录/注册。
- 后端：`/serve/member/user/dev-login` 与 `/member/user/dev-login` 相关逻辑移除。
- 数据库：无变更。
- 兼容性：如果仍有外部调用 `dev-login`，需同步改为基础登录/注册接口。

# 验证方式（已执行/未执行及原因）

- 已执行：静态诊断检查（ReadLints）无新增问题。
- 已执行：关键字扫描确认测试入口已清理（`dev-login` / `wechat-phone-demo` 无代码引用）。
- 已执行：UTF-8 转码脚本针对本次改动文件运行完成。
