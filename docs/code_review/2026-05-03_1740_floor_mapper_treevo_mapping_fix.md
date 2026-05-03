# FloorMapper 树形映射修正

## 变更背景/目的
- 楼层-房间-床位树形查询在 `FloorMapper.xml` 中存在历史包名与字段名不一致问题。
- 修复后确保 MyBatis `resultMap` 能正确装配 `TreeVo`，并保证楼层名称字段读取正确。

## 变更文件清单
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/resources/mapper/serve/FloorMapper.xml`

## 关键改动说明
- 将 `TreeVoResultMap` 的 `type` 从 `com.zzyl.nursing.vo.TreeVo` 改为 `org.FlyingSparrow.YiSmartCloud.serve.vo.TreeVo`。
- 将嵌套 `collection` 的 `ofType` 同步改为 `org.FlyingSparrow.YiSmartCloud.serve.vo.TreeVo`。
- 将楼层标签映射列从 `name` 改为 `floor_name`。
- 将查询 SQL 中 `f.name` 改为 `f.floor_name`，与当前表结构和映射一致。

## 影响范围（接口、数据库、前端、兼容性）
- 接口：影响 `/serve/floor/getRoomAndBedByBedStatus/{status}` 的数据组装稳定性。
- 数据库：无结构变更，仅修正查询字段引用。
- 前端：树形数据返回更准确（楼层 label 正常显示）。
- 兼容性：仅修复错误映射，不改变接口返回结构。

## 验证方式（已执行/未执行及原因）
- 已执行：静态核对 mapper 与 `TreeVo` 包路径、表字段名一致性。
- 未执行：未启动服务进行联调验证，建议请求 `GET /serve/floor/getRoomAndBedByBedStatus/0` 进行接口冒烟。
