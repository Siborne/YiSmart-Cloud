package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.Collections;
import java.util.List;

import org.FlyingSparrow.YiSmartCloud.common.constant.CacheConstants;
import org.FlyingSparrow.YiSmartCloud.common.exception.ServiceException;
import org.FlyingSparrow.YiSmartCloud.common.utils.DateUtils;
import org.FlyingSparrow.YiSmartCloud.common.utils.StringUtils;
import org.FlyingSparrow.YiSmartCloud.serve.domain.NursingLevel;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.NursingLevelMapper;
import org.FlyingSparrow.YiSmartCloud.serve.service.INursingLevelService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 护理等级业务实现。

 * <p>

 * 列表/详情中计划名称通过 {@link NursingLevelMapper#selectNursingLevelList} /

 * {@link NursingLevelMapper#selectNursingLevelById}（XML 内 JOIN nursing_plan）填充；

 * 持久化一律走 XML 的 insert/update/delete，避免 MP 通用方法与扩展字段冲突。

 *

 * @author Siborne
 */
@Service
@RequiredArgsConstructor
public class NursingLevelServiceImpl extends ServiceImpl<NursingLevelMapper, NursingLevel> implements INursingLevelService {

    private final NursingLevelMapper nursingLevelMapper;
    private final RedisTemplate<Object, Object> redisTemplate;

    /**
     * 详情：必须用 XML JOIN，否则拿不到 planName，且不可误用 {@code getById}（会把 planName 拼进单表 SQL）。
     */
    @Override
    public NursingLevel selectNursingLevelById(Long id) {
        if (id == null) {
            throw new ServiceException("护理等级主键不能为空");
        }
        return nursingLevelMapper.selectNursingLevelById(id);
    }

    @Override
    public List<NursingLevel> selectNursingLevelList(NursingLevel nursingLevel) {
        return nursingLevelMapper.selectNursingLevelList(nursingLevel);
    }

    /**
     * 新增：业务约定首次未传状态时默认为禁用（0），与字典 nursing_level_status 一致。

     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertNursingLevel(NursingLevel nursingLevel) {
        if (StringUtils.isEmpty(nursingLevel.getName())) {
            throw new ServiceException("等级名称不能为空");
        }
        if (nursingLevel.getLplanId() == null) {
            throw new ServiceException("请选择关联的护理计划");
        }
        if (nursingLevel.getFee() == null) {
            throw new ServiceException("护理费用不能为空");
        }
        // 展示字段不入库
        nursingLevel.setPlanName(null);
        // 字典：0 禁用、1 启用；首次添加默认禁用
        if (nursingLevel.getStatus() == null) {
            nursingLevel.setStatus(0);
        }
        nursingLevel.setCreateTime(DateUtils.getNowDate());
        nursingLevel.setUpdateTime(DateUtils.getNowDate());
        int rows = nursingLevelMapper.insertNursingLevel(nursingLevel);
        evictListAllCache();
        return rows;
    }

    /**
     * 修改：动态 SQL 仅更新非空字段，支持「只改状态」等局部更新；扩展字段不参与 UPDATE。
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateNursingLevel(NursingLevel nursingLevel) {
        if (nursingLevel.getId() == null) {
            throw new ServiceException("护理等级主键不能为空");
        }
        nursingLevel.setPlanName(null);
        nursingLevel.setUpdateTime(DateUtils.getNowDate());
        int rows = nursingLevelMapper.updateNursingLevel(nursingLevel);
        evictListAllCache();
        return rows;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteNursingLevelByIds(Long[] ids) {
        if (ids == null || ids.length == 0) {
            throw new ServiceException("待删除的护理等级主键不能为空");
        }
        int rows = nursingLevelMapper.deleteNursingLevelByIds(ids);
        evictListAllCache();
        return rows;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteNursingLevelById(Long id) {
        if (id == null) {
            throw new ServiceException("护理等级主键不能为空");
        }
        int rows = nursingLevelMapper.deleteNursingLevelById(id);
        evictListAllCache();
        return rows;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<NursingLevel> listAll() {
        List<NursingLevel> cached = (List<NursingLevel>) redisTemplate.opsForValue().get(CacheConstants.NURSING_LEVEL_LIST_ALL_KEY);
        if (cached != null) {
            return cached;
        }
        List<NursingLevel> list = nursingLevelMapper.listAll();
        if (list == null) {
            list = Collections.emptyList();
        }
        redisTemplate.opsForValue().set(CacheConstants.NURSING_LEVEL_LIST_ALL_KEY, list);
        return list;
    }

    private void evictListAllCache() {
        redisTemplate.delete(CacheConstants.NURSING_LEVEL_LIST_ALL_KEY);
    }

}
