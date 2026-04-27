package org.FlyingSparrow.YiSmartCloud.serve.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import org.FlyingSparrow.YiSmartCloud.serve.domain.CheckInRecord;

/**
 * 老人入住记录Mapper接口
 *
 * @author Siborne
 * @date 2026-04-27
 */
@Mapper
public interface CheckInRecordMapper extends BaseMapper<CheckInRecord> {
    /**
     * 查询老人入住记录
     *
     * @param id 老人入住记录主键
     * @return 老人入住记录
     */
    public CheckInRecord selectCheckInRecordById(Long id);

    /**
     * 查询老人入住记录列表
     *
     * @param checkInRecord 老人入住记录
     * @return 老人入住记录集合
     */
    public List<CheckInRecord> selectCheckInRecordList(CheckInRecord checkInRecord);

    /**
     * 新增老人入住记录
     *
     * @param checkInRecord 老人入住记录
     * @return 结果
     */
    public int insertCheckInRecord(CheckInRecord checkInRecord);

    /**
     * 修改老人入住记录
     *
     * @param checkInRecord 老人入住记录
     * @return 结果
     */
    public int updateCheckInRecord(CheckInRecord checkInRecord);

    /**
     * 删除老人入住记录
     *
     * @param id 老人入住记录主键
     * @return 结果
     */
    public int deleteCheckInRecordById(Long id);

    /**
     * 批量删除老人入住记录
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCheckInRecordByIds(Long[] ids);
}