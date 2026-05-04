package org.FlyingSparrow.YiSmartCloud.serve.vo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 按时间段统计已预约人数（Mapper 查询行）
 *
 * @author agent
 */
@Data
public class ReservationSlotOccupancyRow {

    private LocalDateTime slotTime;

    private Integer bookedCount;
}
