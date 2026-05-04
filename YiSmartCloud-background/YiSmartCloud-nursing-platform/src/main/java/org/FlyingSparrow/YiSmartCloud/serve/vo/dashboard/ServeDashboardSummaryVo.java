package org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import lombok.Data;

/**
 * 管理端首页仪表盘汇总数据
 */
@Data
public class ServeDashboardSummaryVo {
    private DashboardPieBundleVo elder;
    private DashboardPieBundleVo bed;
    private DashboardPieBundleVo service;
    private DashboardPieBundleVo staff;
    private DashboardPieBundleVo money;

    private DashboardTrendsVo trends = new DashboardTrendsVo();

    private List<DashboardSliceVo> elderRank = new ArrayList<>();
    private DashboardElderAgeVo elderAge = new DashboardElderAgeVo();

    /** key: yyyy-MM-dd，当天来访记录列表 */
    private Map<String, List<DashboardVisitItemVo>> visitsByDate = new LinkedHashMap<>();

    @Data
    public static class DashboardTrendsVo {
        private TrendDualGroup earnings = new TrendDualGroup();
        private TrendDualGroup checkIn = new TrendDualGroup();
        private TrendLineGroup serve = new TrendLineGroup();
    }

    @Data
    public static class TrendDualGroup {
        private DashboardDualSeriesVo today = new DashboardDualSeriesVo();
        private DashboardDualSeriesVo week = new DashboardDualSeriesVo();
        private DashboardDualSeriesVo month = new DashboardDualSeriesVo();
    }

    /** 服务/来访次数折线（单序列） */
    @Data
    public static class TrendLineGroup {
        private List<String> todayTimes = new ArrayList<>();
        private List<BigDecimal> today = new ArrayList<>();
        private List<String> weekTimes = new ArrayList<>();
        private List<BigDecimal> week = new ArrayList<>();
        private List<String> monthTimes = new ArrayList<>();
        private List<BigDecimal> month = new ArrayList<>();
    }
}
