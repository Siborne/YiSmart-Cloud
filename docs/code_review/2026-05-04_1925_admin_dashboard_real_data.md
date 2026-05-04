# 变更记录：管理端首页仪表盘接入真实数据

## 变更背景/目的

管理端首页（`/index`）原先大量使用本地 mock 常量（按日期轮换三套假数据）。本次改为调用后端聚合接口，从颐养业务表与 `sys_user` 拉取统计，使概览饼图、趋势图、老人分布与来访列表尽量反映真实库表数据。

## 变更文件清单

### 后端（YiSmartCloud-nursing-platform）

- `serve/controller/ServeDashboardController.java`（新增）
- `serve/service/IServeDashboardService.java`、`serve/service/impl/ServeDashboardServiceImpl.java`（新增）
- `serve/mapper/ServeDashboardMapper.java`（新增）
- `resources/mapper/serve/ServeDashboardMapper.xml`（新增）
- `serve/vo/dashboard/*.java`（新增：饼图、趋势、来访项等 VO）

### 前端（YiSmartCloud-front）

- `src/api/serve/dashboard.js`（新增）
- `src/views/dashboard/index.vue`
- `src/views/dashboard/components/TopPanel.vue`
- `src/views/dashboard/components/MiddleChart.vue`
- `src/views/dashboard/components/RankList.vue`
- `src/views/dashboard/index1.js`（饼图 tooltip 文案：万笔/万元 → 笔/元）

## 关键改动说明

- 新增 `GET /serve/dashboard/summary`，返回：`elder/bed/service/staff/money` 五组饼图数据、`trends`（账单实收/待付按日或按小时、入住/退住按小时或按日、来访次数折线）、`elderRank`（在住登记按护理等级名分组）、`elderAge`（老人年龄五档×性别）、`visitsByDate`（来访记录按日分组，供「预约总览」）。
- 服务饼图语义：来访审批「待审批 / 已处理」分组；员工饼图：`sys_user` 按账号状态；收入饼图：账单费用类型（护理/床位/餐饮 vs 其他）。
- 首页各子组件通过 `props.dashboard` 注入数据；接口失败或未返回时，中部图表与排名区仍回退到原有常量 mock（RankList 来访在无数据时按日 fallback `SUBSCRIBE_DATA`）。

## 影响范围

- **接口**：新增 `/serve/dashboard/summary`，需登录（与其它 `/serve/**` 一致）；未单独配置菜单权限，避免无权限用户无法加载首页。
- **数据库**：只读聚合 `elder_info`、`bed`、`visit_record`、`bill_detail`、`check_in`、`sys_user`；依赖表存在且字段与现有 Mapper 一致。
- **前端**：首页请求增加一次汇总接口调用。

## 验证方式

- 已执行：`mvn -pl YiSmartCloud-nursing-platform -am compile -DskipTests`（通过）。
- 未执行：联调浏览器与真实库数据抽样核对（需本地/测试环境连库）。
