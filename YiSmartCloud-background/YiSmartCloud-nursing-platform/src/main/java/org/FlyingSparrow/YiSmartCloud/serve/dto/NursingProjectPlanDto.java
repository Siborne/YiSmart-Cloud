package org.FlyingSparrow.YiSmartCloud.serve.dto;

import lombok.Data;

@Data
public class NursingProjectPlanDto {

    /** $column.columnComment */
    private Long id;

    /** 计划id */
    private Long planId;

    /** 项目id */
    private String projectId;

    /** 计划执行时间 */
    private String executeTime;

    /** 执行周期 0 天 1 周 2月 */
    private Long executeCycle;

    /** 执行频次 */
    private Long executeFrequency;

    /** 备注 */
    private String remark;
}