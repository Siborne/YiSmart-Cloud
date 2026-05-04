# 代码变更记录：小程序护理项目只读接口 + 预约管理 + 自动过期

## 变更背景/目的

- 按作业要求实现小程序端护理项目分页/详情接口（`/member/orders/project/...`）。
- 实现参观/探访预约完整接口（取消次数限制、时间段容量、分页、取消、自动过期）。
- 使用 Spring `@Scheduled` 在每小时的第 1、31 分钟将已过预约时间且仍为「待报道」的记录置为「过期」。

## 变更文件清单

| 路径 | 说明 |
|------|------|
| `YiSmartCloud-background/sql/nursing_project/reservation.sql` | 新建 `reservation` 表 DDL |
| `YiSmartCloud-background/.../serve/constant/ReservationConstants.java` | 类型/状态/时间段/容量常量 |
| `YiSmartCloud-background/.../serve/domain/Reservation.java` | 预约实体 |
| `YiSmartCloud-background/.../serve/mapper/ReservationMapper.java` | Mapper 接口 |
| `YiSmartCloud-background/.../resources/mapper/serve/ReservationMapper.xml` | 自定义 SQL |
| `YiSmartCloud-background/.../serve/service/IReservationService.java` | 预约 Service 接口 |
| `YiSmartCloud-background/.../serve/service/impl/ReservationServiceImpl.java` | 预约业务实现 |
| `YiSmartCloud-background/.../serve/dto/ReservationCreateDto.java` | 新增预约入参 |
| `YiSmartCloud-background/.../serve/vo/TimeSlotCountVo.java` | 时间段剩余次数 VO |
| `YiSmartCloud-background/.../serve/vo/ReservationSlotOccupancyRow.java` | Mapper 统计行 |
| `YiSmartCloud-background/.../serve/controller/mebber/MemberNursingProjectController.java` | 小程序护理项目只读 |
| `YiSmartCloud-background/.../serve/controller/mebber/ReservationController.java` | 小程序预约 5 个接口 |
| `YiSmartCloud-background/.../serve/task/ReservationExpireTask.java` | 定时过期任务 |

## 关键改动说明

1. **护理项目**：复用 `INursingProjectService`，`/member/orders/project/page` 未传 `status` 时默认 `1`（仅启用）。
2. **预约时间段**：每日 08:00–17:30，步长 30 分钟，每档容量 6；`countByTime` 仅返回已有预约的时间段及剩余次数。
3. **当日取消限制**：`create_by` 为当前登录家属 ID（`SecurityUtils.getUserId()`），当日 `status=2` 且 `DATE(update_time)=当天` 的次数 **大于 3** 则禁止新建预约。
4. **唯一约束**：`(mobile, time)`；冲突时返回业务提示「该手机号在此时间段已有预约」。
5. **DDL 调整**：`create_by`/`update_by` 使用 `varchar(64)`，与 `BaseEntity` 及 `MyMetaObjectHandler` 的 String 填充一致。

## 影响范围

- **接口**：新增 `/member/orders/project/page`、`/member/orders/project/{id}`；`/member/reservation/*` 全套；需小程序携带 JWT。
- **数据库**：需执行 `reservation.sql` 建表。
- **定时任务**：依赖 `YiSmartCloudApplication` 上已有的 `@EnableScheduling`。
- **前端**：未改 Vue 管理端；小程序需自行对接新路径。

## 验证方式

- 已在本地执行：`mvn -pl YiSmartCloud-nursing-platform,YiSmartCloud-admin -am compile`（通过）。
- 未执行集成测试（无现成小程序端到端环境）；上线前建议在库中执行 DDL 后用手动 HTTP 或 Knife4j 验证分页、预约、取消与定时任务日志。
