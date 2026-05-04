# 变更背景/目的

根据最新需求，将小程序“服务列表 / 服务详情 / 下单流程”页面对齐设计稿，并补齐后端下单校验与创建占位逻辑。同时将参观预约 `countByTime` 返回语义调整为接口文档要求（只返回已占用档位，未返回表示可约满额）。

# 变更文件清单

- `YiSmartCloud-member-uniapp/pages/service/index.vue`
- `YiSmartCloud-member-uniapp/pages/service/details.vue`
- `YiSmartCloud-member-uniapp/api/service.js`
- `YiSmartCloud-member-uniapp/pages/subPages/appointment/index.vue`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/ReservationServiceImpl.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/IReservationService.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/dto/MemberOrderCreateDto.java`（新增）
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/mebber/MemberProgramStubController.java`

# 关键改动说明

- 服务列表页改为卡片双列样式：
  - 顶部搜索框支持按 `name` 检索。
  - 卡片展示 `image / name / nursingRequirement / price + unit`，样式接近需求图。
- 服务详情页改为“商品详情 + 下单表单同页”：
  - 顶部大图、名称、护理要求、价格展示。
  - 增加“服务家人”“期望服务日期”“期望服务时间”必填项。
  - 底部固定“立即购买”按钮，先调用 `/member/orders/check`，再调用 `/member/orders`。
- 前端服务 API 语义化重命名（保留旧别名兼容）：
  - `getServiceDetail / checkServiceOrder / createServiceOrder`。
- 预约时段接口前端处理按文档语义修正：
  - `countByTime` 只返回已占用档位，前端补全全量时段；未返回档位默认剩余 6。
  - 对 `count=0` 的时段提示“已约满”并禁止选择。
- 后端下单占位逻辑补齐：
  - 新增 `MemberOrderCreateDto` 校验 `projectId/familyMemberId/count/expectedServiceTime`。
  - `/member/orders/check` 返回校验后的项目、家人、金额信息。
  - `/member/orders` 返回模拟订单号与下单摘要。
  - `/member/user/my`、`/member/user/list-by-page` 返回当前登录家属（用于详情页“服务家人”选择）。
- 预约时段语义回调：
  - `ReservationServiceImpl.countByTime` 改为只返回已占用档位的剩余次数（含 0），与接口示例一致。

# 影响范围（接口、数据库、前端、兼容性）

- 前端：小程序服务模块展示和下单交互发生明显变化。
- 后端：新增下单请求 DTO，`member/orders/check` 与 `member/orders` 从空成功占位改为带业务校验返回。
- 数据库：无表结构变更，当前下单仍为占位返回（未持久化订单表）。
- 兼容性：保留原 `goodsDetail/goodsPay/goodsViseiOrder` 调用别名，不破坏已有引用。

# 验证方式（已执行/未执行及原因）

- 已执行：`ReadLints` 覆盖本次改动文件，无新增告警。
- 已执行：后端编译尝试 `mvn -pl YiSmartCloud-nursing-platform -DskipTests compile`。
- 未通过原因：仓库中存在与本次改动无关的既有错误（多个历史文件编码异常、`common.ai` 依赖缺失、`PDFUtil` 缺失），导致模块整体无法完成编译。
