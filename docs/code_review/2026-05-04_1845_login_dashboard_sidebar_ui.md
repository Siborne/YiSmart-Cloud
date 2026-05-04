# 变更记录：登录页、首页、侧栏 UI 优化

## 背景/目的

登录页改为更现代的玻璃拟态与层次背景；修复首页资源路径与数据概览布局导致的显示/构建问题；侧栏菜单增加圆角与激活态强调，与全局主题色一致。

## 变更文件清单

- `YiSmartCloud-front/src/views/login.vue`
- `YiSmartCloud-front/src/views/dashboard/index.scss`
- `YiSmartCloud-front/src/assets/styles/sidebar.scss`
- `YiSmartCloud-front/src/layout/components/Sidebar/index.vue`
- `YiSmartCloud-front/src/layout/components/Sidebar/Logo.vue`

## 关键改动说明

1. **登录**：全屏背景 + 渐变遮罩；居中毛玻璃卡片；表单项与验证码横向排列；页脚固定且提高可读性；版权文案调整为颐智云表述。
2. **首页**：修正 `index.scss` 中不存在或路径错误的图标（待办/账单/请假/预约）；数据概览改为自适应网格；卡片高度改为 `min-height`；增加底部留白与 `min-height` 缓解裁切；去掉无效的 scoped 选择器。
3. **侧栏**：深色/浅色主题下菜单项外边距与圆角；激活项渐变背景 + 左侧主色条；折叠时收紧边距；组件内激活项不再覆盖背景色以便全局样式生效。
4. **Logo**：字号与字间距微调。

## 影响范围

- 前端展示与构建资源解析；无后端与接口变更。
- 常用功能区「待办」「账单」等图标改为仓库内已有资源，语义接近。

## 验证方式

- 已执行：`npm run build:prod` 成功（约 2m 20s），输出中未再出现 dashboard `index.scss` 图标路径未解析告警。
- 建议：`npm run dev` 查看登录页、首页数据概览换行与底部留白、侧栏激活与折叠。
