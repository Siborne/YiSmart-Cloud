package org.FlyingSparrow.YiSmartCloud.serve.service;

import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

import org.FlyingSparrow.YiSmartCloud.serve.domain.Room;
import org.FlyingSparrow.YiSmartCloud.serve.vo.RoomVo;

/**
 * 房间信息Service接口
 *
 * @author Siborne
 * @date 2026-04-27
 */
public interface IRoomService extends IService<Room> {
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
     * 批量删除房间信息
     *
     * @param ids 需要删除的房间信息主键集合
     * @return 结果
     */
    public int deleteRoomByIds(Long[] ids);

    /**
     * 删除房间信息信息
     *
     * @param id 房间信息主键
     * @return 结果
     */
    public int deleteRoomById(Long id);

    /**
     * 按照房间id查询楼层、房间、价格
     *
     * @param id
     * @return
     */
    RoomVo getRoomById(Long id);

    /**
     * 根据启用状态查询房间列表（不含逻辑删除）
     *
     * @param status 状态: 0-停用, 1-启用；为 null 时不按状态过滤
     * @param availableOnly true 时仅返回存在空闲床位的房间
     * @return 房间集合
     */
    List<Room> findRoomTypeListByStatus(Integer status, Boolean availableOnly);
}