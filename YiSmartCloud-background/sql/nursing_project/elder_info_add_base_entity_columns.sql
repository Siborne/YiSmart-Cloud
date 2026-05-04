-- elder_info 与 BaseEntity / MyBatis-Plus 对齐：补充若依审计字段（库中已存在则勿重复执行）
-- 执行前请确认列不存在，避免 ALTER 报错。

ALTER TABLE `elder_info`
  ADD COLUMN `create_by` varchar(64) DEFAULT '' COMMENT '创建者' AFTER `update_time`,
  ADD COLUMN `update_by` varchar(64) DEFAULT '' COMMENT '更新者' AFTER `create_by`,
  ADD COLUMN `remark` varchar(500) DEFAULT NULL COMMENT '备注' AFTER `update_by`;
