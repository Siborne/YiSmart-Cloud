# 变更背景/目的

为家属端（小程序）接口补充基于 ThreadLocal 的用户身份透传能力：在请求进入 `member` 相关业务接口时校验 token，并将当前用户 `userId` 写入线程上下文，便于后续业务直接读取。

# 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-common/src/main/java/org/FlyingSparrow/YiSmartCloud/common/utils/UserThreadLocal.java`
- `YiSmartCloud-background/YiSmartCloud-framework/src/main/java/org/FlyingSparrow/YiSmartCloud/framework/interceptor/MemberInterceptor.java`
- `YiSmartCloud-background/YiSmartCloud-framework/src/main/java/org/FlyingSparrow/YiSmartCloud/framework/config/ResourcesConfig.java`
- `YiSmartCloud-background/YiSmartCloud-framework/src/main/java/org/FlyingSparrow/YiSmartCloud/framework/web/service/TokenService.java`

# 关键改动说明

1. 新增 `UserThreadLocal` 工具类，提供 `set/getUserId/remove`，用于线程级保存家属端登录用户 ID。
2. 新增 `MemberInterceptor`：
   - 拦截 `HandlerMethod` 请求；
   - 从请求头读取 token，先尝试解析 claim 中的 `userId`；
   - 若 claim 不存在（兼容旧 token），回退到 `TokenService.getLoginUser`（Redis）获取用户信息；
   - 校验失败抛出 `BaseException("认证失败")`；
   - 请求完成后统一 `remove` 清理 ThreadLocal，避免线程复用污染。
3. 调整 `ResourcesConfig`：
   - 注册 `MemberInterceptor`；
   - 作用路径为 `/member/**`、`/serve/member/**`；
   - 放行登录/注册及房型公开接口路径。
4. 调整 `TokenService`：
   - `parseToken` 由 `private` 调整为 `public`，供拦截器复用；
   - 新签发 token 时补充 `userId` claim（兼容逻辑已覆盖旧 token）。

# 影响范围（接口、数据库、前端、兼容性）

- 接口：
  - 新增拦截链路影响 `member` 相关接口（不含已放行路径）。
  - 登录/注册与房型公开查询接口维持匿名可访问。
- 数据库：无变更。
- 前端：无需改动，仍按现有 `authorization` 请求头传 token。
- 兼容性：
  - 旧 token 若没有 `userId` claim，会自动回退 Redis 解析；
  - 新 token 同时具备 claim 与 Redis 两种读取路径。

# 验证方式（已执行/未执行及原因）

- 已执行：静态代码检查（人工检查拦截路径、放行路径、ThreadLocal 生命周期、token 兼容分支）。
- 未执行：本地端到端接口联调与启动验证（当前会话未启动后端服务与小程序）。建议在登录后请求任一受保护 `member` 接口，确认可在业务中读取 `UserThreadLocal.getUserId()`。
