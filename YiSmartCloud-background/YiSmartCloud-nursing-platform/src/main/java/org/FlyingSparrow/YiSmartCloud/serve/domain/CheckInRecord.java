package org.FlyingSparrow.YiSmartCloud.serve.domain;

import java.time.LocalDateTime;

import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 老人入住记录对象 check_in_record
 * 
 * @author Siborne
 * @date 2026-04-27
 */
@Data
public class CheckInRecord extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 老人ID */
    @Excel(name = "老人ID")
    private Long elderId;

    /** 分配床位ID */
    @Excel(name = "分配床位ID")
    private Long bedId;

    /** 护理等级ID (关联护理等级模块) */
    @Excel(name = "护理等级ID (关联护理等级模块)")
    private Long nursingLevelId;

    /** 实际入住日期 */
    @Excel(name = "实际入住日期")
    private LocalDateTime checkInDate;

    /** 合同到期日期 */
    @Excel(name = "合同到期日期")
    private LocalDateTime contractEndDate;

    /** 记录状态: 1-生效中, 2-已结束 */
    @Excel(name = "记录状态: 1-生效中, 2-已结束")
    private Integer status;

    /** 逻辑删除 */
    private Integer isDeleted;


}
