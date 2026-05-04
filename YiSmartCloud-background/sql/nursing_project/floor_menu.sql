-- 楼层管理独立菜单（父级 2018 为颐养业务目录，若环境不同请改 parent_id）
-- 执行后需在「角色管理」中为相关角色勾选本菜单及按钮权限；仅房间管理角色请同时保留 serve:room:list 以便调用楼层下拉（/serve/floor/options）

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values ('楼层管理', '2018', '8', 'floor', 'serve/floor/index', 1, 0, 'C', '0', '0', 'serve:floor:list', 'build', 'admin', sysdate(), '', null, '楼层管理菜单');

SELECT @parentId := LAST_INSERT_ID();

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values ('楼层查询', @parentId, '1', '#', '', 1, 0, 'F', '0', '0', 'serve:floor:query', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values ('楼层新增', @parentId, '2', '#', '', 1, 0, 'F', '0', '0', 'serve:floor:add', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values ('楼层修改', @parentId, '3', '#', '', 1, 0, 'F', '0', '0', 'serve:floor:edit', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values ('楼层删除', @parentId, '4', '#', '', 1, 0, 'F', '0', '0', 'serve:floor:remove', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values ('楼层导出', @parentId, '5', '#', '', 1, 0, 'F', '0', '0', 'serve:floor:export', '#', 'admin', sysdate(), '', null, '');
