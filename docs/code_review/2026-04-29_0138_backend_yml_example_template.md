# 变更背景/目的

为便于他人快速部署后端环境，基于现有后端配置新增可公开使用的 `example` 配置文件。  
本次将原有配置结构完整保留，并将数据库、Redis、JWT、阿里云等敏感字段替换为占位符，避免泄露真实环境信息。

# 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-admin/src/main/resources/application-example.yml`
- `YiSmartCloud-background/YiSmartCloud-admin/src/main/resources/application-druid-example.yml`
- `docs/code_review/2026-04-29_0138_backend_yml_example_template.md`

# 关键改动说明

- 新增 `application-example.yml`：
  - 参考现有 `application.yml` 的结构与注释；
  - 将 Redis 地址/密码、JWT secret、OSS bucket 等字段改为示例值或占位符。
- 新增 `application-druid-example.yml`：
  - 参考现有 `application-druid.yml` 的数据源结构；
  - 将主库连接地址、账号密码、Druid 控制台账号密码改为占位符。
- 保持参数命名与层级一致，降低使用者迁移成本。

# 影响范围（接口、数据库、前端、兼容性）

- 接口：无运行时影响（仅新增示例配置文件）。
- 数据库：无直接影响（未改动实际连接配置）。
- 前端：无影响。
- 兼容性：无破坏性影响；新增文件不影响现有启动逻辑。

# 验证方式（已执行/未执行及原因）

- 已执行：
  - 人工检查示例配置层级、键名和注释与现有配置一致。
  - 人工检查敏感字段已替换为示例值/占位符。
- 未执行：
  - 未实际启动服务验证（本次仅新增示例模板，不改动运行时配置）。
