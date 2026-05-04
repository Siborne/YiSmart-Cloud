# 变更记录：健康评估列表「上传体检报告」双加号修复

## 背景/目的

按钮同时使用 `el-button` 的 `icon="Plus"` 与文案前缀「+」，界面出现两个加号。

## 变更文件清单

- `YiSmartCloud-front/src/views/serve/assessment/index.vue`

## 关键改动说明

- 去掉按钮文案中的「+」，保留 `icon="Plus"`，与 Element Plus 行为一致。

## 影响范围

- 仅健康评估列表页该按钮展示；无接口与权限变更。

## 验证方式

- 未执行自动化测试；建议在页面确认按钮仅显示一个加号图标。
