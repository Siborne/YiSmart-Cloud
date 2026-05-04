package org.FlyingSparrow.YiSmartCloud.serve.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 时间段剩余可约次数
 *
 * @author agent
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(description = "时间段剩余预约次数")
public class TimeSlotCountVo {

    @ApiModelProperty("时间段，格式 yyyy-MM-dd HH:mm:ss")
    private String time;

    @ApiModelProperty("剩余可预约次数")
    private Integer count;
}
