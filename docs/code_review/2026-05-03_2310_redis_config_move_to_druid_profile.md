# 变更记录：Redis 配置迁移至 application-druid.yml

## 变更背景/目的

将 Redis 连接与连接池配置从主配置 `application.yml` 抽离到与 Druid 数据源同级的 profile 文件 `application-druid.yml`，与当前 `spring.profiles.active: druid` 对齐，便于环境与数据源、缓存一并管理。

## 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-admin/src/main/resources/application.yml`（删除 `spring.redis` 段）
- `YiSmartCloud-background/YiSmartCloud-admin/src/main/resources/application-druid.yml`（在 `spring` 下新增 `redis` 段，与 `datasource` 并列）

## 关键改动说明

- `spring.redis`（host、port、database、password、timeout、lettuce.pool）整体迁入 `application-druid.yml`，缩进与文件内既有 `spring.datasource` 风格一致（4 空格层级）。
- 主 `application.yml` 不再包含 Redis 敏感/环境相关项。

## 影响范围

- **运行**：默认 profile 仍为 `druid` 时行为与迁移前一致；若将来使用非 `druid` 的 profile 且未定义 `spring.redis`，需在该 profile 或主配置中补充 Redis，否则 Redis 相关功能无法连接。
- **数据库 / 前端 / 接口**：无。

## 验证方式

- 未执行：启动 `YiSmartCloud-admin` 并确认 Redis 与护理等级缓存等正常；属配置迁移，建议在目标环境做一次冒烟验证。
