package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

import org.FlyingSparrow.YiSmartCloud.common.ai.QianfanChatSupport;
import org.FlyingSparrow.YiSmartCloud.common.exception.ServiceException;
import org.FlyingSparrow.YiSmartCloud.common.utils.StringUtils;
import org.FlyingSparrow.YiSmartCloud.serve.config.QianfanProperties;
import org.FlyingSparrow.YiSmartCloud.serve.domain.HealthAssessment;
import org.FlyingSparrow.YiSmartCloud.serve.dto.HealthAssessmentAnalyzeRequest;
import org.FlyingSparrow.YiSmartCloud.serve.dto.ai.HealthAssessmentAiResult;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.HealthAssessmentMapper;
import org.FlyingSparrow.YiSmartCloud.serve.service.HealthAssessmentAiJsonExtractor;
import org.FlyingSparrow.YiSmartCloud.serve.service.HealthAssessmentAiPrompts;
import org.FlyingSparrow.YiSmartCloud.serve.service.IHealthAssessmentService;
import org.FlyingSparrow.YiSmartCloud.serve.util.IdCardParseUtil;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.openai.client.OpenAIClient;

import lombok.RequiredArgsConstructor;

/**
 * 健康评估Service业务层处理
 *
 * @author Siborne
 * @date 2026-05-04
 */
@Service
@RequiredArgsConstructor
public class HealthAssessmentServiceImpl extends ServiceImpl<HealthAssessmentMapper, HealthAssessment>
        implements IHealthAssessmentService {

    private static final String REDIS_HASH_HEALTH_REPORT = "healthReport";

    private final HealthAssessmentMapper healthAssessmentMapper;
    private final RedisTemplate<String, String> redisTemplate;
    private final QianfanProperties qianfanProperties;
    private final ObjectMapper objectMapper;

    @Override
    public HealthAssessment selectHealthAssessmentById(Long id) {
        return getById(id);
    }

    @Override
    public List<HealthAssessment> selectHealthAssessmentList(HealthAssessment healthAssessment) {
        return healthAssessmentMapper.selectHealthAssessmentList(healthAssessment);
    }

    @Override
    public int insertHealthAssessment(HealthAssessment healthAssessment) {
        return save(healthAssessment) ? 1 : 0;
    }

    @Override
    public int updateHealthAssessment(HealthAssessment healthAssessment) {
        return updateById(healthAssessment) ? 1 : 0;
    }

    @Override
    public int deleteHealthAssessmentByIds(Long[] ids) {
        return removeByIds(Arrays.asList(ids)) ? 1 : 0;
    }

    @Override
    public int deleteHealthAssessmentById(Long id) {
        return removeById(id) ? 1 : 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public HealthAssessment analyzeAndSave(HealthAssessmentAnalyzeRequest request) {
        if (request == null) {
            throw new ServiceException("请求体不能为空");
        }
        if (StringUtils.isEmpty(request.getElderName())) {
            throw new ServiceException("老人姓名不能为空");
        }
        if (StringUtils.isEmpty(request.getIdCard())) {
            throw new ServiceException("身份证号不能为空");
        }
        if (StringUtils.isEmpty(request.getPhysicalExamInstitution())) {
            throw new ServiceException("体检单位不能为空");
        }
        if (StringUtils.isEmpty(request.getPhysicalReportUrl())) {
            throw new ServiceException("体检报告地址不能为空，请先上传 PDF");
        }
        String apiKey = qianfanProperties.getApiKey();
        if (StringUtils.isEmpty(apiKey) || "your_APIKey".equals(apiKey.trim())) {
            throw new ServiceException("未配置千帆 API Key，请在配置中设置 yi.qianfan.api-key");
        }

        Object cached = redisTemplate.opsForHash().get(REDIS_HASH_HEALTH_REPORT, request.getIdCard().trim());
        String reportText = cached == null ? null : cached.toString();
        if (StringUtils.isEmpty(reportText)) {
            throw new ServiceException("未找到该身份证对应的体检报告正文，请先上传 PDF 并完成解析");
        }

        String userMessage = HealthAssessmentAiPrompts.buildUserMessage(reportText);
        OpenAIClient client = QianfanChatSupport.createClient(apiKey.trim());
        String model = StringUtils.isNotEmpty(qianfanProperties.getModel())
                ? qianfanProperties.getModel().trim()
                : "deepseek-r1-distill-qianfan-70b";
        String reply = QianfanChatSupport.chat(client, model, userMessage);
        if (StringUtils.isEmpty(reply)) {
            throw new ServiceException("千帆返回为空，请稍后重试");
        }

        String jsonStr = HealthAssessmentAiJsonExtractor.extractJsonObject(reply);
        HealthAssessmentAiResult parsed;
        try {
            parsed = objectMapper.readValue(jsonStr, HealthAssessmentAiResult.class);
        } catch (JsonProcessingException e) {
            throw new ServiceException("AI 返回无法解析为 JSON：" + e.getMessage());
        }

        HealthAssessment row = buildEntityFromAi(request, parsed, jsonStr);
        if (!save(row)) {
            throw new ServiceException("保存健康评估失败");
        }
        redisTemplate.opsForHash().delete(REDIS_HASH_HEALTH_REPORT, request.getIdCard().trim());
        return row;
    }

    private HealthAssessment buildEntityFromAi(HealthAssessmentAnalyzeRequest req, HealthAssessmentAiResult ai,
            String normalizedJson) {
        HealthAssessment h = new HealthAssessment();
        h.setElderName(req.getElderName().trim());
        h.setIdCard(req.getIdCard().trim());
        h.setPhysicalExamInstitution(req.getPhysicalExamInstitution().trim());
        h.setPhysicalReportUrl(req.getPhysicalReportUrl().trim());

        IdCardParseUtil.birthDateFrom18(h.getIdCard()).ifPresent(d -> h.setBirthDate(d.atStartOfDay()));
        IdCardParseUtil.genderFrom18(h.getIdCard()).ifPresent(h::setGender);
        IdCardParseUtil.ageFrom18(h.getIdCard()).ifPresent(h::setAge);

        h.setTotalCheckDate(ai.getTotalCheckDate());
        if (ai.getHealthAssessment() != null) {
            h.setRiskLevel(ai.getHealthAssessment().getRiskLevel());
            Double idx = ai.getHealthAssessment().getHealthIndex();
            if (idx != null) {
                h.setHealthScore(String.format("%.2f", idx));
            }
        }
        h.setReportSummary(ai.getSummarize());
        h.setAssessmentTime(LocalDateTime.now());

        try {
            if (ai.getRiskDistribution() != null) {
                h.setDiseaseRisk(objectMapper.writeValueAsString(ai.getRiskDistribution()));
            } else {
                h.setDiseaseRisk("{}");
            }
            if (ai.getAbnormalData() != null) {
                h.setAbnormalAnalysis(objectMapper.writeValueAsString(ai.getAbnormalData()));
            } else {
                h.setAbnormalAnalysis("[]");
            }
            if (ai.getSystemScore() != null) {
                h.setSystemScore(objectMapper.writeValueAsString(ai.getSystemScore()));
            } else {
                h.setSystemScore("{}");
            }
        } catch (JsonProcessingException e) {
            throw new ServiceException("序列化 AI 分项失败：" + e.getMessage());
        }

        h.setAiResultJson(normalizedJson);

        String risk = ai.getHealthAssessment() != null ? ai.getHealthAssessment().getRiskLevel() : null;
        Double healthIndex = ai.getHealthAssessment() != null ? ai.getHealthAssessment().getHealthIndex() : null;
        h.setSuggestionForAdmission(admissionSuggestion(risk, healthIndex));
        h.setNursingLevelName(nursingLevelFromRisk(risk));

        return h;
    }

    private static int admissionSuggestion(String riskLevel, Double healthIndex) {
        if ("severeDanger".equals(riskLevel) || "danger".equals(riskLevel)) {
            return 1;
        }
        if (healthIndex != null && healthIndex < 50) {
            return 1;
        }
        return 0;
    }

    private static String nursingLevelFromRisk(String risk) {
        if (risk == null) {
            return "一级护理等级";
        }
        switch (risk) {
            case "healthy":
                return "一级护理等级";
            case "caution":
                return "二级护理等级";
            case "risk":
                return "三级护理等级";
            case "danger":
                return "四级护理等级";
            case "severeDanger":
                return "五级护理等级";
            default:
                return "一级护理等级";
        }
    }
}
