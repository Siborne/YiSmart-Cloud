-- AI analysis async status (0=pending 1=done 2=failed)
ALTER TABLE health_assessment ADD COLUMN analysis_status TINYINT NOT NULL DEFAULT 1 COMMENT '0分析中 1已完成 2失败' AFTER ai_result_json;
ALTER TABLE health_assessment ADD COLUMN analysis_error VARCHAR(500) NULL COMMENT '分析失败原因' AFTER analysis_status;
