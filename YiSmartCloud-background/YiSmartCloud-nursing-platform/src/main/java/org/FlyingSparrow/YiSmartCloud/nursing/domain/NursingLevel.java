package org.FlyingSparrow.YiSmartCloud.nursing.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 护理等级对象 nursing_level
 * 
 * @author Siborne
 * @date 2026-03-01
 */
@ApiModel(description = "护理等级信息")
public class NursingLevel extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    @ApiModelProperty(value = "主键ID", example = "1")
    private Integer id;

    /** 等级名称 */
    @Excel(name = "等级名称")
    @ApiModelProperty(value = "护理等级名称", example = "一级护理")
    private String name;

    /** 护理计划ID */
    @Excel(name = "护理计划ID")
    @ApiModelProperty(value = "关联的护理计划ID", example = "1")
    private Integer lplanId;

    /** 护理费用 */
    @Excel(name = "护理费用")
    @ApiModelProperty(value = "护理费用", example = "500.00")
    private BigDecimal fee;

    /** 状态（0：禁用，1：启用） */
    @Excel(name = "状态", readConverterExp = "0=：禁用，1：启用")
    @ApiModelProperty(value = "状态（0：禁用，1：启用）", example = "1")
    private Integer status;

    /** 等级说明 */
    @Excel(name = "等级说明")
    @ApiModelProperty(value = "护理等级说明", example = "提供24小时专业护理服务")
    private String description;

    public void setId(Integer id) 
    {
        this.id = id;
    }

    public Integer getId() 
    {
        return id;
    }

    public void setName(String name) 
    {
        this.name = name;
    }

    public String getName() 
    {
        return name;
    }

    public void setLplanId(Integer lplanId) 
    {
        this.lplanId = lplanId;
    }

    public Integer getLplanId() 
    {
        return lplanId;
    }

    public void setFee(BigDecimal fee) 
    {
        this.fee = fee;
    }

    public BigDecimal getFee() 
    {
        return fee;
    }

    public void setStatus(Integer status) 
    {
        this.status = status;
    }

    public Integer getStatus() 
    {
        return status;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("name", getName())
            .append("lplanId", getLplanId())
            .append("fee", getFee())
            .append("status", getStatus())
            .append("description", getDescription())
            .append("createTime", getCreateTime())
            .append("createBy", getCreateBy())
            .append("updateBy", getUpdateBy())
            .append("remark", getRemark())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
