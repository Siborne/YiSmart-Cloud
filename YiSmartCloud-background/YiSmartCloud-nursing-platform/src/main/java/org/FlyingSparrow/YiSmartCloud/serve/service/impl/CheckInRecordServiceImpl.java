package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.CheckInRecordMapper;
import org.FlyingSparrow.YiSmartCloud.serve.domain.CheckInRecord;
import org.FlyingSparrow.YiSmartCloud.serve.service.ICheckInRecordService;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import java.util.Arrays;

/**
 * 老人入住记录Service业务层处理
 *
 * @author Siborne
 * @date 2026-04-27
 */
@Service
public class CheckInRecordServiceImpl extends ServiceImpl<CheckInRecordMapper, CheckInRecord> implements ICheckInRecordService {
    @Autowired
    private CheckInRecordMapper checkInRecordMapper;

    /**
     * 查询老人入住记录
     *
     * @param id 老人入住记录主键
     * @return 老人入住记录
     */
    @Override
    public CheckInRecord selectCheckInRecordById(Long id) {
                return getById(id);
    }

    /**
     * 查询老人入住记录列表
     *
     * @param checkInRecord 老人入住记录
     * @return 老人入住记录
     */
    @Override
    public List<CheckInRecord> selectCheckInRecordList(CheckInRecord checkInRecord) {
        return checkInRecordMapper.selectCheckInRecordList(checkInRecord);
    }

    /**
     * 新增老人入住记录
     *
     * @param checkInRecord 老人入住记录
     * @return 结果
     */
    @Override
    public int insertCheckInRecord(CheckInRecord checkInRecord) {
                        return save(checkInRecord) == true? 1 : 0;
    }

    /**
     * 修改老人入住记录
     *
     * @param checkInRecord 老人入住记录
     * @return 结果
     */
    @Override
    public int updateCheckInRecord(CheckInRecord checkInRecord) {
                return updateById(checkInRecord) == true ? 1 : 0;
    }

    /**
     * 批量删除老人入住记录
     *
     * @param ids 需要删除的老人入住记录主键
     * @return 结果
     */
    @Override
    public int deleteCheckInRecordByIds(Long[] ids) {
                return removeByIds(Arrays.asList(ids)) == true ? 1 : 0;
    }

    /**
     * 删除老人入住记录信息
     *
     * @param id 老人入住记录主键
     * @return 结果
     */
    @Override
    public int deleteCheckInRecordById(Long id) {
                return removeById(id) == true ? 1 : 0;
    }
}