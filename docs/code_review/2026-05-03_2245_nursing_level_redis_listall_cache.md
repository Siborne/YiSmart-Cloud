# 变更记录：护理等级 listAll Redis 缓存

## 变更背景/目的

参照分层键名（如 `nursingLevel:all`）在 Redis 中缓存「全部启用护理等级」列表，减轻数据库压力；在新增、修改、删除后删除缓存，保证数据一致。

## 变更文件清单

- `YiSmartCloud-nursing-platform/.../serve/mapper/NursingLevelMapper.java`（新增 `listAll`）
- `YiSmartCloud-nursing-platform/src/main/resources/mapper/serve/NursingLevelMapper.xml`（`listAll` SQL：JOIN + `status = 1`）
- `YiSmartCloud-nursing-platform/.../serve/service/impl/NursingLevelServiceImpl.java`（`RedisTemplate` 构造注入、读写缓存、写操作失效）

## 关键改动说明

- 缓存键：`nursingLevel:all`（冒号分层，与参考一致）。
- `listAll()`：先 `redisTemplate.opsForValue().get`，未命中则走 `nursingLevelMapper.listAll()`（XML，带 `plan_name`），再 `set`；**命中条件为 `!= null`**，空列表也会缓存，避免穿透。
- `insertNursingLevel` / `updateNursingLevel` / `deleteNursingLevelById(s)` 成功后调用 `redisTemplate.delete` 失效缓存。
- 列表语义与原先 MP 条件查询一致：仅 `status = 1`，且保留 JOIN 扩展字段。

## 影响范围

- **接口**：`/serve/level/listAll` 行为不变（仍返回启用列表），首次或缓存失效后多一次 DB。
- **数据库**：无结构变更。
- **前端**：无。
- **运行环境**：依赖 Redis 可用（与项目既有 Redis 配置一致）；Redis 不可用时启动或调用可能失败（与全局 Redis 使用一致）。

## 验证方式

- 已执行：`mvn -q -pl YiSmartCloud-nursing-platform -am compile -DskipTests`（成功）。
- 未执行：联调 Redis 读写与接口手工验证。
