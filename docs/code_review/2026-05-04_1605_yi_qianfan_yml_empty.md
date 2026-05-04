# 变更记录：千帆示例配置留空

## 背景/目的

示例配置不预填密钥与模型名，避免仓库内出现易被误用的占位串。

## 变更文件

- [YiSmartCloud-background/YiSmartCloud-admin/src/main/resources/application-example.yml](YiSmartCloud-background/YiSmartCloud-admin/src/main/resources/application-example.yml)：`yi.qianfan.api-key`、`yi.qianfan.model` 改为空字符串。

## 说明

本地运行分析接口时，请在实际使用的 `application-*.yml` 或环境变量中填写有效 `api-key`；`model` 为空时由代码侧使用默认模型名。

## 验证

未执行（仅配置占位调整）。
