package org.FlyingSparrow.YiSmartCloud.serve.domain;

import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * ?????? floor
 *
 * @author Siborne
 * @date 2026-04-28
 */
@Data
public class Floor extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** ??ID */
    private Long id;

    /** ???? */
    @Excel(name = "????")
    private Integer floorNo;

    /** ???? */
    @Excel(name = "????")
    private String floorName;

    /** ??: 0-??, 1-?? */
    @Excel(name = "??")
    private Integer status;

    /** ?? */
    @Excel(name = "??")
    private Integer sortNo;

    /** ???? */
    private Integer isDeleted;
}
