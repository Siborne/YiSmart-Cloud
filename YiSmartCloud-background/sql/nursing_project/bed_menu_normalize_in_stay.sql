-- 修正「在住管理」下床位相关菜单，解决：智能床位组件路径为空无法打开、床位预览被误设为目录(M)导致无页面等问题
-- 执行后：缓存管理里清菜单缓存，或重新登录；再到「角色管理」确认已勾选 serve:bed:* 与 serve:room:*、serve:floor:*
-- 若仅需保留一个床位入口，执行完本脚本后可在菜单管理将「智能床位」设为隐藏，或取消脚本末尾注释仅隐藏「智能床位」

-- 1) 床位预览：强制为「菜单(C)」并指向床位看板页
UPDATE sys_menu
SET menu_type = 'C',
    component = 'serve/bed/index',
    path = CASE WHEN path IS NULL OR TRIM(path) = '' THEN 'bedPreview' ELSE path END,
    perms = CASE WHEN perms IS NULL OR TRIM(perms) = '' THEN 'serve:bed:list' ELSE perms END,
    route_name = CASE WHEN route_name IS NULL OR TRIM(route_name) = '' THEN 'ServeBedPreview' ELSE route_name END,
    visible = '0',
    status = '0'
WHERE menu_name = '床位预览';

-- 2) 智能床位：补全组件（与床位预览同一 Vue 页；路由 path 区分，避免与「床位预览」path 冲突）
UPDATE sys_menu
SET menu_type = 'C',
    component = 'serve/bed/index',
    path = CASE WHEN path IS NULL OR TRIM(path) = '' THEN 'smartBed' ELSE path END,
    perms = CASE WHEN perms IS NULL OR TRIM(perms) = '' THEN 'serve:bed:list' ELSE perms END,
    route_name = CASE WHEN route_name IS NULL OR TRIM(route_name) = '' THEN 'ServeSmartBed' ELSE route_name END,
    visible = '0',
    status = '0'
WHERE menu_name = '智能床位';

-- 3) 房型设置：确保为菜单且组件正确（常见预期：serve/room/index）
UPDATE sys_menu
SET menu_type = 'C',
    component = 'serve/room/index',
    path = CASE WHEN path IS NULL OR TRIM(path) = '' THEN 'room' ELSE path END,
    perms = CASE WHEN perms IS NULL OR TRIM(perms) = '' THEN 'serve:room:list' ELSE perms END,
    visible = '0',
    status = '0'
WHERE menu_name = '房型设置';

-- 4) 楼层管理：与楼层页一致
UPDATE sys_menu
SET menu_type = 'C',
    component = 'serve/floor/index',
    path = CASE WHEN path IS NULL OR TRIM(path) = '' THEN 'floor' ELSE path END,
    perms = CASE WHEN perms IS NULL OR TRIM(perms) = '' THEN 'serve:floor:list' ELSE perms END,
    route_name = CASE WHEN route_name IS NULL OR TRIM(route_name) = '' THEN 'ServeFloor' ELSE route_name END,
    visible = '0',
    status = '0'
WHERE menu_name = '楼层管理';

-- 可选：只保留「床位预览」一个入口时，隐藏「智能床位」（避免侧栏两个相同功能）
-- UPDATE sys_menu SET visible = '1' WHERE menu_name = '智能床位';
