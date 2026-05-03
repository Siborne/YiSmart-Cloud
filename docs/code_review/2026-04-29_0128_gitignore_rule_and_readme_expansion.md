# 变更背景/目的

用户要求两项改动：

1. 为 `vite.config.js.timestamp-*.mjs` 这类运行时临时文件建立规则，并确保 `.gitignore` 忽略；
2. 现有 README 过于简略，需要基于项目真实代码结构扫描后进行大幅扩写（2000 字以上）。

# 变更文件清单

- `.gitignore`
- `.cursor/rules/gitignore-temp-generated-files.mdc`
- `README.md`

# 关键改动说明

- 在 `.gitignore` 增加临时文件忽略规则：
  - `**/vite.config.js.timestamp-*.mjs`
  - `.vite/`
- 新增 Cursor 规则文件 `gitignore-temp-generated-files.mdc`，约束后续开发中必须忽略 Vite 时间戳快照与缓存目录，避免误提交。
- 重写根目录 `README.md`，基于当前仓库真实结构扩写为详细项目文档，包含：
  - 技术栈（含版本）
  - 目录与模块职责
  - 养老业务模块清单
  - 后端/前端启动流程
  - SQL 初始化建议
  - 配置与安全注意事项
  - 入住办理最近改造说明
  - FAQ 与后续优化建议

# 影响范围（接口、数据库、前端、兼容性）

- 接口：无变更。
- 数据库：无结构变更。
- 前端：仅忽略规则补充，不影响运行逻辑。
- 兼容性：纯配置与文档增强，低风险。

# 验证方式（已执行/未执行及原因）

- 已执行：检查 `.gitignore` 是否覆盖目标临时文件模式。
- 已执行：核对 README 内容与 `pom.xml`、`package.json`、`application*.yml`、业务目录结构一致。
- 未执行：无需运行时联调（本次为配置与文档更新）。
