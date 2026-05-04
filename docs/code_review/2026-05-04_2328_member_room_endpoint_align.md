# member 端 room 接口命名对齐

## 变更背景/目的
- 用户反馈 UniApp 首页请求 `/member/roomTypes` 与当前后端命名习惯不一致，希望统一为 `room`。
- 将成员端房型接口兼容到 `/member/room`，并同步前端调用路径。

## 变更文件清单
- `YiSmartCloud-member-uniapp/api/index.js`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/controller/mebber/MemberRoomTypeController.java`
- `YiSmartCloud-background/YiSmartCloud-framework/src/main/java/org/FlyingSparrow/YiSmartCloud/framework/config/SecurityConfig.java`

## 关键改动说明
- UniApp 首页房型 API 从 `/member/roomTypes` 改为 `/member/room`。
- `MemberRoomTypeController` 的类级 `@RequestMapping` 改为数组形式，同时支持：
  - `/member/roomTypes`
  - `/member/room`
- `SecurityConfig` 增加 `GET /member/room` 放行规则，保持 C 端匿名访问一致。

## 影响范围
- 前端：首页房型接口路径变更为 `/member/room`。
- 后端：保留历史路径兼容，不影响已有调用方。
- 鉴权：新增 `GET /member/room` 匿名放行。

## 验证方式
- 已执行：代码静态检查，前后端路径与放行规则一致。
- 未执行：本地启动后端并在小程序端实测接口返回（若服务未启动，仍会出现 `ERR_CONNECTION_REFUSED`）。
