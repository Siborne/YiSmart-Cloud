package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.List;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.HealthDataRecordMapper;
import org.FlyingSparrow.YiSmartCloud.serve.domain.HealthDataRecord;
import org.FlyingSparrow.YiSmartCloud.serve.service.IHealthDataRecordService;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.util.Arrays;

/**
 * 健康监测数据Service业务层处理
 *
 * @author Siborne
 * @date 2026-04-27
 */
@Service
@RequiredArgsConstructor
public class HealthDataRecordServiceImpl extends ServiceImpl<HealthDataRecordMapper, HealthDataRecord> implements IHealthDataRecordService {
    private final HealthDataRecordMapper healthDataRecordMapper;

    /**
     * 查询健康监测数据
     *
     * @param id 健康监测数据主键
     * @return 健康监测数据
     */
    @Override
    public HealthDataRecord selectHealthDataRecordById(Long id) {
        return getById(id);
    }

    /**
     * 查询健康监测数据列表
     *
     * @param healthDataRecord 健康监测数据
     * @return 健康监测数据
     */
    @Override
    public List<HealthDataRecord> selectHealthDataRecordList(HealthDataRecord healthDataRecord) {
        return healthDataRecordMapper.selectHealthDataRecordList(healthDataRecord);
    }

    /**
     * 新增健康监测数据
     *
     * @param healthDataRecord 健康监测数据
     * @return 结果
     */
    @Override
    public int insertHealthDataRecord(HealthDataRecord healthDataRecord) {
        return save(healthDataRecord) == true ? 1 : 0;
    }

    /**
     * 修改健康监测数据
     *
     * @param healthDataRecord 健康监测数据
     * @return 结果
     */
    @Override
    public int updateHealthDataRecord(HealthDataRecord healthDataRecord) {
        return updateById(healthDataRecord) == true ? 1 : 0;
    }

    /**
     * 批量删除健康监测数据
     *
     * @param ids 需要删除的健康监测数据主键
     * @return 结果
     */
    @Override
    public int deleteHealthDataRecordByIds(Long[] ids) {
        return removeByIds(Arrays.asList(ids)) == true ? 1 : 0;
    }

    /**
     * 删除健康监测数据信息
     *
     * @param id 健康监测数据主键
     * @return 结果
     */
    @Override
    public int deleteHealthDataRecordById(Long id) {
        return removeById(id) == true ? 1 : 0;
    }
}