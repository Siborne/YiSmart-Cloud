# 变更记录：serve 模块 Controller / ServiceImpl 构造器注入

## 变更背景/目的

将 `YiSmartCloud-nursing-platform` 下 `serve.controller` 与 `serve.service.impl` 中依赖注入方式由字段 `@Autowired` 统一改为 **Lombok `@RequiredArgsConstructor` + `private final` 字段**，符合不可变依赖与显式构造注入的惯例。

## 变更文件清单

- `serve/service/impl/*ServiceImpl.java`（所有原先使用 `@Autowired` 的实现类，含 `CheckInServiceImpl` 依赖字段归并）
- `serve/controller/*Controller.java`（所有原先使用 `@Autowired` 的控制器）

## 关键改动说明

- 移除 `org.springframework.beans.factory.annotation.Autowired` 的字段注入。
- 增加 `lombok.RequiredArgsConstructor`，将注入依赖改为 `private final` 成员；Lombok 生成包含上述成员的构造器，由 Spring 构造器注入。
- `CheckInServiceImpl`：原先混用 `@AllArgsConstructor`、分散的 `@Autowired` 与 `final` 字段，已改为单一 `@RequiredArgsConstructor`，并在类首集中声明全部 `Mapper` 依赖。

## 影响范围

- **接口**：无 URL、入参、出参变更。
- **数据库**：无。
- **前端**：无。
- **兼容性**：与 Spring 对单构造器 Bean 的注入行为一致；`mvn -pl YiSmartCloud-nursing-platform -am compile` 已通过。

## 验证方式

- 已执行：`mvn -q -pl YiSmartCloud-nursing-platform -am compile -DskipTests`（成功，exit 0）。
- 未执行：完整集成测试 / 手工联调（本地未跑应用进程）。
