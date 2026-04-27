package org.FlyingSparrow.YiSmartCloud.serve.domain;

import java.time.LocalDateTime;

import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 访客预约记录对象 visit_record
 * 
 * @author Siborne
 * @date 2026-04-27
 */
@Data
public class VisitRecord extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 被访老人ID */
    @Excel(name = "被访老人ID")
    private Long elderId;

    /** 访客姓名 */
    @Excel(name = "访客姓名")
    private String visitorName;

    /** 访客手机号 */
    @Excel(name = "访客手机号")
    private String visitorPhone;

    /** 预计到访时间 */
    @Excel(name = "预计到访时间")
    private LocalDateTime visitTime;

    /** 来访事由 */
    @Excel(name = "来访事由")
    private String visitReason;

    /** 审批状态: 0-待审批, 1-准许, 2-拒绝, 3-已结束 */
    @Excel(name = "审批状态: 0-待审批, 1-准许, 2-拒绝, 3-已结束")
    private Integer status;

    /** 逻辑删除 */
    private Integer isDeleted;


}
