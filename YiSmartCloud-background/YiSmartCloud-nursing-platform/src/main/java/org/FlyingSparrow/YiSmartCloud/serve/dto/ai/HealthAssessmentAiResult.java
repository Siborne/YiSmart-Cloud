package org.FlyingSparrow.YiSmartCloud.serve.dto.ai;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

/**
 * 千帆返回的体检分析 JSON 结构（与产品约定字段一致）。
 */
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class HealthAssessmentAiResult {

    private String totalCheckDate;

    @JsonProperty("healthAssessment")
    private HealthAssessmentBlock healthAssessment;

    @JsonProperty("riskDistribution")
    private RiskDistribution riskDistribution;

    @JsonProperty("abnormalData")
    private List<AbnormalItem> abnormalData;

    @JsonProperty("systemScore")
    private SystemScoreBlock systemScore;

    private String summarize;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class HealthAssessmentBlock {
        private String riskLevel;
        private Double healthIndex;
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class RiskDistribution {
        private Double healthy;
        private Double caution;
        private Double risk;
        private Double danger;
        private Double severeDanger;
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class AbnormalItem {
        private String conclusion;
        @JsonProperty("examinationItem")
        private String examinationItem;
        private String result;
        @JsonProperty("referenceValue")
        private String referenceValue;
        private String unit;
        @JsonProperty("interpret")
        private String interpret;
        private String advice;
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class SystemScoreBlock {
        @JsonProperty("breathingSystem")
        private Integer breathingSystem;
        @JsonProperty("digestiveSystem")
        private Integer digestiveSystem;
        @JsonProperty("endocrineSystem")
        private Integer endocrineSystem;
        @JsonProperty("immuneSystem")
        private Integer immuneSystem;
        @JsonProperty("circulatorySystem")
        private Integer circulatorySystem;
        @JsonProperty("urinarySystem")
        private Integer urinarySystem;
        @JsonProperty("motionSystem")
        private Integer motionSystem;
        @JsonProperty("senseSystem")
        private Integer senseSystem;
    }
}
