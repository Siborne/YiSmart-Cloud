# 变更记录：楼层页中文、健康评估跳转、楼层菜单、小程序登录

## 背景与目的

1. 楼层管理页模板中文变为 `???`（文件编码/内容损坏），需恢复 UTF-8 中文。
2. 侧边栏出现两个「楼层管理」：库内重复插入；用户希望挂在「在住管理」目录下。
3. 从健康评估详情跳转入住办理时请求 `/serve/assessment/undefined`：路由切换后详情页仍监听 `route.params.id`，在非详情路由上触发 `load()`。
4. 微信小程序登录按钮无反应：`getPhoneNumber` 回调中误用 `e.target.errMsg`，条件恒不成立，且依赖已废弃的 `getUserInfo`。

## 变更文件清单

| 文件 | 说明 |
|------|------|
| `YiSmartCloud-front/src/views/serve/floor/index.vue` | 全量恢复中文标签、校验文案、按钮与 `el-radio` |
| `YiSmartCloud-front/src/views/serve/assessment/detail.vue` | 校验路由名与合法 id；`watch` 增加 `immediate`，去掉重复 `onMounted` 中的 `load` |
| `YiSmartCloud-background/sql/nursing_project/floor_menu.sql` | 父级优先 `在住管理`，其次 `enterQuit`，再 2018 |
| `YiSmartCloud-background/sql/nursing_project/floor_menu_move_under_enterQuit.sql` | 同步按「在住管理」优先迁移父级 |
| `YiSmartCloud-background/sql/nursing_project/floor_menu_dedupe.sql` | 新增：去重楼层 C 菜单及多余按钮 |
| `mp-weixin/pages/login/index.js` | 修正手机号授权判断与登录链式调用，去掉无效 `e.target` 与 `getUserInfo` |

## 影响范围

- 前端：楼层页展示；健康评估详情与入住申请切换时的接口调用。
- 数据库：仅当在库中执行提供的 SQL 时影响 `sys_menu`。
- 小程序：登录页授权流程。

## 验证方式

- 浏览器打开楼层管理：表头与按钮为中文；保存文件为 UTF-8。
- 健康评估详情 → 办理入住：不应再出现 `assessment/undefined` 请求。
- 在库中按需执行 `floor_menu_dedupe.sql` 与 `floor_menu_move_under_enterQuit.sql` 后重新登录，检查侧栏仅一条楼层且父级正确。
- 真机小程序：点击「微信快速登录」应发起 `wx.login` 与后端 `/serve/member/user/login`。
