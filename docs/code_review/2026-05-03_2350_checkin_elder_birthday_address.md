# 变更记录：入住办理 elder_info 生日与地址未落库

## 背景与目的

新增入住办理时，`elder_info` 表中 `birthday`、`address` 常为 NULL。排查发现 `insertElderInfo` 对这两列使用了 `!= null and != ''` 动态条件，与 `contact_phone` 等字段不一致；在请求体传空串或未传解析结果为空时，插入语句会整列省略，表现为未写入。另在仅填身份证号、未选手动生日时，增加从 18 位身份证号解析出生日期的兜底。

## 变更文件清单

- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/resources/mapper/serve/ElderInfoMapper.xml`
- `YiSmartCloud-background/YiSmartCloud-nursing-platform/src/main/java/org/FlyingSparrow/YiSmartCloud/serve/service/impl/CheckInServiceImpl.java`

## 关键改动说明

1. **ElderInfoMapper.xml**：`insertElderInfo` 中 `birthday`、`address` 的 `<if>` 与 `values` 片段改为仅判断 `!= null`，与 `updateElderInfo` 及 `contact_phone` 行为对齐，避免合法空串或绑定边界导致列被跳过。
2. **CheckInServiceImpl.insertOrUpdate**：对生日、住址做 `trim`；生日仍为空时对 **18 位** 身份证号解析 `yyyy-MM-dd` 再写入；全空则置 `null`（插入时仍可不写该列）。

## 影响范围

- 数据库：`elder_info` 插入/更新语义（空串可写入 `birthday`/`address` 列，此前插入会跳过空串）。
- 接口：`POST /serve/checkIn/apply` 聚合入住申请写入老人档案。
- 前端：无强制变更；未选手动生日但身份证号合法时后端可补生日。

## 验证方式

- 已执行：`mvn -pl YiSmartCloud-nursing-platform -am compile -DskipTests`（通过）。
- 未执行：联调真实申请接口与库表数据；建议用带生日/住址的 payload 及仅身份证号场景各测一次。
