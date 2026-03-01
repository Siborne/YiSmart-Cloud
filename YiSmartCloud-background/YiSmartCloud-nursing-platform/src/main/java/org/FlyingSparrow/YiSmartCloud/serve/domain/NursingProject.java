package org.FlyingSparrow.YiSmartCloud.serve.domain;

import java.math.BigDecimal;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 护理项目对象 nursing_project
 * 
 * @author ruoyi
 * @date 2026-03-02
 */
@Data
public class NursingProject extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 编号 */
    private Long id;

    /** 名称 */
    @Excel(name = "名称")
    private String name;

    /** 排序号 */
    @Excel(name = "排序号")
    private Integer orderNo;

    /** 单位 */
    @Excel(name = "单位")
    private String unit;

    /** 价格 */
    @Excel(name = "价格")
    private BigDecimal price;

    /** 图片 */
    @Excel(name = "图片")
    private String image;

    /** 护理要求 */
    @Excel(name = "护理要求")
    private String nursingRequirement;

    /** 状态（0：禁用，1：启用） */
    @Excel(name = "状态", readConverterExp = "0=：禁用，1：启用")
    private Integer status;


}
