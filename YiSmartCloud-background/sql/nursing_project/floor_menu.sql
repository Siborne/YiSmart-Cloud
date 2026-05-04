-- 楼层管理菜单：优先挂在「在住管理」目录（menu_name = 在住管理 且 menu_type = M）
-- 其次 path = enterQuit 的目录；再回退 menu_id = 2018（与 levelMenu.sql 等一致，可按实际库调整）
-- 执行后请在「角色管理」中为相关角色勾选本菜单及按钮权限

SET @floor_parent_id := COALESCE(
  (SELECT menu_id FROM sys_menu WHERE menu_name = '在住管理' AND menu_type = 'M' ORDER BY menu_id LIMIT 1),
  (SELECT menu_id FROM sys_menu WHERE path = 'enterQuit' AND menu_type = 'M' ORDER BY menu_id LIMIT 1),
  (SELECT menu_id FROM sys_menu WHERE menu_id = 2018 LIMIT 1)
);

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('楼层管理', @floor_parent_id, 8, 'floor', 'serve/floor/index', NULL, 'ServeFloor', 1, 0, 'C', '0', '0', 'serve:floor:list', 'build', 'admin', sysdate(), '', NULL, '楼层管理菜单');

SELECT @parentId := LAST_INSERT_ID();

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('楼层查询', @parentId, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:query', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('楼层新增', @parentId, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:add', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('楼层修改', @parentId, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:edit', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('楼层删除', @parentId, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:remove', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('楼层导出', @parentId, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:export', '#', 'admin', sysdate(), '', NULL, '');
