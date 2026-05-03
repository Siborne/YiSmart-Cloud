# CheckInServiceImpl 编译错误修复（ObjectUtils.notEqual）

## 变更背景/目的
- `CheckInServiceImpl` 在床位状态校验处使用了 `ObjectUtils.notEqual(...)`。
- 当前 `com.baomidou.mybatisplus.core.toolkit.ObjectUtils` 不提供该方法，导致编译报错。

## 变更文件清单
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/CheckInServiceImpl.java`

## 关键改动说明
- 引入 `java.util.Objects`。
- 将：
  - `ObjectUtils.notEqual(bed.getBedStatus(), 0)`
  改为：
  - `!Objects.equals(bed.getBedStatus(), 0)`
- 保留原有业务语义：非空闲床位（状态不为 0）不可入住。

## 影响范围（接口、数据库、前端、兼容性）
- 接口：不变，仅修复服务层编译问题。
- 数据库：无影响。
- 前端：无影响。
- 兼容性：使用 JDK 标准方法，兼容性更好。

## 验证方式（已执行/未执行及原因）
- 已执行：静态检查 + IDE lint，无新增报错。
- 未执行：未启动完整后端做编译/联调验证。
