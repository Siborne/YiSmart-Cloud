package org.FlyingSparrow.YiSmartCloud.serve.domain;

import java.math.BigDecimal;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 护理等级对象 nursing_level
 * <p>
 * 与护理计划为多对一（lplan_id → nursing_plan.id）；planName 为关联查询展示字段，不存在于本表。
 * 
 * @author Siborne
 * @date 2026-03-23
 */
@Data
@TableName("nursing_level")
public class NursingLevel extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 等级名称 */
    @Excel(name = "等级名称")
    private String name;

    /** 护理计划ID（JSON 与前端字段 planId 对齐） */
    @Excel(name = "护理计划ID")
    @JsonProperty("planId")
    private Long lplanId;

    /**
     * 关联护理计划名称（列表/详情通过 XML JOIN 查询填充）。
     * 必须标记 exist = false，否则 MyBatis-Plus 通用 SQL 会误当作 nursing_level.plan_name 列。
     */
    @TableField(exist = false)
    private String planName;

    /** 护理费用 */
    @Excel(name = "护理费用")
    private BigDecimal fee;

    /** 状态（0：禁用，1：启用） */
    @Excel(name = "状态", readConverterExp = "0=：禁用，1：启用")
    private Integer status;

    /** 等级说明 */
    @Excel(name = "等级说明")
    private String description;


}
