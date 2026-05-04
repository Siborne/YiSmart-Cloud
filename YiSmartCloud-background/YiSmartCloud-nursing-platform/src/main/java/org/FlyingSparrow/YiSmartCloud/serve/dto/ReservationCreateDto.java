package org.FlyingSparrow.YiSmartCloud.serve.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.time.LocalDateTime;

/**
 * 小程序新增预约请求体
 *
 * @author agent
 */
@Data
@ApiModel(description = "新增预约参数")
public class ReservationCreateDto {

    @NotBlank(message = "手机号不能为空")
    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    @ApiModelProperty(value = "手机号", required = true)
    private String mobile;

    @NotBlank(message = "预约人姓名不能为空")
    @ApiModelProperty(value = "预约人姓名", required = true)
    private String name;

    @NotNull(message = "预约时间不能为空")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "预约时间", required = true)
    private LocalDateTime time;

    @NotNull(message = "预约类型不能为空")
    @ApiModelProperty(value = "0：参观预约，1：探访预约", required = true)
    private Integer type;

    @NotBlank(message = "家人姓名不能为空")
    @ApiModelProperty(value = "家人姓名（老人姓名）", required = true)
    private String visitor;
}
