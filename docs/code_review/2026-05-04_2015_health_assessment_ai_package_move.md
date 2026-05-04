# 变更记录：健康评估 AI 工具类包路径调整

## 背景/目的

`HealthAssessmentAiJsonExtractor`、`HealthAssessmentAiPrompts` 为无状态的提示词与 JSON 抽取工具，放在 `serve.service` 下易与 Spring Service 混淆，迁至独立子包以体现「评估域 + AI 辅助」分层。

## 变更文件清单

- 删除：`serve/service/HealthAssessmentAiJsonExtractor.java`、`serve/service/HealthAssessmentAiPrompts.java`
- 新增：`serve/assessment/ai/HealthAssessmentAiJsonExtractor.java`、`serve/assessment/ai/HealthAssessmentAiPrompts.java`（包名 `org.FlyingSparrow.YiSmartCloud.serve.assessment.ai`）
- 修改：`serve/service/impl/HealthAssessmentServiceImpl.java`（import 指向新包）

## 影响范围

- 仅编译期包名变更，无接口与行为变化。

## 验证方式

- `mvn -pl YiSmartCloud-nursing-platform -am compile -DskipTests`（本机已通过）。
