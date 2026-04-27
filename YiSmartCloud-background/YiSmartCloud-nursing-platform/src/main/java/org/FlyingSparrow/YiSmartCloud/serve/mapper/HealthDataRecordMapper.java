package org.FlyingSparrow.YiSmartCloud.serve.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import org.FlyingSparrow.YiSmartCloud.serve.domain.HealthDataRecord;

/**
 * 健康监测数据Mapper接口
 *
 * @author Siborne
 * @date 2026-04-27
 */
@Mapper
public interface HealthDataRecordMapper extends BaseMapper<HealthDataRecord> {
    /**
     * 查询健康监测数据
     *
     * @param id 健康监测数据主键
     * @return 健康监测数据
     */
    public HealthDataRecord selectHealthDataRecordById(Long id);

    /**
     * 查询健康监测数据列表
     *
     * @param healthDataRecord 健康监测数据
     * @return 健康监测数据集合
     */
    public List<HealthDataRecord> selectHealthDataRecordList(HealthDataRecord healthDataRecord);

    /**
     * 新增健康监测数据
     *
     * @param healthDataRecord 健康监测数据
     * @return 结果
     */
    public int insertHealthDataRecord(HealthDataRecord healthDataRecord);

    /**
     * 修改健康监测数据
     *
     * @param healthDataRecord 健康监测数据
     * @return 结果
     */
    public int updateHealthDataRecord(HealthDataRecord healthDataRecord);

    /**
     * 删除健康监测数据
     *
     * @param id 健康监测数据主键
     * @return 结果
     */
    public int deleteHealthDataRecordById(Long id);

    /**
     * 批量删除健康监测数据
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteHealthDataRecordByIds(Long[] ids);
}