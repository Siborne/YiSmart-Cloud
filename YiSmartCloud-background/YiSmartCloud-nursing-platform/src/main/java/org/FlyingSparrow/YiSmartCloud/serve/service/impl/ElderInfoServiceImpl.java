package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.List;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.ElderInfoMapper;
import org.FlyingSparrow.YiSmartCloud.serve.domain.ElderInfo;
import org.FlyingSparrow.YiSmartCloud.serve.service.IElderInfoService;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.util.Arrays;

/**
 * 老人档案Service业务层处理
 *
 * @author Siborne
 * @date 2026-04-27
 */
@Service
@RequiredArgsConstructor
public class ElderInfoServiceImpl extends ServiceImpl<ElderInfoMapper, ElderInfo> implements IElderInfoService {
    private final ElderInfoMapper elderInfoMapper;

    /**
     * 查询老人档案
     *
     * @param id 老人档案主键
     * @return 老人档案
     */
    @Override
    public ElderInfo selectElderInfoById(Long id) {
        return getById(id);
    }

    /**
     * 查询老人档案列表
     *
     * @param elderInfo 老人档案
     * @return 老人档案
     */
    @Override
    public List<ElderInfo> selectElderInfoList(ElderInfo elderInfo) {
        return elderInfoMapper.selectElderInfoList(elderInfo);
    }

    /**
     * 新增老人档案
     *
     * @param elderInfo 老人档案
     * @return 结果
     */
    @Override
    public int insertElderInfo(ElderInfo elderInfo) {
        return save(elderInfo) == true ? 1 : 0;
    }

    /**
     * 修改老人档案
     *
     * @param elderInfo 老人档案
     * @return 结果
     */
    @Override
    public int updateElderInfo(ElderInfo elderInfo) {
        return updateById(elderInfo) == true ? 1 : 0;
    }

    /**
     * 批量删除老人档案
     *
     * @param ids 需要删除的老人档案主键
     * @return 结果
     */
    @Override
    public int deleteElderInfoByIds(Long[] ids) {
        return removeByIds(Arrays.asList(ids)) == true ? 1 : 0;
    }

    /**
     * 删除老人档案信息
     *
     * @param id 老人档案主键
     * @return 结果
     */
    @Override
    public int deleteElderInfoById(Long id) {
        return removeById(id) == true ? 1 : 0;
    }
}