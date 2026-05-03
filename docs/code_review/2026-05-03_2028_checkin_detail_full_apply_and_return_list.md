# 入住「查看」对齐申请页内容，申请完成后回到列表

## 变更背景/目的

1. 列表「查看」应展示与「发起入住申请」页相同维度的信息（基本信息、家属、入住配置、签约），而非仅 `check_in` 扁平字段。  
2. 申请提交成功及点击「返回」时应回到入住办理列表页，并关闭当前申请页签，避免标签栏堆积。

## 变更文件清单

- `YiSmartCloud-front/src/api/serve/checkIn.js`：新增 `getCheckInDetail`（`GET /serve/checkIn/detail/{id}`）。
- `YiSmartCloud-front/src/views/serve/checkIn/index.vue`：查看改为拉取聚合详情；弹窗分四段展示；图片与合同附件链接处理。
- `YiSmartCloud-front/src/views/serve/checkIn/apply.vue`：`goBack` 与提交成功使用 `proxy.$tab.closeOpenPage` 跳转 `/serve/checkIn`。
- `YiSmartCloud-background/.../CheckInController.java`：`/apply` 增加 `@PreAuthorize`、`@Log`；`/detail/{id}` 增加 `@PreAuthorize('serve:checkIn:query')`。
- `YiSmartCloud-background/.../CheckInConfigVo.java`：扩展费用、护理等级、费用期限等字段供详情返回。
- `YiSmartCloud-background/.../CheckInServiceImpl.java`：详情合并 `check_in_config`；老人 VO 性别映射修正；详情回显扩展档案字段；申请保存老人时写入扩展字段。
- `YiSmartCloud-background/.../domain/ElderInfo.java`：出生日期、住址、证件照等字段。
- `YiSmartCloud-background/.../mapper/serve/ElderInfoMapper.xml`：列与增删改映射同步。
- `YiSmartCloud-background/sql/nursing_project/elder_info_extend_apply_fields.sql`：为 `elder_info` 增加上述列（**需在目标库执行一次**）。

## 关键改动说明

- 详情接口仍返回 `CheckInDetailVo`，其中 `checkInConfigVo` 优先来自 `check_in_config` 表，缺失时回退 `check_in` 的起止时间与床位。  
- 老人扩展信息（与申请表单一致）通过 `elder_info` 新列持久化，详情从 `ElderInfo` 映射到 `CheckInElderVo`（含 `image` 与两证图片）。  
- 家属列表仍来自 `check_in.remark` 中 JSON；合同为当前老人最新一条合同记录（与原有逻辑一致）。

## 影响范围

- **数据库**：未执行脚本前，包含新列的 `SELECT` 会报错；上线前需执行 `elder_info_extend_apply_fields.sql`。  
- **权限**：`/serve/checkIn/apply` 现要求 `serve:checkIn:add`；详情要求 `serve:checkIn:query`，与列表「查看」按钮一致。  
- **前端**：申请页依赖 `proxy.$tab`（若依标签页），与现有 `authRole` 等页一致。

## 验证方式

- 已执行：`mvn -pl YiSmartCloud-nursing-platform -am compile -DskipTests` 通过。  
- 未执行：联调需在执行 DDL 后验证申请保存与详情回显；浏览器验证提交后关闭申请页并打开列表。
