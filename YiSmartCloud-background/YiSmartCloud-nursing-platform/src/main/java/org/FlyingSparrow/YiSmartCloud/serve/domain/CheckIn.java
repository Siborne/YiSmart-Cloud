package org.FlyingSparrow.YiSmartCloud.serve.domain;

import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 入住登记对象 check_in
 * 
 * @author Siborne
 * @date 2026-04-29
 */
@Data
public class CheckIn extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 老人姓名 */
    @Excel(name = "老人姓名")
    private String elderName;

    /** 老人ID */
    @Excel(name = "老人ID")
    private Long elderId;

    /** 身份证号 */
    @Excel(name = "身份证号")
    private String idCardNo;

    /** 入住开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "入住开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime startDate;

    /** 入住结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "入住结束时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime endDate;

    /** 护理等级名称 */
    @Excel(name = "护理等级名称")
    private String nursingLevelName;

    /** 入住床位 */
    @Excel(name = "入住床位")
    private String bedNumber;

    /** 状态 (0: 已入住, 1: 已退住) */
    @Excel(name = "状态 (0: 已入住, 1: 已退住)")
    private Integer status;

    /** 排序编号 */
    @Excel(name = "排序编号")
    private Integer sortOrder;


}
