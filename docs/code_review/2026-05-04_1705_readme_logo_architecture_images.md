# 变更记录：README 嵌入品牌 Logo 与架构示意图

## 变更背景/目的

在仓库根 `README.md` 中展示 `assets/readme/logo.png` 与 `assets/readme/tech_pic.png`，便于访客快速识别品牌并理解系统分层；顺带避免与顶部状态徽章重复的说明文字。

## 变更文件清单

- `README.md`

## 关键改动说明

- 文首增加居中品牌 Logo（相对路径 `assets/readme/logo.png`，含无障碍 `alt`）。
- 一级标题去掉装饰性 emoji，与 Logo 视觉并列更简洁。
- 在「仓库结构」章节前增加「架构示意图」小节，嵌入 `assets/readme/tech_pic.png`，并附简短免责说明（以代码与部署为准）。
- 将原引用块中与「开发中」徽章重复的一句改为指向徽章的首次提交时间说明。

## 影响范围

- **接口/数据库/前端代码**：无。
- **兼容性**：GitHub / Gitee 等 Markdown 渲染；图片为仓库内相对路径，克隆后即可显示。

## 验证方式

- **已执行**：人工核对 `README.md` 中图片路径与 `assets/readme/` 下文件一致。
- **未执行**：在托管平台预览页面截图验收（依赖用户推送后查看）。
