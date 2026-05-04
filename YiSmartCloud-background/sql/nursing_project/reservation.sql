-- 小程序参观/探访预约表（执行前请确认库名与字符集）
-- UTF-8

CREATE TABLE IF NOT EXISTS `reservation` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '预约人姓名',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '预约人手机号',
  `time` datetime NOT NULL COMMENT '预约时间',
  `visitor` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '探访人/家人姓名',
  `type` int NOT NULL COMMENT '预约类型，0：参观预约，1：探访预约',
  `status` int NOT NULL COMMENT '预约状态，0：待报道，1：已完成，2：取消，3：过期',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人（家属用户ID，与 BaseEntity 一致）',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_reservation_mobile_time` (`mobile`,`time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='预约信息表';
