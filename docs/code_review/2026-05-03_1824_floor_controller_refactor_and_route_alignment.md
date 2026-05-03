# Floor 模块 Controller 职责收拢重构

## 变更背景/目的
- 楼层（Floor）相关 CRUD 接口此前分散在 `RoomController` 下，导致模块职责边界不清晰。
- 目标是将楼层接口统一收敛到 `FloorController`，并同步前端路由调用，避免后续维护时“串模块”。

## 变更文件清单
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/FloorController.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/RoomController.java`
- `YiSmartCloud-front/src/api/serve/room.js`

## 关键改动说明
- 在 `FloorController` 中补齐楼层接口：
  - `GET /serve/floor/list`
  - `POST /serve/floor/export`
  - `GET /serve/floor/options`
  - `GET /serve/floor/{id}`
  - `POST /serve/floor`
  - `PUT /serve/floor`
  - `DELETE /serve/floor/{ids}`
  - 保留 `GET /serve/floor/getRoomAndBedByBedStatus/{status}`
- 从 `RoomController` 中移除所有 `/floor/*` 相关处理逻辑及 `IFloorService` 依赖，只保留房间领域接口。
- 前端 `room.js` 中楼层相关 API 地址从 `/serve/room/floor/*` 调整为 `/serve/floor/*`，调用方无需改动函数名。

## 影响范围（接口、数据库、前端、兼容性）
- 接口：楼层 CRUD 正式归属 `FloorController`。
- 数据库：无变更。
- 前端：楼层管理/楼层下拉接口请求路径更新，但调用代码保持兼容。
- 兼容性：若有外部调用仍依赖旧路径 `/serve/room/floor/*`，需要同步迁移到新路径。

## 验证方式（已执行/未执行及原因）
- 已执行：静态检查 Controller 路由分布、前端 API 路径替换及 lints。
- 未执行：未完成端到端联调，建议手测房间页“楼层管理”新增/修改/删除与下拉加载流程。
