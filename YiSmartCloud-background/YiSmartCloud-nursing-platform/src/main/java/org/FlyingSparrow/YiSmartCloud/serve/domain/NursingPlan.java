package org.FlyingSparrow.YiSmartCloud.serve.domain;

import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 护理计划对象 nursing_plan
 * 
 * @author Siborne
 * @date 2026-03-02
 */
@Data
public class NursingPlan extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 编号 */
    private Integer id;

    /** 排序号 */
    @Excel(name = "排序号")
    private Integer sortNo;

    /** 名称 */
    @Excel(name = "名称")
    private String planName;

    /** 状态 0禁用 1启用 */
    @Excel(name = "状态 0禁用 1启用")
    private Integer status;


}
