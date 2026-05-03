# 入住登记护理等级改为后端下拉

## 变更背景/目的
- 入住登记页面中的“护理等级”原为手动输入，容易录入不规范数据。
- 按业务要求改为调用后端 `listAll()`（接口 `/serve/level/listAll`）获取可用护理等级，并通过下拉框选择。

## 变更文件清单
- `YiSmartCloud-front/src/api/serve/level.js`
- `YiSmartCloud-front/src/views/serve/checkIn/apply.vue`

## 关键改动说明
- 在护理等级 API 中新增 `listAllLevel()` 方法，调用 `GET /serve/level/listAll`。
- 入住登记页将 `护理等级` 表单项由 `el-input` 改为 `el-select`。
- 页面加载时调用 `listAllLevel()`，将返回的等级列表绑定到下拉选项。
- 表单校验触发器从 `blur` 调整为 `change`，匹配下拉组件交互。
- 下拉框值提交仍使用 `nursingLevelName`（等级名称），保持现有提交流程兼容。

## 影响范围（接口、数据库、前端、兼容性）
- 接口：新增前端对 `/serve/level/listAll` 的调用，不改动后端接口定义。
- 数据库：无变更。
- 前端：仅影响入住登记页面“护理等级”录入方式（输入改选择）。
- 兼容性：提交字段保持不变，后端接收逻辑无需调整。

## 验证方式（已执行/未执行及原因）
- 已执行：静态代码检查（人工核对）确认页面已从输入框改为下拉并在 `onMounted` 拉取数据。
- 未执行：未在本地完整启动前后端联调，需在运行环境中手工验证下拉数据加载与提交流程。
