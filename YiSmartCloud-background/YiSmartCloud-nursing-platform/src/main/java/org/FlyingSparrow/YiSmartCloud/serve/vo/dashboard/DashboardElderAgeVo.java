package org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

/**
 * 老人年龄分布柱状图（五档 × 男女）
 */
@Data
public class DashboardElderAgeVo {
    private List<Long> man = new ArrayList<>();
    private List<Long> woman = new ArrayList<>();
}
