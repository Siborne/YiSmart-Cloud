-- Health assessment menu (same parent pattern as levelMenu.sql; adjust parent_id if your tree differs)
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('½¡¿µÆÀ¹À', '2018', '1', 'assessment', 'serve/assessment/index', 1, 0, 'C', '0', '0', 'serve:assessment:list', '#', 'admin', sysdate(), '', null, '½¡¿µÆÀ¹À');

SELECT @parentId := LAST_INSERT_ID();

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('½¡¿µÆÀ¹À²éÑ¯', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'serve:assessment:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('½¡¿µÆÀ¹ÀÐÂÔö', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'serve:assessment:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('½¡¿µÆÀ¹ÀÐÞ¸Ä', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'serve:assessment:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('½¡¿µÆÀ¹ÀÉ¾³ý', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'serve:assessment:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('½¡¿µÆÀ¹Àµ¼³ö', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'serve:assessment:export',       '#', 'admin', sysdate(), '', null, '');
