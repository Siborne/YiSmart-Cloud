# 入住床位显示路径与床位费回显

## 变更背景/目的
- 现状仅显示床位末级，未展示完整“楼层/房间/床位”路径。
- 选择床位后未回填床位费用，无法满足按床位绑定费用自动回显的业务要求。

## 变更文件清单
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/vo/TreeVo.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/resources/mapper/serve/FloorMapper.xml`
- `YiSmartCloud-front/src/views/serve/checkIn/apply.vue`

## 关键改动说明
- `TreeVo` 增加 `bedFee` 字段，用于承载床位费用。
- `FloorMapper.xml` 在树查询中返回 `r.bed_fee`，并映射到床位节点 `bedFee`。
- 入住登记页取消 `el-cascader` 的 `show-all-levels=false`，恢复完整路径显示。
- 选择床位时：
  - `bedNumber` 回填床位号（末级 label）。
  - `bedFee` 自动回填为当前节点 `bedFee`。
  - 清空选择时重置 `bedFee=0`。

## 影响范围（接口、数据库、前端、兼容性）
- 接口：`/serve/floor/getRoomAndBedByBedStatus/{status}` 节点对象新增 `bedFee` 字段。
- 数据库：无结构改动，仅查询返回补充字段。
- 前端：入住登记页面床位选择显示完整路径，并自动回显床位费用。
- 兼容性：新增字段为向后兼容扩展，不影响已有 `label/value/children` 结构消费。

## 验证方式（已执行/未执行及原因）
- 已执行：静态核对后端查询字段、VO映射与前端赋值链路。
- 未执行：未在运行环境中联调接口与页面交互，需重启后端后手测确认回显。
