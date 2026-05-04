# 变更记录：微信小程序配置迁至 Druid Profile

## 变更背景 / 目的

将 `wechat`（小程序 appId / appSecret）从主配置 `application.yml` 迁至与 `spring.profiles.active=druid` 一并加载的 `application-druid.yml`，与数据源、Redis、千帆等环境相关配置集中管理。

## 变更文件清单

| 路径 | 说明 |
|------|------|
| `YiSmartCloud-admin/.../application.yml` | 删除 `wechat` 段 |
| `YiSmartCloud-admin/.../application-druid.yml` | 新增 `wechat` 段（与现有 `yi` 同级根配置） |
| `YiSmartCloud-admin/.../application-example.yml` | 删除此前误放在全量示例中的 `wechat` 段 |
| `YiSmartCloud-admin/.../application-druid-example.yml` | 补充 `wechat` 示例，便于复制到私有 `application-druid.yml` |

## 关键改动说明

- 激活 profile 仍为 `druid` 时，行为与迁移前一致；`@Value("${wechat.appId}")` 等绑定不变。
- 未使用 `application-druid` 的其它 profile 需自行包含 `wechat` 或提供默认值，否则微信相关接口会报未配置。

## 影响范围

- 仅配置加载位置变化；无 Java 代码与接口变更。

## 验证方式

- 未执行运行时启动；本地确认 `spring.profiles.active` 含 `druid` 且 `application-druid.yml` 中存在 `wechat` 即可。
