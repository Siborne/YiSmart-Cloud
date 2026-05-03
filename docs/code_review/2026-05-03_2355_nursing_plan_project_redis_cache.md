# 变更记录：护理计划 / 护理项目 Redis 缓存

## 变更背景/目的

- 新增护理等级时需拉取全部启用护理计划：对 `selectNursingPlanAll` 增加 Redis 缓存，写操作后失效。
- 新增护理计划时需拉取全部启用护理项目（下拉）：对 `selectAll`（`getAll`）增加 Redis 缓存，写操作后失效。
- 补充 `NursingProjectMapper.xml` 中缺失的 `getAll` 查询（`label`/`value`、仅 `status=1`），与下拉语义一致。

## 变更文件清单

- `YiSmartCloud-common/.../constant/CacheConstants.java`（`NURSING_PLAN_ALL_KEY`、`NURSING_PROJECT_ALL_KEY`）
- `YiSmartCloud-nursing-platform/.../NursingPlanServiceImpl.java`（缓存读写、失效；计划变更时顺带删除护理等级 `listAll` 缓存键）
- `YiSmartCloud-nursing-platform/.../NursingProjectServiceImpl.java`（缓存读写、失效）
- `YiSmartCloud-nursing-platform/.../resources/mapper/serve/NursingProjectMapper.xml`（`NursingProjectVoResult`、`getAll`）

## 关键改动说明

- 缓存键：`nursingPlan:all`、`nursingProject:all`（常量集中于 `CacheConstants`）。
- 读路径：`get` → 未命中则查库 → `set`；允许缓存空列表（`!= null` 即命中）。
- 护理计划新增/改/删后删除 `NURSING_PLAN_ALL_KEY` 与 `NURSING_LEVEL_LIST_ALL_KEY`（等级列表 JOIN 计划名）。
- 护理项目新增/改/删后删除 `NURSING_PROJECT_ALL_KEY`。

## 影响范围

- **接口**：URL 与返回结构不变；首次或缓存失效后多一次 DB。
- **数据库**：无结构变更。
- **前端**：无。

## 验证方式

- 已执行：`mvn -q -pl YiSmartCloud-nursing-platform -am compile -DskipTests`（成功）。
- 未执行：联调 Redis 与前端下拉数据一致性。
