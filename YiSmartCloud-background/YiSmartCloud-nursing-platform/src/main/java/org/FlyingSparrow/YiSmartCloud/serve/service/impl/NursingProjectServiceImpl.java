package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.List;
import org.FlyingSparrow.YiSmartCloud.common.utils.DateUtils;
import org.FlyingSparrow.YiSmartCloud.serve.vo.NursingProjectVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.NursingProjectMapper;
import org.FlyingSparrow.YiSmartCloud.serve.domain.NursingProject;
import org.FlyingSparrow.YiSmartCloud.serve.service.INursingProjectService;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import java.util.Arrays;

/**
 * 护理项目Service业务层处理
 *
 * @author Siborne
 * @date 2026-03-23
 */
@Service
@RequiredArgsConstructor
public class NursingProjectServiceImpl extends ServiceImpl<NursingProjectMapper, NursingProject> implements INursingProjectService {
    private final NursingProjectMapper nursingProjectMapper;

    /**
     * 查询护理项目
     *
     * @param id 护理项目主键
     * @return 护理项目
     */
    @Override
    public NursingProject selectNursingProjectById(Long id) {
                return getById(id);
    }

    /**
     * 查询护理项目列表
     *
     * @param nursingProject 护理项目
     * @return 护理项目
     */
    @Override
    public List<NursingProject> selectNursingProjectList(NursingProject nursingProject) {
        return nursingProjectMapper.selectNursingProjectList(nursingProject);
    }

    /**
     * 新增护理项目
     *
     * @param nursingProject 护理项目
     * @return 结果
     */
    @Override
    public int insertNursingProject(NursingProject nursingProject) {
                        return save(nursingProject) == true? 1 : 0;
    }

    /**
     * 修改护理项目
     *
     * @param nursingProject 护理项目
     * @return 结果
     */
    @Override
    public int updateNursingProject(NursingProject nursingProject) {
                return updateById(nursingProject) == true ? 1 : 0;
    }

    /**
     * 批量删除护理项目
     *
     * @param ids 需要删除的护理项目主键
     * @return 结果
     */
    @Override
    public int deleteNursingProjectByIds(Long[] ids) {
                return removeByIds(Arrays.asList(ids)) == true ? 1 : 0;
    }

    /**
     * 删除护理项目信息
     *
     * @param id 护理项目主键
     * @return 结果
     */
    @Override
    public int deleteNursingProjectById(Long id) {
                return removeById(id) == true ? 1 : 0;
    }

    /**
     * 查询所有护理项目
     *
     * @return 护理项目列表
     */
    @Override
    public List<NursingProjectVo> selectAll() {
        return nursingProjectMapper.getAll();
    }
}