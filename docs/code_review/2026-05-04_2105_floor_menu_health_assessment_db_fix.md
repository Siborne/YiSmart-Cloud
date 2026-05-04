# 变更记录：楼层菜单 / 健康评估库表 / 动态路由组件解析

## 背景与目的

1. 楼层管理页访问 404：排查为动态路由组件路径解析在部分环境下不稳健，且菜单父级与「入住管理」目录不一致时路由层级易错。
2. 健康评估列表 SQL 报错 `Unknown column 'analysis_status'`：库表未执行与 Mapper 一致的迁移脚本。
3. 产品要求：楼层管理挂在「入住管理」（菜单 path = `enterQuit`）目录下。

## 变更文件清单

| 文件 | 说明 |
|------|------|
| `YiSmartCloud-background/sql/nursing_project/health_assessment_analysis_status.sql` | 去掉对 `ai_result_json` 的 AFTER 依赖，独立新增两列 |
| `YiSmartCloud-background/sql/nursing_project/floor_menu.sql` | 父级解析为 `enterQuit` 目录，补充 `query`/`route_name`，UTF-8 |
| `YiSmartCloud-background/sql/nursing_project/floor_menu_move_under_enterQuit.sql` | 已存在菜单时批量调整父级到 `enterQuit` |
| `YiSmartCloud-background/sql/nursing_project/health_assessment_menu.sql` | 修正为 UTF-8 中文与列清单 |
| `YiSmartCloud-front/src/store/modules/permission.js` | `loadView` 归一化斜杠与去前导 `/`，避免组件匹配失败 |
| `YiSmartCloud-front/src/views/serve/floor/index.vue` | 修正乱码中文；修正 `el-radio` 的 `label` 绑定 |

## 关键改动说明

- **数据库**：在目标库执行 `health_assessment_analysis_status.sql` 后，`analysis_status`、`analysis_error` 与 `HealthAssessmentMapper.xml` 一致。
- **菜单**：新装执行 `floor_menu.sql`；已从旧父级插入的库可再执行 `floor_menu_move_under_enterQuit.sql`。
- **前端**：`loadView` 与菜单 `component` 字段（如 `serve/floor/index`）严格匹配，减少 404。

## 影响范围

- **数据库**：`health_assessment` 表结构；`sys_menu` 楼层相关行（需 DBA/运维执行 SQL）。
- **前端**：动态路由加载、楼层管理页展示与表单单选。
- **接口**：无接口契约变更。

## 验证方式

- **未执行**：本地未连业务库；请在测试库执行上述 SQL 后验证健康评估列表与楼层菜单路由。
- **建议**：执行 `floor_menu` 相关 SQL 后重新登录；浏览器强刷或清前端缓存后再点「楼层管理」。
