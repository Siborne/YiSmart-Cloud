# 变更记录：老人模块职责对齐（入住、在院主数据、护工扩展）

## 背景/目的

将「老人模块」在文档与界面上的表述对齐为：**以入住办理为入口**，维护**在院老人主数据**，并明确**护工 / 照护员派工与排班**为后续扩展、与护理计划及员工主数据衔接；避免被理解为泛化的「档案 CRUD」而与入住链路脱节。

## 变更文件清单

- `README.md`
- `YiSmartCloud-background/sql/other/table.sql`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/.../ElderInfoController.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/.../CheckInController.java`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/.../domain/ElderInfo.java`
- `YiSmartCloud-front/src/views/serve/info/index.vue`
- `YiSmartCloud-front/src/views/serve/checkIn/index.vue`
- `YiSmartCloud-front/src/api/serve/info.js`

## 关键改动说明

1. **README**：项目主线描述中突出老人侧「入住 + 在院主数据 + 护工派工预留」；业务列表中 `elder info` 条目改为在院主数据与入住联动说明。
2. **SQL 注释**：`table.sql` 模块顺序与模块二标题、表注释与上述职责一致。
3. **后端**：`ElderInfoController` / `ElderInfo` 的 JavaDoc、Swagger `@Api`、操作日志标题与导出表名统一为「在院老人信息」语义；`CheckInController` 类注释说明与 `/serve/info` 的关系及护工扩展方向。
4. **前端**：在「在院老人信息」列表页与「入住办理」列表页顶部增加 `el-alert` 说明模块边界与协作关系；对话框标题与删除确认文案同步；`info.js` 注释同步。

## 影响范围

- **接口路径、权限标识**：未改；仅文档与展示文案、日志标题、导出文件名语义变化。
- **数据库**：无结构变更，仅脚本内注释。
- **前端**：新增提示条，无路由变更。

## 验证方式

- 未执行自动化测试（文案与注释为主）。
- 建议：本地 `npm run dev` 打开 `serve/info`、`serve/checkIn` 对应菜单页，确认提示条展示与构建无告警；后端启动后抽查 Knife4j 中老人接口分组名称。
