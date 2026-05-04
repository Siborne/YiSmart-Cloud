# 变更记录：微信小程序家属登录

## 变更背景 / 目的

为护理平台增加微信小程序端家属登录：使用 `wx.login` 的 `code` 换 `openid`，使用 `getPhoneNumber` 的 `code` 换手机号，写入或更新 `family_member`，并通过既有 `TokenService` 签发与后台管理端一致的 JWT，供小程序在请求头 `Authorization: Bearer <token>` 中使用。

## 变更文件清单

| 路径 | 说明 |
|------|------|
| `YiSmartCloud-nursing-platform/.../serve/controller/mebber/FamilyMemberController.java` | 仅保留 `POST /serve/member/user/login` |
| `YiSmartCloud-nursing-platform/.../serve/service/IFamilyMemberService.java` | 仅声明 `login`（仍继承 `IService<FamilyMember>`） |
| `YiSmartCloud-nursing-platform/.../serve/service/impl/FamilyMemberServiceImpl.java` | 登录编排：微信 API、落库、`TokenService.createToken` |
| `YiSmartCloud-nursing-platform/.../serve/service/WechatService.java` | 微信 HTTP 封装接口 |
| `YiSmartCloud-nursing-platform/.../serve/service/impl/WechatServiceImpl.java` | `jscode2session` / `access_token` / `getuserphonenumber`（RestTemplate + Fastjson2） |
| `YiSmartCloud-nursing-platform/.../serve/dto/UserLoginRequestDto.java` | 入参 DTO |
| `YiSmartCloud-nursing-platform/.../serve/vo/LoginVo.java` | 出参 VO |
| `YiSmartCloud-nursing-platform/pom.xml` | 增加对 `YiSmartCloud-framework` 的依赖以使用 `TokenService` |
| `YiSmartCloud-framework/.../SecurityConfig.java` | 匿名放行 `/serve/member/user/login` |
| `YiSmartCloud-admin/.../application.yml` | 增加 `wechat.appId` / `wechat.appSecret`（密钥走环境变量） |
| `YiSmartCloud-admin/.../application-example.yml` | 示例中的 `wechat` 配置 |
| `YiSmartCloud-nursing-platform/.../assessment/ai/HealthAssessmentAiJsonExtractor.java` | 类注释改为英文 UTF-8，消除非 UTF-8 源文件 |
| `YiSmartCloud-nursing-platform/.../assessment/ai/HealthAssessmentAiPrompts.java` | 中文提示改为 `\u` 转义，保证 UTF-8 编译 |

## 关键改动说明

- **包名**：与仓库一致使用 `org.FlyingSparrow.YiSmartCloud.serve.*`，未使用示例中的 `com.zzyl.nursing`。
- **接口路径**：`POST /serve/member/user/login`（若依网关/前端常用 `swagger.pathMapping` 前缀如 `/dev-api`，则完整路径为 `/dev-api/serve/member/user/login`，以前端为准）。
- **密钥**：`application.yml` 中 `appSecret` 使用 `${WECHAT_APP_SECRET:}`，避免将生产密钥写入仓库；本地可将密钥设为环境变量 `WECHAT_APP_SECRET`，或在未入库的 profile 中覆盖。
- **JWT 主体**：为兼容现有 `JwtAuthenticationTokenFilter`，构造 `LoginUser` 时挂载合成 `SysUser`（`userName` 形如 `wx_member_{id}`），权限集合为空；仅依赖 `@PreAuthorize` 的接口对小程序用户会拒绝，需后续为 C 端单独配置匿名或权限策略。

## 影响范围

- **接口**：原 `FamilyMemberController` CRUD 已移除，仅保留登录；若菜单/前端仍指向旧路径需同步调整。
- **数据库**：依赖已有 `family_member` 表及 `open_id`、手机号等字段。
- **配置**：需配置 `wechat.appId` 与有效 `appSecret`（或环境变量）。
- **兼容性**：与若依 JWT + Redis 会话机制一致；小程序需携带与 PC 端相同的 `Authorization` 头格式。

## 验证方式

- 已执行：`mvn -pl YiSmartCloud-common compile` 通过。
- **未通过**：`mvn -pl YiSmartCloud-nursing-platform clean compile` 仍因仓库内其他源文件非 UTF-8（如 `serve/vo/dashboard/*.java` 等）及既有引用问题报错；本次改动相关类已使用 UTF-8 安全写法。建议在 IDE 将全模块源文件统一为 UTF-8 后全量编译，并对登录接口做联调（需真实 Redis、微信 code）。
