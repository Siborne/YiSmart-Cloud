package org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard;

import lombok.Data;

/**
 * 老人年龄五档 × 男女（单行聚合）
 */
@Data
public class DashboardElderAgeBucketsRow {
    private Long m0;
    private Long m1;
    private Long m2;
    private Long m3;
    private Long m4;
    private Long w0;
    private Long w1;
    private Long w2;
    private Long w3;
    private Long w4;
}
