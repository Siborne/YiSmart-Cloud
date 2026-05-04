# 变更记录：体检分析 NoSuchFieldError: Companion（OkHttp 版本对齐）

## 变更背景/目的

调用 `/serve/assessment/analyze` 时出现 `java.lang.NoSuchFieldError: Companion`，堆栈指向 `com.openai.client.okhttp.OkHttpClient$Builder.baseUrl`。原因为 **openai-java-client-okhttp 0.22** 的 Kotlin 实现使用 OkHttp 4 的 API（如 `HttpUrl.Companion.toHttpUrl()`、`callTimeout`），而传递依赖解析为 **OkHttp 3.14.9**，运行时二进制不兼容。无需更换模型供应商或升级 Spring Boot。

## 变更文件清单

- `YiSmartCloud-background/pom.xml`

## 关键改动说明

- 在父 POM `properties` 增加 `okhttp.version`（4.12.0）。
- 在 `dependencyManagement` 中声明 `com.squareup.okhttp3:okhttp` 与 `logging-interceptor`，统一版本，使 Maven 覆盖 openai-java 传递的 3.14.x。

## 影响范围

- **接口**：无 URL/契约变更。
- **数据库/前端**：无。
- **兼容性**：全模块 classpath 上 OkHttp 升为 4.x；与 Spring Boot 2.5 无直接冲突（若其他库强依赖 OkHttp 3 需另行验证，当前依赖树未见冲突）。

## 验证方式

- 已执行：`mvn dependency:tree -pl YiSmartCloud-common`（确认 `okhttp`、`logging-interceptor` 为 4.12.0）。
- 已执行：`mvn -pl YiSmartCloud-admin -am compile -DskipTests`，构建成功（exit 0）。
- 未执行：带真实千帆 API Key 的端到端调用（需本地配置与网络）。

**后续**：若 OkHttp 对齐后出现 `HttpMethod` 类初始化失败，需再将 Jackson/Kotlin 与 `openai-java-core` 对齐，见 `2026-05-04_1700_openai_jackson_kotlin_httpmethod_fix.md`。
