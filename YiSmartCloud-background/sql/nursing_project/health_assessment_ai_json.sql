-- health_assessment: store full AI JSON for detail page (run after health_assessment table exists)
ALTER TABLE health_assessment ADD COLUMN ai_result_json LONGTEXT NULL COMMENT 'AI full JSON' AFTER system_score;
