# UniApp 分包目录调整为 pages/subPages

## 变更背景/目的
- 用户反馈 `subPages` 直接放在根目录不符合预期，要求按 UniApp 常规 page 目录实践放入 `pages` 体系。
- 将分包页面目录调整为 `pages/subPages`，避免页面组织与路由认知偏差。

## 变更文件清单
- `YiSmartCloud-member-uniapp/pages.json`
- `YiSmartCloud-member-uniapp/components/Navbar/index.vue`
- `YiSmartCloud-member-uniapp/pages/my/index.vue`
- `YiSmartCloud-member-uniapp/pages/service/orderVerify.vue`
- `YiSmartCloud-member-uniapp/pages/subPages/**`（新增 15 个分包页面文件）

## 关键改动说明
- `pages.json` 中 `subPackages.root` 从 `subPages` 改为 `pages/subPages`。
- 在 `pages/subPages` 下新增完整分包页面文件（appointment/bill/contract/order/pay/search/success/healthy/wuDataDetail/introduce）。
- 更新页面跳转路径到新分包目录前缀：
  - `/subPages/...` -> `/pages/subPages/...`
- 保留原 `subPages` 目录文件，作为临时兼容参考；运行路由已切换到 `pages/subPages`。

## 影响范围
- 前端路由：分包路径统一改为 `pages/subPages/*`。
- 前端导航：Navbar 搜索跳转、我的页面入口、下单成功跳转已同步到新路径。
- 后端接口：无改动。

## 验证方式
- 已执行：
  - 路由存在性校验：`pages.json` 全部主包/分包路径均可映射到对应 `.vue`（missing=0）。
  - lints 校验：本轮改动文件无新增 linter 报错。
- 未执行：
  - 微信开发者工具手工点击回归（需用户本机实时验证界面与导航）。
