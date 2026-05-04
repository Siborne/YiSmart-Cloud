package org.FlyingSparrow.YiSmartCloud.serve.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.FlyingSparrow.YiSmartCloud.serve.vo.RoomVo;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Room;
import org.apache.ibatis.annotations.Param;

/**
 * 房间信息Mapper接口
 *
 * @author Siborne
 * @date 2026-04-27
 */
@Mapper
public interface RoomMapper extends BaseMapper<Room> {
    /**
     * 查询房间信息
     *
     * @param id 房间信息主键
     * @return 房间信息
     */
    public Room selectRoomById(Long id);

    /**
     * 查询房间信息列表
     *
     * @param room 房间信息
     * @return 房间信息集合
     */
    public List<Room> selectRoomList(Room room);

    /**
     * 新增房间信息
     *
     * @param room 房间信息
     * @return 结果
     */
    public int insertRoom(Room room);

    /**
     * 修改房间信息
     *
     * @param room 房间信息
     * @return 结果
     */
    public int updateRoom(Room room);

    /**
     * 删除房间信息
     *
     * @param id 房间信息主键
     * @return 结果
     */
    public int deleteRoomById(Long id);

    /**
     * 批量删除房间信息
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteRoomByIds(Long[] ids);

    RoomVo getRoomById(Long id);

    /**
     * 按状态查询存在空闲床位的房间列表。
     *
     * @param status 状态: 0-停用, 1-启用；为空时不按状态过滤
     * @return 房间集合
     */
    List<Room> selectRoomListWithAvailableBeds(@Param("status") Integer status);
}