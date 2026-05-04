# 变更记录：床位预览菜单 SQL

## 背景

侧栏「床位预览」在部分环境中缺失或为配置项遗漏；前端页面 `serve/bed/index.vue` 与接口 `serve:bed:*` 一直存在，仓库内此前无对应 `sys_menu` 初始化脚本。

## 变更

- 新增 `YiSmartCloud-background/sql/nursing_project/bed_preview_menu.sql`：在「在住管理 / enterQuit / 2018」父级下插入「床位预览」菜单（path=`bedPreview`，component=`serve/bed/index`），并补全按钮权限行（幂等 `NOT EXISTS`）。

## 验证

在目标库执行脚本后，于「角色管理」勾选 `serve:bed:*`（若尚未勾选），重新登录刷新路由。
