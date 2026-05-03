# Bed 查询列不匹配修复（create_by 不存在）

## 变更背景/目的
- `/serve/checkIn/apply` 继续报错：`Unknown column 'create_by' in 'field list'`，定位到 `BedMapper`。
- 根因是 `CheckInServiceImpl` 中对 `Bed` 使用了 MyBatis-Plus 通用方法 `selectById/updateById`，自动 SQL 包含 `create_by` 等审计列，而 `bed` 表无该列。

## 变更文件清单
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/CheckInServiceImpl.java`

## 关键改动说明
- 将床位读取改为 XML 映射方法：
  - `bedMapper.selectById(...)` -> `bedMapper.selectBedById(...)`
- 将床位状态更新改为 XML 映射方法：
  - `bedMapper.updateById(bed)` -> `bedMapper.updateBed(bed)`
- 继续复用原有业务校验逻辑（床位存在性、床位状态判断）。

## 影响范围（接口、数据库、前端、兼容性）
- 接口：影响 `/serve/checkIn/apply` 床位查询与状态更新路径。
- 数据库：无结构变更，仅切换 SQL 执行入口。
- 前端：无改动。
- 兼容性：与现有 `BedMapper.xml` 字段映射一致，避免 MP 自动列引发 SQL 语法错误。

## 验证方式（已执行/未执行及原因）
- 已执行：静态检查 + lints，无新增报错。
- 未执行：未完整联调接口，建议再次提交入住申请复测。
