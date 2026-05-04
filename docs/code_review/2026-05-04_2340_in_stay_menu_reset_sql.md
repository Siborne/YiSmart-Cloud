# 变更记录：在住管理四菜单删除并重建 SQL

## 背景

在住管理下「房型 / 楼层 / 床位预览 / 智能床位」菜单顺序与配置在库中不一致（如楼层 order 靠后、智能床位无组件等），需一次性删除子菜单及按钮权限后按业务顺序重建。

## 变更文件

- `YiSmartCloud-background/sql/nursing_project/in_stay_residential_menu_reset.sql`（新增）

## 脚本行为

1. 解析父级：`在住管理` → `enterQuit`（M）→ `2018`。
2. 删除 `sys_role_menu` 中与上述四个 C 菜单及其 F 子菜单相关的行。
3. 删除 `sys_menu` 中对应 F 再删四个 C。
4. 按 `order_num` **0 房型 → 1 楼层 → 2 床位预览 → 3 智能床位** 插入，并写入与 `RoomController` / `FloorController` / `BedController` 一致的按钮权限标识。

## 影响与验证

- **不删除**「在住管理」目录；**不删除**同父级下其它名称的菜单。
- 执行后管理员需在 **角色管理** 中重新勾选新菜单 ID 对应的权限并重新登录。
- 若不需要「智能床位」与「床位预览」双入口，可在菜单管理将其中一项设为隐藏。
