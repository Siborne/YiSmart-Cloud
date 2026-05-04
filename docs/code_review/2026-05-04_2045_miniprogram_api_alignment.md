# 变更记录：小程序接口与后端对齐

## 背景与目的

- 小程序 `baseUrl` 为 `.../member` 时，登录误请求 `/member/user/login`，而后端实际为 `/serve/member/user/login`。
- 房型接口 `MemberRoomTypeController` 使用若依 `serve:room:list` 权限，家属 JWT 在 `FamilyMemberServiceImpl` 中权限集合为空，导致方法级鉴权失败。
- 预约列表页解析分页字段与 RuoYi `TableDataInfo`（`rows`/`total`）不一致。
- 护理服务列表页使用不存在的 `pages` 字段分页。
- 订单/账单/合同/家属 IoT 等路径在后端不存在，补充占位 Controller 避免 404。

## 变更文件清单

| 文件 |
|------|
| `YiSmartCloud-background/.../MemberRoomTypeController.java` |
| `YiSmartCloud-background/.../MemberProgramStubController.java`（新增） |
| `YiSmartCloud-background/.../SecurityConfig.java` |
| `mp-weixin/utils/env.js` |
| `mp-weixin/pages/api/login.js` |
| `mp-weixin/pages/api/index.js` |
| `mp-weixin/pages/api/appointment.js` |
| `mp-weixin/pages/api/service.js` |
| `mp-weixin/pages/api/order.js` |
| `mp-weixin/pages/api/bill.js` |
| `mp-weixin/pages/api/contract.js` |
| `mp-weixin/pages/api/family.js` |
| `mp-weixin/subPages/appointment/list/index.js` |
| `mp-weixin/pages/service/index.js` |

## 关键改动说明

1. **房型**：去掉 `MemberRoomTypeController` 的 `@PreAuthorize`；Security 对 `GET /member/roomTypes` 放行，便于首页未登录展示。
2. **小程序请求根路径**：`env.js` 改为 `http://host:8080`，各 `pages/api` 使用完整前缀 `/member/...` 或 `/serve/member/user/login`。
3. **分页 UI**：预约列表改为读 `res.rows`/`res.total`；服务列表用 `total` 计算总页数。
4. **占位接口**：`MemberProgramStubController` 对历史小程序路径返回空分页或 `success()`，待业务落地后替换。

## 影响范围

- **安全**：匿名可读取启用房型列表（仅 GET `/member/roomTypes`）。
- **前端**：需重新上传/编译小程序后生效；`env.js` 中 IP 仍按环境自行修改。
- **接口**：占位接口返回空数据，相关页面无真实业务数据。

## 验证方式

- 已执行：`YiSmartCloud-nursing-platform`、`YiSmartCloud-framework` 模块 `mvn compile -DskipTests` 通过；全量 `YiSmartCloud-admin`（`-pl YiSmartCloud-admin -am`）聚合编译通过。
- 未执行：真机/开发者工具联调、微信合法域名配置；若请求经本机代理（如 `127.0.0.1:7897`）出现 502，需在开发者工具中关闭代理或为局域网地址配置直连。
