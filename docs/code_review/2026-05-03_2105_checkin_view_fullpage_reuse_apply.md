# 入住「查看」改为全页复用申请表单（只读）

## 变更背景/目的

用户希望查看入口与「发起入住申请」使用同一套页面布局回显数据，且不可编辑，而不是列表上的弹窗。

## 变更文件清单

- `YiSmartCloud-front/src/router/index.js`：新增隐藏路由 `/serve/checkIn-view/index/:id`，`name: CheckInView`，权限 `serve:checkIn:query`，复用 `apply.vue`。
- `YiSmartCloud-front/src/views/serve/checkIn/apply.vue`：根据 `route.name === 'CheckInView'` 进入查看模式；`getCheckInDetail` 回填表单；`el-form` 整体 `disabled`；隐藏家属「操作」列、隐藏提交/费用预览；床位用只读文本；合同区查看模式下仅展示下载链接。
- `YiSmartCloud-front/src/views/serve/checkIn/index.vue`：移除详情弹窗及相关逻辑；「查看」改为 `router.push({ name: 'CheckInView', params: { id } })`。

## 关键改动说明

- 申请页与查看页共用一个组件，通过路由名区分模式，避免维护两套 UI。  
- `watch` 监听 `route.name` 与 `route.params.id`，支持同组件内切换不同入住记录。  
- 查看模式不加载床位级联数据（床位以 `checkInConfigVo.bedNumber` 文本展示）。

## 影响范围

- 前端路由与入住列表、申请页交互；需具备 `serve:checkIn:query` 才能访问查看页。  
- 后端仍使用既有 `GET /serve/checkIn/detail/{id}`，无接口变更。

## 验证方式

- 未执行自动化测试；浏览器从列表点「查看」应进入全屏布局页，字段只读，仅「返回」可用。
