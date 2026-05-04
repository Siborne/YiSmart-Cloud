package org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard;

import lombok.Data;

/**
 * 首页来访/预约列表项（对齐 RankList 展示字段）
 */
@Data
public class DashboardVisitItemVo {
    /** 1-参观类 2-预约类（与旧 mock type 语义一致） */
    private Integer type;
    private String time;
    private String name;
    private String phone;
}
