package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.List;

import org.FlyingSparrow.YiSmartCloud.serve.vo.RoomVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.RoomMapper;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Room;
import org.FlyingSparrow.YiSmartCloud.serve.service.IRoomService;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 房间信息Service业务层处理
 *
 * @author Siborne
 * @date 2026-04-27
 */
@Service
public class RoomServiceImpl extends ServiceImpl<RoomMapper, Room> implements IRoomService {
    @Autowired
    private RoomMapper roomMapper;

    /**
     * 查询房间信息
     *
     * @param id 房间信息主键
     * @return 房间信息
     */
    @Override
    public Room selectRoomById(Long id) {
        return roomMapper.selectRoomById(id);
    }

    /**
     * 查询房间信息列表
     *
     * @param room 房间信息
     * @return 房间信息
     */
    @Override
    public List<Room> selectRoomList(Room room) {
        return roomMapper.selectRoomList(room);
    }

    /**
     * 新增房间信息
     *
     * @param room 房间信息
     * @return 结果
     */
    @Override
    public int insertRoom(Room room) {
        return roomMapper.insertRoom(room);
    }

    /**
     * 修改房间信息
     *
     * @param room 房间信息
     * @return 结果
     */
    @Override
    public int updateRoom(Room room) {
        return roomMapper.updateRoom(room);
    }

    /**
     * 批量删除房间信息
     *
     * @param ids 需要删除的房间信息主键
     * @return 结果
     */
    @Override
    public int deleteRoomByIds(Long[] ids) {
        return roomMapper.deleteRoomByIds(ids);
    }

    /**
     * 删除房间信息信息
     *
     * @param id 房间信息主键
     * @return 结果
     */
    @Override
    public int deleteRoomById(Long id) {
        return roomMapper.deleteRoomById(id);
    }

    /**
     * 按照房间id查询楼层、房间、价格
     *
     * @param id
     * @return
     */
    @Override
    public RoomVo getRoomById(Long id) {
        return roomMapper.getRoomById(id);
    }
}