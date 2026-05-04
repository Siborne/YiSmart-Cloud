# 变更背景/目的

补齐预约参观/预约探访在后端、管理端、用户端三端链路，并修复用户端“热门房型（床位可预约）查到不展示”的问题。

# 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/dto/ReservationCreateDto.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/IReservationService.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/ReservationServiceImpl.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/mebber/MemberRoomTypeController.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/IRoomService.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/RoomServiceImpl.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/mapper/RoomMapper.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/resources/mapper/serve/RoomMapper.xml`
- `YiSmartCloud-member-uniapp/api/appointment.js`
- `YiSmartCloud-member-uniapp/api/index.js`
- `YiSmartCloud-member-uniapp/pages/index/index.vue`
- `YiSmartCloud-member-uniapp/pages/subPages/appointment/index.vue`
- `YiSmartCloud-member-uniapp/pages/subPages/appointment/list/index.vue`
- `YiSmartCloud-front/src/views/serve/record/index.vue`
- `YiSmartCloud-front/src/views/serve/bed/index.vue`

# 关键改动说明

- 预约后端能力增强：
  - `countByTime` 改为“可预约视角”返回：基于合法时间档位生成可选时段，仅返回仍可预约的时段与剩余名额（不再只返回已有预约时段）。
  - 预约创建 DTO 增加 `remark` 并落库，支持前端备注提交。
- 用户端预约链路补齐：
  - 首页“参观预约/探访预约”入口按 `type` 分流跳转。
  - 预约页按后端契约提交 `type/time/mobile/name/visitor/remark`，并按所选日期实时拉取时段。
  - 预约记录页按后端真实字段展示时间、类型、状态、姓名手机号，且仅待报道可取消。
- 用户端热门房型展示修复：
  - 前端字段映射从 `name/desc` 修正为 `roomNo/roomType/roomDesc/bedFee` 的兼容展示。
  - 调用 `/member/room` 时附带 `availableOnly=true`，仅展示存在空闲床位的房间。
- 房型后端过滤能力补齐：
  - `MemberRoomTypeController` 增加 `availableOnly` 可选参数。
  - `RoomService` 与 `RoomMapper` 增加“仅空闲床位房间”查询（`room` JOIN `bed` 且 `bed_status=0`、`is_deleted=0`）。
- 管理端可用性修复：
  - 访客预约页补充“审批状态”查询与编辑项，修复状态必填但无输入控件的问题。
  - 表格状态改为可读文案映射。
  - 床位页新增“仅可预约/全部床位”视图切换，默认仅可预约。

# 影响范围（接口、数据库、前端、兼容性）

- 接口：
  - 会员房间查询接口新增参数：`GET /member/room?availableOnly=true`（向后兼容，不传保持原行为）。
  - 预约创建接口参数扩展 `remark`（可选，兼容旧调用）。
- 数据库：无表结构变更，仅使用既有字段（含 `reservation.remark`、`bed_status`）。
- 前端：
  - 管理端预约与床位页面交互增强。
  - 用户端预约与热门房型渲染逻辑调整。
- 兼容性：
  - 原接口路径不变，新增参数均为可选，兼容旧客户端。

# 验证方式（已执行/未执行及原因）

- 已执行：
  - `ReadLints` 检查本次改动文件，无新增前端 lint 报错。
  - 关键引用扫描，确认预约与房型新方法调用链完整。
- 已执行但失败（非本次改动引入）：
  - `mvn -pl YiSmartCloud-nursing-platform -am -DskipTests compile`。
  - 失败原因位于未修改文件 `YiSmartCloud-framework/src/main/java/.../MemberInterceptor.java`：编码异常与 `Constants.HEADER` 符号缺失，导致框架模块先失败，`nursing-platform` 未进入编译。
- 未执行：
  - 微信小程序端与管理端实际页面点击联调（当前会话未启动前后端运行环境）。
