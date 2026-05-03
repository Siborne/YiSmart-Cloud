# 入住申请 elder_id 为空导致插入失败修复

## 变更背景/目的
- 入住申请时报错：`Field 'elder_id' doesn't have a default value`。
- 根因是入住记录写入时 `elderId` 可能为空，导致 MyBatis-Plus 生成 SQL 时未包含 `elder_id` 列。

## 变更文件清单
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/CheckInServiceImpl.java`

## 关键改动说明
- 在 `insertCheckIn(...)` 增加保护校验：
  - 若 `elder == null` 或 `elder.id == null`，直接抛业务异常，阻止脏数据入库。
- 在 `insertOrUpdate(...)` 新增老人分支补充兜底：
  - `insert` 后若 `elderInfo.id` 仍为空，按 `idCard + status=1` 回查最新一条并回填 `id`。
  - 查询追加 `order by id desc limit 1`，避免 `selectOne` 多条风险。

## 影响范围（接口、数据库、前端、兼容性）
- 接口：影响 `/serve/checkIn/apply` 入住申请流程。
- 数据库：无结构变更，仅修复业务写入逻辑。
- 前端：请求参数不变；失败信息更明确。
- 兼容性：兼容现有字段与接口，增加容错保护。

## 验证方式（已执行/未执行及原因）
- 已执行：静态检查 + lints，无新增报错。
- 未执行：未完成完整联调，建议使用同一身份证再测一次申请流程验证 `elder_id` 入库。
