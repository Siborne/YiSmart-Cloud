package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

import org.FlyingSparrow.YiSmartCloud.common.ai.QianfanChatSupport;
import org.FlyingSparrow.YiSmartCloud.common.exception.ServiceException;
import org.FlyingSparrow.YiSmartCloud.common.utils.StringUtils;
import org.FlyingSparrow.YiSmartCloud.serve.config.QianfanProperties;
import org.FlyingSparrow.YiSmartCloud.serve.constant.HealthAssessmentAnalysisStatuses;
import org.FlyingSparrow.YiSmartCloud.serve.domain.HealthAssessment;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.HealthAssessmentMapper;
import org.FlyingSparrow.YiSmartCloud.serve.dto.HealthAssessmentAnalyzeRequest;
import org.FlyingSparrow.YiSmartCloud.serve.dto.ai.HealthAssessmentAiResult;
import org.FlyingSparrow.YiSmartCloud.serve.event.HealthAssessmentAnalysisRequestedEvent;
import org.FlyingSparrow.YiSmartCloud.serve.assessment.ai.HealthAssessmentAiJsonExtractor;
import org.FlyingSparrow.YiSmartCloud.serve.assessment.ai.HealthAssessmentAiPrompts;
import org.FlyingSparrow.YiSmartCloud.serve.service.IHealthAssessmentService;
import org.FlyingSparrow.YiSmartCloud.serve.util.IdCardParseUtil;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.openai.client.OpenAIClient;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * 健康评估Service业务层处理
 *
 * @author Siborne
 * @date 2026-05-04
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class HealthAssessmentServiceImpl extends ServiceImpl<HealthAssessmentMapper, HealthAssessment>
        implements IHealthAssessmentService {

    private static final String REDIS_HASH_HEALTH_REPORT = "healthReport";

    private final RedisTemplate<String, String> redisTemplate;
    private final QianfanProperties qianfanProperties;
    private final ObjectMapper objectMapper;
    private final ApplicationEventPublisher eventPublisher;

    @Override
    public HealthAssessment selectHealthAssessmentById(Long id) {
        return getById(id);
    }

    @Override
    public List<HealthAssessment> selectHealthAssessmentList(HealthAssessment healthAssessment) {
        return getBaseMapper().selectHealthAssessmentList(healthAssessment);
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
    public HealthAssessment submitAnalysisAsync(HealthAssessmentAnalyzeRequest request) {
        validateAnalyzeRequest(request);
        HealthAssessment pending = new HealthAssessment();
        copyRequestBase(pending, request);
        pending.setAssessmentTime(LocalDateTime.now());
        pending.setAnalysisStatus(HealthAssessmentAnalysisStatuses.PENDING);
        pending.setReportSummary("AI 分析排队中，您可先处理其它事务，稍后在列表中点击「查看」获取完整报告。");
        pending.setAnalysisError(null);
        if (!save(pending)) {
            throw new ServiceException("保存待分析记录失败");
        }
        eventPublisher.publishEvent(new HealthAssessmentAnalysisRequestedEvent(pending.getId()));
        return getById(pending.getId());
    }

    @Override
    public void executeAnalysisById(Long assessmentId) {
        if (assessmentId == null) {
            return;
        }
        HealthAssessment row = getById(assessmentId);
        if (row == null) {
            log.warn("executeAnalysisById: row not found {}", assessmentId);
            return;
        }
        if (!Integer.valueOf(HealthAssessmentAnalysisStatuses.PENDING).equals(row.getAnalysisStatus())) {
            return;
        }
        try {
            runQianfanAndMerge(row);
        } catch (Exception e) {
            log.error("executeAnalysisById failed id={}", assessmentId, e);
            markAnalysisFailed(assessmentId, e.getMessage());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public HealthAssessment analyzeAndSave(HealthAssessmentAnalyzeRequest request) {
        validateAnalyzeRequest(request);
        String apiKey = qianfanProperties.getApiKey();
        if (StringUtils.isEmpty(apiKey) || "your_APIKey".equals(apiKey.trim())) {
            throw new ServiceException("未配置千帆 API Key，请在配置中设置 yi.qianfan.api-key");
        }
        Object cached = redisTemplate.opsForHash().get(REDIS_HASH_HEALTH_REPORT, request.getIdCard().trim());
        String reportText = cached == null ? null : cached.toString();
        if (StringUtils.isEmpty(reportText)) {
            throw new ServiceException("未找到该身份证对应的体检报告正文，请先上传 PDF 并完成解析");
        }
        LlmParseOut out = invokeQianfan(reportText);
        HealthAssessment row = new HealthAssessment();
        copyRequestBase(row, request);
        fillAiFields(row, out.result, out.jsonStr);
        row.setAnalysisStatus(HealthAssessmentAnalysisStatuses.COMPLETED);
        row.setAnalysisError(null);
        if (!save(row)) {
            throw new ServiceException("保存健康评估失败");
        }
        redisTemplate.opsForHash().delete(REDIS_HASH_HEALTH_REPORT, request.getIdCard().trim());
        return row;
    }

    private void runQianfanAndMerge(HealthAssessment row) {
        String apiKey = qianfanProperties.getApiKey();
        if (StringUtils.isEmpty(apiKey) || "your_APIKey".equals(apiKey.trim())) {
            throw new ServiceException("未配置千帆 API Key，请在配置中设置 yi.qianfan.api-key");
        }
        Object cached = redisTemplate.opsForHash().get(REDIS_HASH_HEALTH_REPORT, row.getIdCard().trim());
        String reportText = cached == null ? null : cached.toString();
        if (StringUtils.isEmpty(reportText)) {
            throw new ServiceException("未找到该身份证对应的体检报告正文，可能已过期，请重新上传 PDF");
        }
        LlmParseOut out = invokeQianfan(reportText);
        fillAiFields(row, out.result, out.jsonStr);
        row.setAnalysisStatus(HealthAssessmentAnalysisStatuses.COMPLETED);
        row.setAnalysisError(null);
        if (!updateById(row)) {
            throw new ServiceException("更新健康评估失败");
        }
        redisTemplate.opsForHash().delete(REDIS_HASH_HEALTH_REPORT, row.getIdCard().trim());
    }

    private LlmParseOut invokeQianfan(String reportText) {
        String apiKey = qianfanProperties.getApiKey().trim();
        String userMessage = HealthAssessmentAiPrompts.buildUserMessage(reportText);
        OpenAIClient client = QianfanChatSupport.createClient(apiKey);
        String model = StringUtils.isNotEmpty(qianfanProperties.getModel())
                ? qianfanProperties.getModel().trim()
                : "deepseek-r1-distill-qianfan-70b";
        String reply = QianfanChatSupport.chat(client, model, userMessage);
        if (StringUtils.isEmpty(reply)) {
            throw new ServiceException("千帆返回为空，请稍后重试");
        }
        String jsonStr = HealthAssessmentAiJsonExtractor.extractJsonObject(reply);
        try {
            HealthAssessmentAiResult parsed = objectMapper.readValue(jsonStr, HealthAssessmentAiResult.class);
            return new LlmParseOut(parsed, jsonStr);
        } catch (JsonProcessingException e) {
            throw new ServiceException("AI 返回无法解析为 JSON：" + e.getMessage());
        }
    }

    private void markAnalysisFailed(Long id, String message) {
        String err = StringUtils.isEmpty(message) ? "未知错误" : message;
        if (err.length() > 500) {
            err = err.substring(0, 500);
        }
        update(Wrappers.<HealthAssessment>lambdaUpdate()
                .eq(HealthAssessment::getId, id)
                .set(HealthAssessment::getAnalysisStatus, HealthAssessmentAnalysisStatuses.FAILED)
                .set(HealthAssessment::getAnalysisError, err)
                .set(HealthAssessment::getReportSummary, "AI 分析失败，请核对千帆配置与报告内容后重新提交。"));
    }

    private static void validateAnalyzeRequest(HealthAssessmentAnalyzeRequest request) {
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
    }

    private static void copyRequestBase(HealthAssessment h, HealthAssessmentAnalyzeRequest req) {
        h.setElderName(req.getElderName().trim());
        h.setIdCard(req.getIdCard().trim());
        h.setPhysicalExamInstitution(req.getPhysicalExamInstitution().trim());
        h.setPhysicalReportUrl(req.getPhysicalReportUrl().trim());
        IdCardParseUtil.birthDateFrom18(h.getIdCard()).ifPresent(d -> h.setBirthDate(d.atStartOfDay()));
        IdCardParseUtil.genderFrom18(h.getIdCard()).ifPresent(h::setGender);
        IdCardParseUtil.ageFrom18(h.getIdCard()).ifPresent(h::setAge);
    }

    private void fillAiFields(HealthAssessment h, HealthAssessmentAiResult ai, String normalizedJson) {
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

    private static final class LlmParseOut {
        final HealthAssessmentAiResult result;
        final String jsonStr;

        LlmParseOut(HealthAssessmentAiResult result, String jsonStr) {
            this.result = result;
            this.jsonStr = jsonStr;
        }
    }
}
