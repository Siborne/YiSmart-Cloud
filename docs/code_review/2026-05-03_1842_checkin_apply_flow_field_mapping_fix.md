# 入住申请流程字段映射与更新逻辑修复

## 变更背景/目的
- `CheckInServiceImpl` 的入住申请流程中存在多处字段名与当前领域模型不一致（如 `idCardNo`/`bedNumber`），并且使用了错误的 Mapper 变量，导致逻辑不稳定甚至编译风险。
- 目标是修正入住申请主链路，保证床位占用、老人信息更新、入住记录落库可正确执行。

## 变更文件清单
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/CheckInServiceImpl.java`

## 关键改动说明
- 修正老人查询字段：`ElderInfo::getIdCard` 对应 `checkInElderDto.idCardNo`。
- 将错误引用的 `elderMapper` 统一改为 `elderInfoMapper`。
- 修正 DTO 访问器：`getCheckInElderInfoDto()` -> `getCheckInElderDto()`。
- 增加床位有效性校验：
  - 床位不存在时报错；
  - 非空闲状态时报错（仅允许 `bedStatus=0` 入住）。
- 修正入住记录床位号来源：使用 `bed.getBedNo()` 写入 `checkIn.bedNumber`。
- 修正老人信息写入：
  - 显式映射 `name/idCard/age/gender/contactPhone`；
  - 性别值按现有字典做转换；
  - 更新场景补齐 `id` 后再 `updateById`，避免更新失败。
- 简化方法签名，去掉未使用的 `insertOrUpdate` 床位参数，并将 `insertCheckIn` 显式传入 `Bed`。

## 影响范围（接口、数据库、前端、兼容性）
- 接口：影响 `/serve/checkIn/apply` 的后端入库逻辑。
- 数据库：无结构变更，仅修正写入字段和值映射。
- 前端：接口契约不变，现有提交参数可继续使用。
- 兼容性：修复后与当前 `ElderInfo/Bed/CheckIn` 领域字段保持一致。

## 验证方式（已执行/未执行及原因）
- 已执行：静态代码核对（字段映射、方法调用链、对象写入路径）。
- 未执行：未在本地完整运行后端做接口联调，建议执行 `/serve/checkIn/apply` 冒烟验证。
