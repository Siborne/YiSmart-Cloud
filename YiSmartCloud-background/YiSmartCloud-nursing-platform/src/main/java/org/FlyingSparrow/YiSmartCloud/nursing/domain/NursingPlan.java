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
 * @date 2026-03-01
 */
@ApiModel(description = "护理计划信息")
public class NursingPlan extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 编号 */
    @ApiModelProperty(value = "护理计划编号", example = "1")
    private Integer id;

    /** 排序号 */
    @Excel(name = "排序号")
    @ApiModelProperty(value = "排序号", example = "1")
    private Integer sortNo;

    /** 名称 */
    @Excel(name = "名称")
    @ApiModelProperty(value = "护理计划名称", example = "基础护理计划")
    private String planName;

    /** 状态 0禁用 1启用 */
    @Excel(name = "状态 0禁用 1启用")
    @ApiModelProperty(value = "状态（0：禁用，1：启用）", example = "1")
    private Integer status;

    public void setId(Integer id) 
    {
        this.id = id;
    }

    public Integer getId() 
    {
        return id;
    }

    public void setSortNo(Integer sortNo) 
    {
        this.sortNo = sortNo;
    }

    public Integer getSortNo() 
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

    public void setStatus(Integer status) 
    {
        this.status = status;
    }

    public Integer getStatus() 
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
