# BedVo 基础实现补全

## 变更背景/目的
- `BedVo` 原为占位空类，无法承载房间下床位列表返回数据。
- 补齐 `BedVo` 常用字段，便于后续在房间/入住相关接口中直接作为 VO 使用。

## 变更文件清单
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/vo/BedVo.java`

## 关键改动说明
- 为 `BedVo` 增加 `@Data`、`@ApiModel` 注解。
- 新增字段：
  - `id`（床位 ID）
  - `bedNo`（床位编号）
  - `bedStatus`（床位状态）
  - `bedStatusName`（床位状态名称）
- 为字段补充 `@ApiModelProperty` 说明，便于接口文档展示。

## 影响范围（接口、数据库、前端、兼容性）
- 接口：为后续/现有返回 `List<BedVo>` 的接口提供完整数据结构。
- 数据库：无变更。
- 前端：若使用 `BedVo` 响应，可直接读取床位编号与状态字段。
- 兼容性：新增 VO 字段，不影响现有数据库与持久层逻辑。

## 验证方式（已执行/未执行及原因）
- 已执行：静态检查类定义和导入是否完整。
- 未执行：未联调具体接口（当前改动仅 VO 结构）。
