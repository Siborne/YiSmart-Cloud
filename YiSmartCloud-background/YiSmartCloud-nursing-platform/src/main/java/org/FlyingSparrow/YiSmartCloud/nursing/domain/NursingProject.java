package org.FlyingSparrow.YiSmartCloud.nursing.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 护理项目对象 nursing_project
 * 
 * @author ruoyi
 * @date 2026-03-01
 */
@ApiModel(description = "护理项目信息")
public class NursingProject extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 编号 */
    @ApiModelProperty(value = "编号", example = "1")
    private Long id;

    /** 名称 */
    @Excel(name = "名称")
    @ApiModelProperty(value = "护理项目名称", example = "基础护理")
    private String name;

    /** 排序号 */
    @Excel(name = "排序号")
    @ApiModelProperty(value = "排序号", example = "1")
    private Integer orderNo;

    /** 单位 */
    @Excel(name = "单位")
    @ApiModelProperty(value = "计量单位", example = "次")
    private String unit;

    /** 价格 */
    @Excel(name = "价格")
    @ApiModelProperty(value = "护理项目价格", example = "100.00")
    private BigDecimal price;

    /** 图片 */
    @Excel(name = "图片")
    @ApiModelProperty(value = "护理项目图片URL", example = "http://example.com/image.jpg")
    private String image;

    /** 护理要求 */
    @Excel(name = "护理要求")
    @ApiModelProperty(value = "护理要求说明", example = "每日一次基础护理服务")
    private String nursingRequirement;

    /** 状态（0：禁用，1：启用） */
    @Excel(name = "状态", readConverterExp = "0=：禁用，1：启用")
    @ApiModelProperty(value = "状态（0：禁用，1：启用）", example = "1")
    private Integer status;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
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

    public void setOrderNo(Integer orderNo) 
    {
        this.orderNo = orderNo;
    }

    public Integer getOrderNo() 
    {
        return orderNo;
    }

    public void setUnit(String unit) 
    {
        this.unit = unit;
    }

    public String getUnit() 
    {
        return unit;
    }

    public void setPrice(BigDecimal price) 
    {
        this.price = price;
    }

    public BigDecimal getPrice() 
    {
        return price;
    }

    public void setImage(String image) 
    {
        this.image = image;
    }

    public String getImage() 
    {
        return image;
    }

    public void setNursingRequirement(String nursingRequirement) 
    {
        this.nursingRequirement = nursingRequirement;
    }

    public String getNursingRequirement() 
    {
        return nursingRequirement;
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
            .append("name", getName())
            .append("orderNo", getOrderNo())
            .append("unit", getUnit())
            .append("price", getPrice())
            .append("image", getImage())
            .append("nursingRequirement", getNursingRequirement())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("updateBy", getUpdateBy())
            .append("remark", getRemark())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
