# 变更记录：管理端前端 UI 现代化（全局样式与布局）

## 背景/目的

统一后台视觉层次：侧栏与主内容区对比更清晰，列表区卡片化；主题色与布局设置中的默认色一致；标签页与主题色联动；表格与表单控件更易读。

## 变更文件清单

- `YiSmartCloud-front/src/assets/styles/variables.module.scss`
- `YiSmartCloud-front/src/assets/styles/index.scss`
- `YiSmartCloud-front/src/assets/styles/ruoyi.scss`
- `YiSmartCloud-front/src/assets/styles/element-ui.scss`
- `YiSmartCloud-front/src/assets/styles/sidebar.scss`
- `YiSmartCloud-front/src/layout/components/Navbar.vue`
- `YiSmartCloud-front/src/layout/components/TagsView/index.vue`

## 关键改动说明

1. **主题与 CSS 变量**：`:root` 增加 `--el-color-primary: #00b8a0`、工作区背景 `--app-page-bg`、顶栏阴影 `--navbar-shadow`、标签栏浅色变量等；暗色模式补充 `--app-page-bg`。
2. **侧栏**：深色菜单改为 slate 系（`#0f172a` / `#020617` 等），导出变量与若依菜单组件一致。
3. **主区域**：`#app .main-container` 使用浅灰底；其下 `.app-container` 在亮色下白底圆角卡片 + 细边框与阴影；暗色下保留圆角与边框。
4. **表格/表单**：表头背景与字重、表单 label 字重与颜色微调。
5. **Element 覆盖**：卡片、输入、按钮圆角；面包屑层级颜色。
6. **顶栏/标签**：Navbar 使用变量色与阴影；Tags 使用 `--current-color`（来自 `layout/index.vue`）与 `--el-color-primary` 作为激活态，去掉内联 `activeStyle`。

## 影响范围

- **前端**：全局样式与布局组件；未改业务页面逻辑。
- **接口/数据库**：无。
- **兼容性**：依赖布局根节点上的 `--current-color`（已有）；用户在「布局设置」中修改主题色后，标签激活态仍随主题变化。

## 验证方式

- 已执行：`npm run build:prod`，**构建成功**（`exit_code: 0`）。构建日志中仍有 dashboard 相关图片 `url()` 在构建时未解析的提示（既有问题，非本次 UI 改动引入）。
- 建议：本地 `npm run dev` 目测首页、列表页、暗色模式、折叠侧栏。
