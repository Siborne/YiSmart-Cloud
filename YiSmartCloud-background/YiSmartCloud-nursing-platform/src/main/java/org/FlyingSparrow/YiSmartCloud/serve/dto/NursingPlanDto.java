package org.FlyingSparrow.YiSmartCloud.serve.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.FlyingSparrow.YiSmartCloud.serve.domain.NursingProjectPlan;

import java.util.List;

@Data
public class NursingPlanDto {

    private Long id;

    /**
     * 排序号
     */
    @ApiModelProperty(value = "排序号")
    private Integer sortNo;

    /**
     * 计划名称
     */
    @ApiModelProperty(value = "计划名称")
    private String planName;

    /**
     * 状态（0：禁用，1：启用）
     */
    @ApiModelProperty(value = "状态（0：禁用，1：启用）")
    private Integer status;

    /**
     * 护理计划关联项目列表
     */
    List<NursingProjectPlanDto> projectPlans;
}