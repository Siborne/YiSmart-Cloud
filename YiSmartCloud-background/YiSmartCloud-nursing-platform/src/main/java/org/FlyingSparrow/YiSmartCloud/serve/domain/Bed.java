package org.FlyingSparrow.YiSmartCloud.serve.domain;

import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 床位信息对象 bed
 * 
 * @author Siborne
 * @date 2026-04-27
 */
@Data
public class Bed extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 所属房间ID */
    @Excel(name = "所属房间ID")
    private Long roomId;

    /** 床位编号 (例: 101-A) */
    @Excel(name = "床位编号 (例: 101-A)")
    private String bedNo;

    /** 床位状态: 0-空闲, 1-占用, 2-维修中 */
    @Excel(name = "床位状态: 0-空闲, 1-占用, 2-维修中")
    private Integer bedStatus;

    /** 逻辑删除 */
    private Integer isDeleted;


}
