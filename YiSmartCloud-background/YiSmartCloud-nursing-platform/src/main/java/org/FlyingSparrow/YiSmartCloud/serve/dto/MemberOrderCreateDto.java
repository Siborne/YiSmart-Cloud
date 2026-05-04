package org.FlyingSparrow.YiSmartCloud.serve.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

/**
 * Member create order request.
 */
@Data
@ApiModel("Member create order request")
public class MemberOrderCreateDto {

    @NotNull(message = "服务项目ID不能为空")
    @ApiModelProperty(value = "服务项目ID", required = true)
    private Long projectId;

    @NotNull(message = "服务家人不能为空")
    @ApiModelProperty(value = "服务家人ID", required = true)
    private Long familyMemberId;

    @Min(value = 1, message = "数量至少为1")
    @ApiModelProperty(value = "数量", required = true)
    private Integer count = 1;

    @NotNull(message = "期望服务时间不能为空")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "期望服务时间", required = true)
    private LocalDateTime expectedServiceTime;

    @ApiModelProperty(value = "备注")
    private String remark;
}

