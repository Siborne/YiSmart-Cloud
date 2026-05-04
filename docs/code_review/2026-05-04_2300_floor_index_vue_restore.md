# 楼层管理页恢复（floor/index.vue 清空后重写）

## 变更背景/目的

用户清空 `YiSmartCloud-front/src/views/serve/floor/index.vue` 后需恢复完整页面：查询、分页列表、新增/修改弹窗、删除与导出，界面文案为中文且与项目内其他 serve 列表页风格一致。

## 变更文件清单

- `YiSmartCloud-front/src/views/serve/floor/index.vue`

## 关键改动说明

- 重新写入完整 `<template>` / `<script setup>`：沿用 `@/api/serve/floor` 的 `listFloor`、`getFloor`、`addFloor`、`updateFloor`、`delFloor`。
- 字典 `room_status` 用于状态列与表单单选。
- 查询条件：`floorNo`、`floorName`；提交时对数值字段做 `Number` 转换。

## 影响范围

- **前端**：仅楼层管理页；权限标识仍为 `serve:floor:*`。
- **后端 / 数据库**：无。

## 验证方式

- **未执行**：未本地跑 `npm run dev`；建议在「楼层管理」打开页面验证列表与弹窗。
