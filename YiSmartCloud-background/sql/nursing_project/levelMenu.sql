-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理等级', '2000', '1', 'level', 'serve/level/index', 1, 0, 'C', '0', '0', 'serve:level:list', '#', 'admin', sysdate(), '', null, '护理等级菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理等级查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'serve:level:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理等级新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'serve:level:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理等级修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'serve:level:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理等级删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'serve:level:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理等级导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'serve:level:export',       '#', 'admin', sysdate(), '', null, '');