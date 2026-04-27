package org.FlyingSparrow.YiSmartCloud.serve.domain;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 费用账单明细对象 bill_detail
 * 
 * @author Siborne
 * @date 2026-04-27
 */
@Data
public class BillDetail extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 老人ID */
    @Excel(name = "老人ID")
    private Long elderId;

    /** 账单月份 (例: 2026-04) */
    @Excel(name = "账单月份 (例: 2026-04)")
    private String billMonth;

    /** 费用类型: 1-护理费, 2-床位费, 3-餐饮费, 4-其他 */
    @Excel(name = "费用类型: 1-护理费, 2-床位费, 3-餐饮费, 4-其他")
    private Integer billType;

    /** 应收金额 */
    @Excel(name = "应收金额")
    private BigDecimal amount;

    /** 支付状态: 0-待支付, 1-已支付 */
    @Excel(name = "支付状态: 0-待支付, 1-已支付")
    private Integer payStatus;

    /** 实际支付时间 */
    @Excel(name = "实际支付时间")
    private LocalDateTime payTime;

    /** 逻辑删除 */
    private Integer isDeleted;


}
