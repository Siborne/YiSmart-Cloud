package org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

/**
 * 首页小饼图：中心合计 + 扇区列表
 */
@Data
public class DashboardPieBundleVo {
    private BigDecimal total;
    private List<DashboardSliceVo> data = new ArrayList<>();
}
