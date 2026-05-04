# 变更记录：application-druid.yml 千帆配置留空

## 目的

与 `application-example.yml` 一致，在随 `druid` profile 加载的配置中提供 `yi.qianfan` 占位且不预填密钥与模型。

## 变更文件

- [YiSmartCloud-background/YiSmartCloud-admin/src/main/resources/application-druid.yml](YiSmartCloud-background/YiSmartCloud-admin/src/main/resources/application-druid.yml)：追加 `yi.qianfan.api-key`、`yi.qianfan.model` 为空字符串。

## 验证

未执行（仅 YAML 占位）。
