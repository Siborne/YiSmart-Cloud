-- 扩展老人档案表：与入住申请页字段对齐，便于详情回显
ALTER TABLE elder_info
  ADD COLUMN birthday varchar(32) DEFAULT NULL COMMENT '出生日期 yyyy-MM-dd' AFTER gender,
  ADD COLUMN address varchar(500) DEFAULT NULL COMMENT '家庭住址' AFTER contact_phone,
  ADD COLUMN portrait_img varchar(500) DEFAULT NULL COMMENT '一寸照片URL' AFTER address,
  ADD COLUMN id_card_portrait_img varchar(500) DEFAULT NULL COMMENT '身份证人像面URL' AFTER portrait_img,
  ADD COLUMN id_card_national_emblem_img varchar(500) DEFAULT NULL COMMENT '身份证国徽面URL' AFTER id_card_portrait_img;
