-- 家庭成员服务订单链路建表脚本

CREATE TABLE IF NOT EXISTS `family_elder_binding` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `family_member_id` bigint NOT NULL COMMENT '家庭成员ID',
  `elder_id` bigint NOT NULL COMMENT '老人ID',
  `relation` varchar(32) DEFAULT NULL COMMENT '关系',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态(0-失效,1-有效)',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_member_elder_active` (`family_member_id`,`elder_id`,`status`,`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='家庭成员老人绑定关系';

CREATE TABLE IF NOT EXISTS `member_service_order` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_no` varchar(32) NOT NULL COMMENT '订单号',
  `family_member_id` bigint NOT NULL COMMENT '家庭成员ID',
  `elder_id` bigint NOT NULL COMMENT '老人ID',
  `project_id` bigint NOT NULL COMMENT '护理项目ID',
  `count` int NOT NULL DEFAULT 1 COMMENT '数量',
  `unit_price` decimal(10,2) NOT NULL DEFAULT 0 COMMENT '单价',
  `total_amount` decimal(10,2) NOT NULL DEFAULT 0 COMMENT '总价',
  `expected_service_time` datetime DEFAULT NULL COMMENT '期望服务时间',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态(0:待支付,1:已预约,2:已取消,3:已退款,4:已完成)',
  `pay_status` tinyint NOT NULL DEFAULT 0 COMMENT '支付状态(0:未支付,1:已支付)',
  `bill_id` bigint DEFAULT NULL COMMENT '关联账单ID',
  `cancel_reason` varchar(255) DEFAULT NULL COMMENT '取消原因',
  `refund_reason` varchar(255) DEFAULT NULL COMMENT '退款原因',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_no` (`order_no`),
  KEY `idx_member_order` (`family_member_id`,`status`,`is_deleted`),
  KEY `idx_bill_order` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员服务订单';

-- 预约表唯一约束：同手机号同时段只能有一条预约记录（避免重复预约）
ALTER TABLE `reservation`
  ADD UNIQUE KEY `uk_reservation_mobile_time` (`mobile`,`time`);
