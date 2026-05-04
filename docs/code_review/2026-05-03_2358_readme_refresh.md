# 变更记录：根目录 README 同步更新

## 变更背景/目的

根目录 `README.md` 与当前仓库结构、技术栈说明存在少量偏差（如未列出小程序目录、API 文档栈表述易与 springdoc 混淆、引用了不存在的 Cursor 规则文件名）。在**保留原有章节与主体内容**的前提下做增量修订，便于新成员与联调人员对照真实代码。

## 变更文件清单

- `README.md`
- `docs/code_review/2026-05-03_2358_readme_refresh.md`（本文件）

## 关键改动说明

- 补充 **RuoYi-Vue 3.8.9** 基线说明及 `mp-weixin` 在仓库结构中的位置与用途。
- 技术栈章节将「前端 / 后端」改为 `### 2.1` / `### 2.2` 子节，避免与二级标题冲突。
- API 文档表述改为 **Springfox 3（OAS_30）+ Knife4j**，并与 `SwaggerConfig` 实现一致；联调小节同步调整路径说明。
- 新增 **7.1 微信小程序** 简要启动与域名配置说明。
- **10. Git 与协作规范**：将误指向的 `gitignore-temp-generated-files.mdc` 改为说明 `.gitignore` 与 `.cursor/rules/` 目录。
- 业务概览中补充 **`/serve/...`** 接口前缀说明。

## 影响范围

- 文档与协作说明 only；无接口、数据库、运行时行为变更。

## 验证方式

- 已对照 `package.json`、根 `pom.xml`、`YiSmartCloud-admin/pom.xml`、`SwaggerConfig.java`、`SecurityConfig.java`、`vite.config.js`、仓库目录结构人工核对。
- 未执行构建/启动（纯文档变更）。
