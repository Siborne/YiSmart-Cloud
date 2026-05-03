# 变更记录：护理等级 Redis 键迁入 CacheConstants

## 变更背景/目的

将护理等级 `listAll` 缓存使用的 Redis 键从 `NursingLevelServiceImpl` 内联常量改为公共常量类 `CacheConstants`，与项目其他缓存键管理一致，便于复用与统一维护。

## 变更文件清单

- `YiSmartCloud-common/.../common/constant/CacheConstants.java`（新增 `NURSING_LEVEL_LIST_ALL_KEY`）
- `YiSmartCloud-nursing-platform/.../serve/service/impl/NursingLevelServiceImpl.java`（引用 `CacheConstants`，删除类内私有常量）

## 关键改动说明

- 常量名：`NURSING_LEVEL_LIST_ALL_KEY`，值仍为 `nursingLevel:all`。
- Service 中 `get` / `set` / `delete` 均改为使用 `CacheConstants.NURSING_LEVEL_LIST_ALL_KEY`。

## 影响范围

- 仅键定义位置变化，**Redis 键字符串不变**，行为与兼容性与迁移前一致。

## 验证方式

- 已执行：`mvn -q -pl YiSmartCloud-nursing-platform -am compile -DskipTests`（成功）。
