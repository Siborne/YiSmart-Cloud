package org.FlyingSparrow.YiSmartCloud.serve.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.FlyingSparrow.YiSmartCloud.serve.dto.NursingProjectPlanDto;
import org.FlyingSparrow.YiSmartCloud.serve.vo.NursingProjectPlanVo;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import org.FlyingSparrow.YiSmartCloud.serve.domain.NursingProjectPlan;
import org.apache.ibatis.annotations.Param;

/**
 * 护理计划和项目关联Mapper接口
 *
 * @author ruoyi
 * @date 2026-03-25
 */
@Mapper
public interface NursingProjectPlanMapper extends BaseMapper<NursingProjectPlan> {
    /**
     * 查询护理计划和项目关联
     *
     * @param id 护理计划和项目关联主键
     * @return 护理计划和项目关联
     */
    public NursingProjectPlan selectNursingProjectPlanById(Long id);

    /**
     * 查询护理计划和项目关联列表
     *
     * @param nursingProjectPlan 护理计划和项目关联
     * @return 护理计划和项目关联集合
     */
    public List<NursingProjectPlan> selectNursingProjectPlanList(NursingProjectPlan nursingProjectPlan);

    /**
     * 新增护理计划和项目关联
     *
     * @param nursingProjectPlan 护理计划和项目关联
     * @return 结果
     */
    public int insertNursingProjectPlan(NursingProjectPlan nursingProjectPlan);

    /**
     * 修改护理计划和项目关联
     *
     * @param nursingProjectPlan 护理计划和项目关联
     * @return 结果
     */
    public int updateNursingProjectPlan(NursingProjectPlan nursingProjectPlan);

    /**
     * 删除护理计划和项目关联
     *
     * @param id 护理计划和项目关联主键
     * @return 结果
     */
    public int deleteNursingProjectPlanById(Long id);

    /**
     * 批量删除护理计划和项目关联
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteNursingProjectPlanByIds(Long[] ids);


    /**
     * 批量插入计划项目关系
     *
     * @param projectPlans 计划项目关系
     * @param planId 计划ID
     * @return 插入结果
     */
    int batchInsert(@Param("list") List<NursingProjectPlanDto> projectPlans, @Param("planId") Long planId);

    /**
     * 根据计划ID查询计划项目关系
     *
     * @param planId 计划ID
     * @return 计划项目关系
     */
    List<NursingProjectPlanVo> selectByNursingPlanId(@Param("planId") Long planId);

    /**
     * 根据计划ID删除计划项目关系
     *
     * @param planId 计划ID
     * @return 删除结果
     */
    @Delete("delete from nursing_project_plan where plan_id = #{planId}")
    void deleteByPlanId(Long planId);
}