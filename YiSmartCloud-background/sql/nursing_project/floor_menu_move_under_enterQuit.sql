-- 将「楼层管理」菜单挂到「在住管理」目录下（无则回退到 path=enterQuit 的 M 目录）
-- 用于修正父级或合并重复菜单前的迁移；执行后请重新登录

UPDATE sys_menu c
INNER JOIN (
  SELECT menu_id FROM sys_menu
  WHERE menu_type = 'M'
    AND (menu_name = '在住管理' OR path = 'enterQuit')
  ORDER BY CASE WHEN menu_name = '在住管理' THEN 0 ELSE 1 END, menu_id ASC
  LIMIT 1
) p
SET c.parent_id = p.menu_id
WHERE c.perms = 'serve:floor:list'
  AND c.menu_type = 'C';
