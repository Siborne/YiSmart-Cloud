package org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard;

import java.math.BigDecimal;

import lombok.Data;

/**
 * 按日聚合金额或计数
 */
@Data
public class DashboardDayAmount {
    /** yyyy-MM-dd */
    private String statDate;
    private BigDecimal amt;
}
