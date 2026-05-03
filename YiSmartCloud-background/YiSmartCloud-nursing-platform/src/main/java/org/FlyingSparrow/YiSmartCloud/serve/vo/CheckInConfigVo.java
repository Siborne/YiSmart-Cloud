package org.FlyingSparrow.YiSmartCloud.serve.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class CheckInConfigVo {

    /**
     * 入住开始时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "入住开始时间", width = 30, dateFormat = "yyyy-MM-dd")
    private LocalDateTime startDate;

    /**
     * 入住结束时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "入住结束时间", width = 30, dateFormat = "yyyy-MM-dd")
    private LocalDateTime endDate;

    /**
     * 入住床位
     */
    @Excel(name = "入住床位")
    private String bedNumber;

    /** 护理等级名称 */
    private String nursingLevelName;

    /** 费用开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime feeStartDate;

    /** 费用结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime feeEndDate;

    /** 押金（元） */
    private BigDecimal deposit;

    /** 护理费用（元/月） */
    private BigDecimal nursingFee;

    /** 床位费用（元/月） */
    private BigDecimal bedFee;

    /** 医保支付（元/月） */
    private BigDecimal insurancePayment;

    /** 政府补贴（元/月） */
    private BigDecimal governmentSubsidy;

    /** 其他费用（元/月） */
    private BigDecimal otherFees;
}
