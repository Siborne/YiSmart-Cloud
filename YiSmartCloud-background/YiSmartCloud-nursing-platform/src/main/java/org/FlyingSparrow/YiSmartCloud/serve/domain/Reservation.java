package org.FlyingSparrow.YiSmartCloud.serve.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;

import java.time.LocalDateTime;

/**
 * 预约信息对象 reservation
 *
 * @author agent
 */
@Data
@TableName("reservation")
@ApiModel(description = "预约信息")
public class Reservation extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    @ApiModelProperty("主键ID")
    private Long id;

    @ApiModelProperty("预约人姓名")
    private String name;

    @ApiModelProperty("预约人手机号")
    private String mobile;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField("`time`")
    @ApiModelProperty("预约时间")
    private LocalDateTime time;

    @ApiModelProperty("家人/探访对象姓名")
    private String visitor;

    @ApiModelProperty("预约类型，0：参观预约，1：探访预约")
    private Integer type;

    @ApiModelProperty("预约状态，0：待报道，1：已完成，2：取消，3：过期")
    private Integer status;
}
