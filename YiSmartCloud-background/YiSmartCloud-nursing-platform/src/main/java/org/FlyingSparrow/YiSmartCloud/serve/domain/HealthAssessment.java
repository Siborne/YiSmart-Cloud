package org.FlyingSparrow.YiSmartCloud.serve.domain;

import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 健康评估对象 health_assessment
 * 
 * @author Siborne
 * @date 2026-05-04
 */
@Data
public class HealthAssessment extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 老人姓名 */
    @Excel(name = "老人姓名")
    private String elderName;

    /** 身份证号 */
    @Excel(name = "身份证号")
    private String idCard;

    /** 出生日期 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "出生日期", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime birthDate;

    /** 年龄 */
    @Excel(name = "年龄")
    private Integer age;

    /** 性别(0:男，1:女) */
    @Excel(name = "性别(0:男，1:女)")
    private Integer gender;

    /** 健康评分 */
    @Excel(name = "健康评分")
    private String healthScore;

    /** 严重危险(健康, 提示, 风险, 危险, 严重危险) */
    @Excel(name = "严重危险(健康, 提示, 风险, 危险, 严重危险)")
    private String riskLevel;

    /** 是否建议入住(0:建议，1:不建议) */
    @Excel(name = "是否建议入住(0:建议，1:不建议)")
    private Integer suggestionForAdmission;

    /** 推荐护理等级 */
    @Excel(name = "推荐护理等级")
    private String nursingLevelName;

    /** 入住情况(0:已入住，1:未入住) */
    @Excel(name = "入住情况(0:已入住，1:未入住)")
    private Integer admissionStatus;

    /** 总检日期 */
    @Excel(name = "总检日期")
    private String totalCheckDate;

    /** 体检机构 */
    @Excel(name = "体检机构")
    private String physicalExamInstitution;

    /** 体检报告URL链接 */
    @Excel(name = "体检报告URL链接")
    private String physicalReportUrl;

    /** 评估时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "评估时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime assessmentTime;

    /** 报告总结 */
    @Excel(name = "报告总结")
    private String reportSummary;

    /** 疾病风险 */
    @Excel(name = "疾病风险")
    private String diseaseRisk;

    /** 异常分析 */
    @Excel(name = "异常分析")
    private String abnormalAnalysis;

    /** 健康系统分值 */
    @Excel(name = "健康系统分值")
    private String systemScore;

    /** AI解析完整JSON（列表查询不返回，详情由 MP getById 带出） */
    @TableField("ai_result_json")
    private String aiResultJson;

    /** AI 分析状态：0分析中 1已完成 2失败 */
    @Excel(name = "分析状态")
    @TableField("analysis_status")
    private Integer analysisStatus;

    /** 分析失败原因 */
    @TableField("analysis_error")
    private String analysisError;

}
