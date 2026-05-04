# 楼层管理独立模块

## 变更背景/目的

将楼层维护从「房间管理」内嵌弹窗拆出为独立业务模块：独立菜单与列表页、独立权限前缀 `serve:floor:*`，与房间管理解耦，便于授权与维护。

## 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-nursing-platform/.../FloorController.java`：`serve:room:*` 改为 `serve:floor:*`；`/options` 使用 `hasAnyPermi('serve:floor:list,serve:room:list')` 以便仅有房间列表权限的角色仍能加载楼层下拉。
- `YiSmartCloud-background/sql/nursing_project/floor_menu.sql`：新增楼层菜单及按钮权限 SQL（父菜单默认 `2018`）。
- `YiSmartCloud-front/src/api/serve/floor.js`：补齐楼层 CRUD、下拉、导出相关请求；保留床位树查询。
- `YiSmartCloud-front/src/api/serve/room.js`：移除楼层相关 API（避免重复定义）。
- `YiSmartCloud-front/src/views/serve/floor/index.vue`：新增楼层管理列表页。
- `YiSmartCloud-front/src/views/serve/room/index.vue`：移除内嵌楼层管理弹窗；楼层下拉改为从 `@/api/serve/floor` 引入。

## 关键改动说明

- 后端权限与前端 `v-hasPermi` 对齐为 `serve:floor:list|query|add|edit|remove|export`。
- 房间页仍调用 `/serve/floor/options`：兼容仅分配 `serve:room:list` 的历史角色。

## 影响范围

- **接口权限**：原依赖 `serve:room:*` 调用楼层 CRUD 的客户端需改为具备 `serve:floor:*`；列表/导出等同名动作一一对应新标识。
- **数据库**：需执行 `floor_menu.sql` 并给角色分配新菜单按钮；若颐养父菜单 ID 不是 `2018`，需手工调整 SQL 中的 `parent_id`。
- **前端**：动态路由依赖后端菜单；未执行 SQL 或未授权时新页面不可见或按钮不可用。
- **兼容性**：`/serve/floor/options` 双权限满足房间下拉场景。

## 验证方式

- 未执行本地 `mvn` 全量编译与 E2E（环境依赖）；建议执行 SQL 后登录管理端，确认「楼层管理」路由与 CRUD/导出，并在「房间管理」中验证楼层下拉仍可用。
