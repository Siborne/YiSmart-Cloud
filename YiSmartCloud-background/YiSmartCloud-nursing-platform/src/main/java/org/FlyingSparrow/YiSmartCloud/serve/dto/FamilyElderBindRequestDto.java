package org.FlyingSparrow.YiSmartCloud.serve.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 家属绑定老人请求
 */
@Data
@ApiModel("家属绑定老人请求")
public class FamilyElderBindRequestDto {

    @NotBlank(message = "老人姓名不能为空")
    @ApiModelProperty(value = "老人姓名", required = true)
    private String elderName;

    @NotBlank(message = "老人预留手机号不能为空")
    @ApiModelProperty(value = "老人档案预留手机号", required = true)
    private String phone;

    @ApiModelProperty(value = "关系描述，例如 子女/配偶")
    private String relation;
}
