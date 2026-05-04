package org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

/**
 * 双折线/双柱：横轴标签 + 两组数值（与现有 MiddleChart 结构一致）
 */
@Data
public class DashboardDualSeriesVo {
    private List<String> times = new ArrayList<>();
    private List<BigDecimal> incomeData = new ArrayList<>();
    private List<BigDecimal> refundData = new ArrayList<>();
}
