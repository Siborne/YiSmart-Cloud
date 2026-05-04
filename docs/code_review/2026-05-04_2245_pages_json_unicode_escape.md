# 变更记录：member-uniapp pages.json 编译告警修复

## 背景

HBuilderX / uni 编译时对 `src/pages.json` 中 `navigationBarTitleText` 等字段的直写中文报错：“This character may get silently deleted by one or more browsers”，导致编译失败。

## 变更

- [`YiSmartCloud-member-uniapp/src/pages.json`](../../YiSmartCloud-member-uniapp/src/pages.json)：将所有相关中文标题改为 JSON `\uXXXX` 转义（语义不变，文件为 ASCII 安全子集）。
- [`YiSmartCloud-member-uniapp/README.md`](../../YiSmartCloud-member-uniapp/README.md)：补充说明与规避方式。

## 验证

- 已执行：`npm run build:mp-weixin`（通过）。
