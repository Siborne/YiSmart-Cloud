CREATE TABLE `nursing_project` (
                                   `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                   `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '名称',
                                   `order_no` int DEFAULT NULL COMMENT '排序号',
                                   `unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '单位',
                                   `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
                                   `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图片',
                                   `nursing_requirement` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '护理要求',
                                   `status` int NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：启用）',
                                   `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
                                   `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
                                   `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
                                   `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                   `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='护理项目表';

-- 护理项目计划关系表
CREATE TABLE "nursing_project_plan" (
                                        "id" int NOT NULL AUTO_INCREMENT,
                                        "plan_id" int NOT NULL COMMENT '计划id',
                                        "project_id" int NOT NULL COMMENT '项目id',
                                        "execute_time" varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '计划执行时间',
                                        "execute_cycle" int NOT NULL COMMENT '执行周期 0 天 1 周 2月',
                                        "execute_frequency" int NOT NULL COMMENT '执行频次',
                                        "create_time" datetime NOT NULL COMMENT '创建时间',
                                        "update_time" datetime DEFAULT NULL COMMENT '更新时间',
                                        "create_by" bigint DEFAULT NULL COMMENT '创建人id',
                                        "update_by" bigint DEFAULT NULL COMMENT '更新人id',
                                        "remark" varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
                                        PRIMARY KEY ("id") USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1727 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='护理计划和项目关联表';

-- 护理计划表
CREATE TABLE "nursing_plan" (
                                "id" int NOT NULL AUTO_INCREMENT COMMENT '编号',
                                "sort_no" int DEFAULT NULL COMMENT '排序号',
                                "plan_name" varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '名称',
                                "status" tinyint NOT NULL DEFAULT '0' COMMENT '状态 0禁用 1启用',
                                "create_time" datetime NOT NULL COMMENT '创建时间',
                                "update_time" datetime DEFAULT NULL COMMENT '更新时间',
                                "create_by" bigint DEFAULT NULL COMMENT '创建人id',
                                "update_by" bigint DEFAULT NULL COMMENT '更新人id',
                                "remark" varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
                                PRIMARY KEY ("id") USING BTREE,
                                UNIQUE KEY "plan_name" ("plan_name") USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='护理计划表';

-- 护理等级表
CREATE TABLE "nursing_level" (
                                 "id" int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                 "name" varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '等级名称',
                                 "lplan_id" int NOT NULL COMMENT '护理计划ID',
                                 "fee" decimal(10,2) NOT NULL COMMENT '护理费用',
                                 "status" tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：启用）',
                                 "description" varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '等级说明',
                                 "create_time" datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                 "create_by" bigint DEFAULT NULL COMMENT '创建人id',
                                 "update_by" bigint DEFAULT NULL COMMENT '更新人id',
                                 "remark" varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
                                 "update_time" datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                 PRIMARY KEY ("id") USING BTREE,
                                 UNIQUE KEY "name" ("name") USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='护理等级表';
