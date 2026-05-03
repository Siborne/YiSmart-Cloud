# 入住详情接口 detail 实现

## 变更背景/目的
- `CheckInServiceImpl#detail(Long id)` 之前返回 `null`，导致入住详情接口无有效数据。
- 补全详情聚合逻辑，返回老人信息、家属信息、入住配置和签约信息。

## 变更文件清单
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/CheckInServiceImpl.java`

## 关键改动说明
- 按 `id` 查询入住记录，不存在时抛出 `BaseException("入住记录不存在")`。
- 组装 `CheckInElderVo`：
  - 从 `elder_info` 查询老人信息
  - 映射 `id/name/idCardNo/age/phone`
  - 将 `elder_info.gender(1男/2女)` 转为详情 VO `sex(0男/1女)`。
- 组装 `CheckInConfigVo`：
  - 使用入住记录中的 `startDate/endDate/bedNumber`。
- 组装家属列表：
  - 从 `check_in.remark` 反序列化为 `List<ElderFamilyVo>`
  - remark 为空或解析空时返回空列表。
- 组装合同：
  - 按 `elderId` 查询合同，按 `id` 倒序取最近一条（`limit 1`）。

## 影响范围（接口、数据库、前端、兼容性）
- 接口：`GET /serve/checkIn/detail/{id}` 现在返回完整业务数据。
- 数据库：无结构变化，仅聚合读取已有表数据。
- 前端：详情页可直接消费 `CheckInDetailVo`，避免空响应。
- 兼容性：保持原接口路径与响应模型不变，仅补全数据内容。

## 验证方式（已执行/未执行及原因）
- 已执行：静态检查与 lints，确认实现逻辑可编译且无新增诊断。
- 未执行：未在运行环境调用接口联调，建议以真实 `checkInId` 做接口验证。
