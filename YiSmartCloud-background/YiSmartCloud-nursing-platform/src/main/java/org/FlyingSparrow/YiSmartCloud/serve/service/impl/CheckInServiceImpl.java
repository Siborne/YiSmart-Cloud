package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.CheckInMapper;
import org.FlyingSparrow.YiSmartCloud.serve.domain.CheckIn;
import org.FlyingSparrow.YiSmartCloud.serve.service.ICheckInService;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import java.util.Arrays;

/**
 * 入住登记Service业务层处理
 *
 * @author Siborne
 * @date 2026-04-29
 */
@Service
public class CheckInServiceImpl extends ServiceImpl<CheckInMapper, CheckIn> implements ICheckInService {
    @Autowired
    private CheckInMapper checkInMapper;

    /**
     * 查询入住登记
     *
     * @param id 入住登记主键
     * @return 入住登记
     */
    @Override
    public CheckIn selectCheckInById(Long id) {
                return getById(id);
    }

    /**
     * 查询入住登记列表
     *
     * @param checkIn 入住登记
     * @return 入住登记
     */
    @Override
    public List<CheckIn> selectCheckInList(CheckIn checkIn) {
        return checkInMapper.selectCheckInList(checkIn);
    }

    /**
     * 新增入住登记
     *
     * @param checkIn 入住登记
     * @return 结果
     */
    @Override
    public int insertCheckIn(CheckIn checkIn) {
                        return save(checkIn) == true? 1 : 0;
    }

    /**
     * 修改入住登记
     *
     * @param checkIn 入住登记
     * @return 结果
     */
    @Override
    public int updateCheckIn(CheckIn checkIn) {
                return updateById(checkIn) == true ? 1 : 0;
    }

    /**
     * 批量删除入住登记
     *
     * @param ids 需要删除的入住登记主键
     * @return 结果
     */
    @Override
    public int deleteCheckInByIds(Long[] ids) {
                return removeByIds(Arrays.asList(ids)) == true ? 1 : 0;
    }

    /**
     * 删除入住登记信息
     *
     * @param id 入住登记主键
     * @return 结果
     */
    @Override
    public int deleteCheckInById(Long id) {
                return removeById(id) == true ? 1 : 0;
    }
}