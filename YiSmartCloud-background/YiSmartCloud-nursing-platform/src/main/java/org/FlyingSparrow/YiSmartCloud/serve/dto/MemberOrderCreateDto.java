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

    @NotNull(message = "鏈嶅姟椤圭洰ID涓嶈兘涓虹┖")
    @ApiModelProperty(value = "鏈嶅姟椤圭洰ID", required = true)
    private Long projectId;

    @NotNull(message = "服务对象ID不能为空")
    @ApiModelProperty(value = "兼容字段：服务对象ID（历史字段名）", required = true)
    private Long familyMemberId;

    @ApiModelProperty("老人ID（新字段，优先使用）")
    private Long elderId;

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

