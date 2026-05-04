# 首页导航栏热修复

## 变更背景/目的
- 用户反馈 UniApp 首页“导航栏没出来/不可用”，优先修复可见导航能力。

## 变更文件清单
- `YiSmartCloud-member-uniapp/pages.json`
- `YiSmartCloud-member-uniapp/components/Navbar/index.vue`
- `YiSmartCloud-member-uniapp/pages/index/index.vue`

## 关键改动说明
- 在 `pages.json` 的 `globalStyle` 中增加 `navigationStyle: custom`，启用自定义导航渲染通道。
- `Navbar` 组件去除 `props.params?.name` 可选链写法，改为显式空值兜底，降低微信运行时兼容风险。
- 首页去除可选链（错误提示与电话弹窗引用），改为显式判空，避免脚本环境差异导致的渲染失败。

## 影响范围
- 前端：自定义 `nav-bar` 在首页及其他页面会按自定义导航样式渲染。
- 接口与后端：无改动。

## 验证方式
- 已执行：静态检查与代码审阅，确认导航样式配置和组件调用链一致。
- 未执行：微信开发者工具端手工刷新验证（需用户本地运行环境确认）。
