package org.FlyingSparrow.YiSmartCloud.serve.domain;

import lombok.Data;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 会员服务订单实体类
 */
@Data
public class MemberServiceOrder extends BaseEntity {
    private static final long serialVersionUID = 1L;

    private Long id;

    private String orderNo;

    private Long familyMemberId;

    private Long elderId;

    private Long projectId;

    private Integer count;

    private BigDecimal unitPrice;

    private BigDecimal totalAmount;

    private LocalDateTime expectedServiceTime;

    /**
     * 订单状态：0-待支付，1-已预约，2-已取消，3-已退款，4-已完成
     */
    private Integer status;

    /**
     * 支付状态：0-未支付，1-已支付
     */
    private Integer payStatus;

    private Long billId;

    private String cancelReason;

    private String refundReason;

    private Integer isDeleted;

    /**
     * 非数据库字段，用于前端展示
     */
    private String statusName;
}
