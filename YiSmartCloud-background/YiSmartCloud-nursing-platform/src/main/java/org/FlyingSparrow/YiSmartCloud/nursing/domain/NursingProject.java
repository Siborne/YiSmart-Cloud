package org.FlyingSparrow.YiSmartCloud.nursing.domain;

import java.math.BigDecimal;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;

/**
 * 护理项目对象 nursing_project
 *
 * @author ruoyi
 * @date 2026-02-27
 */
// Swagger模型注解，描述该实体类的功能和用途
@ApiModel(description = "护理项目信息实体类")
public class NursingProject extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 编号 */
    // Swagger属性注解，描述ID字段
    @ApiModelProperty(value = "护理项目编号", name = "id", example = "1", position = 1)
    private Long id;

    /** 名称 */
    @Excel(name = "名称")
    // Swagger属性注解，描述名称字段
    @ApiModelProperty(value = "护理项目名称", name = "name", example = "基础护理", required = true, position = 2)
    private String name;

    /** 排序号 */
    @Excel(name = "排序号")
    // Swagger属性注解，描述排序号字段
    @ApiModelProperty(value = "显示排序号", name = "orderNo", example = "1", position = 3)
    private Long orderNo;

    /** 单位 */
    @Excel(name = "单位")
    // Swagger属性注解，描述单位字段
    @ApiModelProperty(value = "计价单位", name = "unit", example = "次", position = 4)
    private String unit;

    /** 价格 */
    @Excel(name = "价格")
    // Swagger属性注解，描述价格字段
    @ApiModelProperty(value = "服务价格", name = "price", example = "100.00", position = 5)
    private BigDecimal price;

    /** 图片 */
    @Excel(name = "图片")
    // Swagger属性注解，描述图片字段
    @ApiModelProperty(value = "项目图片URL", name = "image", example = "https://example.com/image.jpg", position = 6)
    private String image;

    /** 护理要求 */
    @Excel(name = "护理要求")
    // Swagger属性注解，描述护理要求字段
    @ApiModelProperty(value = "护理服务要求说明", name = "nursingRequirement", example = "需专业护士操作，注意无菌环境", position = 7)
    private String nursingRequirement;

    /** 状态（0：禁用，1：启用） */
    @Excel(name = "状态", readConverterExp = "0=：禁用，1：启用")
    // Swagger属性注解，描述状态字段
    @ApiModelProperty(value = "状态（0：禁用，1：启用）", name = "status", example = "1", allowableValues = "0,1", position = 8)
    private Long status;

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

    public void setOrderNo(Long orderNo)
    {
        this.orderNo = orderNo;
    }

    public Long getOrderNo()
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
