# 变更记录：老人档案 elder_info 与 BaseEntity 字段 SQL 冲突修复

## 变更背景/目的

`ElderInfo` 继承 `BaseEntity`（含 `create_by`、`update_by`、`remark`），但 `ElderInfoServiceImpl` 对详情/新增/修改使用了 MyBatis-Plus 的 `getById` / `save` / `updateById`，生成的 SQL 会查询/写入表中不存在的审计列，导致 `Unknown column 'create_by' in 'field list'`。

## 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/ElderInfoServiceImpl.java`
- `YiSmartCloud-background/sql/other/table.sql`（新建库时 `elder_info` 建表补充审计列）
- `YiSmartCloud-background/sql/nursing_project/elder_info_add_base_entity_columns.sql`（已有库可选一次性补丁）

## 关键改动说明

- `selectElderInfoById`、`insertElderInfo`、`updateElderInfo` 改为调用 `ElderInfoMapper` 已有 XML 方法，与当前表结构一致，避免 MP 通用 SQL 带上无列字段。
- 建表脚本与可选 `ALTER` 脚本补充 `create_by`、`update_by`、`remark`，便于后续若需与若依审计完全对齐。

## 影响范围

- **接口**：老人档案查询/新增/修改行为与 XML 定义一致；不再依赖 MP 对 `ElderInfo` 的默认列推断。
- **数据库**：业务库无变更要求；可选执行补丁脚本增加审计列。
- **删除**：仍使用 `removeById` / `removeByIds`（物理删除），不涉及缺失列。

## 验证方式

- 已执行：`mvn -pl YiSmartCloud-nursing-platform -am compile -DskipTests`。
- 未执行：连真实库回归（依赖本地库结构）。
