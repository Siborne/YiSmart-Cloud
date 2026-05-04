# 代码变更记录：健康评估上传、千帆解析与详情大屏

## 变更背景/目的

按产品流程实现：列表页以上传体检报告为主入口；PDF 上传 OSS 后正文入 Redis；确认提交时调用百度千帆解析 JSON 并落库；详情页展示 AI 总结、示意年龄堆叠图、系统雷达图与异常项表格。

## 变更文件清单

### 后端

- [YiSmartCloud-background/sql/nursing_project/health_assessment_ai_json.sql](YiSmartCloud-background/sql/nursing_project/health_assessment_ai_json.sql) — 新增 `ai_result_json` 列
- [YiSmartCloud-background/sql/nursing_project/health_assessment_menu.sql](YiSmartCloud-background/sql/nursing_project/health_assessment_menu.sql) — 健康评估菜单与按钮权限（可选执行）
- [YiSmartCloud-background/YiSmartCloud-admin/src/main/resources/application-example.yml](YiSmartCloud-background/YiSmartCloud-admin/src/main/resources/application-example.yml) — `yi.qianfan` 占位配置；multipart 上限调至 70MB/75MB
- [YiSmartCloud-background/YiSmartCloud-admin/src/test/java/.../QianfanChatIntegrationTest.java](YiSmartCloud-background/YiSmartCloud-admin/src/test/java/org/FlyingSparrow/YiSmartCloud/ai/QianfanChatIntegrationTest.java) — 移除硬编码密钥，改为占位符
- [YiSmartCloud-background/YiSmartCloud-nursing-platform/.../HealthAssessment.java](YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/domain/HealthAssessment.java) — `aiResultJson` 字段
- [YiSmartCloud-background/YiSmartCloud-nursing-platform/.../HealthAssessmentController.java](YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/HealthAssessmentController.java) — `POST /analyze`；上传校验 PDF/60MB；PDF 必须抽出文本才写 Redis
- [YiSmartCloud-background/YiSmartCloud-nursing-platform/.../IHealthAssessmentService.java](YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/IHealthAssessmentService.java) — `analyzeAndSave`
- [YiSmartCloud-background/YiSmartCloud-nursing-platform/.../HealthAssessmentServiceImpl.java](YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/HealthAssessmentServiceImpl.java) — 千帆调用、JSON 映射、身份证解析、入库与 Redis 清理
- 新增：`serve/config/QianfanProperties.java`、`serve/dto/HealthAssessmentAnalyzeRequest.java`、`serve/dto/ai/HealthAssessmentAiResult.java`、`serve/util/IdCardParseUtil.java`、`serve/service/HealthAssessmentAiPrompts.java`、`serve/service/HealthAssessmentAiJsonExtractor.java`
- [HealthAssessmentMapper.xml](YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/resources/mapper/serve/HealthAssessmentMapper.xml) — `ai_result_json` 映射与 insert/update；列表 `selectHealthAssessmentVo` 仍不含大字段

### 前端

- [YiSmartCloud-front/src/utils/request.js](YiSmartCloud-front/src/utils/request.js) — `FormData` 请求删除默认 `Content-Type` 以便 multipart 边界正确
- [YiSmartCloud-front/src/api/serve/assessment.js](YiSmartCloud-front/src/api/serve/assessment.js) — `uploadAssessmentReport`、`analyzeAssessment`（180s 超时）
- [YiSmartCloud-front/src/views/serve/assessment/index.vue](YiSmartCloud-front/src/views/serve/assessment/index.vue) — 图2 列表 + 上传弹窗 + 选文件即上传 + 确定分析
- [YiSmartCloud-front/src/views/serve/assessment/detail.vue](YiSmartCloud-front/src/views/serve/assessment/detail.vue) — 图4 详情：基本信息、总结、ECharts 年龄示意堆叠 + 雷达、异常表
- [YiSmartCloud-front/src/router/index.js](YiSmartCloud-front/src/router/index.js) — 隐藏路由 `/serve/assessment-view/index/:id`

## 关键改动说明

- 分析接口权限与上传一致使用 `serve:assessment:add`，并加 `@RepeatSubmit`。
- 建议入住与护理等级由服务层按风险等级与健康指数规则推导（JSON 未包含该字段）。
- 详情页左侧年龄组图表为前端静态示意数据；雷达与异常表来自 AI 结果（`ai_result_json` 或拆解字段）。

## 影响范围

- **数据库**：需执行 `health_assessment_ai_json.sql`；可选执行菜单 SQL。
- **配置**：本地需在 profile 中配置 `yi.qianfan.api-key`、`yi.qianfan.model`，并保证 `spring.servlet.multipart` 能容纳 60MB 级 PDF。
- **接口**：新增 `POST /serve/assessment/analyze`。
- **前端**：健康评估列表交互变更；新增详情路由（`activeMenu` 默认 `/assessment`，与 `health_assessment_menu.sql` 中单段 path 一致；若实际菜单 path 不同需自行对齐）。

## 验证方式

- **已执行**：`mvn -pl YiSmartCloud-nursing-platform,YiSmartCloud-admin -am compile -DskipTests`（通过）。
- **未执行**：端到端联调（需有效千帆 Key、OSS、Redis、MySQL）；`npm run build:prod` 在本地耗时较长，未等待完成；建议在 CI 或本地完整跑一次前端构建与接口冒烟。
