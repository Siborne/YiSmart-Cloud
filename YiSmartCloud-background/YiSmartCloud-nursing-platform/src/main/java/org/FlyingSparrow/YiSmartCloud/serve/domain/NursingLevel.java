package org.FlyingSparrow.YiSmartCloud.serve.domain;

import java.math.BigDecimal;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 护理等级对象 nursing_level
 * 
 * @author Siborne
 * @date 2026-03-23
 */
@Data
public class NursingLevel extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 等级名称 */
    @Excel(name = "等级名称")
    private String name;

    /** 护理计划ID */
    @Excel(name = "护理计划ID")
    private Long lplanId;

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
