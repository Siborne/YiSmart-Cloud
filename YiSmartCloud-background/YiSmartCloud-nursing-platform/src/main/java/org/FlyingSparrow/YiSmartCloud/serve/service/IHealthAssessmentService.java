package org.FlyingSparrow.YiSmartCloud.serve.service;

import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

import org.FlyingSparrow.YiSmartCloud.serve.domain.HealthAssessment;
import org.FlyingSparrow.YiSmartCloud.serve.dto.HealthAssessmentAnalyzeRequest;

/**
 * 健康评估Service接口
 *
 * @author Siborne
 * @date 2026-05-04
 */
public interface IHealthAssessmentService extends IService<HealthAssessment> {
    /**
     * 查询健康评估
     *
     * @param id 健康评估主键
     * @return 健康评估
     */
    public HealthAssessment selectHealthAssessmentById(Long id);

    /**
     * 查询健康评估列表
     *
     * @param healthAssessment 健康评估
     * @return 健康评估集合
     */
    public List<HealthAssessment> selectHealthAssessmentList(HealthAssessment healthAssessment);

    /**
     * 新增健康评估
     *
     * @param healthAssessment 健康评估
     * @return 结果
     */
    public int insertHealthAssessment(HealthAssessment healthAssessment);

    /**
     * 修改健康评估
     *
     * @param healthAssessment 健康评估
     * @return 结果
     */
    public int updateHealthAssessment(HealthAssessment healthAssessment);

    /**
     * 批量删除健康评估
     *
     * @param ids 需要删除的健康评估主键集合
     * @return 结果
     */
    public int deleteHealthAssessmentByIds(Long[] ids);

    /**
     * 删除健康评估信息
     *
     * @param id 健康评估主键
     * @return 结果
     */
    public int deleteHealthAssessmentById(Long id);

    /**
     * 从 Redis 取体检正文，调用千帆解析并写入健康评估表。
     */
    HealthAssessment analyzeAndSave(HealthAssessmentAnalyzeRequest request);

    /**
     * 创建待分析记录，事务提交后异步调用千帆（HTTP 立即返回）。
     */
    HealthAssessment submitAnalysisAsync(HealthAssessmentAnalyzeRequest request);

    /**
     * 按主键执行千帆分析（仅 analysis_status=0），由异步监听器调用。
     */
    void executeAnalysisById(Long assessmentId);
}