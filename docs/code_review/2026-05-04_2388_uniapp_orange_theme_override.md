# UniApp 蓝色主题改橙色主题方案

## 变更背景/目的
- 用户要求 UniApp 端默认蓝色主题统一替换为当前橙色主题，并希望采用更易维护的覆盖方式。

## 变更文件清单
- `YiSmartCloud-member-uniapp/uni.scss`
- `YiSmartCloud-member-uniapp/App.vue`
- `YiSmartCloud-member-uniapp/components/Foot/index.vue`
- `YiSmartCloud-member-uniapp/pages/**`、`subPages/**` 中涉及按钮主色样式的页面（批量替换）

## 关键改动说明
- 采用“双层覆盖”方案：
  1. **UniApp 组件变量层**：`uni.scss` 中 `$uni-color-primary` 从 `#007aff` 改为 `#ff8455`，覆盖官方/插件默认主色。
  2. **业务样式层**：在 `App.vue` 的 `page` 作用域定义主题变量：
     - `--ys-primary: #ff8455`
     - `--ys-primary-dark: #ff7447`
     - `--ys-primary-light: #ffb08f`
     并将项目内原 `#2f80ff` 按钮/文本主色替换为 `var(--ys-primary)`。
- 底部导航激活色改为主题变量引用，避免再次硬编码。

## 影响范围
- 前端视觉：登录、订单、预约、支付、咨询按钮等原蓝色主色统一为橙色。
- 可维护性：后续仅需修改 `App.vue` 变量与 `uni.scss` 主色即可整站换色。
- 接口与后端：无改动。

## 验证方式
- 已执行：
  - 文本批量替换后静态检查。
  - lints 检查通过，无新增报错。
- 未执行：
  - 微信开发者工具全页面人工回归（建议重点看按钮、激活态、描边按钮）。
