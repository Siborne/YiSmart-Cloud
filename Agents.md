# YiSmartCloud — Agent / 协作者说明

本文件供 AI Agent 与开发者快速对齐仓库结构与工作方式。详细编码约定见仓库 [`.cursor/rules/`](.cursor/rules/)（含 `project-modules-and-stack.mdc` 等）。

## 命名说明

本仓库使用根目录 **`Agents.md`**。部分工具或文档习惯 **`AGENTS.md`**（全大写）；若你的环境只认其中一种文件名，可将本文件视为等价入口或自行增加符号链接/副本。

## 项目是什么

基于 **若依 RuoYi-Vue 3.8.9** 的「颐智云」全栈：Spring Boot 多模块后端 + Vue 3（Vite）管理端。业务品牌与包名为 **`org.FlyingSparrow.YiSmartCloud`**。

## 目录结构（高频）

| 路径 | 说明 |
|------|------|
| `YiSmartCloud-background/` | 后端 Maven 父工程与子模块 |
| `YiSmartCloud-background/YiSmartCloud-admin/` | **启动模块**（Spring Boot 入口） |
| `YiSmartCloud-background/YiSmartCloud-nursing-platform/` | **护理/颐养业务默认落点**（`serve` 包、MyBatis XML） |
| `YiSmartCloud-front/` | 前端（`npm run dev`，Vite） |

## 技术栈摘要

- 后端：Java **11**，Spring Boot **2.5.x**，MyBatis-Plus，PageHelper，Spring Security；接口文档 **Knife4j + Swagger 2**（`io.swagger.annotations`）。
- 前端：Vue **3**、`script setup`、Element Plus、Pinia、Axios；开发代理 **`/dev-api`** → 后端（见 `YiSmartCloud-front/vite.config.js` 中 `baseUrl`，默认 `http://localhost:8080`）。

## 本地开发（要点）

1. 配置数据源与 Redis：使用 `YiSmartCloud-admin` 下 profile（参考 `application-druid-example.yml` 等示例），**勿将含真实密码的配置提交入库**。
2. 启动后端：在 `YiSmartCloud-background/YiSmartCloud-admin` 运行 Spring Boot 主类（默认端口常与前端代理一致，如 **8080**）。
3. 启动前端：在 `YiSmartCloud-front` 执行 `npm install`（首次）、`npm run dev`；页面请求以 `/dev-api` 为前缀。

## 业务 API 与前端约定

- 护理模块 HTTP 前缀多为 **`/serve/...`**；前端接口封装在 **`YiSmartCloud-front/src/api/serve/`**，页面在 **`src/views/serve/`** 等目录。
- 菜单与路由主要由**后端菜单**动态下发；新增页面通常需配置菜单与按钮权限，并与 `@PreAuthorize` / `v-hasPermi` 标识一致。

## Agent 工作约定

- 遵守 **`.cursor/rules/`** 下各 `*.mdc`（分层、权限、Mapper、Vue、UTF-8 等）。
- 所有文本/源码文件使用 **UTF-8**。
- 对仓库做**实质性代码或规则变更**后，在 **`docs/code_review/`** 新增一条当日记录（见 `code-change-review-log` 规则）。
- **勿提交**：`**/target/**`、本地 IDE 私货（如未忽略的 `.idea/workspace.xml`）、含密钥的 `application-*.yml`。
