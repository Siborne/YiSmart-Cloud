# 变更背景/目的

- 修正代码生成模板中的字段类型映射，避免 `tinyint` 生成成 `Long`。
- 将时间字段生成与前端表单交互统一为 `LocalDateTime` + `yyyy-MM-dd HH:mm:ss`，减少序列化/反序列化兼容问题。

# 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-generator/src/main/java/org/FlyingSparrow/YiSmartCloud/generator/util/GenUtils.java`
- `YiSmartCloud-background/YiSmartCloud-generator/src/main/resources/vm/java/domain.java.vm`
- `YiSmartCloud-background/YiSmartCloud-generator/src/main/resources/vm/java/sub-domain.java.vm`
- `YiSmartCloud-background/YiSmartCloud-generator/src/main/resources/vm/vue/index.vue.vm`
- `YiSmartCloud-background/YiSmartCloud-generator/src/main/resources/vm/vue/v3/index.vue.vm`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/domain/Room.java`
- `YiSmartCloud-front/src/views/serve/record/index.vue`

# 关键改动说明

- `GenUtils` 数值类型映射规则增强：`tinyint/smallint/mediumint/int/integer` 统一优先映射为 `Integer`。
- Java 领域模型模板中，时间字段注解统一使用 `yyyy-MM-dd HH:mm:ss`，兼容 `LocalDateTime`（并兼容旧 `Date` 分支）。
- Vue 生成模板中，`datetime` 字段统一改为：
  - 单值：`type="datetime"` + `value-format="YYYY-MM-DD HH:mm:ss"`（v2 模板对应小写格式）
  - 区间：`type="datetimerange"` + 时间格式字符串
  - 列表展示：`parseTime` 改为显示到秒。
- 已生成业务代码同步修正：
  - `Room.roomType` 从 `Long` 改为 `Integer`（对应 `tinyint`）。
  - `record/index.vue` 的预计到访时间查询/编辑改为 datetime，列表时间展示精确到秒。

# 影响范围（接口、数据库、前端、兼容性）

- 接口层：时间参数前端提交格式从日期提升为日期时间字符串，后端 `LocalDateTime` 解析更稳定。
- 数据库层：本次未改表结构，仅调整代码映射和前端传参格式。
- 前端层：新生成页面及已改页面时间控件由日期选择升级为日期时间选择。
- 兼容性：对旧模板生成结果有正向兼容（`Date` 分支仍可命中）；对 `tinyint` 映射结果更贴近业务语义。

# 验证方式（已执行/未执行及原因）

- 已执行：对改动文件进行静态核对与 lints 读取（`ReadLints`）。
- 结果：未发现本次改动新增的明确 lint 报错；`record/index.vue` 存在 `v-model` 语法规则告警为仓库既有规范差异（非本次引入）。
- 未执行：未在本地启动全量前后端服务进行联调，因当前任务聚焦模板与类型修正。
