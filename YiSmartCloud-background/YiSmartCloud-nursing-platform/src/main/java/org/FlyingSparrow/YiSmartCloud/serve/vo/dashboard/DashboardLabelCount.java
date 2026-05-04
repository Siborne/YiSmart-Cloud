package org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard;

import java.math.BigDecimal;

import lombok.Data;

/**
 * 聚合查询单行：标签 + 数量（或金额，二选一由 SQL 填充）
 */
@Data
public class DashboardLabelCount {
    private String label;
    private Long cnt;
    private BigDecimal amount;
}
