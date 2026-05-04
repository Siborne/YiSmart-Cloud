# 变更背景/目的

针对家属端 token 校验逻辑中出现的硬编码字符串（请求头名、claim key），统一抽取到全局常量，提升可维护性并降低后续改动风险。

# 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-common/src/main/java/org/FlyingSparrow/YiSmartCloud/common/constant/Constants.java`
- `YiSmartCloud-background/YiSmartCloud-framework/src/main/java/org/FlyingSparrow/YiSmartCloud/framework/interceptor/MemberInterceptor.java`
- `YiSmartCloud-background/YiSmartCloud-framework/src/main/java/org/FlyingSparrow/YiSmartCloud/framework/web/service/TokenService.java`

# 关键改动说明

1. 在 `Constants` 中新增：
   - `AUTHORIZATION = "Authorization"`
   - `AUTHORIZATION_LOWER = "authorization"`
   - `JWT_MEMBER_USER_ID = "userId"`
2. `MemberInterceptor` 改为使用上述常量读取请求头，并读取 `userId` claim。
3. `TokenService` 签发 token 时，`userId` claim key 改为常量引用，避免字面量重复。

# 影响范围（接口、数据库、前端、兼容性）

- 接口：无协议变更，仍兼容 `authorization` 与 `Authorization`。
- 数据库：无影响。
- 前端：无须改动。
- 兼容性：保持不变，仅代码层面去硬编码。

# 验证方式（已执行/未执行及原因）

- 已执行：静态检查，确认改动点均使用常量。
- 未执行：完整工程编译与联调（本次会话未启动服务）。
