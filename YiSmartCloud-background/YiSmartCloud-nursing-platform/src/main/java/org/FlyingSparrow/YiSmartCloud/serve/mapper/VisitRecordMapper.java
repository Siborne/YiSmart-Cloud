package org.FlyingSparrow.YiSmartCloud.serve.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import org.FlyingSparrow.YiSmartCloud.serve.domain.VisitRecord;

/**
 * 访客预约记录Mapper接口
 *
 * @author Siborne
 * @date 2026-04-27
 */
@Mapper
public interface VisitRecordMapper extends BaseMapper<VisitRecord> {
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
     * 删除访客预约记录
     *
     * @param id 访客预约记录主键
     * @return 结果
     */
    public int deleteVisitRecordById(Long id);

    /**
     * 批量删除访客预约记录
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteVisitRecordByIds(Long[] ids);
}