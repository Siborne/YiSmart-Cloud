package org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard;

import lombok.Data;

/**
 * 入住/退住按小时统计
 */
@Data
public class DashboardCheckInHourCount {
    private Integer hr;
    private Long cnt;
}
