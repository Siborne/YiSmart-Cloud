package org.FlyingSparrow.YiSmartCloud.serve.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * Mini-program user login request (C-end).
 */
@Data
@ApiModel("Mini-program login request")
public class UserLoginRequestDto {

    @ApiModelProperty("Nickname from WeChat profile")
    private String nickName;

    @ApiModelProperty("Temporary login credential from wx.login")
    private String code;

    @ApiModelProperty("Phone number credential from getPhoneNumber")
    private String phoneCode;
}
