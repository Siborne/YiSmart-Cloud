package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.List;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.VisitRecordMapper;
import org.FlyingSparrow.YiSmartCloud.serve.domain.VisitRecord;
import org.FlyingSparrow.YiSmartCloud.serve.service.IVisitRecordService;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import java.util.Arrays;

/**
 * 访客预约记录Service业务层处理
 *
 * @author Siborne
 * @date 2026-04-27
 */
@Service
@RequiredArgsConstructor
public class VisitRecordServiceImpl extends ServiceImpl<VisitRecordMapper, VisitRecord> implements IVisitRecordService {
    private final VisitRecordMapper visitRecordMapper;

    /**
     * 查询访客预约记录
     *
     * @param id 访客预约记录主键
     * @return 访客预约记录
     */
    @Override
    public VisitRecord selectVisitRecordById(Long id) {
                return getById(id);
    }

    /**
     * 查询访客预约记录列表
     *
     * @param visitRecord 访客预约记录
     * @return 访客预约记录
     */
    @Override
    public List<VisitRecord> selectVisitRecordList(VisitRecord visitRecord) {
        return visitRecordMapper.selectVisitRecordList(visitRecord);
    }

    /**
     * 新增访客预约记录
     *
     * @param visitRecord 访客预约记录
     * @return 结果
     */
    @Override
    public int insertVisitRecord(VisitRecord visitRecord) {
                        return save(visitRecord) == true? 1 : 0;
    }

    /**
     * 修改访客预约记录
     *
     * @param visitRecord 访客预约记录
     * @return 结果
     */
    @Override
    public int updateVisitRecord(VisitRecord visitRecord) {
                return updateById(visitRecord) == true ? 1 : 0;
    }

    /**
     * 批量删除访客预约记录
     *
     * @param ids 需要删除的访客预约记录主键
     * @return 结果
     */
    @Override
    public int deleteVisitRecordByIds(Long[] ids) {
                return removeByIds(Arrays.asList(ids)) == true ? 1 : 0;
    }

    /**
     * 删除访客预约记录信息
     *
     * @param id 访客预约记录主键
     * @return 结果
     */
    @Override
    public int deleteVisitRecordById(Long id) {
                return removeById(id) == true ? 1 : 0;
    }
}