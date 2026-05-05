# 变更记录：消除家属端护理项目路由重复映射

## 背景 / 目的

启动失败：`IllegalStateException: Ambiguous mapping`，`GET /member/orders/project/page`（及同前缀详情）同时注册在 `MemberProgramStubController` 与已有 `MemberNursingProjectController` 上。

## 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/mebber/MemberProgramStubController.java`

## 关键改动说明

- 从 Stub 中删除 `projectPage`、`projectDetail` 及 `validateProject`，并移除不再使用的 `INursingProjectService` 与相关 import。
- 护理项目只读接口统一由 `MemberNursingProjectController`（`@RequestMapping("/member/orders/project")` + `/page`、`/{id}`）提供。

## 影响范围

- **接口**：`/member/orders/project/page`、`/member/orders/project/{id}` 仅由 `MemberNursingProjectController` 处理；URL 与入参（分页对象绑定 `NursingProject`）与若依惯例一致。
- **行为差异**：原 Stub 对详情强制 `status == 1`；现以 `MemberNursingProjectController#getById` 为准（若需仅上架项目，可在该 Controller 内补充过滤）。

## 验证

- 已执行：`mvn -pl YiSmartCloud-admin -am compile -DskipTests`（以命令输出为准）。
