-- 「床位预览」菜单：与楼层管理相同父级解析（在住管理 → enterQuit → 2018）
-- 对应前端页面：src/views/serve/bed/index.vue（component 必须为 serve/bed/index）
-- 若菜单管理里「智能床位」无组件或类型不对，请执行 bed_menu_normalize_in_stay.sql 一次性修正
-- 权限与 BedController 一致：serve:bed:list 等；若角色侧栏可见但灰，请在「角色管理」勾选 serve:bed:* 权限
-- 若库中已有同名或同 path 菜单，请先菜单管理删除重复项再执行，或改为 INSERT ... SELECT ... WHERE NOT EXISTS

SET @bed_parent_id := COALESCE(
  (SELECT menu_id FROM sys_menu WHERE menu_name = '在住管理' AND menu_type = 'M' ORDER BY menu_id LIMIT 1),
  (SELECT menu_id FROM sys_menu WHERE path = 'enterQuit' AND menu_type = 'M' ORDER BY menu_id LIMIT 1),
  (SELECT menu_id FROM sys_menu WHERE menu_id = 2018 LIMIT 1)
);

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT '床位预览', @bed_parent_id, 3, 'bedPreview', 'serve/bed/index', NULL, 'ServeBedPreview', 1, 0, 'C', '0', '0', 'serve:bed:list', 'nested', 'admin', sysdate(), '', NULL, '床位预览（房间-床位看板）'
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_type = 'C' AND (menu_name = '床位预览' OR path = 'bedPreview'));

SELECT @bedMenuId := (SELECT menu_id FROM sys_menu WHERE menu_type = 'C' AND menu_name = '床位预览' ORDER BY menu_id DESC LIMIT 1);

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT '床位查询', @bedMenuId, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:query', '#', 'admin', sysdate(), '', NULL, ''
FROM DUAL WHERE @bedMenuId IS NOT NULL AND NOT EXISTS (SELECT 1 FROM sys_menu WHERE parent_id = @bedMenuId AND perms = 'serve:bed:query');

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT '床位新增', @bedMenuId, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:add', '#', 'admin', sysdate(), '', NULL, ''
FROM DUAL WHERE @bedMenuId IS NOT NULL AND NOT EXISTS (SELECT 1 FROM sys_menu WHERE parent_id = @bedMenuId AND perms = 'serve:bed:add');

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT '床位修改', @bedMenuId, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:edit', '#', 'admin', sysdate(), '', NULL, ''
FROM DUAL WHERE @bedMenuId IS NOT NULL AND NOT EXISTS (SELECT 1 FROM sys_menu WHERE parent_id = @bedMenuId AND perms = 'serve:bed:edit');

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT '床位删除', @bedMenuId, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:remove', '#', 'admin', sysdate(), '', NULL, ''
FROM DUAL WHERE @bedMenuId IS NOT NULL AND NOT EXISTS (SELECT 1 FROM sys_menu WHERE parent_id = @bedMenuId AND perms = 'serve:bed:remove');

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT '床位导出', @bedMenuId, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:export', '#', 'admin', sysdate(), '', NULL, ''
FROM DUAL WHERE @bedMenuId IS NOT NULL AND NOT EXISTS (SELECT 1 FROM sys_menu WHERE parent_id = @bedMenuId AND perms = 'serve:bed:export');
