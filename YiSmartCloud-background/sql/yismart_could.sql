/*
 Navicat Premium Dump SQL

 Source Server         : YiSmart-Could-Mysql
 Source Server Type    : MySQL
 Source Server Version : 80029 (8.0.29)
 Source Host           : 192.168.100.168:3306
 Source Schema         : yismart_could

 Target Server Type    : MySQL
 Target Server Version : 80029 (8.0.29)
 File Encoding         : 65001

 Date: 09/05/2026 20:42:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bed
-- ----------------------------
DROP TABLE IF EXISTS `bed`;
CREATE TABLE `bed`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `room_id` bigint NOT NULL COMMENT '所属房间ID',
  `bed_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '床位编号 (例: 101-A)',
  `bed_status` tinyint NULL DEFAULT 0 COMMENT '床位状态: 0-空闲, 1-占用, 2-维修中',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '床位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bed
-- ----------------------------
INSERT INTO `bed` VALUES (1, 1, '101-1', 1, '2026-04-27 16:29:34', '2026-04-27 16:29:34', 0);

-- ----------------------------
-- Table structure for bill_detail
-- ----------------------------
DROP TABLE IF EXISTS `bill_detail`;
CREATE TABLE `bill_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `elder_id` bigint NOT NULL COMMENT '老人ID',
  `bill_month` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '账单月份 (例: 2026-04)',
  `bill_type` tinyint NOT NULL COMMENT '费用类型: 1-护理费, 2-床位费, 3-餐饮费, 4-其他',
  `amount` decimal(10, 2) NOT NULL COMMENT '应收金额',
  `pay_status` tinyint NULL DEFAULT 0 COMMENT '支付状态: 0-待支付, 1-已支付',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '实际支付时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '费用账单明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bill_detail
-- ----------------------------

-- ----------------------------
-- Table structure for check_in
-- ----------------------------
DROP TABLE IF EXISTS `check_in`;
CREATE TABLE `check_in`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `elder_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '老人姓名',
  `elder_id` bigint NOT NULL COMMENT '老人ID',
  `id_card_no` char(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '身份证号',
  `start_date` date NOT NULL COMMENT '入住开始时间',
  `end_date` date NULL DEFAULT NULL COMMENT '入住结束时间',
  `nursing_level_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '护理等级名称',
  `bed_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '入住床位',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态 (0: 已入住, 1: 已退住)',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序编号',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '修改人',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of check_in
-- ----------------------------
INSERT INTO `check_in` VALUES (1, '张三', 325, '132123196712131234', '2024-08-27', '2024-09-30', '测试护理等级', '104-1', 0, 0, '2024-08-27 16:43:20', '2024-08-27 08:43:19', '1', NULL, '[{\"kinship\":\"1\",\"name\":\"13211223322\",\"phone\":\"13211223322\"}]');
INSERT INTO `check_in` VALUES (2, '李天龙', 326, '132123196712131239', '2024-08-27', '2024-09-30', '1号护理计划', '104-2', 0, 0, '2024-08-27 16:50:09', '2024-08-27 08:50:08', '1', NULL, '[{\"kinship\":\"0\",\"name\":\"李天\",\"phone\":\"13222334439\"}]');
INSERT INTO `check_in` VALUES (3, '老李', 327, '132123195612132345', '2024-09-12', '2024-10-31', '2号护理等级', '101-2', 0, 0, '2024-09-12 18:51:36', '2024-09-12 18:51:36', '1', NULL, '[{\"kinship\":\"1\",\"name\":\"小李\",\"phone\":\"13212349900\"}]');
INSERT INTO `check_in` VALUES (4, '老李头儿', 328, '410725196904056698', '2024-09-12', '2024-10-31', '2号护理等级', '101-1', 0, 0, '2024-09-12 19:10:23', '2024-09-12 19:10:23', '1', NULL, '[{\"kinship\":\"0\",\"name\":\"老王\",\"phone\":\"15100000002\"}]');
INSERT INTO `check_in` VALUES (5, '吕实萌', 1, '210102197604190730', '2026-05-01', '2026-06-30', '测试', '101-1', 0, 0, '2026-05-03 19:14:34', '2026-05-03 11:14:36', '1', NULL, '[{\"kinship\":\"子女\",\"name\":\"张佳承\",\"phone\":\"15780568256\"},{\"kinship\":\"配偶\",\"name\":\"孔身栋\",\"phone\":\"13740390814\"}]');

-- ----------------------------
-- Table structure for check_in_config
-- ----------------------------
DROP TABLE IF EXISTS `check_in_config`;
CREATE TABLE `check_in_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `check_in_id` bigint NOT NULL COMMENT '入住表ID',
  `nursing_level_id` bigint NOT NULL COMMENT '护理等级ID',
  `nursing_level_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '护理等级名称',
  `fee_start_date` date NOT NULL COMMENT '费用开始时间',
  `fee_end_date` date NULL DEFAULT NULL COMMENT '费用结束时间',
  `deposit` decimal(10, 2) NOT NULL COMMENT '押金（元）',
  `nursing_fee` decimal(10, 2) NOT NULL COMMENT '护理费用（元/月）',
  `bed_fee` decimal(10, 2) NOT NULL COMMENT '床位费用（元/月）',
  `insurance_payment` decimal(10, 2) NOT NULL COMMENT '医保支付（元/月）',
  `government_subsidy` decimal(10, 2) NOT NULL COMMENT '政府补贴（元/月）',
  `other_fees` decimal(10, 2) NOT NULL COMMENT '其他费用（元/月）',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序编号',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '修改人',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of check_in_config
-- ----------------------------
INSERT INTO `check_in_config` VALUES (1, 5, 77, '测试', '2026-05-02', '2026-06-30', 3000.00, 0.00, 200.00, 0.00, 0.00, 0.00, 0, '2026-05-03 19:14:35', '2026-05-03 11:14:36', '1', NULL, NULL);

-- ----------------------------
-- Table structure for check_in_record
-- ----------------------------
DROP TABLE IF EXISTS `check_in_record`;
CREATE TABLE `check_in_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `elder_id` bigint NOT NULL COMMENT '老人ID',
  `bed_id` bigint NOT NULL COMMENT '分配床位ID',
  `nursing_level_id` bigint NOT NULL COMMENT '护理等级ID (关联护理等级模块)',
  `check_in_date` date NOT NULL COMMENT '实际入住日期',
  `contract_end_date` date NULL DEFAULT NULL COMMENT '合同到期日期',
  `status` tinyint NULL DEFAULT 1 COMMENT '记录状态: 1-生效中, 2-已结束',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '老人入住记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of check_in_record
-- ----------------------------

-- ----------------------------
-- Table structure for contract
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `elder_id` int NOT NULL COMMENT '老人ID',
  `contract_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '合同名称',
  `contract_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '合同编号',
  `agreement_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '协议地址（文件路径或URL）',
  `third_party_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '丙方手机号',
  `third_party_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '丙方姓名',
  `elder_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '老人姓名',
  `start_date` date NOT NULL COMMENT '开始时间',
  `end_date` date NOT NULL COMMENT '结束时间',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态 (0: 未生效, 1: 已生效, 2: 已过期, 3: 已失效)',
  `sign_date` date NOT NULL COMMENT '签约日期',
  `termination_submitter` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '解除提交人',
  `termination_date` date NULL DEFAULT NULL COMMENT '解除日期',
  `termination_agreement_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '解除协议地址（文件路径或URL）',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序编号',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '修改人',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contract
-- ----------------------------
INSERT INTO `contract` VALUES (1, 1, '测试合同', 'HT202605031914340001', 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/05/94d55ded-c61e-439d-97ac-4a4f865aa875.docx', '13887111565', '张源网', '吕实萌', '2026-05-01', '2026-06-30', 1, '2026-05-01', NULL, NULL, NULL, 0, '2026-05-03 19:14:34', '2026-05-03 11:14:35', '1', '1', NULL);

-- ----------------------------
-- Table structure for elder_info
-- ----------------------------
DROP TABLE IF EXISTS `elder_info`;
CREATE TABLE `elder_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '老人姓名',
  `id_card` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '身份证号',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `gender` tinyint NULL DEFAULT 1 COMMENT '性别: 1-男, 2-女',
  `birthday` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出生日期 yyyy-MM-dd',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '家属紧急联系电话',
  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '家庭住址',
  `portrait_img` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '一寸照片URL',
  `id_card_portrait_img` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证人像面URL',
  `id_card_national_emblem_img` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证国徽面URL',
  `health_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '健康状况简述',
  `status` tinyint NULL DEFAULT 0 COMMENT '当前状态: 0-待入住, 1-在院, 2-已退住',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '老人档案表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of elder_info
-- ----------------------------
INSERT INTO `elder_info` VALUES (1, '吕实萌', '210102197604190730', 66, 1, NULL, '15238406644', NULL, NULL, NULL, NULL, NULL, 1, '2026-05-03 11:14:35', '2026-05-03 11:14:35', 0);

-- ----------------------------
-- Table structure for family_member
-- ----------------------------
DROP TABLE IF EXISTS `family_member`;
CREATE TABLE `family_member`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `open_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'OpenID',
  `gender` int NULL DEFAULT NULL COMMENT '性别(0:男，1:女)',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '老人家属' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of family_member
-- ----------------------------
INSERT INTO `family_member` VALUES (2, '13719685888', 'Siborne', NULL, 'dev_openid_13719685888', NULL, '2026-05-05 00:58:01', '2026-05-05 00:58:01', 1, NULL, NULL);

-- ----------------------------
-- Table structure for floor
-- ----------------------------
DROP TABLE IF EXISTS `floor`;
CREATE TABLE `floor`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `floor_no` int NOT NULL COMMENT '楼层编号 (例: 1,2,3)',
  `floor_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '楼层名称 (例: 1楼)',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态: 0-停用, 1-启用',
  `sort_no` int NULL DEFAULT 1 COMMENT '排序号',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除: 0-未删除, 1-已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '楼层信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of floor
-- ----------------------------
INSERT INTO `floor` VALUES (1, 1, '一楼', 1, 1, '2026-04-27 16:45:41', '2026-04-27 16:45:41', 0);
INSERT INTO `floor` VALUES (2, 2, '二楼', 1, 1, '2026-04-27 16:46:09', '2026-04-27 16:46:09', 0);

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'nursing_level', '护理等级表', NULL, NULL, 'NursingLevel', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'level', '护理等级', 'Siborne', '0', '/', '{\"parentMenuId\":2018}', 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:08:08', NULL);
INSERT INTO `gen_table` VALUES (2, 'nursing_plan', '护理计划表', NULL, NULL, 'NursingPlan', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'plan', '护理计划', 'Siborne', '0', '/', '{\"parentMenuId\":2018}', 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:57', NULL);
INSERT INTO `gen_table` VALUES (3, 'nursing_project', '护理项目表', NULL, NULL, 'NursingProject', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'project', '护理项目', 'Siborne', '0', '/', '{\"parentMenuId\":2018}', 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:46', NULL);
INSERT INTO `gen_table` VALUES (4, 'check_in', '入住登记表', NULL, NULL, 'CheckIn', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'checkIn', '入住登记', 'Siborne', '0', '/', '{\"parentMenuId\":2105}', 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06', NULL);
INSERT INTO `gen_table` VALUES (5, 'check_in_config', '入住配置表', NULL, NULL, 'CheckInConfig', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'checkInConfig', '入住配置', 'Siborne', '0', '/', '{}', 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:39:48', NULL);
INSERT INTO `gen_table` VALUES (6, 'contract', '合同表', NULL, NULL, 'Contract', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'contract', '合同', 'Siborne', '0', '/', '{}', 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34', NULL);
INSERT INTO `gen_table` VALUES (7, 'nursing_project_plan', '护理计划和项目关联表', NULL, NULL, 'NursingProjectPlan', 'crud', '', 'org.FlyingSparrow.YiSmartCloud.system', 'system', 'plan', '护理计划和项目关联', 'ruoyi', '0', '/', NULL, 'admin', '2026-03-24 17:01:58', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (8, 'bed', '床位信息表', NULL, NULL, 'Bed', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'bed', '床位信息', 'Siborne', '0', '/', '{\"parentMenuId\":2071}', 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:25:19', NULL);
INSERT INTO `gen_table` VALUES (9, 'bill_detail', '费用账单明细表', NULL, NULL, 'BillDetail', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'detail', '费用账单明细', 'Siborne', '0', '/', '{}', 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:35:48', NULL);
INSERT INTO `gen_table` VALUES (10, 'check_in_record', '老人入住记录表', NULL, NULL, 'CheckInRecord', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'record', '老人入住记录', 'Siborne', '0', '/', '{\"parentMenuId\":2073}', 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:32:50', NULL);
INSERT INTO `gen_table` VALUES (11, 'elder_info', '老人档案表', NULL, NULL, 'ElderInfo', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'info', '老人档案', 'Siborne', '0', '/', '{}', 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:34:45', NULL);
INSERT INTO `gen_table` VALUES (12, 'health_data_record', '健康监测数据表', NULL, NULL, 'HealthDataRecord', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'record', '健康监测数据', 'Siborne', '0', '/', '{\"parentMenuId\":2072}', 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:29:46', NULL);
INSERT INTO `gen_table` VALUES (13, 'room', '房间信息表', NULL, NULL, 'Room', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'room', '房间信息', 'Siborne', '0', '/', '{\"parentMenuId\":2071}', 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:26:53', NULL);
INSERT INTO `gen_table` VALUES (14, 'visit_record', '访客预约记录表', NULL, NULL, 'VisitRecord', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'record', '访客预约记录', 'Siborne', '0', '/', '{\"parentMenuId\":2068}', 'admin', '2026-04-27 15:18:44', '', '2026-04-27 15:24:59', NULL);
INSERT INTO `gen_table` VALUES (15, 'floor', '楼层信息表', NULL, NULL, 'Floor', 'crud', '', 'org.FlyingSparrow.YiSmartCloud.system', 'system', 'floor', '楼层信息', 'ruoyi', '0', '/', NULL, 'admin', '2026-04-28 16:25:15', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (16, 'health_assessment', '健康评估表', NULL, NULL, 'HealthAssessment', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'assessment', '健康评估', 'Siborne', '0', '/', '{\"parentMenuId\":2104}', 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43', NULL);
INSERT INTO `gen_table` VALUES (17, 'family_member', '老人家属', NULL, NULL, 'FamilyMember', 'crud', 'element-plus', 'org.FlyingSparrow.YiSmartCloud.serve', 'serve', 'member', '老人家属', 'Siborne', '0', '/', '{}', 'admin', '2026-05-04 09:58:52', '', '2026-05-04 09:59:39', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 207 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'id', '主键ID', 'int', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:08:08');
INSERT INTO `gen_table_column` VALUES (2, 1, 'name', '等级名称', 'varchar(50)', 'String', 'name', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:08:08');
INSERT INTO `gen_table_column` VALUES (3, 1, 'lplan_id', '护理计划ID', 'int', 'Long', 'lplanId', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 3, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:08:08');
INSERT INTO `gen_table_column` VALUES (4, 1, 'fee', '护理费用', 'decimal(10,2)', 'BigDecimal', 'fee', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 4, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:08:08');
INSERT INTO `gen_table_column` VALUES (5, 1, 'status', '状态（0：禁用，1：启用）', 'tinyint(1)', 'Integer', 'status', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'radio', '', 5, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:08:08');
INSERT INTO `gen_table_column` VALUES (6, 1, 'description', '等级说明', 'varchar(255)', 'String', 'description', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 6, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:08:08');
INSERT INTO `gen_table_column` VALUES (7, 1, 'create_time', '创建时间', 'datetime', 'LocalDateTime', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'datetime', '', 7, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:08:08');
INSERT INTO `gen_table_column` VALUES (8, 1, 'create_by', '创建人id', 'bigint', 'Long', 'createBy', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:08:08');
INSERT INTO `gen_table_column` VALUES (9, 1, 'update_by', '更新人id', 'bigint', 'Long', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:08:08');
INSERT INTO `gen_table_column` VALUES (10, 1, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'input', '', 10, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:08:08');
INSERT INTO `gen_table_column` VALUES (11, 1, 'update_time', '更新时间', 'datetime', 'LocalDateTime', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'datetime', '', 11, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:08:08');
INSERT INTO `gen_table_column` VALUES (12, 2, 'id', '编号', 'int', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:57');
INSERT INTO `gen_table_column` VALUES (13, 2, 'sort_no', '排序号', 'int', 'Long', 'sortNo', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 2, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:57');
INSERT INTO `gen_table_column` VALUES (14, 2, 'plan_name', '名称', 'varchar(255)', 'String', 'planName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:57');
INSERT INTO `gen_table_column` VALUES (15, 2, 'status', '状态 0禁用 1启用', 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'radio', '', 4, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:57');
INSERT INTO `gen_table_column` VALUES (16, 2, 'create_time', '创建时间', 'datetime', 'LocalDateTime', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'datetime', '', 5, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:57');
INSERT INTO `gen_table_column` VALUES (17, 2, 'update_time', '更新时间', 'datetime', 'LocalDateTime', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'datetime', '', 6, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:57');
INSERT INTO `gen_table_column` VALUES (18, 2, 'create_by', '创建人id', 'bigint', 'Long', 'createBy', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:57');
INSERT INTO `gen_table_column` VALUES (19, 2, 'update_by', '更新人id', 'bigint', 'Long', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:57');
INSERT INTO `gen_table_column` VALUES (20, 2, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'input', '', 9, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:57');
INSERT INTO `gen_table_column` VALUES (21, 3, 'id', '编号', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:46');
INSERT INTO `gen_table_column` VALUES (22, 3, 'name', '名称', 'varchar(100)', 'String', 'name', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:46');
INSERT INTO `gen_table_column` VALUES (23, 3, 'order_no', '排序号', 'int', 'Long', 'orderNo', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 3, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:46');
INSERT INTO `gen_table_column` VALUES (24, 3, 'unit', '单位', 'varchar(50)', 'String', 'unit', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 4, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:46');
INSERT INTO `gen_table_column` VALUES (25, 3, 'price', '价格', 'decimal(10,2)', 'BigDecimal', 'price', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 5, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:46');
INSERT INTO `gen_table_column` VALUES (26, 3, 'image', '图片', 'varchar(255)', 'String', 'image', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'imageUpload', '', 6, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:46');
INSERT INTO `gen_table_column` VALUES (27, 3, 'nursing_requirement', '护理要求', 'varchar(255)', 'String', 'nursingRequirement', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 7, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:46');
INSERT INTO `gen_table_column` VALUES (28, 3, 'status', '状态（0：禁用，1：启用）', 'int', 'Long', 'status', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'radio', '', 8, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:46');
INSERT INTO `gen_table_column` VALUES (29, 3, 'create_by', '创建人', 'varchar(50)', 'String', 'createBy', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:46');
INSERT INTO `gen_table_column` VALUES (30, 3, 'update_by', '更新人', 'varchar(50)', 'String', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:46');
INSERT INTO `gen_table_column` VALUES (31, 3, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'input', '', 11, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:46');
INSERT INTO `gen_table_column` VALUES (32, 3, 'create_time', '创建时间', 'datetime', 'LocalDateTime', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'datetime', '', 12, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:46');
INSERT INTO `gen_table_column` VALUES (33, 3, 'update_time', '更新时间', 'datetime', 'LocalDateTime', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'datetime', '', 13, 'admin', '2026-03-22 14:24:11', '', '2026-03-22 16:07:46');
INSERT INTO `gen_table_column` VALUES (34, 4, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (35, 4, 'elder_name', '老人姓名', 'varchar(50)', 'String', 'elderName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (36, 4, 'elder_id', '老人ID', 'bigint', 'Long', 'elderId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (37, 4, 'id_card_no', '身份证号', 'char(18)', 'String', 'idCardNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (38, 4, 'start_date', '入住开始时间', 'date', 'LocalDateTime', 'startDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (39, 4, 'end_date', '入住结束时间', 'date', 'LocalDateTime', 'endDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (40, 4, 'nursing_level_name', '护理等级名称', 'varchar(50)', 'String', 'nursingLevelName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 7, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (41, 4, 'bed_number', '入住床位', 'varchar(50)', 'String', 'bedNumber', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (42, 4, 'status', '状态 (0: 已入住, 1: 已退住)', 'tinyint', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 9, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (43, 4, 'sort_order', '排序编号', 'int', 'Integer', 'sortOrder', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (44, 4, 'create_time', '创建时间', 'timestamp', 'LocalDateTime', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (45, 4, 'update_time', '修改时间', 'timestamp', 'LocalDateTime', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (46, 4, 'create_by', '创建人', 'varchar(50)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (47, 4, 'update_by', '修改人', 'varchar(50)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (48, 4, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 15, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:40:06');
INSERT INTO `gen_table_column` VALUES (49, 5, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (50, 5, 'check_in_id', '入住表ID', 'bigint', 'Long', 'checkInId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (51, 5, 'nursing_level_id', '护理等级ID', 'bigint', 'Long', 'nursingLevelId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (52, 5, 'nursing_level_name', '护理等级名称', 'varchar(50)', 'String', 'nursingLevelName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (53, 5, 'fee_start_date', '费用开始时间', 'date', 'LocalDateTime', 'feeStartDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (54, 5, 'fee_end_date', '费用结束时间', 'date', 'LocalDateTime', 'feeEndDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2026-03-22 16:08:25', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (55, 5, 'deposit', '押金（元）', 'decimal(10,2)', 'BigDecimal', 'deposit', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (56, 5, 'nursing_fee', '护理费用（元/月）', 'decimal(10,2)', 'BigDecimal', 'nursingFee', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (57, 5, 'bed_fee', '床位费用（元/月）', 'decimal(10,2)', 'BigDecimal', 'bedFee', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (58, 5, 'insurance_payment', '医保支付（元/月）', 'decimal(10,2)', 'BigDecimal', 'insurancePayment', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (59, 5, 'government_subsidy', '政府补贴（元/月）', 'decimal(10,2)', 'BigDecimal', 'governmentSubsidy', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (60, 5, 'other_fees', '其他费用（元/月）', 'decimal(10,2)', 'BigDecimal', 'otherFees', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (61, 5, 'sort_order', '排序编号', 'int', 'Integer', 'sortOrder', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 13, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (62, 5, 'create_time', '创建时间', 'timestamp', 'LocalDateTime', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 14, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (63, 5, 'update_time', '修改时间', 'timestamp', 'LocalDateTime', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 15, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (64, 5, 'create_by', '创建人', 'varchar(50)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 16, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (65, 5, 'update_by', '修改人', 'varchar(50)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 17, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (66, 5, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 18, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:39:48');
INSERT INTO `gen_table_column` VALUES (67, 6, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (68, 6, 'elder_id', '老人ID', 'int', 'Long', 'elderId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (69, 6, 'contract_name', '合同名称', 'varchar(100)', 'String', 'contractName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (70, 6, 'contract_number', '合同编号', 'varchar(50)', 'String', 'contractNumber', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (71, 6, 'agreement_path', '协议地址（文件路径或URL）', 'varchar(255)', 'String', 'agreementPath', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (72, 6, 'third_party_phone', '丙方手机号', 'varchar(20)', 'String', 'thirdPartyPhone', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (73, 6, 'third_party_name', '丙方姓名', 'varchar(50)', 'String', 'thirdPartyName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 7, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (74, 6, 'elder_name', '老人姓名', 'varchar(50)', 'String', 'elderName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 8, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (75, 6, 'start_date', '开始时间', 'date', 'LocalDateTime', 'startDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 9, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (76, 6, 'end_date', '结束时间', 'date', 'Date', 'endDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 10, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (77, 6, 'status', '状态 (0: 未生效, 1: 已生效, 2: 已过期, 3: 已失效)', 'tinyint', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 11, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (78, 6, 'sign_date', '签约日期', 'date', 'LocalDateTime', 'signDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 12, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (79, 6, 'termination_submitter', '解除提交人', 'varchar(50)', 'String', 'terminationSubmitter', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 13, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (80, 6, 'termination_date', '解除日期', 'date', 'LocalDateTime', 'terminationDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 14, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (81, 6, 'termination_agreement_path', '解除协议地址（文件路径或URL）', 'varchar(255)', 'String', 'terminationAgreementPath', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 15, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (82, 6, 'sort_order', '排序编号', 'int', 'Integer', 'sortOrder', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 16, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (83, 6, 'create_time', '创建时间', 'timestamp', 'LocalDateTime', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 17, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (84, 6, 'update_time', '修改时间', 'timestamp', 'LocalDateTime', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 18, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (85, 6, 'create_by', '创建人', 'varchar(50)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 19, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (86, 6, 'update_by', '修改人', 'varchar(50)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 20, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (87, 6, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 21, 'admin', '2026-03-22 16:08:26', '', '2026-04-28 16:36:34');
INSERT INTO `gen_table_column` VALUES (88, 7, 'id', NULL, 'int', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-03-24 17:01:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (89, 7, 'plan_id', '计划id', 'int', 'Long', 'planId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-03-24 17:01:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (90, 7, 'project_id', '项目id', 'int', 'Long', 'projectId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-03-24 17:01:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (91, 7, 'execute_time', '计划执行时间', 'varchar(50)', 'String', 'executeTime', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-03-24 17:01:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (92, 7, 'execute_cycle', '执行周期 0 天 1 周 2月', 'int', 'Long', 'executeCycle', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-03-24 17:01:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (93, 7, 'execute_frequency', '执行频次', 'int', 'Long', 'executeFrequency', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-03-24 17:01:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (94, 7, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2026-03-24 17:01:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (95, 7, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2026-03-24 17:01:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (96, 7, 'create_by', '创建人id', 'bigint', 'Long', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2026-03-24 17:01:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (97, 7, 'update_by', '更新人id', 'bigint', 'Long', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2026-03-24 17:01:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (98, 7, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 11, 'admin', '2026-03-24 17:01:58', '', NULL);
INSERT INTO `gen_table_column` VALUES (99, 8, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:25:19');
INSERT INTO `gen_table_column` VALUES (100, 8, 'room_id', '所属房间ID', 'bigint', 'Long', 'roomId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:25:19');
INSERT INTO `gen_table_column` VALUES (101, 8, 'bed_no', '床位编号 (例: 101-A)', 'varchar(32)', 'String', 'bedNo', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:25:19');
INSERT INTO `gen_table_column` VALUES (102, 8, 'bed_status', '床位状态: 0-空闲, 1-占用, 2-维修中', 'tinyint', 'Integer', 'bedStatus', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 4, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:25:19');
INSERT INTO `gen_table_column` VALUES (103, 8, 'create_time', '创建时间', 'datetime', 'LocalDateTime', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'datetime', '', 5, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:25:19');
INSERT INTO `gen_table_column` VALUES (104, 8, 'update_time', '更新时间', 'datetime', 'LocalDateTime', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'datetime', '', 6, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:25:19');
INSERT INTO `gen_table_column` VALUES (105, 8, 'is_deleted', '逻辑删除', 'tinyint', 'Integer', 'isDeleted', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 7, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:25:19');
INSERT INTO `gen_table_column` VALUES (106, 9, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:35:48');
INSERT INTO `gen_table_column` VALUES (107, 9, 'elder_id', '老人ID', 'bigint', 'Long', 'elderId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:35:48');
INSERT INTO `gen_table_column` VALUES (108, 9, 'bill_month', '账单月份 (例: 2026-04)', 'varchar(10)', 'String', 'billMonth', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:35:48');
INSERT INTO `gen_table_column` VALUES (109, 9, 'bill_type', '费用类型: 1-护理费, 2-床位费, 3-餐饮费, 4-其他', 'tinyint', 'Integer', 'billType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 4, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:35:48');
INSERT INTO `gen_table_column` VALUES (110, 9, 'amount', '应收金额', 'decimal(10,2)', 'BigDecimal', 'amount', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:35:48');
INSERT INTO `gen_table_column` VALUES (111, 9, 'pay_status', '支付状态: 0-待支付, 1-已支付', 'tinyint', 'Integer', 'payStatus', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 6, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:35:48');
INSERT INTO `gen_table_column` VALUES (112, 9, 'pay_time', '实际支付时间', 'datetime', 'LocalDateTime', 'payTime', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'datetime', '', 7, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:35:48');
INSERT INTO `gen_table_column` VALUES (113, 9, 'create_time', '创建时间', 'datetime', 'LocalDateTime', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'datetime', '', 8, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:35:48');
INSERT INTO `gen_table_column` VALUES (114, 9, 'update_time', '更新时间', 'datetime', 'LocalDateTime', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'datetime', '', 9, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:35:48');
INSERT INTO `gen_table_column` VALUES (115, 9, 'is_deleted', '逻辑删除', 'tinyint', 'Integer', 'isDeleted', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 10, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:35:48');
INSERT INTO `gen_table_column` VALUES (116, 10, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:32:50');
INSERT INTO `gen_table_column` VALUES (117, 10, 'elder_id', '老人ID', 'bigint', 'Long', 'elderId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:32:50');
INSERT INTO `gen_table_column` VALUES (118, 10, 'bed_id', '分配床位ID', 'bigint', 'Long', 'bedId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:32:50');
INSERT INTO `gen_table_column` VALUES (119, 10, 'nursing_level_id', '护理等级ID (关联护理等级模块)', 'bigint', 'Long', 'nursingLevelId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:32:50');
INSERT INTO `gen_table_column` VALUES (120, 10, 'check_in_date', '实际入住日期', 'date', 'LocalDateTime', 'checkInDate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:32:50');
INSERT INTO `gen_table_column` VALUES (121, 10, 'contract_end_date', '合同到期日期', 'date', 'LocalDateTime', 'contractEndDate', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'datetime', '', 6, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:32:50');
INSERT INTO `gen_table_column` VALUES (122, 10, 'status', '记录状态: 1-生效中, 2-已结束', 'tinyint', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 7, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:32:50');
INSERT INTO `gen_table_column` VALUES (123, 10, 'create_time', '创建时间', 'datetime', 'LocalDateTime', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'datetime', '', 8, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:32:50');
INSERT INTO `gen_table_column` VALUES (124, 10, 'update_time', '更新时间', 'datetime', 'LocalDateTime', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'datetime', '', 9, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:32:50');
INSERT INTO `gen_table_column` VALUES (125, 10, 'is_deleted', '逻辑删除', 'tinyint', 'Integer', 'isDeleted', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 10, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:32:50');
INSERT INTO `gen_table_column` VALUES (126, 11, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:34:45');
INSERT INTO `gen_table_column` VALUES (127, 11, 'name', '老人姓名', 'varchar(64)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:34:45');
INSERT INTO `gen_table_column` VALUES (128, 11, 'id_card', '身份证号', 'varchar(18)', 'String', 'idCard', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:34:45');
INSERT INTO `gen_table_column` VALUES (129, 11, 'age', '年龄', 'int', 'Integer', 'age', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:34:45');
INSERT INTO `gen_table_column` VALUES (130, 11, 'gender', '性别: 1-男, 2-女', 'tinyint', 'Integer', 'gender', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:34:45');
INSERT INTO `gen_table_column` VALUES (131, 11, 'contact_phone', '家属紧急联系电话', 'varchar(20)', 'String', 'contactPhone', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:34:45');
INSERT INTO `gen_table_column` VALUES (132, 11, 'health_status', '健康状况简述', 'varchar(255)', 'String', 'healthStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 7, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:34:45');
INSERT INTO `gen_table_column` VALUES (133, 11, 'status', '当前状态: 0-待入住, 1-在院, 2-已退住', 'tinyint', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 8, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:34:45');
INSERT INTO `gen_table_column` VALUES (134, 11, 'create_time', '创建时间', 'datetime', 'LocalDateTime', 'createTime', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:34:46');
INSERT INTO `gen_table_column` VALUES (135, 11, 'update_time', '更新时间', 'datetime', 'LocalDateTime', 'updateTime', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:34:46');
INSERT INTO `gen_table_column` VALUES (136, 11, 'is_deleted', '逻辑删除', 'tinyint', 'Integer', 'isDeleted', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 11, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:34:46');
INSERT INTO `gen_table_column` VALUES (137, 12, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:29:46');
INSERT INTO `gen_table_column` VALUES (138, 12, 'elder_id', '老人ID', 'bigint', 'Long', 'elderId', '0', '0', '1', '1', '0', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:29:46');
INSERT INTO `gen_table_column` VALUES (139, 12, 'device_no', '绑定的监测设备编号', 'varchar(64)', 'String', 'deviceNo', '0', '0', '0', '1', '0', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:29:46');
INSERT INTO `gen_table_column` VALUES (140, 12, 'heart_rate', '心率 (次/分)', 'int', 'Long', 'heartRate', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 4, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:29:46');
INSERT INTO `gen_table_column` VALUES (141, 12, 'blood_pressure_high', '收缩压 (高压)', 'int', 'Long', 'bloodPressureHigh', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 5, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:29:46');
INSERT INTO `gen_table_column` VALUES (142, 12, 'blood_pressure_low', '舒张压 (低压)', 'int', 'Long', 'bloodPressureLow', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 6, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:29:46');
INSERT INTO `gen_table_column` VALUES (143, 12, 'measure_time', '测量时间', 'datetime', 'LocalDateTime', 'measureTime', '0', '0', '1', '1', '0', '1', '1', 'EQ', 'datetime', '', 7, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:29:46');
INSERT INTO `gen_table_column` VALUES (144, 12, 'is_alert', '是否触发报警: 0-正常, 1-异常报警', 'tinyint', 'Integer', 'isAlert', '0', '0', '0', '0', '0', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:29:46');
INSERT INTO `gen_table_column` VALUES (145, 12, 'create_time', '创建时间', 'datetime', 'LocalDateTime', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'datetime', '', 9, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:29:46');
INSERT INTO `gen_table_column` VALUES (146, 13, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:26:53');
INSERT INTO `gen_table_column` VALUES (147, 13, 'room_no', '房间编号 (例: 101)', 'varchar(32)', 'String', 'roomNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:26:53');
INSERT INTO `gen_table_column` VALUES (148, 13, 'floor_id', '楼层ID', 'bigint', 'Long', 'floorId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:26:53');
INSERT INTO `gen_table_column` VALUES (149, 13, 'room_type', '房间类型: 1-单人间, 2-双人间, 3-多人间', 'tinyint', 'Long', 'roomType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 4, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:26:53');
INSERT INTO `gen_table_column` VALUES (150, 13, 'status', '状态: 0-停用, 1-启用', 'tinyint', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 5, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:26:53');
INSERT INTO `gen_table_column` VALUES (151, 13, 'create_time', '创建时间', 'datetime', 'LocalDateTime', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'datetime', '', 6, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:26:53');
INSERT INTO `gen_table_column` VALUES (152, 13, 'update_time', '更新时间', 'datetime', 'LocalDateTime', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'datetime', '', 7, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:26:53');
INSERT INTO `gen_table_column` VALUES (153, 13, 'is_deleted', '逻辑删除: 0-未删除, 1-已删除', 'tinyint', 'Integer', 'isDeleted', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 8, 'admin', '2026-04-27 15:04:09', '', '2026-04-27 15:26:53');
INSERT INTO `gen_table_column` VALUES (154, 14, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-27 15:18:44', '', '2026-04-27 15:24:59');
INSERT INTO `gen_table_column` VALUES (155, 14, 'elder_id', '被访老人ID', 'bigint', 'Long', 'elderId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-27 15:18:44', '', '2026-04-27 15:24:59');
INSERT INTO `gen_table_column` VALUES (156, 14, 'visitor_name', '访客姓名', 'varchar(64)', 'String', 'visitorName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2026-04-27 15:18:44', '', '2026-04-27 15:24:59');
INSERT INTO `gen_table_column` VALUES (157, 14, 'visitor_phone', '访客手机号', 'varchar(20)', 'String', 'visitorPhone', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-04-27 15:18:44', '', '2026-04-27 15:24:59');
INSERT INTO `gen_table_column` VALUES (158, 14, 'visit_time', '预计到访时间', 'datetime', 'LocalDateTime', 'visitTime', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2026-04-27 15:18:44', '', '2026-04-27 15:24:59');
INSERT INTO `gen_table_column` VALUES (159, 14, 'visit_reason', '来访事由', 'varchar(255)', 'String', 'visitReason', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-04-27 15:18:44', '', '2026-04-27 15:24:59');
INSERT INTO `gen_table_column` VALUES (160, 14, 'status', '审批状态: 0-待审批, 1-准许, 2-拒绝, 3-已结束', 'tinyint', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 7, 'admin', '2026-04-27 15:18:44', '', '2026-04-27 15:24:59');
INSERT INTO `gen_table_column` VALUES (161, 14, 'create_time', '创建时间', 'datetime', 'LocalDateTime', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'datetime', '', 8, 'admin', '2026-04-27 15:18:44', '', '2026-04-27 15:24:59');
INSERT INTO `gen_table_column` VALUES (162, 14, 'update_time', '更新时间', 'datetime', 'LocalDateTime', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'datetime', '', 9, 'admin', '2026-04-27 15:18:44', '', '2026-04-27 15:24:59');
INSERT INTO `gen_table_column` VALUES (163, 14, 'is_deleted', '逻辑删除', 'tinyint', 'Integer', 'isDeleted', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 10, 'admin', '2026-04-27 15:18:44', '', '2026-04-27 15:24:59');
INSERT INTO `gen_table_column` VALUES (164, 15, 'id', '主键ID', 'bigint', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-04-28 16:25:15', '', NULL);
INSERT INTO `gen_table_column` VALUES (165, 15, 'floor_no', '楼层编号 (例: 1,2,3)', 'int', 'Integer', 'floorNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-04-28 16:25:15', '', NULL);
INSERT INTO `gen_table_column` VALUES (166, 15, 'floor_name', '楼层名称 (例: 1楼)', 'varchar(32)', 'String', 'floorName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2026-04-28 16:25:15', '', NULL);
INSERT INTO `gen_table_column` VALUES (167, 15, 'status', '状态: 0-停用, 1-启用', 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 4, 'admin', '2026-04-28 16:25:15', '', NULL);
INSERT INTO `gen_table_column` VALUES (168, 15, 'sort_no', '排序号', 'int', 'Integer', 'sortNo', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-04-28 16:25:15', '', NULL);
INSERT INTO `gen_table_column` VALUES (169, 15, 'create_time', '创建时间', 'datetime', 'LocalDateTime', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 6, 'admin', '2026-04-28 16:25:15', '', NULL);
INSERT INTO `gen_table_column` VALUES (170, 15, 'update_time', '更新时间', 'datetime', 'LocalDateTime', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2026-04-28 16:25:15', '', NULL);
INSERT INTO `gen_table_column` VALUES (171, 15, 'is_deleted', '逻辑删除: 0-未删除, 1-已删除', 'tinyint', 'Long', 'isDeleted', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-04-28 16:25:15', '', NULL);
INSERT INTO `gen_table_column` VALUES (172, 16, 'id', '主键', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (173, 16, 'elder_name', '老人姓名', 'varchar(255)', 'String', 'elderName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (174, 16, 'id_card', '身份证号', 'varchar(255)', 'String', 'idCard', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (175, 16, 'birth_date', '出生日期', 'datetime', 'LocalDateTime', 'birthDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 4, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (176, 16, 'age', '年龄', 'int', 'Integer', 'age', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (177, 16, 'gender', '性别(0:男，1:女)', 'int', 'Integer', 'gender', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (178, 16, 'health_score', '健康评分', 'varchar(255)', 'String', 'healthScore', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (179, 16, 'risk_level', '严重危险(健康, 提示, 风险, 危险, 严重危险)', 'varchar(255)', 'String', 'riskLevel', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (180, 16, 'suggestion_for_admission', '是否建议入住(0:建议，1:不建议)', 'int', 'Integer', 'suggestionForAdmission', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (181, 16, 'nursing_level_name', '推荐护理等级', 'varchar(255)', 'String', 'nursingLevelName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 10, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (182, 16, 'admission_status', '入住情况(0:已入住，1:未入住)', 'int', 'Integer', 'admissionStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 11, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (183, 16, 'total_check_date', '总检日期', 'varchar(64)', 'String', 'totalCheckDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (184, 16, 'physical_exam_institution', '体检机构', 'varchar(255)', 'String', 'physicalExamInstitution', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 13, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (185, 16, 'physical_report_url', '体检报告URL链接', 'varchar(255)', 'String', 'physicalReportUrl', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 14, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (186, 16, 'assessment_time', '评估时间', 'datetime', 'LocalDateTime', 'assessmentTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 15, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (187, 16, 'report_summary', '报告总结', 'text', 'String', 'reportSummary', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 16, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (188, 16, 'disease_risk', '疾病风险', 'text', 'String', 'diseaseRisk', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 17, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (189, 16, 'abnormal_analysis', '异常分析', 'text', 'String', 'abnormalAnalysis', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 18, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (190, 16, 'system_score', '健康系统分值', 'varchar(255)', 'String', 'systemScore', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 19, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (191, 16, 'create_by', '创建者', 'varchar(255)', 'String', 'createBy', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'input', '', 20, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (192, 16, 'create_time', '创建时间', 'datetime', 'LocalDateTime', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'datetime', '', 21, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (193, 16, 'update_by', '更新者', 'varchar(255)', 'String', 'updateBy', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'input', '', 22, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (194, 16, 'update_time', '更新时间', 'datetime', 'LocalDateTime', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'datetime', '', 23, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (195, 16, 'remark', '备注', 'text', 'String', 'remark', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'textarea', '', 24, 'admin', '2026-05-04 06:47:35', '', '2026-05-04 06:48:43');
INSERT INTO `gen_table_column` VALUES (196, 17, 'id', '主键', 'bigint', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2026-05-04 09:58:52', '', '2026-05-04 09:59:39');
INSERT INTO `gen_table_column` VALUES (197, 17, 'phone', '手机号', 'varchar(20)', 'String', 'phone', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2026-05-04 09:58:52', '', '2026-05-04 09:59:39');
INSERT INTO `gen_table_column` VALUES (198, 17, 'name', '名称', 'varchar(100)', 'String', 'name', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2026-05-04 09:58:52', '', '2026-05-04 09:59:39');
INSERT INTO `gen_table_column` VALUES (199, 17, 'avatar', '头像', 'varchar(255)', 'String', 'avatar', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2026-05-04 09:58:52', '', '2026-05-04 09:59:39');
INSERT INTO `gen_table_column` VALUES (200, 17, 'open_id', 'OpenID', 'varchar(255)', 'String', 'openId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2026-05-04 09:58:52', '', '2026-05-04 09:59:39');
INSERT INTO `gen_table_column` VALUES (201, 17, 'gender', '性别(0:男，1:女)', 'int', 'Integer', 'gender', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2026-05-04 09:58:52', '', '2026-05-04 09:59:39');
INSERT INTO `gen_table_column` VALUES (202, 17, 'create_time', '创建时间', 'timestamp', 'LocalDateTime', 'createTime', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'datetime', '', 7, 'admin', '2026-05-04 09:58:52', '', '2026-05-04 09:59:39');
INSERT INTO `gen_table_column` VALUES (203, 17, 'update_time', '更新时间', 'timestamp', 'LocalDateTime', 'updateTime', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'datetime', '', 8, 'admin', '2026-05-04 09:58:52', '', '2026-05-04 09:59:39');
INSERT INTO `gen_table_column` VALUES (204, 17, 'create_by', '创建人', 'bigint', 'Integer', 'createBy', '0', '0', '0', '0', NULL, '1', NULL, 'EQ', 'input', '', 9, 'admin', '2026-05-04 09:58:52', '', '2026-05-04 09:59:39');
INSERT INTO `gen_table_column` VALUES (205, 17, 'update_by', '更新人', 'bigint', 'Integer', 'updateBy', '0', '0', '0', '0', '0', '1', NULL, 'EQ', 'input', '', 10, 'admin', '2026-05-04 09:58:52', '', '2026-05-04 09:59:39');
INSERT INTO `gen_table_column` VALUES (206, 17, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 11, 'admin', '2026-05-04 09:58:52', '', '2026-05-04 09:59:39');

-- ----------------------------
-- Table structure for health_assessment
-- ----------------------------
DROP TABLE IF EXISTS `health_assessment`;
CREATE TABLE `health_assessment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `elder_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '老人姓名',
  `id_card` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号',
  `birth_date` datetime NULL DEFAULT NULL COMMENT '出生日期',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `gender` int NULL DEFAULT NULL COMMENT '性别(0:男，1:女)',
  `health_score` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '健康评分',
  `risk_level` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '严重危险(健康, 提示, 风险, 危险, 严重危险)',
  `suggestion_for_admission` int NULL DEFAULT NULL COMMENT '是否建议入住(0:建议，1:不建议)',
  `nursing_level_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '推荐护理等级',
  `admission_status` int NULL DEFAULT NULL COMMENT '入住情况(0:已入住，1:未入住)',
  `total_check_date` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '总检日期',
  `physical_exam_institution` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '体检机构',
  `physical_report_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '体检报告URL链接',
  `assessment_time` datetime NULL DEFAULT NULL COMMENT '评估时间',
  `report_summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '报告总结',
  `disease_risk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '疾病风险',
  `abnormal_analysis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '异常分析',
  `system_score` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '健康系统分值',
  `ai_result_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'AI full JSON',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `analysis_status` tinyint NOT NULL DEFAULT 1 COMMENT '0分析中 1已完成 2失败',
  `analysis_error` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分析失败原因',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '健康评估表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of health_assessment
-- ----------------------------
INSERT INTO `health_assessment` VALUES (7, '晨红茶', '21010219760910554X', '1976-09-10 00:00:00', 49, 1, '75.50', 'caution', 0, '二级护理等级', NULL, '2026-05-04', '麻雀体检', 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/05/2842fa67-db93-42b0-8554-6bb287d2dff8.pdf', '2026-05-04 17:15:27', '本次体检结果显示整体健康状况良好，但存在轻度脂肪肝倾向及血脂偏高（总胆固醇和低密度脂蛋白胆固醇均高于正常范围）。建议调整饮食结构，减少高脂肪、高糖食物的摄入，增加深海鱼类、粗粮及新鲜蔬菜的比例，并进行适量的有氧运动以控制体重和改善代谢。同时，建议在6个月后复查血脂四项及肝脏超声，以观察指标变化。', '{\"healthy\":60.0,\"caution\":20.0,\"risk\":15.0,\"danger\":5.0,\"severeDanger\":0.0}', '[{\"conclusion\":\"血脂偏高\",\"result\":\"5.45 mmol/L\",\"unit\":\"mmol/L\",\"advice\":\"建议减少高脂肪食物的摄入，增加运动量，并在6个月后复查血脂。\",\"examinationItem\":\"总胆固醇 (TC)\",\"referenceValue\":\"< 5.18 mmol/L\",\"interpret\":\"总胆固醇水平高于正常范围，可能增加心血管疾病的风险。\"},{\"conclusion\":\"低密度脂蛋白胆固醇偏高\",\"result\":\"3.62 mmol/L\",\"unit\":\"mmol/L\",\"advice\":\"建议改善饮食习惯，减少饱和脂肪和胆固醇的摄入，增加膳食纤维的摄入，并进行适量的有氧运动。\",\"examinationItem\":\"低密度脂蛋白 (LDL-C)\",\"referenceValue\":\"< 3.37 mmol/L\",\"interpret\":\"低密度脂蛋白胆固醇水平高于正常范围，是动脉粥样硬化的危险因素之一。\"},{\"conclusion\":\"轻度脂肪肝倾向\",\"result\":\"肝脏回声稍增强，分布尚均匀，血管纹理清晰\",\"unit\":\"无\",\"advice\":\"建议调整饮食结构，减少高脂肪、高糖食物的摄入，增加运动量，以控制体重和改善代谢。\",\"examinationItem\":\"腹部超声\",\"referenceValue\":\"正常肝脏超声表现\",\"interpret\":\"腹部超声显示肝脏回声稍增强，提示可能有轻度脂肪肝倾向。\"}]', '{\"breathingSystem\":85,\"digestiveSystem\":70,\"endocrineSystem\":65,\"immuneSystem\":80,\"circulatorySystem\":60,\"urinarySystem\":90,\"motionSystem\":75,\"senseSystem\":95}', '{\n    \"totalCheckDate\": \"2026-05-04\",\n    \"healthAssessment\": {\n        \"riskLevel\": \"caution\",\n        \"healthIndex\": 75.50 \n    },\n    \"riskDistribution\": {\n        \"healthy\": 60.00, \n        \"caution\": 20.00, \n        \"risk\": 15.00, \n        \"danger\": 5.00, \n        \"severeDanger\": 0.00 \n    },\n    \"abnormalData\": [\n        {\n            \"conclusion\": \"血脂偏高\",\n            \"examinationItem\": \"总胆固醇 (TC)\",\n            \"result\": \"5.45 mmol/L\",\n            \"referenceValue\": \"< 5.18 mmol/L\",\n            \"unit\": \"mmol/L\",\n            \"interpret\": \"总胆固醇水平高于正常范围，可能增加心血管疾病的风险。\",\n            \"advice\": \"建议减少高脂肪食物的摄入，增加运动量，并在6个月后复查血脂。\"\n        },\n        {\n            \"conclusion\": \"低密度脂蛋白胆固醇偏高\",\n            \"examinationItem\": \"低密度脂蛋白 (LDL-C)\",\n            \"result\": \"3.62 mmol/L\",\n            \"referenceValue\": \"< 3.37 mmol/L\",\n            \"unit\": \"mmol/L\",\n            \"interpret\": \"低密度脂蛋白胆固醇水平高于正常范围，是动脉粥样硬化的危险因素之一。\",\n            \"advice\": \"建议改善饮食习惯，减少饱和脂肪和胆固醇的摄入，增加膳食纤维的摄入，并进行适量的有氧运动。\"\n        },\n        {\n            \"conclusion\": \"轻度脂肪肝倾向\",\n            \"examinationItem\": \"腹部超声\",\n            \"result\": \"肝脏回声稍增强，分布尚均匀，血管纹理清晰\",\n            \"referenceValue\": \"正常肝脏超声表现\",\n            \"unit\": \"无\",\n            \"interpret\": \"腹部超声显示肝脏回声稍增强，提示可能有轻度脂肪肝倾向。\",\n            \"advice\": \"建议调整饮食结构，减少高脂肪、高糖食物的摄入，增加运动量，以控制体重和改善代谢。\"\n        }\n    ],\n    \"systemScore\": {\n        \"breathingSystem\": 85, \n        \"digestiveSystem\": 70, \n        \"endocrineSystem\": 65, \n        \"immuneSystem\": 80, \n        \"circulatorySystem\": 60, \n        \"urinarySystem\": 90, \n        \"motionSystem\": 75, \n        \"senseSystem\": 95 \n    },\n    \"summarize\": \"本次体检结果显示整体健康状况良好，但存在轻度脂肪肝倾向及血脂偏高（总胆固醇和低密度脂蛋白胆固醇均高于正常范围）。建议调整饮食结构，减少高脂肪、高糖食物的摄入，增加深海鱼类、粗粮及新鲜蔬菜的比例，并进行适量的有氧运动以控制体重和改善代谢。同时，建议在6个月后复查血脂四项及肝脏超声，以观察指标变化。\"\n}', '1', '2026-05-04 17:15:28', NULL, NULL, NULL, 1, NULL);

-- ----------------------------
-- Table structure for health_data_record
-- ----------------------------
DROP TABLE IF EXISTS `health_data_record`;
CREATE TABLE `health_data_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `elder_id` bigint NOT NULL COMMENT '老人ID',
  `device_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '绑定的监测设备编号',
  `heart_rate` int NULL DEFAULT NULL COMMENT '心率 (次/分)',
  `blood_pressure_high` int NULL DEFAULT NULL COMMENT '收缩压 (高压)',
  `blood_pressure_low` int NULL DEFAULT NULL COMMENT '舒张压 (低压)',
  `measure_time` datetime NOT NULL COMMENT '测量时间',
  `is_alert` tinyint NULL DEFAULT 0 COMMENT '是否触发报警: 0-正常, 1-异常报警',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_elder_time`(`elder_id` ASC, `measure_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '健康监测数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of health_data_record
-- ----------------------------

-- ----------------------------
-- Table structure for nursing_level
-- ----------------------------
DROP TABLE IF EXISTS `nursing_level`;
CREATE TABLE `nursing_level`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '等级名称',
  `lplan_id` int NOT NULL COMMENT '护理计划ID',
  `fee` decimal(10, 2) NOT NULL COMMENT '护理费用',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态（0：禁用，1：启用）',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '等级说明',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 78 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '护理等级表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nursing_level
-- ----------------------------
INSERT INTO `nursing_level` VALUES (77, '测试', 129, 1.00, 1, '1', '2026-04-23 00:34:07', 1, NULL, NULL, '2026-04-23 00:44:31');

-- ----------------------------
-- Table structure for nursing_plan
-- ----------------------------
DROP TABLE IF EXISTS `nursing_plan`;
CREATE TABLE `nursing_plan`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '编号',
  `sort_no` int NULL DEFAULT NULL COMMENT '排序号',
  `plan_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '名称',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态 0禁用 1启用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `plan_name`(`plan_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 135 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '护理计划表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nursing_plan
-- ----------------------------
INSERT INTO `nursing_plan` VALUES (129, 1, '护理计划1', 1, '2026-04-21 23:48:56', '2026-04-22 00:30:59', NULL, 1, NULL);

-- ----------------------------
-- Table structure for nursing_project
-- ----------------------------
DROP TABLE IF EXISTS `nursing_project`;
CREATE TABLE `nursing_project`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `order_no` int NULL DEFAULT NULL COMMENT '排序号',
  `unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单位',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `nursing_requirement` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '护理要求',
  `status` int NOT NULL DEFAULT 1 COMMENT '状态（0：禁用，1：启用）',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 97 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '护理项目表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nursing_project
-- ----------------------------
INSERT INTO `nursing_project` VALUES (84, '修剪指甲', 1, '次', 99.00, 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/4dfbc94f-e26f-49a2-899f-3d6ae80bf7f0.png', '无', 1, '1', '1', NULL, '2026-03-22 23:53:33', '2026-03-22 15:53:32');
INSERT INTO `nursing_project` VALUES (85, '洗脸', 1, '次', 5.00, 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/03/ed570085-e18c-4edd-8b2e-1b2d2b0657e1.png', '无', 1, '1', '1', NULL, '2026-03-22 23:53:57', '2026-04-22 23:42:49');
INSERT INTO `nursing_project` VALUES (86, '助浴', 1, '次', 88.00, 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/e52116c2-2e6f-4acd-9fc8-4dea46226ee7.png', '无', 1, '1', '1', NULL, '2026-04-22 23:52:22', '2026-04-22 15:52:21');
INSERT INTO `nursing_project` VALUES (88, '公共空间清洁', 1, '次', 100.00, 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/543c8f40-6a3f-49e6-b712-417ba020cf87.png', '无', 1, '1', NULL, NULL, '2026-04-22 23:53:23', '2026-04-22 15:53:22');
INSERT INTO `nursing_project` VALUES (89, '助餐', 1, '次', 20.00, 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/cede37e3-4e89-4f47-a626-5ac83b1d8654.png', '无', 1, '1', NULL, NULL, '2026-04-22 23:53:45', '2026-04-22 15:53:44');
INSERT INTO `nursing_project` VALUES (90, '复建运动', 1, '次', 88.00, 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/4b3bf106-0158-46bd-8d31-0020b91ee6bd.png', '无', 1, '1', NULL, NULL, '2026-04-22 23:54:04', '2026-04-22 15:54:03');
INSERT INTO `nursing_project` VALUES (91, '整体床铺', 1, '次', 66.00, 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/fb0ffc1f-150d-4b51-8bd4-c84f6bf5c447.png', '无', 1, '1', NULL, NULL, '2026-04-22 23:54:26', '2026-04-22 15:54:25');
INSERT INTO `nursing_project` VALUES (92, '洗头', 1, '次', 66.00, 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/11958d89-b7d4-4013-b7dc-f45d4394dfb8.png', '无', 1, '1', '1', NULL, '2026-04-22 23:54:52', '2026-04-22 15:54:51');
INSERT INTO `nursing_project` VALUES (93, '洗脚', 1, '次', 39.00, 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/6b5b8dd3-7bab-49d8-9493-dd4390d4492a.png', '无', 1, '1', NULL, NULL, '2026-04-22 23:55:16', '2026-04-22 15:55:15');
INSERT INTO `nursing_project` VALUES (94, '翻身拍背', 1, '次', 100.00, 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/448a985e-5256-4b77-934c-b0f8eb16290a.png', '无', 1, '1', NULL, NULL, '2026-04-22 23:55:34', '2026-04-22 15:55:33');
INSERT INTO `nursing_project` VALUES (95, '衣物清洁', 1, '次', 100.00, 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/af5d57cd-e495-4bb4-8f0f-408c248a9eac.png', '无', 1, '1', NULL, NULL, '2026-04-22 23:56:01', '2026-04-22 15:56:00');
INSERT INTO `nursing_project` VALUES (96, '谈心', 1, '次', 12.00, 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/c1e548ba-722e-40c8-84ed-4ddfd37f8224.png', '无', 1, '1', NULL, NULL, '2026-04-22 23:56:17', '2026-04-22 15:56:17');

-- ----------------------------
-- Table structure for nursing_project_plan
-- ----------------------------
DROP TABLE IF EXISTS `nursing_project_plan`;
CREATE TABLE `nursing_project_plan`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `plan_id` int NOT NULL COMMENT '计划id',
  `project_id` int NOT NULL COMMENT '项目id',
  `execute_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '计划执行时间',
  `execute_cycle` int NOT NULL COMMENT '执行周期 0 天 1 周 2月',
  `execute_frequency` int NOT NULL COMMENT '执行频次',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1733 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '护理计划和项目关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nursing_project_plan
-- ----------------------------
INSERT INTO `nursing_project_plan` VALUES (1727, 129, 84, '20:00:00', 0, 1, '2026-04-21 15:48:55', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for reservation
-- ----------------------------
DROP TABLE IF EXISTS `reservation`;
CREATE TABLE `reservation`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '预约人姓名',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '预约人手机号',
  `time` datetime NOT NULL COMMENT '预约时间',
  `visitor` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '探访人',
  `type` int NOT NULL COMMENT '预约类型，0：参观预约，1：探访预约',
  `status` int NOT NULL COMMENT '预约状态，0：待报道，1：已完成，2：取消，3：过期',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name_mobile_time_visitor`(`mobile` ASC, `time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '预约信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reservation
-- ----------------------------

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `room_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '房间编号 (例: 101)',
  `floor_id` bigint NULL DEFAULT NULL COMMENT '楼层ID',
  `room_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房间图片URL',
  `bed_fee` decimal(10, 2) NULL DEFAULT NULL COMMENT '床位费用',
  `room_type` tinyint NULL DEFAULT 1 COMMENT '房间类型: 1-单人间, 2-双人间, 3-多人间',
  `room_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房间介绍',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态: 0-停用, 1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除: 0-未删除, 1-已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '房间信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (1, '101', 1, 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/a8241560-e820-467a-9b85-1058057d3f03.png', 200.00, 9, '单人套房', 1, '2026-04-27 16:09:34', '2026-04-27 16:09:34', 0);
INSERT INTO `room` VALUES (2, '102', 2, 'https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/12c5742c-db4f-4915-ae2b-8f881d878f5a.png', 100.00, 1, '普通单人间', 1, '2026-04-27 16:12:01', '2026-04-27 16:12:01', 0);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-03-01 18:20:30', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-03-01 18:20:30', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-03-01 18:20:30', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2026-03-01 18:20:30', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2026-03-01 18:20:30', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-03-01 18:20:30', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-01 18:20:28', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-01 18:20:28', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-01 18:20:28', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-01 18:20:28', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-01 18:20:28', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-01 18:20:28', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-01 18:20:28', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-01 18:20:28', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-01 18:20:28', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-01 18:20:28', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 128 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 0, '启用', '1', 'nursing_project_status', NULL, 'default', 'N', '0', 'admin', '2026-03-23 13:12:06', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (101, 1, '禁用', '0', 'nursing_project_status', NULL, 'default', 'N', '0', 'admin', '2026-03-23 13:12:12', 'admin', '2026-03-23 13:12:29', NULL);
INSERT INTO `sys_dict_data` VALUES (102, 0, '启用', '1', 'nursing_plan_status', NULL, 'default', 'N', '0', 'admin', '2026-03-24 17:10:53', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (103, 0, '禁用', '0', 'nursing_plan_status', NULL, 'default', 'N', '0', 'admin', '2026-03-24 17:10:58', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (104, 0, '启用', '1', 'nursing_level_status', NULL, 'default', 'N', '0', 'admin', '2026-04-22 16:11:12', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (105, 0, '禁用', '0', 'nursing_level_status', NULL, 'default', 'N', '0', 'admin', '2026-04-22 16:11:19', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (106, 0, '启用', '1', 'room_status', NULL, 'default', 'N', '0', 'admin', '2026-04-27 15:58:17', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (107, 0, '禁用', '0', 'room_status', NULL, 'default', 'N', '0', 'admin', '2026-04-27 15:58:27', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (115, 0, '单人间', '1', 'room_type', NULL, 'default', 'N', '0', 'admin', '2026-04-27 16:19:36', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (116, 0, '双人间', '2', 'room_type', NULL, 'default', 'N', '0', 'admin', '2026-04-27 16:19:52', 'admin', '2026-04-27 16:19:57', NULL);
INSERT INTO `sys_dict_data` VALUES (117, 0, '三人间', '3', 'room_type', NULL, 'default', 'N', '0', 'admin', '2026-04-27 16:20:04', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (118, 0, '四人间', '4', 'room_type', NULL, 'default', 'N', '0', 'admin', '2026-04-27 16:20:12', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (119, 0, '豪华单人间', '5', 'room_type', NULL, 'default', 'N', '0', 'admin', '2026-04-27 16:20:23', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (120, 0, '豪华双人间', '6', 'room_type', NULL, 'default', 'N', '0', 'admin', '2026-04-27 16:20:34', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (121, 0, '豪华三人间', '7', 'room_type', NULL, 'default', 'N', '0', 'admin', '2026-04-27 16:20:42', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (122, 0, '特护房', '8', 'room_type', NULL, 'default', 'N', '0', 'admin', '2026-04-27 16:20:52', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (123, 0, '单人套房', '9', 'room_type', NULL, 'default', 'N', '0', 'admin', '2026-04-27 16:21:05', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (124, 0, '双人套房', '10', 'room_type', NULL, 'default', 'N', '0', 'admin', '2026-04-27 16:21:13', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (125, 0, '空闲中', '0', 'bed_status', NULL, 'default', 'N', '0', 'admin', '2026-04-27 16:26:30', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (126, 0, '已入住', '1', 'bed_status', NULL, 'default', 'N', '0', 'admin', '2026-04-27 16:26:36', 'admin', '2026-04-27 16:26:43', NULL);
INSERT INTO `sys_dict_data` VALUES (127, 0, '请假中', '2', 'bed_status', NULL, 'default', 'N', '0', 'admin', '2026-04-27 16:26:48', 'admin', '2026-04-27 16:28:15', NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 108 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-03-01 18:20:29', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '护理项目状态', 'nursing_project_status', '0', 'admin', '2026-03-23 13:11:30', 'admin', '2026-03-23 13:14:56', '护理项目状态列表\n');
INSERT INTO `sys_dict_type` VALUES (102, '护理计划状态', 'nursing_plan_status', '0', 'admin', '2026-03-24 17:10:06', 'admin', '2026-03-24 17:10:29', '护理计划状态列表');
INSERT INTO `sys_dict_type` VALUES (103, '护理等级状态', 'nursing_level_status', '0', 'admin', '2026-04-22 16:10:42', 'admin', '2026-04-22 16:10:50', '护理等级状态列表\n');
INSERT INTO `sys_dict_type` VALUES (104, '房间状态列表', 'room_status', '0', 'admin', '2026-04-27 15:57:24', 'admin', '2026-04-27 15:57:57', '房间状态列表');
INSERT INTO `sys_dict_type` VALUES (106, '房间类型列表', 'room_type', '0', 'admin', '2026-04-27 16:19:21', '', NULL, '房间类型列表');
INSERT INTO `sys_dict_type` VALUES (107, '床位状态列表', 'bed_status', '0', 'admin', '2026-04-27 16:26:14', '', NULL, '床位状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-03-01 18:20:30', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-03-01 18:20:30', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-03-01 18:20:30', '', NULL, '');
INSERT INTO `sys_job` VALUES (100, '定时更新合同状态', 'DEFAULT', 'contractJob.updateContractStatusJob', '0 0 1 * * ?', '1', '1', '0', 'admin', '2026-05-03 13:05:08', '', '2026-05-03 13:05:54', '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
INSERT INTO `sys_job_log` VALUES (1, '定时更新合同状态', 'DEFAULT', 'contractJob.updateContractStatusJob', '定时更新合同状态 总共耗时：210毫秒', '0', '', '2026-05-03 13:05:15');
INSERT INTO `sys_job_log` VALUES (2, '定时更新合同状态', 'DEFAULT', 'contractJob.updateContractStatusJob', '定时更新合同状态 总共耗时：87毫秒', '0', '', '2026-05-04 17:00:03');

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 122 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-22 14:17:32');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-22 15:53:14');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-23 12:33:44');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-23 15:13:26');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-03-24 16:47:47');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-24 16:47:50');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-21 14:29:11');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-21 15:48:31');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-04-22 15:42:21');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-22 15:42:28');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-27 15:03:40');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-28 16:11:38');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-03 09:17:26');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-03 10:48:57');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-05-03 13:03:51');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-03 13:04:03');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-04 06:47:17');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-04 09:14:10');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-04 09:48:26');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-04 11:43:14');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-04 12:45:46');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-04 18:09:32');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2172 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-03-01 18:20:28', 'admin', '2026-04-22 16:58:53', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-03-01 18:20:28', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-03-01 18:20:28', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2026-03-01 18:20:28', '', NULL, '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-03-01 18:20:28', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-03-01 18:20:28', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-03-01 18:20:28', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-03-01 18:20:28', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2026-03-01 18:20:28', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-03-01 18:20:28', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-03-01 18:20:28', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-03-01 18:20:28', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-03-01 18:20:28', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-03-01 18:20:28', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-03-01 18:20:28', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-03-01 18:20:28', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-03-01 18:20:28', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-03-01 18:20:28', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-03-01 18:20:28', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-03-01 18:20:28', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-03-01 18:20:28', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-03-01 18:20:28', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-03-01 18:20:28', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-03-01 18:20:28', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-03-01 18:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-03-01 18:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-03-01 18:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-03-01 18:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-03-01 18:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-03-01 18:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-03-01 18:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-03-01 18:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-03-01 18:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-03-01 18:20:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '服务管理', 0, 0, 'serve', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-03-22 14:22:35', 'admin', '2026-04-22 16:58:57', '');
INSERT INTO `sys_menu` VALUES (2049, '护理项目', 2018, 1, 'project', 'serve/project/index', NULL, '', 1, 0, 'C', '0', '0', 'serve:project:list', 'component', 'admin', '2026-03-22 16:10:06', '', NULL, '护理项目菜单');
INSERT INTO `sys_menu` VALUES (2050, '护理项目查询', 2049, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:project:query', '#', 'admin', '2026-03-22 16:10:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2051, '护理项目新增', 2049, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:project:add', '#', 'admin', '2026-03-22 16:10:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2052, '护理项目修改', 2049, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:project:edit', '#', 'admin', '2026-03-22 16:10:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2053, '护理项目删除', 2049, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:project:remove', '#', 'admin', '2026-03-22 16:10:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2054, '护理项目导出', 2049, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:project:export', '#', 'admin', '2026-03-22 16:10:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2055, '护理计划', 2018, 1, 'plan', 'serve/plan/index', NULL, '', 1, 0, 'C', '0', '0', 'serve:plan:list', 'logininfor', 'admin', '2026-03-22 16:10:06', '', NULL, '护理计划菜单');
INSERT INTO `sys_menu` VALUES (2056, '护理计划查询', 2055, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:plan:query', '#', 'admin', '2026-03-22 16:10:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2057, '护理计划新增', 2055, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:plan:add', '#', 'admin', '2026-03-22 16:10:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2058, '护理计划修改', 2055, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:plan:edit', '#', 'admin', '2026-03-22 16:10:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2059, '护理计划删除', 2055, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:plan:remove', '#', 'admin', '2026-03-22 16:10:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2060, '护理计划导出', 2055, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:plan:export', '#', 'admin', '2026-03-22 16:10:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2061, '护理等级', 2018, 1, 'level', 'serve/level/index', NULL, '', 1, 0, 'C', '0', '0', 'serve:level:list', 'checkbox', 'admin', '2026-03-22 16:10:06', '', NULL, '护理等级菜单');
INSERT INTO `sys_menu` VALUES (2062, '护理等级查询', 2061, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:level:query', '#', 'admin', '2026-03-22 16:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2063, '护理等级新增', 2061, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:level:add', '#', 'admin', '2026-03-22 16:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2064, '护理等级修改', 2061, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:level:edit', '#', 'admin', '2026-03-22 16:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2065, '护理等级删除', 2061, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:level:remove', '#', 'admin', '2026-03-22 16:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2066, '护理等级导出', 2061, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:level:export', '#', 'admin', '2026-03-22 16:10:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2067, '来访管理', 0, 0, 'ppointment', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'button', 'admin', '2026-04-22 16:47:40', 'admin', '2026-04-22 16:47:51', '');
INSERT INTO `sys_menu` VALUES (2068, '预约信息', 2067, 0, 'reservation', 'serve/record/index', NULL, '', 1, 0, 'C', '0', '0', '', 'dashboard', 'admin', '2026-04-22 16:48:19', 'admin', '2026-04-27 15:51:21', '');
INSERT INTO `sys_menu` VALUES (2069, '在住管理', 0, 0, 'liveIn', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'date-range', 'admin', '2026-04-22 16:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2073, '负责老人', 2018, 4, 'oldPeople', 'serve/info/index', NULL, '', 1, 0, 'C', '0', '0', '', 'peoples', 'admin', '2026-04-22 16:59:21', 'admin', '2026-04-27 15:50:08', '');
INSERT INTO `sys_menu` VALUES (2075, '床位信息查询', 2074, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:query', '#', 'admin', '2026-04-27 15:36:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2076, '床位信息新增', 2074, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:add', '#', 'admin', '2026-04-27 15:36:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2077, '床位信息修改', 2074, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:edit', '#', 'admin', '2026-04-27 15:36:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2078, '床位信息删除', 2074, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:remove', '#', 'admin', '2026-04-27 15:36:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2079, '床位信息导出', 2074, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:export', '#', 'admin', '2026-04-27 15:36:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2080, '费用账单明细', 3, 1, 'detail', 'serve/detail/index', NULL, '', 1, 0, 'C', '1', '0', 'serve:detail:list', '#', 'admin', '2026-04-27 15:36:49', 'admin', '2026-04-28 16:21:34', '费用账单明细菜单');
INSERT INTO `sys_menu` VALUES (2081, '费用账单明细查询', 2080, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:detail:query', '#', 'admin', '2026-04-27 15:36:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2082, '费用账单明细新增', 2080, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:detail:add', '#', 'admin', '2026-04-27 15:36:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2083, '费用账单明细修改', 2080, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:detail:edit', '#', 'admin', '2026-04-27 15:36:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2084, '费用账单明细删除', 2080, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:detail:remove', '#', 'admin', '2026-04-27 15:36:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2085, '费用账单明细导出', 2080, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:detail:export', '#', 'admin', '2026-04-27 15:36:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2086, '老人档案', 3, 1, 'info', 'serve/info/index', NULL, '', 1, 0, 'C', '1', '0', 'serve:info:list', '#', 'admin', '2026-04-27 15:36:56', 'admin', '2026-04-28 16:21:37', '老人档案菜单');
INSERT INTO `sys_menu` VALUES (2087, '老人档案查询', 2086, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:info:query', '#', 'admin', '2026-04-27 15:36:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2088, '老人档案新增', 2086, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:info:add', '#', 'admin', '2026-04-27 15:36:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2089, '老人档案修改', 2086, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:info:edit', '#', 'admin', '2026-04-27 15:36:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2090, '老人档案删除', 2086, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:info:remove', '#', 'admin', '2026-04-27 15:36:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2091, '老人档案导出', 2086, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:info:export', '#', 'admin', '2026-04-27 15:36:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2092, '访客预约记录', 2068, 1, 'record', 'serve/record/index', NULL, '', 1, 0, 'C', '0', '0', 'serve:record:list', '#', 'admin', '2026-04-27 15:37:02', '', NULL, '访客预约记录菜单');
INSERT INTO `sys_menu` VALUES (2093, '访客预约记录查询', 2092, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:record:query', '#', 'admin', '2026-04-27 15:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2094, '访客预约记录新增', 2092, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:record:add', '#', 'admin', '2026-04-27 15:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2095, '访客预约记录修改', 2092, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:record:edit', '#', 'admin', '2026-04-27 15:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2096, '访客预约记录删除', 2092, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:record:remove', '#', 'admin', '2026-04-27 15:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2097, '访客预约记录导出', 2092, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:record:export', '#', 'admin', '2026-04-27 15:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2099, '房间信息查询', 2098, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:query', '#', 'admin', '2026-04-27 15:37:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2100, '房间信息新增', 2098, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:add', '#', 'admin', '2026-04-27 15:37:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2101, '房间信息修改', 2098, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:edit', '#', 'admin', '2026-04-27 15:37:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2102, '房间信息删除', 2098, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:remove', '#', 'admin', '2026-04-27 15:37:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2103, '房间信息导出', 2098, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:export', '#', 'admin', '2026-04-27 15:37:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2104, '入退管理', 0, 0, 'enterQuit', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'component', 'admin', '2026-04-28 16:13:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2106, '合同', 3, 1, 'contract', 'serve/contract/index', NULL, '', 1, 0, 'C', '1', '0', 'serve:contract:list', '#', 'admin', '2026-04-28 16:41:27', 'admin', '2026-04-28 16:47:21', '合同菜单');
INSERT INTO `sys_menu` VALUES (2107, '合同查询', 2106, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:contract:query', '#', 'admin', '2026-04-28 16:41:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2108, '合同新增', 2106, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:contract:add', '#', 'admin', '2026-04-28 16:41:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2109, '合同修改', 2106, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:contract:edit', '#', 'admin', '2026-04-28 16:41:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2110, '合同删除', 2106, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:contract:remove', '#', 'admin', '2026-04-28 16:41:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2111, '合同导出', 2106, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:contract:export', '#', 'admin', '2026-04-28 16:41:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2112, '入住配置', 3, 1, 'checkInConfig', 'serve/checkInConfig/index', NULL, '', 1, 0, 'C', '1', '0', 'serve:checkInConfig:list', '#', 'admin', '2026-04-28 16:41:33', 'admin', '2026-04-28 16:47:16', '入住配置菜单');
INSERT INTO `sys_menu` VALUES (2113, '入住配置查询', 2112, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:checkInConfig:query', '#', 'admin', '2026-04-28 16:41:33', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2114, '入住配置新增', 2112, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:checkInConfig:add', '#', 'admin', '2026-04-28 16:41:33', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2115, '入住配置修改', 2112, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:checkInConfig:edit', '#', 'admin', '2026-04-28 16:41:33', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2116, '入住配置删除', 2112, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:checkInConfig:remove', '#', 'admin', '2026-04-28 16:41:33', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2117, '入住配置导出', 2112, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:checkInConfig:export', '#', 'admin', '2026-04-28 16:41:33', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2118, '入住办理', 2104, 1, 'checkIn', 'serve/checkIn/index', NULL, '', 1, 0, 'C', '0', '0', 'serve:checkIn:list', 'edit', 'admin', '2026-04-28 16:41:39', 'admin', '2026-04-28 16:50:06', '入住登记菜单');
INSERT INTO `sys_menu` VALUES (2119, '入住登记查询', 2118, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:checkIn:query', '#', 'admin', '2026-04-28 16:41:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2120, '入住登记新增', 2118, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:checkIn:add', '#', 'admin', '2026-04-28 16:41:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2121, '入住登记修改', 2118, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:checkIn:edit', '#', 'admin', '2026-04-28 16:41:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2122, '入住登记删除', 2118, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:checkIn:remove', '#', 'admin', '2026-04-28 16:41:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2123, '入住登记导出', 2118, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:checkIn:export', '#', 'admin', '2026-04-28 16:41:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2124, '入住申请', 2104, 2, 'checkIn-apply', 'serve/checkIn/apply', NULL, 'CheckInApplyPage', 1, 0, 'C', '1', '0', 'serve:checkIn:add', 'form', 'admin', '2026-05-03 13:16:09', 'admin', '2026-05-04 07:11:21', '发起入住申请；组件对应 views/serve/checkIn/apply.vue；接口需 serve:checkIn:add');
INSERT INTO `sys_menu` VALUES (2125, '健康评估', 2104, 1, 'assessment', 'serve/assessment/index', NULL, '', 1, 0, 'C', '0', '0', 'serve:assessment:list', 'documentation', 'admin', '2026-05-04 06:50:24', 'admin', '2026-05-04 07:11:30', '健康评估菜单');
INSERT INTO `sys_menu` VALUES (2126, '健康评估查询', 2125, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:assessment:query', '#', 'admin', '2026-05-04 06:50:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2127, '健康评估新增', 2125, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:assessment:add', '#', 'admin', '2026-05-04 06:50:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2128, '健康评估修改', 2125, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:assessment:edit', '#', 'admin', '2026-05-04 06:50:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2129, '健康评估删除', 2125, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:assessment:remove', '#', 'admin', '2026-05-04 06:50:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2130, '健康评估导出', 2125, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:assessment:export', '#', 'admin', '2026-05-04 06:50:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2148, '房型设置', 2069, 0, 'room', 'serve/room/index', NULL, 'ServeRoom', 1, 0, 'C', '0', '0', 'serve:room:list', 'table', 'admin', '2026-05-04 13:24:24', '', NULL, '在住-房型');
INSERT INTO `sys_menu` VALUES (2149, '房型查询', 2148, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:query', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2150, '房型新增', 2148, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:add', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2151, '房型修改', 2148, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:edit', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2152, '房型删除', 2148, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:remove', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2153, '房型导出', 2148, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:room:export', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2154, '楼层管理', 2069, 1, 'floor', 'serve/floor/index', NULL, 'ServeFloor', 1, 0, 'C', '0', '0', 'serve:floor:list', 'build', 'admin', '2026-05-04 13:24:24', '', NULL, '在住-楼层');
INSERT INTO `sys_menu` VALUES (2155, '楼层查询', 2154, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:query', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2156, '楼层新增', 2154, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:add', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2157, '楼层修改', 2154, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:edit', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2158, '楼层删除', 2154, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:remove', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2159, '楼层导出', 2154, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:floor:export', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2160, '床位预览', 2069, 2, 'bedPreview', 'serve/bed/index', NULL, 'ServeBedPreview', 1, 0, 'C', '0', '0', 'serve:bed:list', 'nested', 'admin', '2026-05-04 13:24:24', '', NULL, '在住-床位预览');
INSERT INTO `sys_menu` VALUES (2161, '床位查询', 2160, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:query', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2162, '床位新增', 2160, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:add', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2163, '床位修改', 2160, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:edit', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2164, '床位删除', 2160, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:remove', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2165, '床位导出', 2160, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:export', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2166, '智能床位', 2069, 3, 'smartBed', 'serve/bed/index', NULL, 'ServeSmartBed', 1, 0, 'C', '0', '0', 'serve:bed:list', 'guide', 'admin', '2026-05-04 13:24:24', '', NULL, '在住-智能床位');
INSERT INTO `sys_menu` VALUES (2167, '床位查询', 2166, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:query', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2168, '床位新增', 2166, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:add', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2169, '床位修改', 2166, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:edit', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2170, '床位删除', 2166, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:remove', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2171, '床位导出', 2166, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'serve:bed:export', '#', 'admin', '2026-05-04 13:24:24', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-03-01 18:20:30', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-03-01 18:20:30', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 334 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"服务管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"serve\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 14:22:35', 95);
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 6, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"nursing_plan,nursing_project,nursing_level\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 14:24:11', 434);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-03-22 14:22:35\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2018,\"menuName\":\"服务管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"serve\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 14:26:24', 25);
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-03-22 14:22:35\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2018,\"menuName\":\"服务管理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"serve\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 14:27:57', 31);
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-03-22 14:22:35\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2018,\"menuName\":\"服务管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"serve\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 14:28:22', 17);
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/level/index\",\"createTime\":\"2026-03-22 14:33:28\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"护理等级\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2018,\"path\":\"level\",\"perms\":\"serve:level:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 14:39:39', 29);
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/plan/index\",\"createTime\":\"2026-03-22 14:33:28\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2037,\"menuName\":\"护理计划\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2018,\"path\":\"plan\",\"perms\":\"serve:plan:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 14:39:45', 23);
INSERT INTO `sys_oper_log` VALUES (107, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/plan/index\",\"createTime\":\"2026-03-22 14:33:28\",\"icon\":\"logininfor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2037,\"menuName\":\"护理计划\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2018,\"path\":\"plan\",\"perms\":\"serve:plan:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 14:41:36', 26);
INSERT INTO `sys_oper_log` VALUES (108, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/level/index\",\"createTime\":\"2026-03-22 14:33:28\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"护理等级\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2018,\"path\":\"level\",\"perms\":\"serve:level:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 14:41:58', 23);
INSERT INTO `sys_oper_log` VALUES (109, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/project/index\",\"createTime\":\"2026-03-22 14:33:28\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2043,\"menuName\":\"护理项目\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2018,\"path\":\"project\",\"perms\":\"serve:project:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 14:42:41', 23);
INSERT INTO `sys_oper_log` VALUES (110, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/project/index\",\"createTime\":\"2026-03-22 14:33:28\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2043,\"menuName\":\"护理项目\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2018,\"path\":\"project\",\"perms\":\"serve:project:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 14:43:04', 24);
INSERT INTO `sys_oper_log` VALUES (111, '护理项目', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.add()', 'POST', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-03-22 23:53:33\",\"id\":84,\"name\":\"洗脚\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":99,\"unit\":\"次\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 15:53:32', 140);
INSERT INTO `sys_oper_log` VALUES (112, '护理项目', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.add()', 'POST', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-03-22 23:53:57\",\"id\":85,\"name\":\"洗手\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":5,\"unit\":\"次\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 15:53:57', 18);
INSERT INTO `sys_oper_log` VALUES (113, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"project\",\"className\":\"NursingProject\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"编号\",\"columnId\":21,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"名称\",\"columnId\":22,\"columnName\":\"name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"OrderNo\",\"columnComment\":\"排序号\",\"columnId\":23,\"columnName\":\"order_no\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"orderNo\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Unit\",\"columnComment\":\"单位\",\"columnId\":24,\"columnName\":\"unit\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"unit\",\"javaType\":\"String\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 16:03:57', 182);
INSERT INTO `sys_oper_log` VALUES (114, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"project\",\"className\":\"NursingProject\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"编号\",\"columnId\":21,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:03:56\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"名称\",\"columnId\":22,\"columnName\":\"name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:03:56\",\"usableColumn\":false},{\"capJavaField\":\"OrderNo\",\"columnComment\":\"排序号\",\"columnId\":23,\"columnName\":\"order_no\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"orderNo\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:03:56\",\"usableColumn\":false},{\"capJavaField\":\"Unit\",\"columnComment\":\"单位\",\"columnId\":24,\"columnName\":\"unit\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 16:04:23', 121);
INSERT INTO `sys_oper_log` VALUES (115, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"plan\",\"className\":\"NursingPlan\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"编号\",\"columnId\":12,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SortNo\",\"columnComment\":\"排序号\",\"columnId\":13,\"columnName\":\"sort_no\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"sortNo\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PlanName\",\"columnComment\":\"名称\",\"columnId\":14,\"columnName\":\"plan_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"planName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Status\",\"columnComment\":\"状态 0禁用 1启用\",\"columnId\":15,\"columnName\":\"status\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"status\",\"javaTyp', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 16:04:44', 84);
INSERT INTO `sys_oper_log` VALUES (116, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"plan\",\"className\":\"NursingPlan\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"编号\",\"columnId\":12,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:04:44\",\"usableColumn\":false},{\"capJavaField\":\"SortNo\",\"columnComment\":\"排序号\",\"columnId\":13,\"columnName\":\"sort_no\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"sortNo\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:04:44\",\"usableColumn\":false},{\"capJavaField\":\"PlanName\",\"columnComment\":\"名称\",\"columnId\":14,\"columnName\":\"plan_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"planName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:04:44\",\"usableColumn\":false},{\"capJavaField\":\"Status\",\"columnComment\":\"状态 0禁用 1启用\",\"columnId\":15,\"columnName\":\"status\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 16:05:25', 105);
INSERT INTO `sys_oper_log` VALUES (117, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"level\",\"className\":\"NursingLevel\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"等级名称\",\"columnId\":2,\"columnName\":\"name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"LplanId\",\"columnComment\":\"护理计划ID\",\"columnId\":3,\"columnName\":\"lplan_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"lplanId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Fee\",\"columnComment\":\"护理费用\",\"columnId\":4,\"columnName\":\"fee\",\"columnType\":\"decimal(10,2)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"fee\",\"javaType\":\"BigDecimal\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 16:07:09', 124);
INSERT INTO `sys_oper_log` VALUES (118, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"level\",\"className\":\"NursingLevel\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:07:09\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"等级名称\",\"columnId\":2,\"columnName\":\"name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:07:09\",\"usableColumn\":false},{\"capJavaField\":\"LplanId\",\"columnComment\":\"护理计划ID\",\"columnId\":3,\"columnName\":\"lplan_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"lplanId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:07:09\",\"usableColumn\":false},{\"capJavaField\":\"Fee\",\"columnComment\":\"护理费用\",\"columnId\":4,\"columnName\":\"fee\",\"columnType\":\"decimal(10,2)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isIns', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 16:07:23', 116);
INSERT INTO `sys_oper_log` VALUES (119, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"plan\",\"className\":\"NursingPlan\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"编号\",\"columnId\":12,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:05:25\",\"usableColumn\":false},{\"capJavaField\":\"SortNo\",\"columnComment\":\"排序号\",\"columnId\":13,\"columnName\":\"sort_no\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"sortNo\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:05:25\",\"usableColumn\":false},{\"capJavaField\":\"PlanName\",\"columnComment\":\"名称\",\"columnId\":14,\"columnName\":\"plan_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"planName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:05:25\",\"usableColumn\":false},{\"capJavaField\":\"Status\",\"columnComment\":\"状态 0禁用 1启用\",\"columnId\":15,\"columnName\":\"status\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 16:07:33', 87);
INSERT INTO `sys_oper_log` VALUES (120, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"project\",\"className\":\"NursingProject\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"编号\",\"columnId\":21,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:04:23\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"名称\",\"columnId\":22,\"columnName\":\"name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:04:23\",\"usableColumn\":false},{\"capJavaField\":\"OrderNo\",\"columnComment\":\"排序号\",\"columnId\":23,\"columnName\":\"order_no\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"orderNo\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:04:23\",\"usableColumn\":false},{\"capJavaField\":\"Unit\",\"columnComment\":\"单位\",\"columnId\":24,\"columnName\":\"unit\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 16:07:46', 117);
INSERT INTO `sys_oper_log` VALUES (121, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"plan\",\"className\":\"NursingPlan\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"编号\",\"columnId\":12,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:07:33\",\"usableColumn\":false},{\"capJavaField\":\"SortNo\",\"columnComment\":\"排序号\",\"columnId\":13,\"columnName\":\"sort_no\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"sortNo\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:07:33\",\"usableColumn\":false},{\"capJavaField\":\"PlanName\",\"columnComment\":\"名称\",\"columnId\":14,\"columnName\":\"plan_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"planName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:07:33\",\"usableColumn\":false},{\"capJavaField\":\"Status\",\"columnComment\":\"状态 0禁用 1启用\",\"columnId\":15,\"columnName\":\"status\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 16:07:52', 114);
INSERT INTO `sys_oper_log` VALUES (122, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"plan\",\"className\":\"NursingPlan\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"编号\",\"columnId\":12,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:07:52\",\"usableColumn\":false},{\"capJavaField\":\"SortNo\",\"columnComment\":\"排序号\",\"columnId\":13,\"columnName\":\"sort_no\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"sortNo\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:07:52\",\"usableColumn\":false},{\"capJavaField\":\"PlanName\",\"columnComment\":\"名称\",\"columnId\":14,\"columnName\":\"plan_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"planName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:07:52\",\"usableColumn\":false},{\"capJavaField\":\"Status\",\"columnComment\":\"状态 0禁用 1启用\",\"columnId\":15,\"columnName\":\"status\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 16:07:57', 98);
INSERT INTO `sys_oper_log` VALUES (123, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"level\",\"className\":\"NursingLevel\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:07:23\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"等级名称\",\"columnId\":2,\"columnName\":\"name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:07:23\",\"usableColumn\":false},{\"capJavaField\":\"LplanId\",\"columnComment\":\"护理计划ID\",\"columnId\":3,\"columnName\":\"lplan_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"lplanId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2026-03-22 16:07:23\",\"usableColumn\":false},{\"capJavaField\":\"Fee\",\"columnComment\":\"护理费用\",\"columnId\":4,\"columnName\":\"fee\",\"columnType\":\"decimal(10,2)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 14:24:11\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isIns', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 16:08:08', 112);
INSERT INTO `sys_oper_log` VALUES (124, '代码生成', 8, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"nursing_level\"}', NULL, 0, NULL, '2026-03-22 16:08:12', 1611);
INSERT INTO `sys_oper_log` VALUES (125, '代码生成', 8, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"nursing_level,nursing_plan,nursing_project\"}', NULL, 0, NULL, '2026-03-22 16:08:19', 713);
INSERT INTO `sys_oper_log` VALUES (126, '代码生成', 6, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"check_in,check_in_config,contract\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 16:08:26', 365);
INSERT INTO `sys_oper_log` VALUES (127, '护理项目', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"id\":85,\"params\":{},\"status\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-03-23 20:57:11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-23 12:57:11', 165);
INSERT INTO `sys_oper_log` VALUES (128, '护理项目', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"id\":85,\"params\":{},\"status\":0,\"updateBy\":\"1\",\"updateTime\":\"2026-03-23 20:57:13\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-23 12:57:12', 17);
INSERT INTO `sys_oper_log` VALUES (129, '字典类型', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"护理项目状态\",\"dictType\":\"nursing_project_status\",\"params\":{},\"remark\":\"护理项目状态列表\\n\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-23 13:11:31', 60);
INSERT INTO `sys_oper_log` VALUES (130, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"启用\",\"dictSort\":0,\"dictType\":\"nursing_project_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-23 13:12:06', 27);
INSERT INTO `sys_oper_log` VALUES (131, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"禁用\",\"dictSort\":0,\"dictType\":\"nursing_project_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-23 13:12:12', 15);
INSERT INTO `sys_oper_log` VALUES (132, '字典数据', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-03-23 13:12:12\",\"default\":false,\"dictCode\":101,\"dictLabel\":\"禁用\",\"dictSort\":1,\"dictType\":\"nursing_project_status\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-23 13:12:29', 27);
INSERT INTO `sys_oper_log` VALUES (133, '字典类型', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-03-23 13:11:30\",\"dictId\":100,\"dictName\":\"护理项目状态\",\"dictType\":\"nursing_project_status\",\"params\":{},\"remark\":\"护理项目状态列表\\n\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-23 13:14:56', 152);
INSERT INTO `sys_oper_log` VALUES (134, '护理项目', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-03-22 23:53:57\",\"id\":85,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/03/ed570085-e18c-4edd-8b2e-1b2d2b0657e1.png\",\"name\":\"洗手\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":5,\"status\":0,\"unit\":\"次\",\"updateBy\":\"1\",\"updateTime\":\"2026-03-23 20:57:13\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-23 15:57:35', 14);
INSERT INTO `sys_oper_log` VALUES (135, '护理项目', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-03-22 23:53:57\",\"id\":85,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/03/ed570085-e18c-4edd-8b2e-1b2d2b0657e1.png\",\"name\":\"洗手\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":5,\"status\":0,\"unit\":\"次\",\"updateBy\":\"1\",\"updateTime\":\"2026-03-23 20:57:13\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-23 15:57:35', 445);
INSERT INTO `sys_oper_log` VALUES (136, '护理项目', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-03-22 23:53:57\",\"id\":85,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/03/ed570085-e18c-4edd-8b2e-1b2d2b0657e1.png\",\"name\":\"洗脸\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":5,\"status\":0,\"unit\":\"次\",\"updateBy\":\"1\",\"updateTime\":\"2026-03-23 20:57:13\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-23 15:57:42', 28);
INSERT INTO `sys_oper_log` VALUES (137, '代码生成', 6, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"nursing_project_plan\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 17:01:59', 2050);
INSERT INTO `sys_oper_log` VALUES (138, '字典类型', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"护理计划状态\",\"dictType\":\"nursing_plan_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 17:10:06', 322);
INSERT INTO `sys_oper_log` VALUES (139, '字典类型', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"护理计划状态\",\"dictType\":\"nursing_plan_status\",\"params\":{},\"status\":\"0\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'nursing_plan_status\' for key \'sys_dict_type.dict_type\'\r\n### The error may exist in file [S:\\Sto-box\\700-project\\YiSmartCloud\\YiSmartCloud-background\\YiSmartCloud-system\\target\\classes\\mapper\\system\\SysDictTypeMapper.xml]\r\n### The error may involve org.FlyingSparrow.YiSmartCloud.system.mapper.SysDictTypeMapper.insertDictType-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_dict_type(      dict_name,       dict_type,       status,             create_by,      create_time    )values(      ?,       ?,       ?,             ?,      sysdate()    )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'nursing_plan_status\' for key \'sys_dict_type.dict_type\'\n; Duplicate entry \'nursing_plan_status\' for key \'sys_dict_type.dict_type\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'nursing_plan_status\' for key \'sys_dict_type.dict_type\'', '2026-03-24 17:10:07', 817);
INSERT INTO `sys_oper_log` VALUES (140, '字典类型', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-03-24 17:10:06\",\"dictId\":102,\"dictName\":\"护理计划状态\",\"dictType\":\"nursing_plan_status\",\"params\":{},\"remark\":\"护理计划状态\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 17:10:16', 389);
INSERT INTO `sys_oper_log` VALUES (141, '字典类型', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-03-24 17:10:06\",\"dictId\":102,\"dictName\":\"护理计划状态\",\"dictType\":\"nursing_plan_status\",\"params\":{},\"remark\":\"护理计划状态列表\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 17:10:29', 94);
INSERT INTO `sys_oper_log` VALUES (142, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"启用\",\"dictSort\":0,\"dictType\":\"nursing_plan_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 17:10:53', 28);
INSERT INTO `sys_oper_log` VALUES (143, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"禁用\",\"dictSort\":0,\"dictType\":\"nursing_plan_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-24 17:10:58', 28);
INSERT INTO `sys_oper_log` VALUES (144, '护理计划', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingPlanController.add()', 'POST', 1, 'admin', '研发部门', '/serve/plan', '127.0.0.1', '内网IP', '{\"planName\":\"护理计划1\",\"projectPlans\":[{\"createBy\":\"1\",\"createTime\":\"2026-04-21 23:48:55\",\"executeCycle\":0,\"executeFrequency\":1,\"executeTime\":\"20:00:00\",\"params\":{},\"projectId\":84}],\"sortNo\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-21 15:48:55', 167);
INSERT INTO `sys_oper_log` VALUES (145, '护理计划', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingPlanController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/plan', '127.0.0.1', '内网IP', '{\"id\":129,\"params\":{},\"planName\":\"护理计划1\",\"sortNo\":1,\"status\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-22 00:30:46\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-21 16:30:46', 319);
INSERT INTO `sys_oper_log` VALUES (146, '护理计划', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingPlanController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/plan', '127.0.0.1', '内网IP', '{\"id\":129,\"params\":{},\"planName\":\"护理计划1\",\"sortNo\":1,\"status\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-22 00:30:59\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-21 16:30:58', 25);
INSERT INTO `sys_oper_log` VALUES (147, '护理项目', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"id\":85,\"params\":{},\"status\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-22 23:42:49\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 15:42:48', 70);
INSERT INTO `sys_oper_log` VALUES (148, '护理项目', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.add()', 'POST', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-22 23:52:21\",\"id\":86,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/e52116c2-2e6f-4acd-9fc8-4dea46226ee7.png\",\"name\":\"助浴\",\"params\":{},\"price\":88,\"status\":1,\"unit\":\"次\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 15:52:21', 225);
INSERT INTO `sys_oper_log` VALUES (149, '护理项目', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.add()', 'POST', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-22 23:52:21\",\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/e52116c2-2e6f-4acd-9fc8-4dea46226ee7.png\",\"name\":\"助浴\",\"params\":{},\"price\":88,\"status\":1,\"unit\":\"次\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'助浴\' for key \'nursing_project.name\'\r\n### The error may exist in org/FlyingSparrow/YiSmartCloud/serve/mapper/NursingProjectMapper.java (best guess)\r\n### The error may involve org.FlyingSparrow.YiSmartCloud.serve.mapper.NursingProjectMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO nursing_project  ( name,  unit, price, image,  status, create_by, create_time )  VALUES  ( ?,  ?, ?, ?,  ?, ?, ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'助浴\' for key \'nursing_project.name\'\n; Duplicate entry \'助浴\' for key \'nursing_project.name\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'助浴\' for key \'nursing_project.name\'', '2026-04-22 15:52:21', 361);
INSERT INTO `sys_oper_log` VALUES (150, '护理项目', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-22 23:52:22\",\"id\":86,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/e52116c2-2e6f-4acd-9fc8-4dea46226ee7.png\",\"name\":\"助浴\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":88,\"status\":1,\"unit\":\"次\",\"updateBy\":\"1\",\"updateTime\":\"2026-04-22 15:52:21\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 15:52:39', 99);
INSERT INTO `sys_oper_log` VALUES (151, '护理项目', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-03-22 23:53:33\",\"id\":84,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/4dfbc94f-e26f-49a2-899f-3d6ae80bf7f0.png\",\"name\":\"修剪指甲\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":99,\"status\":1,\"unit\":\"次\",\"updateBy\":\"1\",\"updateTime\":\"2026-03-22 15:53:32\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 15:52:58', 16);
INSERT INTO `sys_oper_log` VALUES (152, '护理项目', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.add()', 'POST', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-22 23:53:22\",\"id\":88,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/543c8f40-6a3f-49e6-b712-417ba020cf87.png\",\"name\":\"公共空间清洁\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":100,\"unit\":\"次\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 15:53:22', 11);
INSERT INTO `sys_oper_log` VALUES (153, '护理项目', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.add()', 'POST', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-22 23:53:44\",\"id\":89,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/cede37e3-4e89-4f47-a626-5ac83b1d8654.png\",\"name\":\"助餐\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":20,\"status\":1,\"unit\":\"次\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 15:53:44', 12);
INSERT INTO `sys_oper_log` VALUES (154, '护理项目', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.add()', 'POST', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-22 23:54:04\",\"id\":90,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/4b3bf106-0158-46bd-8d31-0020b91ee6bd.png\",\"name\":\"复建运动\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":88,\"status\":1,\"unit\":\"次\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 15:54:03', 12);
INSERT INTO `sys_oper_log` VALUES (155, '护理项目', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.add()', 'POST', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-22 23:54:25\",\"id\":91,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/fb0ffc1f-150d-4b51-8bd4-c84f6bf5c447.png\",\"name\":\"整体床铺\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":66,\"unit\":\"次\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 15:54:25', 17);
INSERT INTO `sys_oper_log` VALUES (156, '护理项目', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.add()', 'POST', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-22 23:54:52\",\"id\":92,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/11958d89-b7d4-4013-b7dc-f45d4394dfb8.png\",\"name\":\"洗头\",\"nursingRequirement\":\"无\",\"params\":{},\"price\":66,\"status\":1,\"unit\":\"次\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 15:54:51', 15);
INSERT INTO `sys_oper_log` VALUES (157, '护理项目', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.add()', 'POST', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-22 23:55:15\",\"id\":93,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/6b5b8dd3-7bab-49d8-9493-dd4390d4492a.png\",\"name\":\"洗脚\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":39,\"status\":1,\"unit\":\"次\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 15:55:15', 13);
INSERT INTO `sys_oper_log` VALUES (158, '护理项目', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.add()', 'POST', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-22 23:55:33\",\"id\":94,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/448a985e-5256-4b77-934c-b0f8eb16290a.png\",\"name\":\"翻身拍背\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":100,\"status\":1,\"unit\":\"次\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 15:55:33', 12);
INSERT INTO `sys_oper_log` VALUES (159, '护理项目', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-22 23:54:52\",\"id\":92,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/11958d89-b7d4-4013-b7dc-f45d4394dfb8.png\",\"name\":\"洗头\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":66,\"status\":1,\"unit\":\"次\",\"updateBy\":\"1\",\"updateTime\":\"2026-04-22 15:54:51\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 15:55:37', 17);
INSERT INTO `sys_oper_log` VALUES (160, '护理项目', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.add()', 'POST', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-22 23:56:00\",\"id\":95,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/af5d57cd-e495-4bb4-8f0f-408c248a9eac.png\",\"name\":\"衣物清洁\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":100,\"status\":1,\"unit\":\"次\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 15:56:00', 15);
INSERT INTO `sys_oper_log` VALUES (161, '护理项目', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingProjectController.add()', 'POST', 1, 'admin', '研发部门', '/serve/project', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-22 23:56:17\",\"id\":96,\"image\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/c1e548ba-722e-40c8-84ed-4ddfd37f8224.png\",\"name\":\"谈心\",\"nursingRequirement\":\"无\",\"orderNo\":1,\"params\":{},\"price\":12,\"status\":1,\"unit\":\"次\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 15:56:17', 10);
INSERT INTO `sys_oper_log` VALUES (162, '护理计划', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingPlanController.add()', 'POST', 1, 'admin', '研发部门', '/serve/plan', '127.0.0.1', '内网IP', '{\"planName\":\"洗洗洗套餐\",\"projectPlans\":[{\"executeCycle\":0,\"executeFrequency\":1,\"executeTime\":\"00:02:16\",\"projectId\":\"85\"},{\"executeCycle\":0,\"executeFrequency\":1,\"executeTime\":\"00:02:22\",\"projectId\":\"92\"}],\"sortNo\":1,\"status\":1}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'remark\' in \'class org.FlyingSparrow.YiSmartCloud.serve.dto.NursingProjectPlanDto\'', '2026-04-22 16:02:43', 353);
INSERT INTO `sys_oper_log` VALUES (163, '护理计划', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingPlanController.add()', 'POST', 1, 'admin', '研发部门', '/serve/plan', '127.0.0.1', '内网IP', '{\"planName\":\"洗洗洗套餐\",\"projectPlans\":[{\"executeCycle\":0,\"executeFrequency\":1,\"executeTime\":\"00:02:16\",\"projectId\":\"85\"},{\"executeCycle\":0,\"executeFrequency\":1,\"executeTime\":\"00:02:22\",\"projectId\":\"92\"}],\"sortNo\":1,\"status\":1}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'remark\' in \'class org.FlyingSparrow.YiSmartCloud.serve.dto.NursingProjectPlanDto\'', '2026-04-22 16:02:43', 19);
INSERT INTO `sys_oper_log` VALUES (164, '护理计划', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingPlanController.add()', 'POST', 1, 'admin', '研发部门', '/serve/plan', '127.0.0.1', '内网IP', '{\"planName\":\"洗洗洗套餐\",\"projectPlans\":[{\"executeCycle\":0,\"executeFrequency\":1,\"executeTime\":\"00:02:16\",\"projectId\":\"85\"},{\"executeCycle\":0,\"executeFrequency\":1,\"executeTime\":\"00:02:22\",\"projectId\":\"92\"}],\"sortNo\":1,\"status\":1}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'remark\' in \'class org.FlyingSparrow.YiSmartCloud.serve.dto.NursingProjectPlanDto\'', '2026-04-22 16:02:44', 18);
INSERT INTO `sys_oper_log` VALUES (165, '护理计划', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingPlanController.add()', 'POST', 1, 'admin', '研发部门', '/serve/plan', '127.0.0.1', '内网IP', '{\"planName\":\"洗洗洗套餐\",\"projectPlans\":[{\"executeCycle\":0,\"executeFrequency\":1,\"executeTime\":\"00:02:16\",\"projectId\":\"85\"},{\"executeCycle\":0,\"executeFrequency\":1,\"executeTime\":\"00:02:22\",\"projectId\":\"92\"}],\"sortNo\":1,\"status\":1}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'remark\' in \'class org.FlyingSparrow.YiSmartCloud.serve.dto.NursingProjectPlanDto\'', '2026-04-22 16:02:51', 21);
INSERT INTO `sys_oper_log` VALUES (166, '字典类型', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"护理等级状态\",\"dictType\":\"nursing_level_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:10:42', 151);
INSERT INTO `sys_oper_log` VALUES (167, '字典类型', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-22 16:10:42\",\"dictId\":103,\"dictName\":\"护理等级状态\",\"dictType\":\"nursing_level_status\",\"params\":{},\"remark\":\"护理等级状态列表\\n\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:10:50', 256);
INSERT INTO `sys_oper_log` VALUES (168, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"启用\",\"dictSort\":0,\"dictType\":\"nursing_level_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:11:12', 18);
INSERT INTO `sys_oper_log` VALUES (169, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"禁用\",\"dictSort\":0,\"dictType\":\"nursing_level_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:11:19', 22);
INSERT INTO `sys_oper_log` VALUES (170, '护理计划', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingPlanController.add()', 'POST', 1, 'admin', '研发部门', '/serve/plan', '127.0.0.1', '内网IP', '{\"planName\":\"洗洗洗计划\",\"projectPlans\":[{\"executeCycle\":0,\"executeFrequency\":1,\"executeTime\":\"00:15:01\",\"projectId\":\"85\"},{\"executeCycle\":0,\"executeFrequency\":1,\"executeTime\":\"00:15:11\",\"projectId\":\"92\"}],\"sortNo\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:15:17', 303);
INSERT INTO `sys_oper_log` VALUES (171, '护理计划', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingPlanController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/plan', '127.0.0.1', '内网IP', '{\"id\":134,\"planName\":\"洗洗洗计划\",\"projectPlans\":[{\"executeCycle\":0,\"executeFrequency\":1,\"executeTime\":\"00:15:01\",\"id\":1728,\"planId\":134,\"projectId\":\"85\"}],\"sortNo\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:15:21', 61);
INSERT INTO `sys_oper_log` VALUES (172, '护理计划', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingPlanController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/plan', '127.0.0.1', '内网IP', '{\"id\":134,\"planName\":\"洗洗洗计划\",\"projectPlans\":[{\"executeCycle\":0,\"executeFrequency\":1,\"executeTime\":\"00:15:01\",\"id\":1730,\"planId\":134,\"projectId\":\"85\"},{\"executeCycle\":0,\"executeFrequency\":1,\"executeTime\":\"00:15:24\",\"projectId\":\"92\"}],\"sortNo\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:15:28', 47);
INSERT INTO `sys_oper_log` VALUES (173, '护理计划', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingPlanController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/plan', '127.0.0.1', '内网IP', '{\"id\":134,\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:15:30', 21);
INSERT INTO `sys_oper_log` VALUES (174, '护理计划', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingPlanController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/plan', '127.0.0.1', '内网IP', '{\"id\":134,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:15:32', 29);
INSERT INTO `sys_oper_log` VALUES (175, '护理计划', 3, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingPlanController.remove()', 'DELETE', 1, 'admin', '研发部门', '/serve/plan/134', '127.0.0.1', '内网IP', '134', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:15:34', 41);
INSERT INTO `sys_oper_log` VALUES (176, '护理等级', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingLevelController.add()', 'POST', 1, 'admin', '研发部门', '/serve/level', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-23 00:32:23\",\"description\":\"1\",\"fee\":1321,\"id\":76,\"name\":\"测试·\",\"params\":{},\"planId\":129,\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:32:23', 206);
INSERT INTO `sys_oper_log` VALUES (177, '护理等级', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingLevelController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/level', '127.0.0.1', '内网IP', '{\"id\":76,\"params\":{},\"status\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-23 00:32:27\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:32:26', 89);
INSERT INTO `sys_oper_log` VALUES (178, '护理等级', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingLevelController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/level', '127.0.0.1', '内网IP', '{\"id\":76,\"params\":{},\"status\":0,\"updateBy\":\"1\",\"updateTime\":\"2026-04-23 00:32:41\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:32:41', 23);
INSERT INTO `sys_oper_log` VALUES (179, '护理等级', 3, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingLevelController.remove()', 'DELETE', 1, 'admin', '研发部门', '/serve/level/76', '127.0.0.1', '内网IP', '[76]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:32:43', 97);
INSERT INTO `sys_oper_log` VALUES (180, '护理等级', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingLevelController.add()', 'POST', 1, 'admin', '研发部门', '/serve/level', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-23 00:34:06\",\"description\":\"1\",\"fee\":1,\"id\":77,\"name\":\"测试\",\"params\":{},\"planId\":129,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:34:06', 19);
INSERT INTO `sys_oper_log` VALUES (181, '护理等级', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingLevelController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/level', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-23 00:34:07\",\"description\":\"1\",\"fee\":1,\"id\":77,\"name\":\"测试\",\"params\":{},\"planId\":129,\"status\":0,\"updateBy\":\"1\",\"updateTime\":\"2026-04-23 00:44:26\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:44:26', 250);
INSERT INTO `sys_oper_log` VALUES (182, '护理等级', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.NursingLevelController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/level', '127.0.0.1', '内网IP', '{\"id\":77,\"params\":{},\"status\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-23 00:44:31\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:44:30', 32);
INSERT INTO `sys_oper_log` VALUES (183, '菜单管理', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"button\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"来访管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"ppointment\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:47:40', 50);
INSERT INTO `sys_oper_log` VALUES (184, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-04-22 16:47:40\",\"icon\":\"button\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2067,\"menuName\":\"来访管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"ppointment\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:47:51', 26);
INSERT INTO `sys_oper_log` VALUES (185, '菜单管理', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"dashboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"预约信息\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":2067,\"path\":\"reservation\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:48:19', 15);
INSERT INTO `sys_oper_log` VALUES (186, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-03-22 14:22:35\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2018,\"menuName\":\"服务管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"serve\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:48:53', 26);
INSERT INTO `sys_oper_log` VALUES (187, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-03-01 18:20:28\",\"icon\":\"system\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:49:00', 22);
INSERT INTO `sys_oper_log` VALUES (188, '菜单管理', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"在住管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"liveIn\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:51:18', 19);
INSERT INTO `sys_oper_log` VALUES (189, '菜单管理', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"size\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"房型设置\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":2069,\"path\":\"houseSet\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:51:55', 14);
INSERT INTO `sys_oper_log` VALUES (190, '菜单管理', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"tree-table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"床位预览\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":2069,\"path\":\"floor\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:52:16', 11);
INSERT INTO `sys_oper_log` VALUES (191, '菜单管理', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"online\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"只能床位\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":2069,\"path\":\"smartBed\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:52:45', 20);
INSERT INTO `sys_oper_log` VALUES (192, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-04-22 16:52:45\",\"icon\":\"online\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2072,\"menuName\":\"智能床位\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":2069,\"path\":\"smartBed\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:52:54', 21);
INSERT INTO `sys_oper_log` VALUES (193, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-03-01 18:20:28\",\"icon\":\"system\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:58:53', 22);
INSERT INTO `sys_oper_log` VALUES (194, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-03-22 14:22:35\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2018,\"menuName\":\"服务管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"serve\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:58:57', 20);
INSERT INTO `sys_oper_log` VALUES (195, '菜单管理', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"负责老人\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":2018,\"path\":\"oldPeople\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:59:21', 19);
INSERT INTO `sys_oper_log` VALUES (196, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-04-22 16:59:21\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"负责老人\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":2018,\"path\":\"oldPeople\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-22 16:59:49', 25);
INSERT INTO `sys_oper_log` VALUES (197, '代码生成', 6, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"bill_detail,health_data_record,room,bed,check_in_record,elder_info\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:04:09', 621);
INSERT INTO `sys_oper_log` VALUES (198, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"bed\",\"className\":\"Bed\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":99,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"RoomId\",\"columnComment\":\"所属房间ID\",\"columnId\":100,\"columnName\":\"room_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"roomId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BedNo\",\"columnComment\":\"床位编号 (例: 101-A)\",\"columnId\":101,\"columnName\":\"bed_no\",\"columnType\":\"varchar(32)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"bedNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BedStatus\",\"columnComment\":\"床位状态: 0-空闲, 1-占用, 2-维修中\",\"columnId\":102,\"columnName\":\"bed_status\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"jav', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:11:09', 140);
INSERT INTO `sys_oper_log` VALUES (199, '代码生成', 6, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"visit_record\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:18:44', 89);
INSERT INTO `sys_oper_log` VALUES (200, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"record\",\"className\":\"VisitRecord\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":154,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:18:44\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":14,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ElderId\",\"columnComment\":\"被访老人ID\",\"columnId\":155,\"columnName\":\"elder_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:18:44\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"elderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":14,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"VisitorName\",\"columnComment\":\"访客姓名\",\"columnId\":156,\"columnName\":\"visitor_name\",\"columnType\":\"varchar(64)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:18:44\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"visitorName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":14,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"VisitorPhone\",\"columnComment\":\"访客手机号\",\"columnId\":157,\"columnName\":\"visitor_phone\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:18:44\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isR', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:24:37', 151);
INSERT INTO `sys_oper_log` VALUES (201, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"bed\",\"className\":\"Bed\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":99,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2026-04-27 15:11:09\",\"usableColumn\":false},{\"capJavaField\":\"RoomId\",\"columnComment\":\"所属房间ID\",\"columnId\":100,\"columnName\":\"room_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"roomId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2026-04-27 15:11:09\",\"usableColumn\":false},{\"capJavaField\":\"BedNo\",\"columnComment\":\"床位编号 (例: 101-A)\",\"columnId\":101,\"columnName\":\"bed_no\",\"columnType\":\"varchar(32)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"bedNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2026-04-27 15:11:09\",\"usableColumn\":false},{\"capJavaField\":\"BedStatus\",\"columnComment\":\"床位状态: 0-空闲, 1-占用, 2-维修中\",\"columnId\":102,\"columnName\":\"bed_status\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":true,', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:24:54', 66);
INSERT INTO `sys_oper_log` VALUES (202, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"record\",\"className\":\"VisitRecord\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":154,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:18:44\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":14,\"updateBy\":\"\",\"updateTime\":\"2026-04-27 15:24:36\",\"usableColumn\":false},{\"capJavaField\":\"ElderId\",\"columnComment\":\"被访老人ID\",\"columnId\":155,\"columnName\":\"elder_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:18:44\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"elderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":14,\"updateBy\":\"\",\"updateTime\":\"2026-04-27 15:24:36\",\"usableColumn\":false},{\"capJavaField\":\"VisitorName\",\"columnComment\":\"访客姓名\",\"columnId\":156,\"columnName\":\"visitor_name\",\"columnType\":\"varchar(64)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:18:44\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"visitorName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":14,\"updateBy\":\"\",\"updateTime\":\"2026-04-27 15:24:36\",\"usableColumn\":false},{\"capJavaField\":\"VisitorPhone\",\"columnComment\":\"访客手机号\",\"columnId\":157,\"columnName\":\"visitor_phone\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:18:44\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":fal', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:24:59', 68);
INSERT INTO `sys_oper_log` VALUES (203, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"bed\",\"className\":\"Bed\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":99,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2026-04-27 15:24:54\",\"usableColumn\":false},{\"capJavaField\":\"RoomId\",\"columnComment\":\"所属房间ID\",\"columnId\":100,\"columnName\":\"room_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"roomId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2026-04-27 15:24:54\",\"usableColumn\":false},{\"capJavaField\":\"BedNo\",\"columnComment\":\"床位编号 (例: 101-A)\",\"columnId\":101,\"columnName\":\"bed_no\",\"columnType\":\"varchar(32)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"bedNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2026-04-27 15:24:54\",\"usableColumn\":false},{\"capJavaField\":\"BedStatus\",\"columnComment\":\"床位状态: 0-空闲, 1-占用, 2-维修中\",\"columnId\":102,\"columnName\":\"bed_status\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":true,', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:25:19', 65);
INSERT INTO `sys_oper_log` VALUES (204, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"room\",\"className\":\"Room\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":146,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":13,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"RoomNo\",\"columnComment\":\"房间编号 (例: 101)\",\"columnId\":147,\"columnName\":\"room_no\",\"columnType\":\"varchar(32)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"roomNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":13,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FloorId\",\"columnComment\":\"楼层ID\",\"columnId\":148,\"columnName\":\"floor_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"floorId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":13,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"RoomType\",\"columnComment\":\"房间类型: 1-单人间, 2-双人间, 3-多人间\",\"columnId\":149,\"columnName\":\"room_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:25:43', 68);
INSERT INTO `sys_oper_log` VALUES (205, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"room\",\"className\":\"Room\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":146,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":13,\"updateBy\":\"\",\"updateTime\":\"2026-04-27 15:25:43\",\"usableColumn\":false},{\"capJavaField\":\"RoomNo\",\"columnComment\":\"房间编号 (例: 101)\",\"columnId\":147,\"columnName\":\"room_no\",\"columnType\":\"varchar(32)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"roomNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":13,\"updateBy\":\"\",\"updateTime\":\"2026-04-27 15:25:43\",\"usableColumn\":false},{\"capJavaField\":\"FloorId\",\"columnComment\":\"楼层ID\",\"columnId\":148,\"columnName\":\"floor_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"floorId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":13,\"updateBy\":\"\",\"updateTime\":\"2026-04-27 15:25:43\",\"usableColumn\":false},{\"capJavaField\":\"RoomType\",\"columnComment\":\"房间类型: 1-单人间, 2-双人间, 3-多人间\",\"columnId\":149,\"columnName\":\"room_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"inser', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:26:53', 63);
INSERT INTO `sys_oper_log` VALUES (206, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"record\",\"className\":\"HealthDataRecord\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":137,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":12,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ElderId\",\"columnComment\":\"老人ID\",\"columnId\":138,\"columnName\":\"elder_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"elderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":12,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"DeviceNo\",\"columnComment\":\"绑定的监测设备编号\",\"columnId\":139,\"columnName\":\"device_no\",\"columnType\":\"varchar(64)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"deviceNo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":12,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"HeartRate\",\"columnComment\":\"心率 (次/分)\",\"columnId\":140,\"columnName\":\"heart_rate\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:29:46', 67);
INSERT INTO `sys_oper_log` VALUES (207, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"record\",\"className\":\"CheckInRecord\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":116,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ElderId\",\"columnComment\":\"老人ID\",\"columnId\":117,\"columnName\":\"elder_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"elderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BedId\",\"columnComment\":\"分配床位ID\",\"columnId\":118,\"columnName\":\"bed_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"bedId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"NursingLevelId\",\"columnComment\":\"护理等级ID (关联护理等级模块)\",\"columnId\":119,\"columnName\":\"nursing_level_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:32:50', 69);
INSERT INTO `sys_oper_log` VALUES (208, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"info\",\"className\":\"ElderInfo\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":126,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"老人姓名\",\"columnId\":127,\"columnName\":\"name\",\"columnType\":\"varchar(64)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"IdCard\",\"columnComment\":\"身份证号\",\"columnId\":128,\"columnName\":\"id_card\",\"columnType\":\"varchar(18)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"idCard\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":11,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Age\",\"columnComment\":\"年龄\",\"columnId\":129,\"columnName\":\"age\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"age\",\"javaType\":\"Integer\",\"l', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:34:46', 83);
INSERT INTO `sys_oper_log` VALUES (209, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"detail\",\"className\":\"BillDetail\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":106,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ElderId\",\"columnComment\":\"老人ID\",\"columnId\":107,\"columnName\":\"elder_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"elderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BillMonth\",\"columnComment\":\"账单月份 (例: 2026-04)\",\"columnId\":108,\"columnName\":\"bill_month\",\"columnType\":\"varchar(10)\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"billMonth\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BillType\",\"columnComment\":\"费用类型: 1-护理费, 2-床位费, 3-餐饮费, 4-其他\",\"columnId\":109,\"columnName\":\"bill_type\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:04:09\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:35:48', 78);
INSERT INTO `sys_oper_log` VALUES (210, '代码生成', 8, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"visit_record,bed,bill_detail,check_in_record,elder_info,health_data_record,room\"}', NULL, 0, NULL, '2026-04-27 15:35:56', 1181);
INSERT INTO `sys_oper_log` VALUES (211, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/info/index\",\"createTime\":\"2026-04-22 16:59:21\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2073,\"menuName\":\"负责老人\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2018,\"path\":\"oldPeople\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:50:08', 88);
INSERT INTO `sys_oper_log` VALUES (212, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/record/index\",\"createTime\":\"2026-04-22 16:48:19\",\"icon\":\"dashboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2068,\"menuName\":\"预约信息\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2067,\"path\":\"reservation\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:51:21', 27);
INSERT INTO `sys_oper_log` VALUES (213, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/bed/index\",\"createTime\":\"2026-04-22 16:51:55\",\"icon\":\"size\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2070,\"menuName\":\"房型设置\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2069,\"path\":\"houseSet\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:51:38', 20);
INSERT INTO `sys_oper_log` VALUES (214, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/room/index\",\"createTime\":\"2026-04-22 16:51:55\",\"icon\":\"size\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2070,\"menuName\":\"房型设置\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2069,\"path\":\"houseSet\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:52:12', 18);
INSERT INTO `sys_oper_log` VALUES (215, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/bed/index\",\"createTime\":\"2026-04-22 16:52:16\",\"icon\":\"tree-table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2071,\"menuName\":\"床位预览\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2069,\"path\":\"floor\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:52:19', 22);
INSERT INTO `sys_oper_log` VALUES (216, '字典类型', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"房间状态列表\",\"dictType\":\"room\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:57:24', 92);
INSERT INTO `sys_oper_log` VALUES (217, '字典类型', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:57:24\",\"dictId\":104,\"dictName\":\"房间状态列表\",\"dictType\":\"room_status\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:57:30', 79);
INSERT INTO `sys_oper_log` VALUES (218, '字典类型', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"房间类型列表\",\"dictType\":\"room_type\",\"params\":{},\"remark\":\"房间类型列表\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:57:54', 25);
INSERT INTO `sys_oper_log` VALUES (219, '字典类型', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:57:24\",\"dictId\":104,\"dictName\":\"房间状态列表\",\"dictType\":\"room_status\",\"params\":{},\"remark\":\"房间状态列表\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:57:57', 53);
INSERT INTO `sys_oper_log` VALUES (220, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"启用\",\"dictSort\":0,\"dictType\":\"room_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:58:17', 29);
INSERT INTO `sys_oper_log` VALUES (221, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"禁用\",\"dictSort\":0,\"dictType\":\"room_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:58:27', 21);
INSERT INTO `sys_oper_log` VALUES (222, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"单人房\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:58:45', 24);
INSERT INTO `sys_oper_log` VALUES (223, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"双人房\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:58:51', 23);
INSERT INTO `sys_oper_log` VALUES (224, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"三人房\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:59:00', 21);
INSERT INTO `sys_oper_log` VALUES (225, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"四人房\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"4\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:59:05', 21);
INSERT INTO `sys_oper_log` VALUES (226, '字典数据', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:58:45\",\"default\":false,\"dictCode\":108,\"dictLabel\":\"普通单人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 15:59:44', 28);
INSERT INTO `sys_oper_log` VALUES (227, '字典数据', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:58:51\",\"default\":false,\"dictCode\":109,\"dictLabel\":\"双人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"2\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:00:03', 23);
INSERT INTO `sys_oper_log` VALUES (228, '字典数据', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:58:45\",\"default\":false,\"dictCode\":108,\"dictLabel\":\"单人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:00:06', 22);
INSERT INTO `sys_oper_log` VALUES (229, '字典数据', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:59:05\",\"default\":false,\"dictCode\":111,\"dictLabel\":\"三人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"4\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:00:12', 27);
INSERT INTO `sys_oper_log` VALUES (230, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"四人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"4\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:00:17', 19);
INSERT INTO `sys_oper_log` VALUES (231, '字典数据', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:59:05\",\"default\":false,\"dictCode\":111,\"dictLabel\":\"四人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"4\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:00:24', 22);
INSERT INTO `sys_oper_log` VALUES (232, '字典数据', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:59:00\",\"default\":false,\"dictCode\":110,\"dictLabel\":\"三人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"3\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:00:30', 24);
INSERT INTO `sys_oper_log` VALUES (233, '字典数据', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-27 16:00:17\",\"default\":false,\"dictCode\":112,\"dictLabel\":\"单人套房\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"5\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:00:45', 24);
INSERT INTO `sys_oper_log` VALUES (234, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"双人套房\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"6\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:00:58', 22);
INSERT INTO `sys_oper_log` VALUES (235, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"豪华单人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"7\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:01:14', 36);
INSERT INTO `sys_oper_log` VALUES (236, '字典类型', 3, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/105', '127.0.0.1', '内网IP', '[105]', NULL, 1, '房间类型列表已分配,不能删除', '2026-04-27 16:01:29', 41);
INSERT INTO `sys_oper_log` VALUES (237, '字典类型', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-27 15:57:54\",\"dictId\":105,\"dictName\":\"房间类型列表\",\"dictType\":\"room_type\",\"params\":{},\"remark\":\"房间类型列表\",\"status\":\"1\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:01:36', 43);
INSERT INTO `sys_oper_log` VALUES (238, '字典类型', 3, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/105', '127.0.0.1', '内网IP', '[105]', NULL, 1, '房间类型列表已分配,不能删除', '2026-04-27 16:01:37', 9);
INSERT INTO `sys_oper_log` VALUES (239, '字典类型', 3, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/data/108,109,110,111,112,113,114', '127.0.0.1', '内网IP', '[108,109,110,111,112,113,114]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:01:41', 201);
INSERT INTO `sys_oper_log` VALUES (240, '字典类型', 3, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/105', '127.0.0.1', '内网IP', '[105]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:01:44', 54);
INSERT INTO `sys_oper_log` VALUES (241, '房间信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.add()', 'POST', 1, 'admin', '研发部门', '/serve/room', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:06:12\",\"params\":{},\"roomImage\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/a8241560-e820-467a-9b85-1058057d3f03.png\",\"roomNo\":\"101\",\"roomType\":1,\"status\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'\r\n### The error may exist in org/FlyingSparrow/YiSmartCloud/serve/mapper/RoomMapper.java (best guess)\r\n### The error may involve org.FlyingSparrow.YiSmartCloud.serve.mapper.RoomMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO room  ( room_no,  room_image, room_type, status,  create_by, create_time )  VALUES  ( ?,  ?, ?, ?,  ?, ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'', '2026-04-27 16:06:14', 231);
INSERT INTO `sys_oper_log` VALUES (242, '房间信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.add()', 'POST', 1, 'admin', '研发部门', '/serve/room', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:06:34\",\"params\":{},\"roomImage\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/a8241560-e820-467a-9b85-1058057d3f03.png\",\"roomNo\":\"101\",\"roomType\":1,\"status\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'\r\n### The error may exist in org/FlyingSparrow/YiSmartCloud/serve/mapper/RoomMapper.java (best guess)\r\n### The error may involve org.FlyingSparrow.YiSmartCloud.serve.mapper.RoomMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO room  ( room_no,  room_image, room_type, status,  create_by, create_time )  VALUES  ( ?,  ?, ?, ?,  ?, ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'', '2026-04-27 16:06:35', 9);
INSERT INTO `sys_oper_log` VALUES (243, '房间信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.add()', 'POST', 1, 'admin', '研发部门', '/serve/room', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:09:32\",\"id\":1,\"params\":{},\"roomImage\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/a8241560-e820-467a-9b85-1058057d3f03.png\",\"roomNo\":\"101\",\"roomType\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:09:34', 91);
INSERT INTO `sys_oper_log` VALUES (244, '房间信息', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/room', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-04-27 16:09:34\",\"id\":1,\"isDeleted\":0,\"params\":{},\"roomImage\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/a8241560-e820-467a-9b85-1058057d3f03.png\",\"roomNo\":\"101\",\"roomType\":1,\"status\":0,\"updateBy\":\"1\",\"updateTime\":\"2026-04-27 16:09:34\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:09:43', 67);
INSERT INTO `sys_oper_log` VALUES (245, '房间信息', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/room', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-04-27 16:09:34\",\"id\":1,\"isDeleted\":0,\"params\":{},\"roomImage\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/a8241560-e820-467a-9b85-1058057d3f03.png\",\"roomNo\":\"101\",\"roomType\":1,\"status\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-27 16:09:34\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:09:45', 16);
INSERT INTO `sys_oper_log` VALUES (246, '房间信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.add()', 'POST', 1, 'admin', '研发部门', '/serve/room', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:12:00\",\"id\":2,\"params\":{},\"roomImage\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/12c5742c-db4f-4915-ae2b-8f881d878f5a.png\",\"roomNo\":\"101\",\"roomType\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:12:01', 26);
INSERT INTO `sys_oper_log` VALUES (247, '字典类型', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"房间类型列表\",\"dictType\":\"room_type\",\"params\":{},\"remark\":\"房间类型列表\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:19:21', 48);
INSERT INTO `sys_oper_log` VALUES (248, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"单人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:19:36', 22);
INSERT INTO `sys_oper_log` VALUES (249, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"2\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"双人间\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:19:52', 20);
INSERT INTO `sys_oper_log` VALUES (250, '字典数据', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-27 16:19:52\",\"default\":false,\"dictCode\":116,\"dictLabel\":\"双人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"2\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:19:57', 33);
INSERT INTO `sys_oper_log` VALUES (251, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"三人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:20:04', 17);
INSERT INTO `sys_oper_log` VALUES (252, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"四人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"4\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:20:12', 23);
INSERT INTO `sys_oper_log` VALUES (253, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"豪华单人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"5\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:20:23', 21);
INSERT INTO `sys_oper_log` VALUES (254, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"豪华双人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"6\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:20:34', 15);
INSERT INTO `sys_oper_log` VALUES (255, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"豪华三人间\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"7\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:20:42', 22);
INSERT INTO `sys_oper_log` VALUES (256, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"特护房\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"8\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:20:52', 17);
INSERT INTO `sys_oper_log` VALUES (257, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"单人套房\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"9\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:21:05', 16);
INSERT INTO `sys_oper_log` VALUES (258, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"双人套房\",\"dictSort\":0,\"dictType\":\"room_type\",\"dictValue\":\"10\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:21:13', 17);
INSERT INTO `sys_oper_log` VALUES (259, '房间信息', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/room', '127.0.0.1', '内网IP', '{\"bedFee\":200,\"createTime\":\"2026-04-27 16:09:34\",\"id\":1,\"isDeleted\":0,\"params\":{},\"roomDesc\":\"单人间\",\"roomImage\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/a8241560-e820-467a-9b85-1058057d3f03.png\",\"roomNo\":\"101\",\"roomType\":1,\"status\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-27 16:09:34\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:22:35', 31);
INSERT INTO `sys_oper_log` VALUES (260, '房间信息', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/room', '127.0.0.1', '内网IP', '{\"bedFee\":100,\"createTime\":\"2026-04-27 16:12:01\",\"id\":2,\"isDeleted\":0,\"params\":{},\"roomDesc\":\"普通单人间\",\"roomImage\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/12c5742c-db4f-4915-ae2b-8f881d878f5a.png\",\"roomNo\":\"101\",\"roomType\":1,\"status\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-27 16:12:01\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:22:57', 14);
INSERT INTO `sys_oper_log` VALUES (261, '房间信息', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/room', '127.0.0.1', '内网IP', '{\"bedFee\":200,\"createTime\":\"2026-04-27 16:09:34\",\"id\":1,\"isDeleted\":0,\"params\":{},\"roomDesc\":\"单人套房\",\"roomImage\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/a8241560-e820-467a-9b85-1058057d3f03.png\",\"roomNo\":\"101\",\"roomType\":9,\"status\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-27 16:09:34\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:23:07', 12);
INSERT INTO `sys_oper_log` VALUES (262, '房间信息', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/room', '127.0.0.1', '内网IP', '{\"bedFee\":100,\"createTime\":\"2026-04-27 16:12:01\",\"id\":2,\"isDeleted\":0,\"params\":{},\"roomDesc\":\"普通单人间\",\"roomImage\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/12c5742c-db4f-4915-ae2b-8f881d878f5a.png\",\"roomNo\":\"102\",\"roomType\":1,\"status\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-27 16:12:01\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:23:12', 12);
INSERT INTO `sys_oper_log` VALUES (263, '床位信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.add()', 'POST', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"1\",\"bedStatus\":0,\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:25:30\",\"params\":{},\"roomId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'\r\n### The error may exist in org/FlyingSparrow/YiSmartCloud/serve/mapper/BedMapper.java (best guess)\r\n### The error may involve org.FlyingSparrow.YiSmartCloud.serve.mapper.BedMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO bed  ( room_id, bed_no, bed_status,  create_by, create_time )  VALUES  ( ?, ?, ?,  ?, ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'', '2026-04-27 16:25:32', 45);
INSERT INTO `sys_oper_log` VALUES (264, '床位信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.add()', 'POST', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"0\",\"bedStatus\":0,\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:25:34\",\"params\":{},\"roomId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'\r\n### The error may exist in org/FlyingSparrow/YiSmartCloud/serve/mapper/BedMapper.java (best guess)\r\n### The error may involve org.FlyingSparrow.YiSmartCloud.serve.mapper.BedMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO bed  ( room_id, bed_no, bed_status,  create_by, create_time )  VALUES  ( ?, ?, ?,  ?, ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'', '2026-04-27 16:25:35', 6);
INSERT INTO `sys_oper_log` VALUES (265, '床位信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.add()', 'POST', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"0\",\"bedStatus\":0,\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:25:40\",\"params\":{},\"roomId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'\r\n### The error may exist in org/FlyingSparrow/YiSmartCloud/serve/mapper/BedMapper.java (best guess)\r\n### The error may involve org.FlyingSparrow.YiSmartCloud.serve.mapper.BedMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO bed  ( room_id, bed_no, bed_status,  create_by, create_time )  VALUES  ( ?, ?, ?,  ?, ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'', '2026-04-27 16:25:42', 5);
INSERT INTO `sys_oper_log` VALUES (266, '字典类型', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"床位状态列表\",\"dictType\":\"bed_status\",\"params\":{},\"remark\":\"床位状态列表\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:26:14', 20);
INSERT INTO `sys_oper_log` VALUES (267, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"空闲中\",\"dictSort\":0,\"dictType\":\"bed_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:26:30', 24);
INSERT INTO `sys_oper_log` VALUES (268, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"使用中\",\"dictSort\":0,\"dictType\":\"bed_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:26:36', 25);
INSERT INTO `sys_oper_log` VALUES (269, '字典数据', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-27 16:26:36\",\"default\":false,\"dictCode\":126,\"dictLabel\":\"已入住\",\"dictSort\":0,\"dictType\":\"bed_status\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:26:43', 36);
INSERT INTO `sys_oper_log` VALUES (270, '字典数据', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"维修中\",\"dictSort\":0,\"dictType\":\"bed_status\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:26:48', 33);
INSERT INTO `sys_oper_log` VALUES (271, '床位信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.add()', 'POST', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"1\",\"bedStatus\":0,\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:27:10\",\"params\":{},\"roomId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'\r\n### The error may exist in org/FlyingSparrow/YiSmartCloud/serve/mapper/BedMapper.java (best guess)\r\n### The error may involve org.FlyingSparrow.YiSmartCloud.serve.mapper.BedMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO bed  ( room_id, bed_no, bed_status,  create_by, create_time )  VALUES  ( ?, ?, ?,  ?, ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'create_by\' in \'field list\'', '2026-04-27 16:27:11', 14);
INSERT INTO `sys_oper_log` VALUES (272, '字典数据', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-04-27 16:26:48\",\"default\":false,\"dictCode\":127,\"dictLabel\":\"请假中\",\"dictSort\":0,\"dictType\":\"bed_status\",\"dictValue\":\"2\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:28:15', 30);
INSERT INTO `sys_oper_log` VALUES (273, '床位信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.add()', 'POST', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"101-1\",\"bedStatus\":0,\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:29:32\",\"id\":1,\"params\":{},\"roomId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:29:34', 90);
INSERT INTO `sys_oper_log` VALUES (274, '床位信息', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"101-1\",\"bedStatus\":1,\"createTime\":\"2026-04-27 16:29:34\",\"id\":1,\"isDeleted\":0,\"params\":{},\"roomId\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-27 16:29:34\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:31:23', 27);
INSERT INTO `sys_oper_log` VALUES (275, '床位信息', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"101-1\",\"bedStatus\":0,\"createTime\":\"2026-04-27 16:29:34\",\"id\":1,\"isDeleted\":0,\"params\":{},\"roomId\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-27 16:29:34\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:31:26', 27);
INSERT INTO `sys_oper_log` VALUES (276, '床位信息', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"101-1\",\"bedStatus\":2,\"createTime\":\"2026-04-27 16:29:34\",\"id\":1,\"isDeleted\":0,\"params\":{},\"roomId\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-27 16:29:34\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:31:28', 27);
INSERT INTO `sys_oper_log` VALUES (277, '床位信息', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"101-1\",\"bedStatus\":0,\"createTime\":\"2026-04-27 16:29:34\",\"id\":1,\"isDeleted\":0,\"params\":{},\"roomId\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-27 16:29:34\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:31:30', 17);
INSERT INTO `sys_oper_log` VALUES (278, '床位信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.add()', 'POST', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"101-2\",\"bedStatus\":0,\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:33:37\",\"id\":2,\"params\":{},\"roomId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:33:39', 9);
INSERT INTO `sys_oper_log` VALUES (279, '床位信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.add()', 'POST', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"101-3\",\"bedStatus\":0,\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:33:42\",\"id\":3,\"params\":{},\"roomId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:33:43', 11);
INSERT INTO `sys_oper_log` VALUES (280, '床位信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.add()', 'POST', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"101-4\",\"bedStatus\":0,\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:33:50\",\"id\":4,\"params\":{},\"roomId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:33:51', 12);
INSERT INTO `sys_oper_log` VALUES (281, '床位信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.add()', 'POST', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"101-5\",\"bedStatus\":0,\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:33:52\",\"id\":5,\"params\":{},\"roomId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:33:54', 11);
INSERT INTO `sys_oper_log` VALUES (282, '床位信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.add()', 'POST', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"101-6\",\"bedStatus\":0,\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:33:55\",\"id\":6,\"params\":{},\"roomId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:33:57', 11);
INSERT INTO `sys_oper_log` VALUES (283, '床位信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.add()', 'POST', 1, 'admin', '研发部门', '/serve/bed', '127.0.0.1', '内网IP', '{\"bedNo\":\"101-7\",\"bedStatus\":0,\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:33:58\",\"id\":7,\"params\":{},\"roomId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:33:59', 15);
INSERT INTO `sys_oper_log` VALUES (284, '床位信息', 3, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.remove()', 'DELETE', 1, 'admin', '研发部门', '/serve/bed/7', '127.0.0.1', '内网IP', '[7]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:34:01', 50);
INSERT INTO `sys_oper_log` VALUES (285, '床位信息', 3, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.remove()', 'DELETE', 1, 'admin', '研发部门', '/serve/bed/6', '127.0.0.1', '内网IP', '[6]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:34:03', 12);
INSERT INTO `sys_oper_log` VALUES (286, '床位信息', 3, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.remove()', 'DELETE', 1, 'admin', '研发部门', '/serve/bed/5', '127.0.0.1', '内网IP', '[5]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:34:05', 12);
INSERT INTO `sys_oper_log` VALUES (287, '床位信息', 3, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.remove()', 'DELETE', 1, 'admin', '研发部门', '/serve/bed/4', '127.0.0.1', '内网IP', '[4]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:34:07', 22);
INSERT INTO `sys_oper_log` VALUES (288, '床位信息', 3, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.remove()', 'DELETE', 1, 'admin', '研发部门', '/serve/bed/3', '127.0.0.1', '内网IP', '[3]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:34:08', 12);
INSERT INTO `sys_oper_log` VALUES (289, '床位信息', 3, 'org.FlyingSparrow.YiSmartCloud.serve.controller.BedController.remove()', 'DELETE', 1, 'admin', '研发部门', '/serve/bed/2', '127.0.0.1', '内网IP', '[2]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:34:10', 11);
INSERT INTO `sys_oper_log` VALUES (290, '楼层信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.addFloor()', 'POST', 1, 'admin', '研发部门', '/serve/room/floor', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:45:39\",\"floorName\":\"一楼\",\"floorNo\":1,\"id\":1,\"params\":{},\"sortNo\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:45:41', 62);
INSERT INTO `sys_oper_log` VALUES (291, '房间信息', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/room', '127.0.0.1', '内网IP', '{\"bedFee\":200,\"createTime\":\"2026-04-27 16:09:34\",\"floorId\":1,\"id\":1,\"isDeleted\":0,\"params\":{},\"roomDesc\":\"单人套房\",\"roomImage\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/a8241560-e820-467a-9b85-1058057d3f03.png\",\"roomNo\":\"101\",\"roomType\":9,\"status\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-27 16:09:34\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:45:46', 35);
INSERT INTO `sys_oper_log` VALUES (292, '房间信息', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/room', '127.0.0.1', '内网IP', '{\"bedFee\":100,\"createTime\":\"2026-04-27 16:12:01\",\"floorId\":1,\"id\":2,\"isDeleted\":0,\"params\":{},\"roomDesc\":\"普通单人间\",\"roomImage\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/12c5742c-db4f-4915-ae2b-8f881d878f5a.png\",\"roomNo\":\"102\",\"roomType\":1,\"status\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-27 16:12:01\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:45:50', 16);
INSERT INTO `sys_oper_log` VALUES (293, '楼层信息', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.addFloor()', 'POST', 1, 'admin', '研发部门', '/serve/room/floor', '127.0.0.1', '内网IP', '{\"createBy\":\"1\",\"createTime\":\"2026-04-28 00:46:08\",\"floorName\":\"二楼\",\"floorNo\":2,\"id\":2,\"params\":{},\"sortNo\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:46:09', 18);
INSERT INTO `sys_oper_log` VALUES (294, '房间信息', 2, 'org.FlyingSparrow.YiSmartCloud.serve.controller.RoomController.edit()', 'PUT', 1, 'admin', '研发部门', '/serve/room', '127.0.0.1', '内网IP', '{\"bedFee\":100,\"createTime\":\"2026-04-27 16:12:01\",\"floorId\":2,\"id\":2,\"isDeleted\":0,\"params\":{},\"roomDesc\":\"普通单人间\",\"roomImage\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/04/12c5742c-db4f-4915-ae2b-8f881d878f5a.png\",\"roomNo\":\"102\",\"roomType\":1,\"status\":1,\"updateBy\":\"1\",\"updateTime\":\"2026-04-27 16:12:01\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 16:46:16', 20);
INSERT INTO `sys_oper_log` VALUES (295, '菜单管理', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"component\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"入退管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"enterQuit\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:13:49', 45);
INSERT INTO `sys_oper_log` VALUES (296, '菜单管理', 1, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"入住办理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2104,\"path\":\"checkin\",\"routeName\":\"checkin\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:14:09', 15);
INSERT INTO `sys_oper_log` VALUES (297, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/detail/index\",\"createTime\":\"2026-04-27 15:36:49\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2080,\"menuName\":\"费用账单明细\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":3,\"path\":\"detail\",\"perms\":\"serve:detail:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:21:34', 174);
INSERT INTO `sys_oper_log` VALUES (298, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/info/index\",\"createTime\":\"2026-04-27 15:36:56\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2086,\"menuName\":\"老人档案\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":3,\"path\":\"info\",\"perms\":\"serve:info:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:21:38', 22);
INSERT INTO `sys_oper_log` VALUES (299, '代码生成', 6, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"floor\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:25:15', 181);
INSERT INTO `sys_oper_log` VALUES (300, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"contract\",\"className\":\"Contract\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":67,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:26\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ElderId\",\"columnComment\":\"老人ID\",\"columnId\":68,\"columnName\":\"elder_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:26\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"elderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ContractName\",\"columnComment\":\"合同名称\",\"columnId\":69,\"columnName\":\"contract_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:26\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"contractName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ContractNumber\",\"columnComment\":\"合同编号\",\"columnId\":70,\"columnName\":\"contract_number\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:26\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:36:34', 243);
INSERT INTO `sys_oper_log` VALUES (301, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"checkIn\",\"className\":\"CheckIn\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":34,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:25\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ElderName\",\"columnComment\":\"老人姓名\",\"columnId\":35,\"columnName\":\"elder_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"elderName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ElderId\",\"columnComment\":\"老人ID\",\"columnId\":36,\"columnName\":\"elder_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"elderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"IdCardNo\",\"columnComment\":\"身份证号\",\"columnId\":37,\"columnName\":\"id_card_no\",\"columnType\":\"char(18)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"idCa', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:38:39', 108);
INSERT INTO `sys_oper_log` VALUES (302, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"checkInConfig\",\"className\":\"CheckInConfig\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":49,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:25\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CheckInId\",\"columnComment\":\"入住表ID\",\"columnId\":50,\"columnName\":\"check_in_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"checkInId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"NursingLevelId\",\"columnComment\":\"护理等级ID\",\"columnId\":51,\"columnName\":\"nursing_level_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"nursingLevelId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"NursingLevelName\",\"columnComment\":\"护理等级名称\",\"columnId\":52,\"columnName\":\"nursing_level_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:39:48', 121);
INSERT INTO `sys_oper_log` VALUES (303, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"checkIn\",\"className\":\"CheckIn\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":34,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:25\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-04-28 16:38:39\",\"usableColumn\":false},{\"capJavaField\":\"ElderName\",\"columnComment\":\"老人姓名\",\"columnId\":35,\"columnName\":\"elder_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"elderName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-04-28 16:38:39\",\"usableColumn\":false},{\"capJavaField\":\"ElderId\",\"columnComment\":\"老人ID\",\"columnId\":36,\"columnName\":\"elder_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"elderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2026-04-28 16:38:39\",\"usableColumn\":false},{\"capJavaField\":\"IdCardNo\",\"columnComment\":\"身份证号\",\"columnId\":37,\"columnName\":\"id_card_no\",\"columnType\":\"char(18)\",\"createBy\":\"admin\",\"createTime\":\"2026-03-22 16:08:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:40:06', 97);
INSERT INTO `sys_oper_log` VALUES (304, '代码生成', 8, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"check_in,check_in_config,contract\"}', NULL, 0, NULL, '2026-04-28 16:40:13', 675);
INSERT INTO `sys_oper_log` VALUES (305, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/checkInConfig/index\",\"createTime\":\"2026-04-28 16:41:33\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2112,\"menuName\":\"入住配置\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":3,\"path\":\"checkInConfig\",\"perms\":\"serve:checkInConfig:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:47:16', 67);
INSERT INTO `sys_oper_log` VALUES (306, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/contract/index\",\"createTime\":\"2026-04-28 16:41:27\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2106,\"menuName\":\"合同\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":3,\"path\":\"contract\",\"perms\":\"serve:contract:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:47:21', 18);
INSERT INTO `sys_oper_log` VALUES (307, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/checkIn/index\",\"createTime\":\"2026-04-28 16:14:09\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2105,\"menuName\":\"入住办理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2104,\"path\":\"checkin\",\"perms\":\"\",\"routeName\":\"checkin\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:48:05', 15);
INSERT INTO `sys_oper_log` VALUES (308, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2026-04-28 16:14:09\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2105,\"menuName\":\"入住办理\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2104,\"path\":\"checkin\",\"perms\":\"\",\"routeName\":\"checkin\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:48:26', 21);
INSERT INTO `sys_oper_log` VALUES (309, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/checkIn/index\",\"createTime\":\"2026-04-28 16:41:39\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2118,\"menuName\":\"入住办理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2105,\"path\":\"checkIn\",\"perms\":\"serve:checkIn:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:49:10', 16);
INSERT INTO `sys_oper_log` VALUES (310, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/checkIn/index\",\"createTime\":\"2026-04-28 16:41:39\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2118,\"menuName\":\"入住办理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2104,\"path\":\"checkIn\",\"perms\":\"serve:checkIn:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"修改菜单\'入住办理\'失败，菜单名称已存在\",\"code\":500}', 0, NULL, '2026-04-28 16:49:23', 5);
INSERT INTO `sys_oper_log` VALUES (311, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2026-04-28 16:14:09\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2105,\"menuName\":\"入住办理2\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":2104,\"path\":\"checkin\",\"perms\":\"\",\"routeName\":\"checkin\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:49:30', 16);
INSERT INTO `sys_oper_log` VALUES (312, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/checkIn/index\",\"createTime\":\"2026-04-28 16:41:39\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2118,\"menuName\":\"入住办理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2104,\"path\":\"checkIn\",\"perms\":\"serve:checkIn:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:49:36', 19);
INSERT INTO `sys_oper_log` VALUES (313, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/checkIn/index\",\"createTime\":\"2026-04-28 16:41:39\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2118,\"menuName\":\"入住办理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2104,\"path\":\"checkIn\",\"perms\":\"serve:checkIn:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:50:06', 16);
INSERT INTO `sys_oper_log` VALUES (314, '菜单管理', 3, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2105', '127.0.0.1', '内网IP', '2105', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-28 16:50:09', 66);
INSERT INTO `sys_oper_log` VALUES (315, '入住登记', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.CheckInController.add()', 'POST', 1, 'admin', '研发部门', '/serve/checkIn', '127.0.0.1', '内网IP', '{\"bedNumber\":\"101-1\",\"createBy\":\"1\",\"createTime\":\"2026-05-03 18:53:36\",\"elderName\":\"吕实萌\",\"endDate\":\"2026-06-25 23:59:59\",\"idCardNo\":\"210102197604190730\",\"nursingLevelName\":\"测试\",\"params\":{},\"remark\":\"\",\"sortOrder\":0,\"startDate\":\"2026-05-06 00:00:00\",\"status\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value\r\n### The error may exist in org/FlyingSparrow/YiSmartCloud/serve/mapper/CheckInMapper.java (best guess)\r\n### The error may involve org.FlyingSparrow.YiSmartCloud.serve.mapper.CheckInMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO check_in  ( elder_name,  id_card_no, start_date, end_date, nursing_level_name, bed_number, status, sort_order, create_by, create_time,   remark )  VALUES  ( ?,  ?, ?, ?, ?, ?, ?, ?, ?, ?,   ? )\r\n### Cause: java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value\n; Field \'elder_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value', '2026-05-03 10:53:38', 318);
INSERT INTO `sys_oper_log` VALUES (316, '入住登记', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.CheckInController.add()', 'POST', 1, 'admin', '研发部门', '/serve/checkIn', '127.0.0.1', '内网IP', '{\"bedNumber\":\"101-1\",\"createBy\":\"1\",\"createTime\":\"2026-05-03 18:53:44\",\"elderName\":\"吕实萌\",\"endDate\":\"2026-06-25 23:59:59\",\"idCardNo\":\"210102197604190730\",\"nursingLevelName\":\"测试\",\"params\":{},\"remark\":\"\",\"sortOrder\":0,\"startDate\":\"2026-05-06 00:00:00\",\"status\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value\r\n### The error may exist in org/FlyingSparrow/YiSmartCloud/serve/mapper/CheckInMapper.java (best guess)\r\n### The error may involve org.FlyingSparrow.YiSmartCloud.serve.mapper.CheckInMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO check_in  ( elder_name,  id_card_no, start_date, end_date, nursing_level_name, bed_number, status, sort_order, create_by, create_time,   remark )  VALUES  ( ?,  ?, ?, ?, ?, ?, ?, ?, ?, ?,   ? )\r\n### Cause: java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value\n; Field \'elder_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value', '2026-05-03 10:53:46', 8);
INSERT INTO `sys_oper_log` VALUES (317, '入住登记', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.CheckInController.add()', 'POST', 1, 'admin', '研发部门', '/serve/checkIn', '127.0.0.1', '内网IP', '{\"bedNumber\":\"101-1\",\"createBy\":\"1\",\"createTime\":\"2026-05-03 18:55:31\",\"elderName\":\"吕实萌\",\"endDate\":\"2026-06-25 23:59:59\",\"idCardNo\":\"210102197604190730\",\"nursingLevelName\":\"测试\",\"params\":{},\"remark\":\"\",\"sortOrder\":0,\"startDate\":\"2026-05-06 00:00:00\",\"status\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value\r\n### The error may exist in org/FlyingSparrow/YiSmartCloud/serve/mapper/CheckInMapper.java (best guess)\r\n### The error may involve org.FlyingSparrow.YiSmartCloud.serve.mapper.CheckInMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO check_in  ( elder_name,  id_card_no, start_date, end_date, nursing_level_name, bed_number, status, sort_order, create_by, create_time,   remark )  VALUES  ( ?,  ?, ?, ?, ?, ?, ?, ?, ?, ?,   ? )\r\n### Cause: java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value\n; Field \'elder_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value', '2026-05-03 10:55:33', 14);
INSERT INTO `sys_oper_log` VALUES (318, '入住登记', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.CheckInController.add()', 'POST', 1, 'admin', '研发部门', '/serve/checkIn', '127.0.0.1', '内网IP', '{\"bedNumber\":\"101-1\",\"createBy\":\"1\",\"createTime\":\"2026-05-03 18:58:02\",\"elderName\":\"吕实萌\",\"endDate\":\"2026-06-25 23:59:59\",\"idCardNo\":\"210102197604190730\",\"nursingLevelName\":\"测试\",\"params\":{},\"remark\":\"\",\"sortOrder\":0,\"startDate\":\"2026-05-06 00:00:00\",\"status\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value\r\n### The error may exist in org/FlyingSparrow/YiSmartCloud/serve/mapper/CheckInMapper.java (best guess)\r\n### The error may involve org.FlyingSparrow.YiSmartCloud.serve.mapper.CheckInMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO check_in  ( elder_name,  id_card_no, start_date, end_date, nursing_level_name, bed_number, status, sort_order, create_by, create_time,   remark )  VALUES  ( ?,  ?, ?, ?, ?, ?, ?, ?, ?, ?,   ? )\r\n### Cause: java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value\n; Field \'elder_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value', '2026-05-03 10:58:04', 330);
INSERT INTO `sys_oper_log` VALUES (319, '入住登记', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.CheckInController.add()', 'POST', 1, 'admin', '研发部门', '/serve/checkIn', '127.0.0.1', '内网IP', '{\"bedNumber\":\"101-1\",\"createBy\":\"1\",\"createTime\":\"2026-05-03 18:58:40\",\"elderName\":\"吕实萌\",\"endDate\":\"2026-06-25 23:59:59\",\"idCardNo\":\"210102197604190730\",\"nursingLevelName\":\"测试\",\"params\":{},\"remark\":\"\",\"sortOrder\":0,\"startDate\":\"2026-05-06 00:00:00\",\"status\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value\r\n### The error may exist in org/FlyingSparrow/YiSmartCloud/serve/mapper/CheckInMapper.java (best guess)\r\n### The error may involve org.FlyingSparrow.YiSmartCloud.serve.mapper.CheckInMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO check_in  ( elder_name,  id_card_no, start_date, end_date, nursing_level_name, bed_number, status, sort_order, create_by, create_time,   remark )  VALUES  ( ?,  ?, ?, ?, ?, ?, ?, ?, ?, ?,   ? )\r\n### Cause: java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value\n; Field \'elder_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value', '2026-05-03 10:58:42', 10);
INSERT INTO `sys_oper_log` VALUES (320, '入住登记', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.CheckInController.add()', 'POST', 1, 'admin', '研发部门', '/serve/checkIn', '127.0.0.1', '内网IP', '{\"bedNumber\":\"101-1\",\"createBy\":\"1\",\"createTime\":\"2026-05-03 18:59:01\",\"elderName\":\"吕实萌\",\"endDate\":\"2026-06-25 23:59:59\",\"idCardNo\":\"210102197604190730\",\"nursingLevelName\":\"测试\",\"params\":{},\"remark\":\"\",\"sortOrder\":0,\"startDate\":\"2026-05-06 00:00:00\",\"status\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value\r\n### The error may exist in org/FlyingSparrow/YiSmartCloud/serve/mapper/CheckInMapper.java (best guess)\r\n### The error may involve org.FlyingSparrow.YiSmartCloud.serve.mapper.CheckInMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO check_in  ( elder_name,  id_card_no, start_date, end_date, nursing_level_name, bed_number, status, sort_order, create_by, create_time,   remark )  VALUES  ( ?,  ?, ?, ?, ?, ?, ?, ?, ?, ?,   ? )\r\n### Cause: java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value\n; Field \'elder_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'elder_id\' doesn\'t have a default value', '2026-05-03 10:59:03', 10);
INSERT INTO `sys_oper_log` VALUES (321, '定时任务', 1, 'org.FlyingSparrow.YiSmartCloud.quartz.controller.SysJobController.add()', 'POST', 1, 'admin', '研发部门', '/monitor/job', '127.0.0.1', '内网IP', '{\"concurrent\":\"1\",\"createBy\":\"admin\",\"cronExpression\":\"0 0 1 * * ?\",\"invokeTarget\":\"contractJob.updateContractStatusJob\",\"jobGroup\":\"DEFAULT\",\"jobId\":100,\"jobName\":\"定时更新合同状态\",\"misfirePolicy\":\"1\",\"nextValidTime\":\"2026-05-04 01:00:00\",\"params\":{},\"status\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-03 13:05:08', 151);
INSERT INTO `sys_oper_log` VALUES (322, '定时任务', 2, 'org.FlyingSparrow.YiSmartCloud.quartz.controller.SysJobController.run()', 'PUT', 1, 'admin', '研发部门', '/monitor/job/run', '127.0.0.1', '内网IP', '{\"jobGroup\":\"DEFAULT\",\"jobId\":100,\"misfirePolicy\":\"0\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-03 13:05:14', 22);
INSERT INTO `sys_oper_log` VALUES (323, '定时任务', 2, 'org.FlyingSparrow.YiSmartCloud.quartz.controller.SysJobController.changeStatus()', 'PUT', 1, 'admin', '研发部门', '/monitor/job/changeStatus', '127.0.0.1', '内网IP', '{\"jobId\":100,\"misfirePolicy\":\"0\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-03 13:05:54', 25);
INSERT INTO `sys_oper_log` VALUES (324, '代码生成', 6, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"health_assessment\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-04 06:47:35', 294);
INSERT INTO `sys_oper_log` VALUES (325, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"assessment\",\"className\":\"HealthAssessment\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":172,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-04 06:47:35\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":16,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ElderName\",\"columnComment\":\"老人姓名\",\"columnId\":173,\"columnName\":\"elder_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-04 06:47:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"elderName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":16,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"IdCard\",\"columnComment\":\"身份证号\",\"columnId\":174,\"columnName\":\"id_card\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-04 06:47:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"idCard\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":16,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BirthDate\",\"columnComment\":\"出生日期\",\"columnId\":175,\"columnName\":\"birth_date\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2026-05-04 06:47:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isReq', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-04 06:48:43', 246);
INSERT INTO `sys_oper_log` VALUES (326, '代码生成', 8, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"health_assessment\"}', NULL, 0, NULL, '2026-05-04 06:48:48', 743);
INSERT INTO `sys_oper_log` VALUES (327, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/checkIn/apply\",\"createTime\":\"2026-05-03 13:16:09\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2124,\"menuName\":\"入住申请\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2104,\"path\":\"checkIn-apply\",\"perms\":\"serve:checkIn:add\",\"routeName\":\"CheckInApplyPage\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-04 07:11:21', 217);
INSERT INTO `sys_oper_log` VALUES (328, '菜单管理', 2, 'org.FlyingSparrow.YiSmartCloud.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"serve/assessment/index\",\"createTime\":\"2026-05-04 06:50:24\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2125,\"menuName\":\"健康评估\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2104,\"path\":\"assessment\",\"perms\":\"serve:assessment:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-04 07:11:30', 25);
INSERT INTO `sys_oper_log` VALUES (329, '健康评估', 1, 'org.FlyingSparrow.YiSmartCloud.serve.controller.HealthAssessmentController.analyze()', 'POST', 1, 'admin', '研发部门', '/serve/assessment/analyze', '127.0.0.1', '内网IP', '{\"elderName\":\"晨红茶\",\"idCard\":\"21010219760910554X\",\"physicalExamInstitution\":\"麻雀体检\",\"physicalReportUrl\":\"https://yismart-could.oss-cn-beijing.aliyuncs.com/2026/05/2842fa67-db93-42b0-8554-6bb287d2dff8.pdf\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"abnormalAnalysis\":\"[{\\\"conclusion\\\":\\\"血脂偏高\\\",\\\"result\\\":\\\"5.45 mmol/L\\\",\\\"unit\\\":\\\"mmol/L\\\",\\\"advice\\\":\\\"建议减少高脂肪食物的摄入，增加运动量，并在6个月后复查血脂。\\\",\\\"examinationItem\\\":\\\"总胆固醇 (TC)\\\",\\\"referenceValue\\\":\\\"< 5.18 mmol/L\\\",\\\"interpret\\\":\\\"总胆固醇水平高于正常范围，可能增加心血管疾病的风险。\\\"},{\\\"conclusion\\\":\\\"低密度脂蛋白胆固醇偏高\\\",\\\"result\\\":\\\"3.62 mmol/L\\\",\\\"unit\\\":\\\"mmol/L\\\",\\\"advice\\\":\\\"建议改善饮食习惯，减少饱和脂肪和胆固醇的摄入，增加膳食纤维的摄入，并进行适量的有氧运动。\\\",\\\"examinationItem\\\":\\\"低密度脂蛋白 (LDL-C)\\\",\\\"referenceValue\\\":\\\"< 3.37 mmol/L\\\",\\\"interpret\\\":\\\"低密度脂蛋白胆固醇水平高于正常范围，是动脉粥样硬化的危险因素之一。\\\"},{\\\"conclusion\\\":\\\"轻度脂肪肝倾向\\\",\\\"result\\\":\\\"肝脏回声稍增强，分布尚均匀，血管纹理清晰\\\",\\\"unit\\\":\\\"无\\\",\\\"advice\\\":\\\"建议调整饮食结构，减少高脂肪、高糖食物的摄入，增加运动量，以控制体重和改善代谢。\\\",\\\"examinationItem\\\":\\\"腹部超声\\\",\\\"referenceValue\\\":\\\"正常肝脏超声表现\\\",\\\"interpret\\\":\\\"腹部超声显示肝脏回声稍增强，提示可能有轻度脂肪肝倾向。\\\"}]\",\"age\":49,\"aiResultJson\":\"{\\n    \\\"totalCheckDate\\\": \\\"2026-05-04\\\",\\n    \\\"healthAssessment\\\": {\\n        \\\"riskLevel\\\": \\\"caution\\\",\\n        \\\"healthIndex\\\": 75.50 \\n    },\\n    \\\"riskDistribution\\\": {\\n        \\\"healthy\\\": 60.00, \\n        \\\"caution\\\": 20.00, \\n        \\\"risk\\\": 15.00, \\n        \\\"danger\\\": 5.00, \\n        \\\"severeDanger\\\": 0.00 \\n    },\\n    \\\"abnormalData\\\": [\\n        {\\n            \\\"conclusion\\\": \\\"血脂偏高\\\",\\n            \\\"examinationItem\\\": \\\"总胆固醇 (TC)\\\",\\n            \\\"result\\\": \\\"5.45 mmol/L\\\",\\n            \\\"referenceValue\\\": \\\"< 5.18 mmol/L\\\",\\n            \\\"unit\\\": \\\"mmol/L\\\",\\n            \\\"interpret\\\": \\\"总胆固醇水平高于正常范围，可能增加心血管疾病的风险。\\\",\\n            \\\"advice\\\": \\\"建议减少高脂肪食物的摄入，增加运动量，并在6个月后复查血脂。\\\"\\n        },\\n        {\\n            \\\"conclusion\\\": \\\"低密度脂蛋白胆固醇偏高\\\",\\n            \\\"examinationItem\\\": \\\"低密度脂蛋白 (LDL-C)\\\",\\n            \\\"result\\\": \\\"3.62 mmol/L\\\",\\n            \\\"referenceValue\\\": \\\"< 3.37 mmol/L\\\",\\n            \\\"unit\\\": \\\"mmol/L\\\",\\n            \\\"interpret\\\": \\\"低密度脂蛋白胆固醇水平高于正常范围，是动脉粥样硬化的危险因素之一。\\\",\\n            \\\"advice\\\": \\\"建议改善饮食习惯，减少饱和脂肪和胆固醇的摄入，增加膳食纤维的摄入，并进行适量的有氧运动。\\\"\\n        },\\n        {\\n            \\\"conclusion\\\": \\\"轻度脂肪肝倾向\\\",\\n      ', 0, NULL, '2026-05-04 09:15:30', 28860);
INSERT INTO `sys_oper_log` VALUES (330, '代码生成', 6, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"family_member\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-04 09:58:53', 428);
INSERT INTO `sys_oper_log` VALUES (331, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"member\",\"className\":\"FamilyMember\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":196,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-04 09:58:52\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":17,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Phone\",\"columnComment\":\"手机号\",\"columnId\":197,\"columnName\":\"phone\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-04 09:58:52\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"phone\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":17,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"名称\",\"columnId\":198,\"columnName\":\"name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-04 09:58:52\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":17,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Avatar\",\"columnComment\":\"头像\",\"columnId\":199,\"columnName\":\"avatar\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-04 09:58:52\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"avatar\",\"javaTy', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-04 09:59:39', 264);
INSERT INTO `sys_oper_log` VALUES (332, '代码生成', 2, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"member\",\"className\":\"FamilyMember\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":196,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2026-05-04 09:58:52\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":17,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Phone\",\"columnComment\":\"手机号\",\"columnId\":197,\"columnName\":\"phone\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-04 09:58:52\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"phone\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":17,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"名称\",\"columnId\":198,\"columnName\":\"name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-04 09:58:52\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":17,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Avatar\",\"columnComment\":\"头像\",\"columnId\":199,\"columnName\":\"avatar\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2026-05-04 09:58:52\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"avatar\",\"javaTy', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-04 09:59:39', 232);
INSERT INTO `sys_oper_log` VALUES (333, '代码生成', 8, 'org.FlyingSparrow.YiSmartCloud.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"family_member\"}', NULL, 0, NULL, '2026-05-04 09:59:44', 2131);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-03-01 18:20:28', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-03-01 18:20:28', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-03-01 18:20:28', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-03-01 18:20:28', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-03-01 18:20:28', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-03-01 18:20:28', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-05-05 02:09:29', 'admin', '2026-03-01 18:20:28', '', '2026-05-04 18:09:32', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-01 18:20:28', 'admin', '2026-03-01 18:20:28', '', NULL, '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

-- ----------------------------
-- Table structure for visit_record
-- ----------------------------
DROP TABLE IF EXISTS `visit_record`;
CREATE TABLE `visit_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `elder_id` bigint NOT NULL COMMENT '被访老人ID',
  `visitor_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '访客姓名',
  `visitor_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '访客手机号',
  `visit_time` datetime NOT NULL COMMENT '预计到访时间',
  `visit_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '来访事由',
  `status` tinyint NULL DEFAULT 0 COMMENT '审批状态: 0-待审批, 1-准许, 2-拒绝, 3-已结束',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '访客预约记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of visit_record
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
