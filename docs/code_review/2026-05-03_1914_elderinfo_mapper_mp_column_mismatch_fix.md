# ElderInfo 查询列不匹配修复（create_by 不存在）

## 变更背景/目的
- `/serve/checkIn/apply` 报错：`Unknown column 'create_by' in 'field list'`。
- 根因是 `CheckInServiceImpl` 使用了 MyBatis-Plus `selectOne/selectById/updateById/insert` 访问 `ElderInfo`，其自动 SQL 会带上继承字段（如 `create_by`），但 `elder_info` 表不存在该列。

## 变更文件清单
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/CheckInServiceImpl.java`

## 关键改动说明
- 将 `ElderInfo` 相关访问从 MP 通用方法改为 XML 映射方法：
  - `selectOne` -> `selectElderInfoList`（按条件查后取最新）
  - `selectById` -> `selectElderInfoById`
  - `updateById` -> `updateElderInfo`
  - `insert` -> `insertElderInfo`
- 新增私有方法 `findLatestElderByIdCardAndStatus(idCard, status)`，统一身份证+状态查询逻辑并取最新记录。
- 保留 `Contract` 查询的 MP 用法（该表包含审计列，不受此次问题影响）。

## 影响范围（接口、数据库、前端、兼容性）
- 接口：影响 `/serve/checkIn/apply` 与 `/serve/checkIn/detail/{id}` 的老人信息查询链路。
- 数据库：无结构改动，仅修正 SQL 生成方式。
- 前端：无改动，接口契约保持不变。
- 兼容性：规避了 `elder_info` 表字段缺失导致的运行时 SQL 错误。

## 验证方式（已执行/未执行及原因）
- 已执行：静态检查 + lints，无新增诊断。
- 未执行：未在运行环境进行端到端提交流程回归，建议再次提交入住申请验证。
