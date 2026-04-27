package org.FlyingSparrow.YiSmartCloud.serve.domain;

import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * Â¥²ãÐÅÏ¢¶ÔÏó floor
 *
 * @author Siborne
 * @date 2026-04-28
 */
@Data
public class Floor extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** Ö÷¼üID */
    private Long id;

    /** Â¥²ã±àºÅ */
    @Excel(name = "Â¥²ã±àºÅ")
    private Integer floorNo;

    /** Â¥²ãÃû³Æ */
    @Excel(name = "Â¥²ãÃû³Æ")
    private String floorName;

    /** ×´Ì¬: 0-Í£ÓÃ, 1-ÆôÓÃ */
    @Excel(name = "×´Ì¬")
    private Integer status;

    /** ÅÅÐò */
    @Excel(name = "ÅÅÐò")
    private Integer sortNo;

    /** Âß¼­É¾³ý */
    private Integer isDeleted;
}
