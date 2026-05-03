# 变更记录：Cursor 规则补充与 Agents.md

## 变更背景 / 目的

对照仓库 RuoYi 多模块与护理业务实际落点，补齐 `.cursor/rules` 中未覆盖的模块栈、MyBatis-Plus 与 XML 分工、`domain`/`vo` 路径、权限与菜单闭环、Knife4j/Swagger2、动态路由等说明；新增根目录 `Agents.md` 供 Agent 与协作者快速对齐。

## 变更文件清单

- [.cursor/rules/backend-java-ruoyi-conventions.mdc](../../.cursor/rules/backend-java-ruoyi-conventions.mdc)
- [.cursor/rules/backend-vo-and-domain-conventions.mdc](../../.cursor/rules/backend-vo-and-domain-conventions.mdc)
- [.cursor/rules/backend-controller-permission-conventions.mdc](../../.cursor/rules/backend-controller-permission-conventions.mdc)
- [.cursor/rules/front-api-and-config-conventions.mdc](../../.cursor/rules/front-api-and-config-conventions.mdc)
- [.cursor/rules/project-modules-and-stack.mdc](../../.cursor/rules/project-modules-and-stack.mdc)（新建，`alwaysApply: true`）
- [Agents.md](../../Agents.md)（新建）

## 关键改动说明

- **Java 约定**：明确业务默认在 `YiSmartCloud-nursing-platform`；补充 `IService`/`ServiceImpl` 与 XML 的职责划分及日期类型一致性建议。
- **Domain/VO**：`globs` 扩展为同时匹配 `domain` 与 `vo`；区分持久化实体与展示 VO，对齐 `TreeVo` 与 Swagger 注解风格。
- **Controller**：菜单/SQL 权限闭环、Knife4j+Swagger2、可选 `@RepeatSubmit`。
- **前端 API**：补充动态路由由后端菜单下发的说明。
- **全局**：`project-modules-and-stack.mdc` 提供技术栈与模块地图；`Agents.md` 汇总目录、启动要点与 Agent 合规项。

## 影响范围

- **接口 / 数据库**：无。
- **前端 / 后端代码**：无（仅文档与 Cursor 规则）。
- **兼容性**：无运行时影响。

## 验证方式

- 已执行：人工通读新增/修改的 `.mdc` 与 `Agents.md` 的 YAML 与 Markdown 结构。
- 未执行：无需构建或单测（文档-only 变更）。
