package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.Collections;
import java.util.List;

import org.FlyingSparrow.YiSmartCloud.common.constant.CacheConstants;
import org.FlyingSparrow.YiSmartCloud.common.utils.DateUtils;
import org.FlyingSparrow.YiSmartCloud.common.utils.bean.BeanUtils;
import org.FlyingSparrow.YiSmartCloud.serve.dto.NursingPlanDto;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.NursingProjectPlanMapper;
import org.FlyingSparrow.YiSmartCloud.serve.vo.NursingPlanVo;
import org.FlyingSparrow.YiSmartCloud.serve.vo.NursingProjectPlanVo;
import org.springframework.beans.BeansException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.NursingPlanMapper;
import org.FlyingSparrow.YiSmartCloud.serve.domain.NursingPlan;
import org.FlyingSparrow.YiSmartCloud.serve.service.INursingPlanService;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;

/**
 * 护理计划Service业务层处理
 *
 * @author Siborne
 * @date 2026-03-23
 */
@Service
@Transactional
@RequiredArgsConstructor
public class NursingPlanServiceImpl extends ServiceImpl<NursingPlanMapper, NursingPlan> implements INursingPlanService {
    private final NursingPlanMapper nursingPlanMapper;

    private final NursingProjectPlanMapper nursingProjectPlanMapper;

    private final RedisTemplate<Object, Object> redisTemplate;

    /**
     * 查询护理计划
     *
     * @param id 护理计划主键
     * @return 护理计划
     */
    @Override
    public NursingPlanVo selectNursingPlanById(Long id) {
        //查询护理计划
        NursingPlan nursingPlan = nursingPlanMapper.selectNursingPlanById(id);
        NursingPlanVo nursingPlanVo = new NursingPlanVo();
        BeanUtils.copyProperties(nursingPlan, nursingPlanVo);

        //根据护理计划ID查询护理项目的关系
        List<NursingProjectPlanVo> list = nursingProjectPlanMapper.selectByNursingPlanId(id);
        nursingPlanVo.setProjectPlans(list);

        return nursingPlanVo;
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

    @Override
    @SuppressWarnings("unchecked")
    public List<NursingPlan> selectNursingPlanAll() {
        List<NursingPlan> cached = (List<NursingPlan>) redisTemplate.opsForValue().get(CacheConstants.NURSING_PLAN_ALL_KEY);
        if (cached != null) {
            return cached;
        }
        List<NursingPlan> list = nursingPlanMapper.selectNursingPlanAll();
        if (list == null) {
            list = Collections.emptyList();
        }
        redisTemplate.opsForValue().set(CacheConstants.NURSING_PLAN_ALL_KEY, list);
        return list;
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
        int count = nursingProjectPlanMapper.batchInsert(dto.getProjectPlans(), nursingPlan.getId());
        evictNursingPlanAllCache();
        return count == 0 ? 0 : 1;
    }

    /**
     * 修改护理计划
     *
     * @param dto 护理计划
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateNursingPlan(NursingPlanDto dto) {
        try {
            //属性拷贝
            NursingPlan nursingPlan = new NursingPlan();
            BeanUtils.copyProperties(dto, nursingPlan);

            //判断dto中的项目列表为空，如果不为空，则先删除护理计划与护理项目的关系，然后重新批量添加
            if (dto.getProjectPlans() != null && dto.getProjectPlans().size() > 0) {
                //删除护理计划与护理项目的关系
                nursingProjectPlanMapper.deleteByPlanId(dto.getId());
                //批量添加护理计划与护理项目的关系
                nursingProjectPlanMapper.batchInsert(dto.getProjectPlans(), dto.getId());
            }

            //别管项目列表是否为空，都要修改护理计划
            int rows = nursingPlanMapper.updateNursingPlan(nursingPlan);
            evictNursingPlanAllCache();
            return rows;
        } catch (BeansException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 批量删除护理计划
     *
     * @param ids 需要删除的护理计划主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteNursingPlanByIds(Long[] ids) {
        int rows = removeByIds(Arrays.asList(ids)) == true ? 1 : 0;
        evictNursingPlanAllCache();
        return rows;
    }

    /**
     * 删除护理计划信息
     *
     * @param id 护理计划主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteNursingPlanById(Long id) {
        //删除关系
        //删除护理计划与护理项目的关系
        nursingProjectPlanMapper.deleteByPlanId(id);
        int rows = nursingPlanMapper.deleteNursingPlanById(id);
        evictNursingPlanAllCache();
        return rows;
    }

    private void evictNursingPlanAllCache() {
        redisTemplate.delete(CacheConstants.NURSING_PLAN_ALL_KEY);
        // 护理等级「全部启用」JOIN 计划名称，计划变更后需一并失效
        redisTemplate.delete(CacheConstants.NURSING_LEVEL_LIST_ALL_KEY);
    }
}