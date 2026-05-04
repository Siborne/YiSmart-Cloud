# 养老院介绍页返回报错修复（switchTab）

## 变更背景/目的
- 用户反馈在“养老院介绍页”返回时报错：
  - `switchTab:fail can not switch to no-tabBar page`
- 原因是项目使用自定义底部导航（`uni-footer`），并未配置原生 `tabBar`，因此 `switchTab` 不可用。

## 变更文件清单
- `YiSmartCloud-member-uniapp/components/Navbar/index.vue`

## 关键改动说明
- 导航栏返回逻辑由：
  - `navigateBack` 失败时 `switchTab('/pages/index/index')`
- 调整为：
  - `navigateBack` 失败时 `reLaunch('/pages/index/index')`
- 这样既能处理无历史栈场景，也不会触发 `no-tabBar page` 异常。

## 影响范围
- 前端：所有使用 `Navbar` 默认返回逻辑的页面。
- 交互：在无法 `navigateBack` 时稳定回首页，不再报错。
- 接口与后端：无影响。

## 验证方式
- 已执行：代码修改完成并通过静态检查。
- 未执行：微信开发者工具端手工回归“养老院介绍页 -> 返回”流程（需用户本地验证）。
