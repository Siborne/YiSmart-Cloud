package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.List;

import org.FlyingSparrow.YiSmartCloud.common.utils.DateUtils;
import org.FlyingSparrow.YiSmartCloud.common.utils.bean.BeanUtils;
import org.FlyingSparrow.YiSmartCloud.serve.dto.NursingPlanDto;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.NursingProjectPlanMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.NursingPlanMapper;
import org.FlyingSparrow.YiSmartCloud.serve.domain.NursingPlan;
import org.FlyingSparrow.YiSmartCloud.serve.service.INursingPlanService;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.util.Arrays;

/**
 * 护理计划Service业务层处理
 *
 * @author Siborne
 * @date 2026-03-23
 */
@Service
public class NursingPlanServiceImpl extends ServiceImpl<NursingPlanMapper, NursingPlan> implements INursingPlanService {
    @Autowired
    private NursingPlanMapper nursingPlanMapper;

    @Autowired
    private NursingProjectPlanMapper nursingProjectPlanMapper;

    /**
     * 查询护理计划
     *
     * @param id 护理计划主键
     * @return 护理计划
     */
    @Override
    public NursingPlan selectNursingPlanById(Long id) {
        return getById(id);
    }

    /**
     * 查询护理计划列表
     *
     * @param nursingPlan 护理计划
     * @return 护理计划
     */
    @Override
    public List<NursingPlan> selectNursingPlanList(NursingPlan nursingPlan) {
        return nursingPlanMapper.selectNursingPlanList(nursingPlan);
    }

    /**
     * 新增护理计划
     *
     * @param dto 护理计划
     * @return 结果
     */
    @Override
    public int insertNursingPlan(NursingPlanDto dto) {
        // 1.保存护理计划
        NursingPlan nursingPlan = new NursingPlan();
        BeanUtils.copyProperties(dto, nursingPlan);
        nursingPlan.setCreateTime(DateUtils.getNowDate());

        nursingPlanMapper.insertNursingPlan(nursingPlan);

        // 2.批量保存护理计划和护理项目的对应关系
        int count = nursingProjectPlanMapper.batchInsert(dto.getProjectPlans(),nursingPlan.getId());
        return count == 0 ? 0 : 1;
    }

    /**
     * 修改护理计划
     *
     * @param nursingPlan 护理计划
     * @return 结果
     */
    @Override
    public int updateNursingPlan(NursingPlan nursingPlan) {
        return updateById(nursingPlan) == true ? 1 : 0;
    }

    /**
     * 批量删除护理计划
     *
     * @param ids 需要删除的护理计划主键
     * @return 结果
     */
    @Override
    public int deleteNursingPlanByIds(Long[] ids) {
        return removeByIds(Arrays.asList(ids)) == true ? 1 : 0;
    }

    /**
     * 删除护理计划信息
     *
     * @param id 护理计划主键
     * @return 结果
     */
    @Override
    public int deleteNursingPlanById(Long id) {
        return removeById(id) == true ? 1 : 0;
    }
}