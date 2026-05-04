# 变更记录：在住管理下床位/房型/楼层菜单规范化 SQL

## 背景

菜单管理中出现与预期不一致的配置：**智能床位**组件路径为空导致无法打开页面；**床位预览**可能被设为目录类型；与「房型设置」「楼层管理」在同一父级下需统一为 RuoYi 的 **C 菜单 + component** 模式。

## 变更文件

- `YiSmartCloud-background/sql/nursing_project/bed_menu_normalize_in_stay.sql`（新增）
- `YiSmartCloud-background/sql/nursing_project/bed_preview_menu.sql`（注释补充指向 normalize 脚本）

## 使用说明

在业务库执行 `bed_menu_normalize_in_stay.sql` 后：**重新登录**或清菜单缓存；检查角色是否具备 `serve:bed:*`、`serve:room:*`、`serve:floor:*`。若不需要两个床位入口，可按脚本末尾注释隐藏「智能床位」。

## 验证

菜单管理中「床位预览」「智能床位」的组件路径均为 `serve/bed/index`，类型为菜单；侧栏点击可进入床位看板并加载列表接口。
