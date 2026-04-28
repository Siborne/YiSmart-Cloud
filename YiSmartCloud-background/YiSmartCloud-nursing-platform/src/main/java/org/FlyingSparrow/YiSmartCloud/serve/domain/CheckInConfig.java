package org.FlyingSparrow.YiSmartCloud.serve.domain;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 入住配置对象 check_in_config
 * 
 * @author Siborne
 * @date 2026-04-29
 */
@Data
public class CheckInConfig extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 入住表ID */
    @Excel(name = "入住表ID")
    private Long checkInId;

    /** 护理等级ID */
    @Excel(name = "护理等级ID")
    private Long nursingLevelId;

    /** 护理等级名称 */
    @Excel(name = "护理等级名称")
    private String nursingLevelName;

    /** 费用开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "费用开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime feeStartDate;

    /** 费用结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "费用结束时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime feeEndDate;

    /** 押金（元） */
    @Excel(name = "押金", readConverterExp = "元=")
    private BigDecimal deposit;

    /** 护理费用（元/月） */
    @Excel(name = "护理费用", readConverterExp = "元=/月")
    private BigDecimal nursingFee;

    /** 床位费用（元/月） */
    @Excel(name = "床位费用", readConverterExp = "元=/月")
    private BigDecimal bedFee;

    /** 医保支付（元/月） */
    @Excel(name = "医保支付", readConverterExp = "元=/月")
    private BigDecimal insurancePayment;

    /** 政府补贴（元/月） */
    @Excel(name = "政府补贴", readConverterExp = "元=/月")
    private BigDecimal governmentSubsidy;

    /** 其他费用（元/月） */
    @Excel(name = "其他费用", readConverterExp = "元=/月")
    private BigDecimal otherFees;

    /** 排序编号 */
    @Excel(name = "排序编号")
    private Integer sortOrder;


}
