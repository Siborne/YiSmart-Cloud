# 变更记录：README 插图嵌入与文案润色

## 变更背景 / 目的

在 `assets/readme/` 下已生成多示意图（业务域、入住流程、联调拓扑、多端形态、健康评估与 AI 概念、横幅背景等），需在根目录 `README.md` 中引用并适度润色结构，便于读者快速建立全局认知。

## 变更文件清单

- `README.md`

## 关键改动说明

- 在「仓库结构」中补充 `assets/readme/` 说明，并嵌入 `multi_client.png`（多端示意）。
- 在「业务模块能力」中嵌入 `business_domains.png`，新增健康评估业务条目及 `health_ai_concept.png` 示意与免责说明。
- 在「入住办理」中嵌入 `checkin_flow.png`，将原编号列表改为「变更要点」并收紧表述。
- 在「本地开发环境」之后嵌入 `dev_topology.png`（联调拓扑）。
- 在「后续建议」中增加一条，指向宽屏素材 `background_readme_banner.png`。
- 润色开篇与后端技术栈说明（含可选千帆 AI 接入一行）；版本说明数据源表述略作统一。

## 影响范围

- **文档**：仅根 README，无接口与数据库变更。
- **前端 / 后端**：无。
- **兼容性**：图片为相对路径 `assets/readme/...`，在 GitHub/Gitee 等 Markdown 预览中正常显示。

## 验证方式

- 已核对 `assets/readme/` 下对应 PNG 文件存在。
- 未执行构建；建议在本地或远端预览 `README.md` 确认图片加载与排版。
