# 变更记录：ServeDashboardMapper.xml UTF-8 解析失败修复

## 背景

启动时报 `SAXParseException: Invalid byte 1 of 1-byte UTF-8 sequence`，定位到 `ServeDashboardMapper.xml` 第 8 行附近，为 MyBatis 按声明 `encoding="UTF-8"` 解析时遇到非法 UTF-8 字节（常见于文件被以非 UTF-8 保存或混入损坏字节）。

## 处理

- 重写 `ServeDashboardMapper.xml`，SQL 中固定展示类字符串改为 **ASCII 标签键**（如 `elder_pending`、`bill_main`），XML 内不再嵌入中文常量。
- 在 `ServeDashboardServiceImpl.displayDashboardLabel` 中将上述键映射回中文（Unicode 转义写入源码，避免 Java 源文件编码差异）；数据库返回的护理等级名称仍原样透传 `default` 分支。

## 变更文件

- `YiSmartCloud-nursing-platform/src/main/resources/mapper/serve/ServeDashboardMapper.xml`
- `YiSmartCloud-nursing-platform/.../ServeDashboardServiceImpl.java`

## 验证

- 已执行：`mvn -pl YiSmartCloud-nursing-platform -am compile -DskipTests`（通过）。
