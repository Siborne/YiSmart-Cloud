-- 在住管理下：房型设置 / 楼层管理 / 床位预览 / 智能床位 — 连带按钮权限一并删除后按固定顺序重建
-- 仅处理 menu_name 为下列四条的「菜单(C)」及其子按钮(F)，不会删除「在住管理」目录本身，也不会动同目录下其它名称的菜单
-- 执行前请备份 sys_menu、sys_role_menu；执行后：角色管理重新勾选这四项及按钮权限，并重新登录（或清菜单缓存）

SET @in_stay_parent_id := COALESCE(
  (SELECT menu_id FROM sys_menu WHERE menu_name = '在住管理' AND menu_type = 'M' ORDER BY menu_id LIMIT 1),
  (SELECT menu_id FROM sys_menu WHERE path = 'enterQuit' AND menu_type = 'M' ORDER BY menu_id LIMIT 1),
  (SELECT menu_id FROM sys_menu WHERE menu_id = 2018 LIMIT 1)
);

-- 1) 解除角色与即将删除菜单的关联
DELETE rm FROM sys_role_menu rm
WHERE rm.menu_id IN (
  SELECT menu_id FROM (
    SELECT m.menu_id
    FROM sys_menu m
    WHERE m.parent_id = @in_stay_parent_id
      AND m.menu_type = 'C'
      AND m.menu_name IN ('房型设置', '床位预览', '智能床位', '楼层管理')
    UNION
    SELECT m2.menu_id
    FROM sys_menu m2
    INNER JOIN sys_menu p ON m2.parent_id = p.menu_id
    WHERE p.parent_id = @in_stay_parent_id
      AND p.menu_type = 'C'
      AND p.menu_name IN ('房型设置', '床位预览', '智能床位', '楼层管理')
  ) t
);

-- 2) 先删按钮，再删四个 C 菜单
DELETE FROM sys_menu
WHERE parent_id IN (
  SELECT menu_id FROM (
    SELECT menu_id
    FROM sys_menu
    WHERE parent_id = @in_stay_parent_id
      AND menu_type = 'C'
      AND menu_name IN ('房型设置', '床位预览', '智能床位', '楼层管理')
  ) x
);

DELETE FROM sys_menu
WHERE parent_id = @in_stay_parent_id
  AND menu_type = 'C'
  AND menu_name IN ('房型设置', '床位预览', '智能床位', '楼层管理');

-- 3) 按顺序重建：0 房型 → 1 楼层 → 2 床位预览 → 3 智能床位（与业务配置顺序一致：先房型/楼层，再看床位）

-- 3.1 房型设置
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('房型设置', @in_stay_parent_id, 0, 'room', 'serve/room/index', NULL, 'ServeRoom', 1, 0, 'C', '0', '0', 'serve:room:list', 'table', 'admin', sysdate(), '', NULL, '在住-房型');
SELECT @idRoom := LAST_INSERT_ID();
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES
('房型查询', @idRoom, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:query', '#', 'admin', sysdate(), '', NULL, ''),
('房型新增', @idRoom, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:add', '#', 'admin', sysdate(), '', NULL, ''),
('房型修改', @idRoom, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:edit', '#', 'admin', sysdate(), '', NULL, ''),
('房型删除', @idRoom, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:remove', '#', 'admin', sysdate(), '', NULL, ''),
('房型导出', @idRoom, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:export', '#', 'admin', sysdate(), '', NULL, '');

-- 3.2 楼层管理
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('楼层管理', @in_stay_parent_id, 1, 'floor', 'serve/floor/index', NULL, 'ServeFloor', 1, 0, 'C', '0', '0', 'serve:floor:list', 'build', 'admin', sysdate(), '', NULL, '在住-楼层');
SELECT @idFloor := LAST_INSERT_ID();
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES
('楼层查询', @idFloor, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:query', '#', 'admin', sysdate(), '', NULL, ''),
('楼层新增', @idFloor, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:add', '#', 'admin', sysdate(), '', NULL, ''),
('楼层修改', @idFloor, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:edit', '#', 'admin', sysdate(), '', NULL, ''),
('楼层删除', @idFloor, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:remove', '#', 'admin', sysdate(), '', NULL, ''),
('楼层导出', @idFloor, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:export', '#', 'admin', sysdate(), '', NULL, '');

-- 3.3 床位预览
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('床位预览', @in_stay_parent_id, 2, 'bedPreview', 'serve/bed/index', NULL, 'ServeBedPreview', 1, 0, 'C', '0', '0', 'serve:bed:list', 'nested', 'admin', sysdate(), '', NULL, '在住-床位预览');
SELECT @idBedPreview := LAST_INSERT_ID();
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES
('床位查询', @idBedPreview, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:query', '#', 'admin', sysdate(), '', NULL, ''),
('床位新增', @idBedPreview, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:add', '#', 'admin', sysdate(), '', NULL, ''),
('床位修改', @idBedPreview, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:edit', '#', 'admin', sysdate(), '', NULL, ''),
('床位删除', @idBedPreview, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:remove', '#', 'admin', sysdate(), '', NULL, ''),
('床位导出', @idBedPreview, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:export', '#', 'admin', sysdate(), '', NULL, '');

-- 3.4 智能床位（同页不同 path，便于路由区分；若不需要可再在菜单管理里隐藏本项）
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('智能床位', @in_stay_parent_id, 3, 'smartBed', 'serve/bed/index', NULL, 'ServeSmartBed', 1, 0, 'C', '0', '0', 'serve:bed:list', 'guide', 'admin', sysdate(), '', NULL, '在住-智能床位');
SELECT @idSmartBed := LAST_INSERT_ID();
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES
('床位查询', @idSmartBed, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:query', '#', 'admin', sysdate(), '', NULL, ''),
('床位新增', @idSmartBed, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:add', '#', 'admin', sysdate(), '', NULL, ''),
('床位修改', @idSmartBed, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:edit', '#', 'admin', sysdate(), '', NULL, ''),
('床位删除', @idSmartBed, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:remove', '#', 'admin', sysdate(), '', NULL, ''),
('床位导出', @idSmartBed, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:export', '#', 'admin', sysdate(), '', NULL, '');
