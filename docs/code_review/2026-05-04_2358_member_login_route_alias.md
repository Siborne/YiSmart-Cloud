# 变更背景/目的

微信小程序请求日志显示使用了 `POST /member/user/login` 与 `GET /member/roomTypes?status=1`。后端已存在房型接口，但登录接口仅暴露在 `/serve/member/user/login`，导致路径不一致时无法命中业务控制器。  
本次变更为家属端登录接口补充无 `serve` 前缀的兼容路由，并同步放开 Spring Security 匿名访问策略。

# 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/mebber/FamilyMemberController.java`
- `YiSmartCloud-background/YiSmartCloud-framework/src/main/java/org/FlyingSparrow/YiSmartCloud/framework/config/SecurityConfig.java`
- `docs/code_review/2026-05-04_2358_member_login_route_alias.md`

# 关键改动说明

1. `FamilyMemberController` 类级 `@RequestMapping` 从单一路径改为数组，新增 `/member/user` 兼容前缀：
   - 原：`/serve/member/user`
   - 新：`/serve/member/user`、`/member/user`
2. `SecurityConfig` 中匿名放行规则新增以下路径，避免被鉴权拦截：
   - `POST /member/user/login`
   - `POST /member/user/dev-login`
   - 同时保留原 `/serve/member/user/*` 放行配置
3. 保持现有 `GET /member/roomTypes` 匿名访问策略不变，该接口后端已存在。

# 影响范围（接口、数据库、前端、兼容性）

- 接口影响：新增登录路由别名（兼容访问），不改变原接口行为和返回结构。
- 数据库影响：无。
- 前端影响：现有使用 `/serve/member/user/login` 的调用不受影响；误用 `/member/user/login` 也可正常访问。
- 兼容性：向后兼容，属于路由增强。

# 验证方式（已执行/未执行及原因）

- 已执行：代码级检查，确认控制器路由与安全放行一致。
- 未执行：未在当前会话启动后端进行联调验证（需依赖本地运行环境、网关与服务实例状态）。
