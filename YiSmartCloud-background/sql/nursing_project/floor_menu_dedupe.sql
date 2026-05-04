-- 删除重复的「楼层管理」菜单（保留 menu_id 最小的一条及其按钮，删除其余 C 菜单及其子按钮）
-- 执行前请备份 sys_menu；执行后重新登录并在「角色管理」中检查权限是否仍勾选

SET @keep_floor_menu_id := (
  SELECT MIN(menu_id) FROM sys_menu WHERE perms = 'serve:floor:list' AND menu_type = 'C'
);

DELETE FROM sys_menu
WHERE @keep_floor_menu_id IS NOT NULL
  AND menu_type = 'F'
  AND parent_id IN (
    SELECT menu_id FROM (
      SELECT menu_id FROM sys_menu
      WHERE perms = 'serve:floor:list' AND menu_type = 'C' AND menu_id <> @keep_floor_menu_id
    ) t
  );

DELETE FROM sys_menu
WHERE @keep_floor_menu_id IS NOT NULL
  AND perms = 'serve:floor:list'
  AND menu_type = 'C'
  AND menu_id <> @keep_floor_menu_id;
