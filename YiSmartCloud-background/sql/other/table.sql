-- =========================================================
-- 养老核心业务表设计（护理配置后续四大核心模块）
-- 模块顺序：床位管理 -> 入住管理 -> 账单管理 -> 健康监测
-- 说明：统一采用审计字段 create_time / update_time / is_deleted
-- =========================================================

-- =========================
-- 模块一：床位与房间管理
-- =========================

-- 楼层信息表：用于维护房间归属楼层及排序
CREATE TABLE `floor` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `floor_no` int NOT NULL COMMENT '楼层编号 (例: 1,2,3)',
  `floor_name` varchar(32) DEFAULT NULL COMMENT '楼层名称 (例: 1楼)',
  `status` tinyint DEFAULT '1' COMMENT '状态: 0-停用, 1-启用',
  `sort_no` int DEFAULT '1' COMMENT '排序号',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT '0' COMMENT '逻辑删除: 0-未删除, 1-已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='楼层信息表';

-- 房间信息表：用于管理楼层下房间基础信息
CREATE TABLE `room` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `room_no` varchar(32) NOT NULL COMMENT '房间编号 (例: 101)',
  `floor_id` bigint DEFAULT NULL COMMENT '楼层ID',
  `room_image` varchar(255) DEFAULT NULL COMMENT '房间图片URL',
  `bed_fee` decimal(10,2) DEFAULT NULL COMMENT '床位费用',
  `room_type` tinyint DEFAULT '1' COMMENT '房间类型: 1-单人间, 2-双人间, 3-多人间',
  `room_desc` varchar(255) DEFAULT NULL COMMENT '房间介绍',
  `status` tinyint DEFAULT '1' COMMENT '状态: 0-停用, 1-启用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT '0' COMMENT '逻辑删除: 0-未删除, 1-已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='房间信息表';

-- 已存在 room 表时，执行以下补丁 SQL 增加房间图片字段
ALTER TABLE `room`
  ADD COLUMN IF NOT EXISTS `room_image` varchar(255) DEFAULT NULL COMMENT '房间图片URL' AFTER `floor_id`;
ALTER TABLE `room`
  ADD COLUMN IF NOT EXISTS `bed_fee` decimal(10,2) DEFAULT NULL COMMENT '床位费用' AFTER `room_image`;
ALTER TABLE `room`
  ADD COLUMN IF NOT EXISTS `room_desc` varchar(255) DEFAULT NULL COMMENT '房间介绍' AFTER `room_type`;

-- 已存在 floor 表时，可补充排序字段
ALTER TABLE `floor`
  ADD COLUMN IF NOT EXISTS `sort_no` int DEFAULT '1' COMMENT '排序号' AFTER `status`;

-- 床位信息表：用于维护房间内床位及占用状态
CREATE TABLE `bed` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `room_id` bigint NOT NULL COMMENT '所属房间ID',
  `bed_no` varchar(32) NOT NULL COMMENT '床位编号 (例: 101-A)',
  `bed_status` tinyint DEFAULT '0' COMMENT '床位状态: 0-空闲, 1-占用, 2-维修中',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='床位信息表';

-- =========================
-- 模块二：老人档案与入住记录
-- =========================

-- 老人档案表：保存老人基础档案和在院状态
CREATE TABLE `elder_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(64) NOT NULL COMMENT '老人姓名',
  `id_card` varchar(18) NOT NULL COMMENT '身份证号',
  `age` int DEFAULT NULL COMMENT '年龄',
  `gender` tinyint DEFAULT '1' COMMENT '性别: 1-男, 2-女',
  `contact_phone` varchar(20) DEFAULT NULL COMMENT '家属紧急联系电话',
  `health_status` varchar(255) DEFAULT NULL COMMENT '健康状况简述',
  `status` tinyint DEFAULT '0' COMMENT '当前状态: 0-待入住, 1-在院, 2-已退住',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='老人档案表';

-- 入住记录表：绑定老人、床位、护理等级，记录入住周期
CREATE TABLE `check_in_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `elder_id` bigint NOT NULL COMMENT '老人ID',
  `bed_id` bigint NOT NULL COMMENT '分配床位ID',
  `nursing_level_id` bigint NOT NULL COMMENT '护理等级ID (关联护理等级模块)',
  `check_in_date` date NOT NULL COMMENT '实际入住日期',
  `contract_end_date` date DEFAULT NULL COMMENT '合同到期日期',
  `status` tinyint DEFAULT '1' COMMENT '记录状态: 1-生效中, 2-已结束',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='老人入住记录表';

-- =========================
-- 模块三：费用与账单明细
-- =========================

-- 费用账单明细表：汇总老人月度护理、床位、餐饮等收费项
CREATE TABLE `bill_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `elder_id` bigint NOT NULL COMMENT '老人ID',
  `bill_month` varchar(10) NOT NULL COMMENT '账单月份 (例: 2026-04)',
  `bill_type` tinyint NOT NULL COMMENT '费用类型: 1-护理费, 2-床位费, 3-餐饮费, 4-其他',
  `amount` decimal(10,2) NOT NULL COMMENT '应收金额',
  `pay_status` tinyint DEFAULT '0' COMMENT '支付状态: 0-待支付, 1-已支付',
  `pay_time` datetime DEFAULT NULL COMMENT '实际支付时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='费用账单明细表';

-- =========================
-- 模块四：健康监测（IoT扩展）
-- =========================

-- 健康监测数据表：记录设备采集的生命体征及告警标记
CREATE TABLE `health_data_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `elder_id` bigint NOT NULL COMMENT '老人ID',
  `device_no` varchar(64) DEFAULT NULL COMMENT '绑定的监测设备编号',
  `heart_rate` int DEFAULT NULL COMMENT '心率 (次/分)',
  `blood_pressure_high` int DEFAULT NULL COMMENT '收缩压 (高压)',
  `blood_pressure_low` int DEFAULT NULL COMMENT '舒张压 (低压)',
  `measure_time` datetime NOT NULL COMMENT '测量时间',
  `is_alert` tinyint DEFAULT '0' COMMENT '是否触发报警: 0-正常, 1-异常报警',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_elder_time` (`elder_id`,`measure_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='健康监测数据表';

-- =========================
-- 访客管理模块：预约记录表设计
-- 记录老人相关访客的来访预约，实现审批与管理
-- =========================
CREATE TABLE `visit_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',                          -- 自增主键
  `elder_id` bigint NOT NULL COMMENT '被访老人ID',                              -- 被预约探访的老人ID
  `visitor_name` varchar(64) NOT NULL COMMENT '访客姓名',                       -- 访客真实姓名
  `visitor_phone` varchar(20) NOT NULL COMMENT '访客手机号',                    -- 访客手机号（便于核验/通知）
  `visit_time` datetime NOT NULL COMMENT '预计到访时间',                        -- 预定到访时间
  `visit_reason` varchar(255) DEFAULT NULL COMMENT '来访事由',                  -- 预约来访原因说明
  `status` tinyint DEFAULT '0' COMMENT '审批状态: 0-待审批, 1-准许, 2-拒绝, 3-已结束', -- 0-待审批(默认)，1-准许，2-拒绝，3-已结束
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',           -- 预约申请时间
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间', -- 最近流程时间（审批/修改）
  `is_deleted` tinyint DEFAULT '0' COMMENT '逻辑删除',                          -- 逻辑删除标记，1-已删除
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='访客预约记录表'; -- 每条记录代表一次访客对某老人的预约申请