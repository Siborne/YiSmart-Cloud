-- ???????? levelMenu.sql ?? parent ?????????? parent_id?
-- ???????????????????????????

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('????', '2018', '1', 'assessment', 'serve/assessment/index', NULL, '', 1, 0, 'C', '0', '0', 'serve:assessment:list', '#', 'admin', sysdate(), '', NULL, '????');

SELECT @parentId := LAST_INSERT_ID();

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('??????', @parentId, '1', '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:assessment:query', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('??????', @parentId, '2', '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:assessment:add', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('??????', @parentId, '3', '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:assessment:edit', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('??????', @parentId, '4', '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:assessment:remove', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('??????', @parentId, '5', '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:assessment:export', '#', 'admin', sysdate(), '', NULL, '');
