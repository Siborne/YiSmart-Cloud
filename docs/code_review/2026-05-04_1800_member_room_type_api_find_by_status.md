# 变更记录：客户房型接口与房间按状态查询

## 变更背景/目的

`MemberRoomTypeController` 调用了 `RoomServiceImpl.findRoomTypeListByStatus`，但该方法在 Service 中不存在，导致无法编译。本次补齐 Service 契约与实现，并规范 Controller 注入与参数绑定。

## 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/IRoomService.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/RoomServiceImpl.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/mebber/MemberRoomTypeController.java`

## 关键改动说明

- 在 `IRoomService` 增加 `findRoomTypeListByStatus(Integer status)`；在 `RoomServiceImpl` 使用 MyBatis-Plus `LambdaQueryWrapper` 查询：`is_deleted = 0`，`status` 非空时等值过滤，按 `room_type`、`id` 排序。
- `MemberRoomTypeController` 改为注入 `IRoomService`；`status` 使用 `@RequestParam(required = false)` 与 `@ApiParam`；增加 `@PreAuthorize("@ss.hasPermi('serve:room:list')")` 与既有房间列表权限对齐。

## 影响范围

- **接口**：`GET /member/roomTypes` 支持显式查询参数 `status`；需登录且具备 `serve:room:list` 权限（与房间列表一致）。
- **数据库**：无结构变更。
- **前端**：若此前未传 `status`，行为为返回全部未逻辑删除房间（此前接口不可用）。
- **兼容性**：修复编译错误；权限与参数绑定为新增约束。

## 验证方式

- 已执行：`mvn -pl YiSmartCloud-nursing-platform -am compile -DskipTests`，退出码 0。
- 未执行：端到端联调、菜单权限单独配置（当前复用 `serve:room:list`）。
