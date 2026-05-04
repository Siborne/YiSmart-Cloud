# 健康评估文档上传接口修复

## 变更背景/目的

`HealthAssessmentController.uploadFile` 存在编译错误与运行时问题：误调用不存在的 `AliyunOSSOperator.store`、字段名拼写错误、重复读取 `MultipartFile` 输入流导致 PDF 解析失败；与项目内 `CommonController` 已采用的 OSS `upload(byte[], String)` 不一致。

## 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/HealthAssessmentController.java`

## 关键改动说明

- 使用 `file.getBytes()` 单次读取，供 OSS 上传与 PDF 文本提取复用。
- 调用 `aliyunOSSOperator.upload(bytes, originalFilename)`，与 `AliyunOSSOperator` 实际 API 对齐。
- 基本参数校验（空文件、身份证号、原始文件名）；`newFileName` 与 `CommonController` 一致从返回 URL 截取。
- 仅当扩展名为 `.pdf`（忽略大小写）时解析并写入 Redis；解析结果非空才 `put`，避免 `null` 入 Redis。
- 补充 `@PreAuthorize("serve:assessment:add")` 与同模块其它写接口一致。

## 影响范围

- **接口**：`POST /serve/assessment/upload` 行为与返回字段保持一致；非 PDF 仍上传 OSS，但不再尝试 PDF 解析与写 Redis。
- **权限**：上传需具备 `serve:assessment:add`（与新增健康评估同权）；若前端仅开放编辑权限需单独配置按钮权限或改为 `edit`。
- **数据库**：无。
- **兼容性**：前端需传有效 `idCardNo`；OSS 环境变量与凭证要求与通用上传一致。

## 验证方式

- 已执行：在 `YiSmartCloud-background` 下执行 `mvn -pl YiSmartCloud-nursing-platform -am compile -DskipTests`，**通过**（exit code 0）。
- 未执行：联调 OSS、Redis 与实际上传；需在目标环境配置 OSS 与 Redis 后手工验证。
