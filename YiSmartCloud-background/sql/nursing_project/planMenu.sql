-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理计划', '2000', '1', 'plan', 'serve/plan/index', 1, 0, 'C', '0', '0', 'serve:plan:list', '#', 'admin', sysdate(), '', null, '护理计划菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理计划查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'serve:plan:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理计划新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'serve:plan:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理计划修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'serve:plan:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理计划删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'serve:plan:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('护理计划导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'serve:plan:export',       '#', 'admin', sysdate(), '', null, '');