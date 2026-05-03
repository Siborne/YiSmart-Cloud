# 入住申请/详情「返回」与提交后跳转路径调整

## 变更背景/目的

申请页、查看页点击「返回」及申请提交成功后，应回到实际菜单地址 `http://localhost/enterQuit/checkIn`（path：`/enterQuit/checkIn`），而非 `/serve/checkIn`。

## 变更文件清单

- `YiSmartCloud-front/src/views/serve/checkIn/apply.vue`：统一常量 `CHECK_IN_LIST_PATH`，`goBack` 与提交成功 `closeOpenPage` 使用该 path。
- `YiSmartCloud-front/src/router/index.js`：`CheckInApply`、`CheckInView` 的 `meta.activeMenu` 改为 `/enterQuit/checkIn`，侧栏高亮与列表一致。

## 影响范围

- 仅入住申请/详情页的返回与提交后关闭页签跳转；依赖若依 `proxy.$tab.closeOpenPage`。

## 验证方式

- 未执行自动化测试；在本地从 `/enterQuit/checkIn` 进入申请或查看，点返回或提交成功，应回到 `/enterQuit/checkIn`。
