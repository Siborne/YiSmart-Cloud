package org.FlyingSparrow.YiSmartCloud.serve.service;

import com.baomidou.mybatisplus.extension.service.IService;
import java.util.List;
import org.FlyingSparrow.YiSmartCloud.serve.domain.VisitRecord;

/**
 * 访客预约记录Service接口
 *
 * @author Siborne
 * @date 2026-04-27
 */
public interface IVisitRecordService extends IService<VisitRecord> {
    /**
     * 查询访客预约记录
     *
     * @param id 访客预约记录主键
     * @return 访客预约记录
     */
    public VisitRecord selectVisitRecordById(Long id);

    /**
     * 查询访客预约记录列表
     *
     * @param visitRecord 访客预约记录
     * @return 访客预约记录集合
     */
    public List<VisitRecord> selectVisitRecordList(VisitRecord visitRecord);

    /**
     * 新增访客预约记录
     *
     * @param visitRecord 访客预约记录
     * @return 结果
     */
    public int insertVisitRecord(VisitRecord visitRecord);

    /**
     * 修改访客预约记录
     *
     * @param visitRecord 访客预约记录
     * @return 结果
     */
    public int updateVisitRecord(VisitRecord visitRecord);

    /**
     * 批量删除访客预约记录
     *
     * @param ids 需要删除的访客预约记录主键集合
     * @return 结果
     */
    public int deleteVisitRecordByIds(Long[] ids);

    /**
     * 删除访客预约记录信息
     *
     * @param id 访客预约记录主键
     * @return 结果
     */
    public int deleteVisitRecordById(Long id);
}