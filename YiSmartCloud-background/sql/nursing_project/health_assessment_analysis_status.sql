-- health_assessment：AI 异步分析状态字段（与 HealthAssessmentMapper.xml 中 analysis_status / analysis_error 对应）
-- 在 health_assessment 表已存在的前提下执行；若库中尚无 ai_result_json，请勿使用 AFTER ai_result_json，避免执行失败。
-- 可重复执行：若列已存在会报错，忽略即可或手工校验 information_schema。

ALTER TABLE health_assessment ADD COLUMN analysis_status TINYINT NOT NULL DEFAULT 1 COMMENT '0分析中 1已完成 2失败';
ALTER TABLE health_assessment ADD COLUMN analysis_error VARCHAR(500) NULL COMMENT '分析失败原因';
