package org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 来访记录行（含日期，用于区间查询后分组）
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class DashboardVisitRowVo extends DashboardVisitItemVo {
    /** yyyy-MM-dd */
    private String visitDate;
}
