package org.FlyingSparrow.YiSmartCloud.serve.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 房间下床位信息 VO。
 */
@Data
@ApiModel("床位Vo")
public class BedVo {

    @ApiModelProperty(value = "床位ID", required = true)
    private Long id;

    @ApiModelProperty(value = "床位编号", required = true)
    private String bedNo;

    @ApiModelProperty(value = "床位状态(0-空闲,1-占用,2-维修中)", required = true)
    private Integer bedStatus;

    @ApiModelProperty(value = "床位状态名称")
    private String bedStatusName;
}
