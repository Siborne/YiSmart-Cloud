# 入住申请接口与请求体结构对齐修复

## 变更背景/目的
- 申请入住页面提交仍调用 `POST /serve/checkIn`（普通新增接口），导致后端按 `CheckIn` 单表插入，缺少 `elder_id` 报错。
- 需要改为调用聚合申请接口 `POST /serve/checkIn/apply`，并按 `CheckInApplyDto` 结构提交完整数据。

## 变更文件清单
- `YiSmartCloud-front/src/api/serve/checkIn.js`
- `YiSmartCloud-front/src/views/serve/checkIn/apply.vue`

## 关键改动说明
- 新增前端 API：`applyCheckIn(data)`，请求地址 `/serve/checkIn/apply`。
- 入住申请页提交流程从 `addCheckIn(payload)` 改为 `applyCheckIn(payload)`。
- 按后端 DTO 组装请求体：
  - `checkInElderDto`
  - `elderFamilyDtoList`（`relation` -> `kinship`）
  - `checkInConfigDto`（补齐 `bedId`、`nursingLevelId`、费用与期限字段）
  - `checkInContractDto`
- 床位级联选择时新增 `form.config.bedId` 回填。
- 统一日期时间格式为 `yyyy-MM-dd HH:mm:ss`（起始 00:00:00、结束 23:59:59）。

## 影响范围（接口、数据库、前端、兼容性）
- 接口：入住申请页由单表新增接口切换为聚合申请接口。
- 数据库：无结构修改，修复写入链路字段缺失问题。
- 前端：仅入住申请页提交逻辑变更，其它入住列表 CRUD 不受影响。
- 兼容性：保留原 `addCheckIn`，避免影响其它调用方。

## 验证方式（已执行/未执行及原因）
- 已执行：静态检查 + lints，确认编译无报错。
- 未执行：未实际联调后端接口，建议提交一笔入住申请验证 `elder_id`、`bed_id`、`nursing_level_id` 入库。
