package org.FlyingSparrow.YiSmartCloud.serve.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * Member basic auth request.
 */
@Data
@ApiModel("Member basic auth request")
public class MemberAuthRequestDto {

    @ApiModelProperty("Phone number")
    private String phone;

    @ApiModelProperty("Optional nickname")
    private String nickName;
}

