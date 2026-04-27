package org.FlyingSparrow.YiSmartCloud.serve.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Floor;

/**
 * 楼层信息Mapper接口
 *
 * @author Siborne
 * @date 2026-04-28
 */
@Mapper
public interface FloorMapper extends BaseMapper<Floor> {
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
     * 删除楼层信息
     *
     * @param id 楼层信息主键
     * @return 结果
     */
    public int deleteFloorById(Long id);

    /**
     * 批量删除楼层信息
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteFloorByIds(Long[] ids);
}
