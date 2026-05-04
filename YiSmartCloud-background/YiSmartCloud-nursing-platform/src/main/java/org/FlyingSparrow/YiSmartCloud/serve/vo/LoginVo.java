package org.FlyingSparrow.YiSmartCloud.serve.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * Login response for mini-program (same JWT scheme as admin).
 */
@Data
@ApiModel("Login result")
public class LoginVo {

    @ApiModelProperty("JWT Bearer token")
    private String token;

    @ApiModelProperty("Display nickname")
    private String nickName;
}
