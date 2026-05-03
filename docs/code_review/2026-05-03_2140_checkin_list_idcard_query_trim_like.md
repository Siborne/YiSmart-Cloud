# 入住列表按老人身份证号查询修复

## 变更背景/目的

按身份证号查询无结果或不稳定。常见原因：`check_in.id_card_no` 使用 `CHAR(18)` 时 MySQL 右补空格，与前端传入的 18 位字符串做 `=` 比较会失败；另对用户输入前后空格做规范化。

## 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/resources/mapper/serve/CheckInMapper.xml`
- `YiSmartCloud-front/src/views/serve/checkIn/index.vue`

## 关键改动说明

- SQL 条件由 `id_card_no = #{idCardNo}` 改为 `trim(id_card_no) like concat('%', trim(#{idCardNo}), '%')`，消除 CHAR 补空格问题，并支持后若干位模糊查询。
- 列表请求前对 `elderName`、`idCardNo` 做 `trim`，空串按 `null` 不传条件（与 `tansParams` 省略空值一致）。

## 影响范围

- 入住登记列表查询语义；与导出等共用 `selectCheckInList` 时身份证号条件行为一致变为模糊匹配（完整 18 位时通常仍唯一）。

## 验证方式

- 未执行集成测试；建议在库内存在 `CHAR` 补空格数据时，用完整身份证号与带空格输入分别验证列表筛选。
