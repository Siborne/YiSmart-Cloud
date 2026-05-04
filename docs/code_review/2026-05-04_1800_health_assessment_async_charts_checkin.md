# 变更记录：健康评估异步分析、图表美化与办理入住

## 背景/目的

- 提交 AI 分析改为**异步**：接口立即返回，后台千帆完成后更新同一条记录；用户可先处理其它事务再查看报告。
- 详情页**图表美化**（渐变堆叠柱、年龄段竖线标记、雷达渐变与分割区），并**高亮当前老人年龄段**。
- 详情页底部增加**办理入住**，跳转入住申请并预填姓名、身份证（及生日/年龄/性别解析）。

## 变更文件清单

### 后端

- [YiSmartCloudApplication.java](YiSmartCloud-background/YiSmartCloud-admin/src/main/java/org/FlyingSparrow/YiSmartCloud/YiSmartCloudApplication.java)：启用 `@EnableAsync`。
- [health_assessment_analysis_status.sql](YiSmartCloud-background/sql/nursing_project/health_assessment_analysis_status.sql)：`analysis_status`、`analysis_error` 列。
- [HealthAssessment.java](YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/domain/HealthAssessment.java)：新字段。
- [HealthAssessmentMapper.xml](YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/resources/mapper/serve/HealthAssessmentMapper.xml)：列表/映射/条件。
- 新增：`serve/constant/HealthAssessmentAnalysisStatuses.java`、`serve/event/HealthAssessmentAnalysisRequestedEvent.java`、`serve/listener/HealthAssessmentAnalysisEventListener.java`（`@TransactionalEventListener(AFTER_COMMIT)` + `@Async`）。
- [Floor.java](YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/domain/Floor.java)：注释与 `@Excel` 中文曾以错误编码保存导致 `javac` UTF-8 不可映射，已恢复为 UTF-8 中文。
- [IHealthAssessmentService](YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/IHealthAssessmentService.java) / [HealthAssessmentServiceImpl](YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/HealthAssessmentServiceImpl.java)：`submitAnalysisAsync`、`executeAnalysisById`；保留同步 `analyzeAndSave`；自定义列表 SQL 经 `getBaseMapper().selectHealthAssessmentList` 调用。
- [HealthAssessmentController.java](YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/HealthAssessmentController.java)：`POST /serve/assessment/analyze-async`。

### 前端

- [assessment.js](YiSmartCloud-front/src/api/serve/assessment.js)：`analyzeAssessmentAsync`。
- [assessment/index.vue](YiSmartCloud-front/src/views/serve/assessment/index.vue)：列表「分析状态」列；提交改调异步接口与提示文案。
- [assessment/detail.vue](YiSmartCloud-front/src/views/serve/assessment/detail.vue)：分析中轮询、失败提示、图表样式、底部「办理入住」。
- [checkIn/apply.vue](YiSmartCloud-front/src/views/serve/checkIn/apply.vue)：`fromHealth=1` 时根据 query 预填老人信息。

## 影响范围

- **数据库**：需执行 `health_assessment_analysis_status.sql`。
- **接口**：新增 `POST /serve/assessment/analyze-async`；权限与上传一致 `serve:assessment:add`。
- **线程**：依赖 `@EnableAsync` 与事务提交后事件；请保证应用进程存活至异步任务结束。

## 验证方式

- **已执行**：`mvn -pl YiSmartCloud-nursing-platform,YiSmartCloud-admin -am compile -DskipTests`（本机已通过）。
- **建议**：上传 PDF → 异步提交 → 列表显示「分析中」→ 完成后详情与图表正常；点击「办理入住」入住申请页字段预填正确。
