package org.FlyingSparrow.YiSmartCloud.serve.service;

import com.baomidou.mybatisplus.extension.service.IService;
import java.util.List;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Floor;

/**
 * 楼层信息Service接口
 *
 * @author Siborne
 * @date 2026-04-28
 */
public interface IFloorService extends IService<Floor> {
    /**
     * 查询楼层信息
     *
     * @param id 楼层信息主键
     * @return 楼层信息
     */
    public Floor selectFloorById(Long id);

    /**
     * 查询楼层信息列表
     *
     * @param floor 楼层信息
     * @return 楼层信息集合
     */
    public List<Floor> selectFloorList(Floor floor);

    /**
     * 新增楼层信息
     *
     * @param floor 楼层信息
     * @return 结果
     */
    public int insertFloor(Floor floor);

    /**
     * 修改楼层信息
     *
     * @param floor 楼层信息
     * @return 结果
     */
    public int updateFloor(Floor floor);

    /**
     * 批量删除楼层信息
     *
     * @param ids 需要删除的楼层信息主键集合
     * @return 结果
     */
    public int deleteFloorByIds(Long[] ids);

    /**
     * 删除楼层信息
     *
     * @param id 楼层信息主键
     * @return 结果
     */
    public int deleteFloorById(Long id);
}
