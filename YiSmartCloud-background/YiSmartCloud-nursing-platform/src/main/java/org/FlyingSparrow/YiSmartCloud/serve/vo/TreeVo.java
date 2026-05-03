package org.FlyingSparrow.YiSmartCloud.serve.vo;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@Data
@ApiModel("树形结构VO")
public class TreeVo {

    /**
     * 菜单名称
     */
    @ApiModelProperty(value = "菜单名称")
    private String label;

    /**
     * 菜单ID
     */
    @ApiModelProperty(value = "菜单ID")
    private String value;

    /**
     * 子菜单
     */
    @ApiModelProperty(value = "子菜单")
    private List<TreeVo> children;
}