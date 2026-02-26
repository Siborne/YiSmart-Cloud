package com.ruoyi.common.core.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
// 导入Swagger的模型注解，用于描述整个实体类
import io.swagger.annotations.ApiModel;
// 导入Swagger的属性注解，用于描述字段属性
import io.swagger.annotations.ApiModelProperty;

/**
 * Entity基类
 * 
 * @author ruoyi
 */
// Swagger模型注解，描述该基类实体的功能和用途
@ApiModel(description = "基础实体类，包含通用字段")
public class BaseEntity implements Serializable
{
    private static final long serialVersionUID = 1L;

    /** 搜索值 */
    @JsonIgnore
    // Swagger属性注解，描述搜索值字段（在JSON序列化时忽略）
    @ApiModelProperty(value = "搜索关键字", name = "searchValue", hidden = true)
    private String searchValue;

    /** 创建者 */
    // Swagger属性注解，描述创建者字段
    @ApiModelProperty(value = "创建者用户名", name = "createBy", example = "admin", position = 10)
    private String createBy;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    // Swagger属性注解，描述创建时间字段
    @ApiModelProperty(value = "创建时间", name = "createTime", example = "2026-02-27 10:00:00", position = 11)
    private Date createTime;

    /** 更新者 */
    // Swagger属性注解，描述更新者字段
    @ApiModelProperty(value = "最后更新者用户名", name = "updateBy", example = "admin", position = 12)
    private String updateBy;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    // Swagger属性注解，描述更新时间字段
    @ApiModelProperty(value = "最后更新时间", name = "updateTime", example = "2026-02-27 15:30:00", position = 13)
    private Date updateTime;

    /** 备注 */
    // Swagger属性注解，描述备注字段
    @ApiModelProperty(value = "备注信息", name = "remark", example = "这是备注内容", position = 14)
    private String remark;

    /** 请求参数 */
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    // Swagger属性注解，描述请求参数字段（在JSON序列化时空值不包含）
    @ApiModelProperty(value = "请求参数Map", name = "params", hidden = true)
    private Map<String, Object> params;

    public String getSearchValue()
    {
        return searchValue;
    }

    public void setSearchValue(String searchValue)
    {
        this.searchValue = searchValue;
    }

    public String getCreateBy()
    {
        return createBy;
    }

    public void setCreateBy(String createBy)
    {
        this.createBy = createBy;
    }

    public Date getCreateTime()
    {
        return createTime;
    }

    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }

    public String getUpdateBy()
    {
        return updateBy;
    }

    public void setUpdateBy(String updateBy)
    {
        this.updateBy = updateBy;
    }

    public Date getUpdateTime()
    {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime)
    {
        this.updateTime = updateTime;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }

    public Map<String, Object> getParams()
    {
        if (params == null)
        {
            params = new HashMap<>();
        }
        return params;
    }

    public void setParams(Map<String, Object> params)
    {
        this.params = params;
    }
}
