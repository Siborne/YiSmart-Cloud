# 变更记录：根目录 .gitignore 补充微信小程序相关规则

## 变更背景/目的

分析仓库内 `mp-weixin`（由 uni-app 编译得到的微信小程序端产物）及常见微信/uni 工具链产生的本地文件，在根 `.gitignore` 中补充应忽略项，避免误提交个人配置、构建缓存与 map 等。

## 变更文件清单

- `.gitignore`
- `docs/code_review/2026-05-03_2345_gitignore_mp_weixin.md`（本文件）

## 关键改动说明

新增「WeChat Miniprogram」段落，主要包括：

| 规则 | 说明 |
|------|------|
| `project.private.config.json` | 微信开发者工具私有配置，按官方说明优先写个人本机设置，与团队共享的 `project.config.json` 分离，建议忽略。 |
| `miniprogram_npm/` | 在小程序根目录构建 npm 后的输出，可重建，通常不提交。 |
| `mp-weixin/**/*.map` | 若生成 source map，可忽略以减小仓库与避免源码映射外泄（仅作用于 `mp-weixin`）。 |
| `unpackage/` | uni-app 默认发行目录；若将来在仓库中维护 uni 源码并发行到各端，应忽略。 |
| `.hbuilderx/` | HBuilderX IDE 本地状态。 |
| `**/cloudfunctions/**/node_modules/` | 若使用微信云开发，云函数内依赖可忽略（与根 `node_modules/` 规则互补）。 |

**未**将整块 `mp-weixin/` 加入忽略：当前仓库将该目录作为可运行的编译产物纳入版本管理时，忽略整目录会导致协作/部署断裂；若后续改为「仅维护 uni 源码、发行物 CI 生成」，可再评估改为忽略 `mp-weixin/` 并在流水线产出。

根目录已有 `node_modules/`、`dist/` 等规则，已覆盖小程序根下若出现的 `node_modules`（全局匹配目录名）。

## 影响范围

- **接口/数据库/前端业务逻辑**：无。
- **Git 行为**：已跟踪的 `mp-weixin/project.private.config.json` 若存在，需执行 `git rm --cached` 后才会停止被跟踪（本次未执行该命令，由团队按需处理）。

## 验证方式

- 已核对 `mp-weixin` 目录结构（uni 编译结构、`project.config.json` / `project.private.config.json`）。
- 未执行 `git status` 全量校验（可选：本地确认忽略规则是否生效）。
