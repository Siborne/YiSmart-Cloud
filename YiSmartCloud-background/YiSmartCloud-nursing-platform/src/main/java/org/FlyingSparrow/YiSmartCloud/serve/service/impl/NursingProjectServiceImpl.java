package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.Collections;
import java.util.List;

import org.FlyingSparrow.YiSmartCloud.common.constant.CacheConstants;
import org.FlyingSparrow.YiSmartCloud.serve.vo.NursingProjectVo;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
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

    private final RedisTemplate<Object, Object> redisTemplate;

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
        int rows = save(nursingProject) ? 1 : 0;
        evictNursingProjectAllCache();
        return rows;
    }

    /**
     * 修改护理项目
     *
     * @param nursingProject 护理项目
     * @return 结果
     */
    @Override
    public int updateNursingProject(NursingProject nursingProject) {
        int rows = updateById(nursingProject) ? 1 : 0;
        evictNursingProjectAllCache();
        return rows;
    }

    /**
     * 批量删除护理项目
     *
     * @param ids 需要删除的护理项目主键
     * @return 结果
     */
    @Override
    public int deleteNursingProjectByIds(Long[] ids) {
        int rows = removeByIds(Arrays.asList(ids)) ? 1 : 0;
        evictNursingProjectAllCache();
        return rows;
    }

    /**
     * 删除护理项目信息
     *
     * @param id 护理项目主键
     * @return 结果
     */
    @Override
    public int deleteNursingProjectById(Long id) {
        int rows = removeById(id) ? 1 : 0;
        evictNursingProjectAllCache();
        return rows;
    }

    /**
     * 查询所有护理项目
     *
     * @return 护理项目列表
     */
    @Override
    @SuppressWarnings("unchecked")
    public List<NursingProjectVo> selectAll() {
        List<NursingProjectVo> cached = (List<NursingProjectVo>) redisTemplate.opsForValue().get(CacheConstants.NURSING_PROJECT_ALL_KEY);
        if (cached != null) {
            return cached;
        }
        List<NursingProjectVo> list = nursingProjectMapper.getAll();
        if (list == null) {
            list = Collections.emptyList();
        }
        redisTemplate.opsForValue().set(CacheConstants.NURSING_PROJECT_ALL_KEY, list);
        return list;
    }

    private void evictNursingProjectAllCache() {
        redisTemplate.delete(CacheConstants.NURSING_PROJECT_ALL_KEY);
    }
}