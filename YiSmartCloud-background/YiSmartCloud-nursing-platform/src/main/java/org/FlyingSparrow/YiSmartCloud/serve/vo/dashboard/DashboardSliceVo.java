package org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 饼图扇区（与前端 ECharts data 项一致）
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DashboardSliceVo {
    private String name;
    private BigDecimal value;
}
