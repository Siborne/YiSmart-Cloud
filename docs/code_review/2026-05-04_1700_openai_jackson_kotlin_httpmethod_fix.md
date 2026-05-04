# 变更记录：体检分析 NoClassDefFoundError（HttpMethod 类初始化）— Jackson/Kotlin 与 openai-java 对齐

## 变更背景/目的

在已修复 OkHttp 4 之后，调用 `/serve/assessment/analyze` 仍出现 `java.lang.NoClassDefFoundError: Could not initialize class com.openai.core.http.HttpMethod`。根因是 **运行时 Kotlin 标准库与 openai-java-core 0.22 编译所用版本不一致**：`openai-java-core` 官方 POM 声明 **kotlin-stdlib 1.9.23**、**Jackson 2.18.1**，而工程此前将 Jackson 固定在 **2.15.4**，`jackson-module-kotlin` 连带解析出 **Kotlin 1.5.32**（且被 Spring Boot 2.5 BOM 进一步固化），与 SDK 字节码不兼容，导致 Kotlin 相关类初始化失败。

## 变更文件清单

- `YiSmartCloud-background/pom.xml`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/dto/HealthAssessmentAnalyzeRequest.java`（按 UTF-8 重写，消除编译期 unmappable character 警告）

## 关键改动说明

- 将 `jackson-bom.version` 从 **2.15.4** 提升至 **2.18.1**，与 `openai-java-core` 0.22 一致。
- 新增属性 `kotlin.version` = **1.9.23**。
- 在 `dependencyManagement` 中显式声明 `kotlin-stdlib`、`kotlin-stdlib-common`、`kotlin-stdlib-jdk7/jdk8`、`kotlin-reflect`，避免 Spring Boot BOM 将 Kotlin 压在 1.5.x。
- 移除仅通过 `kotlin-bom` import 的方式（实测未能覆盖 Boot 管理的 Kotlin 版本）。

## 影响范围

- **全模块** Jackson 与 Kotlin 传递版本统一为上述版本；与 Spring Boot 2.5 / Spring Framework 5.3 组合在常见场景下可用，若个别模块强依赖旧 Jackson 行为需回归关注。
- 接口、数据库、前端无直接契约变更。

## 验证方式

- 已执行：`mvn dependency:tree -pl YiSmartCloud-admin`（确认 `kotlin-*` 为 1.9.23、`jackson-*` 为 2.18.1）。
- 已执行：`mvn -pl YiSmartCloud-admin -am clean compile -DskipTests`，全模块构建成功。
- 未执行：带真实千帆 Key 的 HTTP 端到端（依赖本地配置）。
