package org.FlyingSparrow.YiSmartCloud.serve.domain;

import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 在院老人主数据 elder_info（入住流程写入或维护，供床位与后续护工派工关联）
 *
 * @author Siborne
 * @date 2026-04-27
 */
@Data
public class ElderInfo extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 老人姓名 */
    @Excel(name = "老人姓名")
    private String name;

    /** 身份证号 */
    @Excel(name = "身份证号")
    private String idCard;

    /** 年龄 */
    @Excel(name = "年龄")
    private Integer age;

    /** 性别: 1-男, 2-女 */
    @Excel(name = "性别: 1-男, 2-女")
    private Integer gender;

    /** 出生日期 yyyy-MM-dd */
    private String birthday;

    /** 家属紧急联系电话 */
    @Excel(name = "家属紧急联系电话")
    private String contactPhone;

    /** 家庭住址 */
    private String address;

    /** 一寸照片（URL） */
    private String portraitImg;

    /** 身份证人像面（URL） */
    private String idCardPortraitImg;

    /** 身份证国徽面（URL） */
    private String idCardNationalEmblemImg;

    /** 健康状况简述 */
    @Excel(name = "健康状况简述")
    private String healthStatus;

    /** 当前状态: 0-待入住, 1-在院, 2-已退住 */
    @Excel(name = "当前状态: 0-待入住, 1-在院, 2-已退住")
    private Integer status;

    /** 逻辑删除 */
    private Integer isDeleted;


}
