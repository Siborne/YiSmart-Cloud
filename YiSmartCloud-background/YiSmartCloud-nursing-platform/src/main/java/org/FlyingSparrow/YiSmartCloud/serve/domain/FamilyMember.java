package org.FlyingSparrow.YiSmartCloud.serve.domain;

import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 老人家属对象 family_member
 * 
 * @author Siborne
 * @date 2026-05-04
 */
@Data
public class FamilyMember extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 手机号 */
    @Excel(name = "手机号")
    private String phone;

    /** 名称 */
    @Excel(name = "名称")
    private String name;

    /** 头像 */
    @Excel(name = "头像")
    private String avatar;

    /** OpenID */
    @Excel(name = "OpenID")
    private String openId;

    /** 性别(0:男，1:女) */
    @Excel(name = "性别(0:男，1:女)")
    private Integer gender;


}
