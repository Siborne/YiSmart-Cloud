# UniApp 复刻续做（页面业务化）

## 变更背景/目的
- 按“复刻续做计划”继续推进，把剩余 18 个占位页面改为可用业务页面。
- 优先保证页面可访问、可请求、可提交、可跳转，消除占位文案页面。

## 变更文件清单
- `YiSmartCloud-member-uniapp/pages/family/binding.vue`
- `YiSmartCloud-member-uniapp/pages/service/details.vue`
- `YiSmartCloud-member-uniapp/pages/service/orderVerify.vue`
- `YiSmartCloud-member-uniapp/subPages/healthy/index.vue`
- `YiSmartCloud-member-uniapp/subPages/wuDataDetail/index.vue`
- `YiSmartCloud-member-uniapp/subPages/appointment/index.vue`
- `YiSmartCloud-member-uniapp/subPages/appointment/components/PickerView.vue`
- `YiSmartCloud-member-uniapp/subPages/appointment/components/des.vue`
- `YiSmartCloud-member-uniapp/subPages/appointment/list/index.vue`
- `YiSmartCloud-member-uniapp/subPages/introduce/index.vue`
- `YiSmartCloud-member-uniapp/subPages/bill/index.vue`
- `YiSmartCloud-member-uniapp/subPages/contract/index.vue`
- `YiSmartCloud-member-uniapp/subPages/order/index.vue`
- `YiSmartCloud-member-uniapp/subPages/order/cancel.vue`
- `YiSmartCloud-member-uniapp/subPages/order/details.vue`
- `YiSmartCloud-member-uniapp/subPages/success/index.vue`
- `YiSmartCloud-member-uniapp/subPages/search/index.vue`
- `YiSmartCloud-member-uniapp/subPages/pay/index.vue`

## 关键改动说明
- 18 个页面全部替换占位实现，接入真实 API 调用或业务流程。
- 每页补齐最小可用能力：加载态、空态、基础交互（跳转/提交/取消/搜索/支付）。
- 关键业务闭环已接通：
  - 服务详情 -> 订单确认 -> 下单 -> 成功页
  - 预约创建 -> 预约记录 -> 取消预约
  - 订单列表 -> 订单详情 -> 删除/退款 -> 取消页
  - 账单列表 -> 账单详情 -> 支付 -> 成功页

## 影响范围
- 前端：`YiSmartCloud-member-uniapp` 原占位页面全部业务化。
- 后端：本轮未新增后端接口，沿用现有占位兼容 Controller。
- 接口兼容：继续使用 `/member/*` 与 `/serve/member/*` 的已对齐路径。

## 验证方式
- 已执行：
  - 文本扫描确认占位文案已清零（未再出现“该页面已完成路由迁移/该分包页面已迁移路由”）。
  - IDE lints 检查通过（本次改动文件无新增 linter 报错）。
- 未执行：
  - 微信开发者工具逐页面手工点击联调（需本地后端保持可用并实际跑流程）。
