# 楼层房间床位树查询字段修正

## 变更背景/目的
- 入住登记调用楼层-房间-床位树接口时前端显示“暂无数据”。
- 排查发现 `FloorMapper.xml` 树查询字段名与现有 `room`、`bed` 表结构不一致，导致查询异常/无结果。

## 变更文件清单
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/resources/mapper/serve/FloorMapper.xml`

## 关键改动说明
- 房间标签列由 `code` 修正为 `room_no`。
- 床位标签列由 `bed_number` 修正为 `bed_no`。
- SQL 查询字段同步修正：
  - `r.code` -> `r.room_no`
  - `b.bed_number` -> `b.bed_no`
- 保持树形结构映射层级不变（楼层 -> 房间 -> 床位）。

## 影响范围（接口、数据库、前端、兼容性）
- 接口：影响 `/serve/floor/getRoomAndBedByBedStatus/{status}` 返回内容。
- 数据库：无结构变更，仅字段引用修正。
- 前端：入住床位级联可正常显示楼层、房间号、床位号。
- 兼容性：不改变接口结构，仅修复字段映射错误。

## 验证方式（已执行/未执行及原因）
- 已执行：静态核对 `FloorMapper.xml` 与 `RoomMapper.xml`、`BedMapper.xml` 列定义一致性。
- 未执行：未在运行中的后端进程上做接口实调，需重启/热加载后访问接口确认数据返回。
