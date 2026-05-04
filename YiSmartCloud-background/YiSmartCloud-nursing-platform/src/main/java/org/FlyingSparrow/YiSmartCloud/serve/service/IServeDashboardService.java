package org.FlyingSparrow.YiSmartCloud.serve.service;

import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.ServeDashboardSummaryVo;

/**
 * 管理端首页仪表盘
 */
public interface IServeDashboardService {

    /**
     * 汇总首页所需真实统计数据
     */
    ServeDashboardSummaryVo loadSummary();
}
