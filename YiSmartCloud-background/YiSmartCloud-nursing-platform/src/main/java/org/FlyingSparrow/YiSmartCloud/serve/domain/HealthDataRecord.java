package org.FlyingSparrow.YiSmartCloud.serve.domain;

import java.time.LocalDateTime;

import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 健康监测数据对象 health_data_record
 * 
 * @author Siborne
 * @date 2026-04-27
 */
@Data
public class HealthDataRecord extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 老人ID */
    @Excel(name = "老人ID")
    private Long elderId;

    /** 绑定的监测设备编号 */
    @Excel(name = "绑定的监测设备编号")
    private String deviceNo;

    /** 心率 (次/分) */
    @Excel(name = "心率 (次/分)")
    private Long heartRate;

    /** 收缩压 (高压) */
    @Excel(name = "收缩压 (高压)")
    private Long bloodPressureHigh;

    /** 舒张压 (低压) */
    @Excel(name = "舒张压 (低压)")
    private Long bloodPressureLow;

    /** 测量时间 */
    @Excel(name = "测量时间")
    private LocalDateTime measureTime;

    /** 是否触发报警: 0-正常, 1-异常报警 */
    @Excel(name = "是否触发报警: 0-正常, 1-异常报警")
    private Integer isAlert;


}
