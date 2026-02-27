package org.FlyingSparrow.YiSmartCloud.nursing.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 护理计划对象 nursing_plan
 * 
 * @author Siborne
 * @date 2026-02-28
 */
@ApiModel(description = "护理计划信息实体类")
public class NursingPlan extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 编号 */
    @ApiModelProperty(value = "护理计划编号", name = "id", example = "1", position = 1)
    private Long id;

    /** 排序号 */
    @Excel(name = "排序号")
    @ApiModelProperty(value = "显示排序号", name = "sortNo", example = "1", position = 2)
    private Long sortNo;

    /** 名称 */
    @Excel(name = "名称")
    @ApiModelProperty(value = "护理计划名称", name = "planName", example = "基础护理计划", required = true, position = 3)
    private String planName;

    /** 状态 0禁用 1启用 */
    @Excel(name = "状态 0禁用 1启用")
    @ApiModelProperty(value = "状态（0：禁用，1：启用）", name = "status", example = "1", allowableValues = "0,1", position = 4)
    private Long status;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setSortNo(Long sortNo) 
    {
        this.sortNo = sortNo;
    }

    public Long getSortNo() 
    {
        return sortNo;
    }

    public void setPlanName(String planName) 
    {
        this.planName = planName;
    }

    public String getPlanName() 
    {
        return planName;
    }

    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("sortNo", getSortNo())
            .append("planName", getPlanName())
            .append("status", getStatus())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .append("createBy", getCreateBy())
            .append("updateBy", getUpdateBy())
            .append("remark", getRemark())
            .toString();
    }
}
