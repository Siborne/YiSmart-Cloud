# 变更背景/目的

修复家属端 token 拦截器编译失败问题：`MemberInterceptor` 误用了不存在的 `Constants.HEADER` 常量，导致无法通过编译。

# 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-framework/src/main/java/org/FlyingSparrow/YiSmartCloud/framework/interceptor/MemberInterceptor.java`

# 关键改动说明

1. 将 `request.getHeader(Constants.HEADER)` 替换为 `request.getHeader("Authorization")`。
2. 与已有 `request.getHeader("authorization")` 形成大小写兼容，避免不同客户端头名称导致取值失败。

# 影响范围（接口、数据库、前端、兼容性）

- 接口：仅影响家属端 token 拦截器读取请求头逻辑。
- 数据库：无影响。
- 前端：无须改动，现有小程序发送 `authorization` 仍可用。
- 兼容性：增强兼容性（同时支持 `authorization` / `Authorization`）。

# 验证方式（已执行/未执行及原因）

- 已执行：静态检查，确认仓库内无 `Constants.HEADER` 其他引用。
- 未执行：完整 Maven 编译与端到端接口联调（本次会话未启动项目）。
