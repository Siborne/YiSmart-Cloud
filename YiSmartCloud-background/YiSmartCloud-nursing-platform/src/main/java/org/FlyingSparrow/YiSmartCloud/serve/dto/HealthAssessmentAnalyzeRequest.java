package org.FlyingSparrow.YiSmartCloud.serve.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 提交体检报告进行 AI 分析（Redis 中需已有该身份证号对应的 PDF 正文）。
 */
@Data
@ApiModel("健康评估分析请求")
public class HealthAssessmentAnalyzeRequest {

    @ApiModelProperty(value = "老人姓名", required = true)
    private String elderName;

    @ApiModelProperty(value = "身份证号", required = true)
    private String idCard;

    @ApiModelProperty(value = "体检单位", required = true)
    private String physicalExamInstitution;

    @ApiModelProperty(value = "体检报告 OSS URL（上传接口返回）", required = true)
    private String physicalReportUrl;
}
