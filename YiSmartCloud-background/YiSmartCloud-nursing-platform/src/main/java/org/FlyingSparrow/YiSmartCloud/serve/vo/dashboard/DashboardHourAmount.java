package org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard;

import java.math.BigDecimal;

import lombok.Data;

/**
 * 按小时聚合金额
 */
@Data
public class DashboardHourAmount {
    /** 0-23 */
    private Integer hr;
    private BigDecimal amt;
}
