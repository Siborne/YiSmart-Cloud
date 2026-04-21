package org.FlyingSparrow.YiSmartCloud.serve.domain;

import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 护理计划和项目关联对象 nursing_project_plan
 * 
 * @author ruoyi
 * @date 2026-03-25
 */
@Data
public class NursingProjectPlan extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long id;

    /** 计划id */
    @Excel(name = "计划id")
    private Long planId;

    /** 项目id */
    @Excel(name = "项目id")
    private Long projectId;

    /** 计划执行时间 */
    @Excel(name = "计划执行时间")
    private String executeTime;

    /** 执行周期 0 天 1 周 2月 */
    @Excel(name = "执行周期 0 天 1 周 2月")
    private Long executeCycle;

    /** 执行频次 */
    @Excel(name = "执行频次")
    private Long executeFrequency;


}
