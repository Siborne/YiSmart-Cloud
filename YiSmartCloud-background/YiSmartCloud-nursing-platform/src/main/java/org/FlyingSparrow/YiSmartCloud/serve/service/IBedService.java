package org.FlyingSparrow.YiSmartCloud.serve.service;

import com.baomidou.mybatisplus.extension.service.IService;
import java.util.List;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Bed;

/**
 * 床位信息Service接口
 *
 * @author Siborne
 * @date 2026-04-27
 */
public interface IBedService extends IService<Bed> {
    /**
     * 查询床位信息
     *
     * @param id 床位信息主键
     * @return 床位信息
     */
    public Bed selectBedById(Long id);

    /**
     * 查询床位信息列表
     *
     * @param bed 床位信息
     * @return 床位信息集合
     */
    public List<Bed> selectBedList(Bed bed);

    /**
     * 新增床位信息
     *
     * @param bed 床位信息
     * @return 结果
     */
    public int insertBed(Bed bed);

    /**
     * 修改床位信息
     *
     * @param bed 床位信息
     * @return 结果
     */
    public int updateBed(Bed bed);

    /**
     * 批量删除床位信息
     *
     * @param ids 需要删除的床位信息主键集合
     * @return 结果
     */
    public int deleteBedByIds(Long[] ids);

    /**
     * 删除床位信息信息
     *
     * @param id 床位信息主键
     * @return 结果
     */
    public int deleteBedById(Long id);
}