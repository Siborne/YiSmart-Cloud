package org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard;

import lombok.Data;

/**
 * 按日聚合笔数
 */
@Data
public class DashboardDayCount {
    /** yyyy-MM-dd */
    private String statDate;
    private Long cnt;
}
