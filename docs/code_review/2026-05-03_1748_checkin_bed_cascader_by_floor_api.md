# 入住登记床位改为楼层房间床位级联

## 变更背景/目的
- 入住登记页面“入住床位”原为手动输入，不便于按空闲床位准确选择。
- 按现有后端接口 `/serve/floor/getRoomAndBedByBedStatus/{status}` 实现楼层-房间-床位三级联动选择，复现业务期望交互。

## 变更文件清单
- `YiSmartCloud-front/src/api/serve/floor.js`
- `YiSmartCloud-front/src/views/serve/checkIn/apply.vue`

## 关键改动说明
- 新增前端 API：`getRoomAndBedByBedStatus(status)`，调用 `GET /serve/floor/getRoomAndBedByBedStatus/{status}`。
- 入住登记页将“入住床位”由 `el-input` 改为 `el-cascader`。
- 页面加载时请求 `status=0`（未入住）床位树数据并绑定级联选项。
- 选择级联末级节点时自动将床位号（末级 label）回填到 `form.config.bedNumber`，保持提交字段兼容。
- 入住床位校验触发从 `blur` 调整为 `change`，匹配级联组件交互。

## 影响范围（接口、数据库、前端、兼容性）
- 接口：新增入住登记页对楼层床位树接口调用。
- 数据库：无变更。
- 前端：入住登记页“入住床位”输入方式从手输改为级联选择。
- 兼容性：提交字段仍为 `bedNumber`，后端新增/保存逻辑无需改动。

## 验证方式（已执行/未执行及原因）
- 已执行：静态核对组件渲染、数据加载、值回填与提交字段映射。
- 未执行：未在本地启动前后端完成交互验证，建议手测确认级联面板展示与提交成功。
