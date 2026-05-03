package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.List;

import org.FlyingSparrow.YiSmartCloud.serve.vo.TreeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.FloorMapper;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Floor;
import org.FlyingSparrow.YiSmartCloud.serve.service.IFloorService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 楼层信息Service业务层处理
 *
 * @author Siborne
 * @date 2026-04-28
 */
@Service
public class FloorServiceImpl extends ServiceImpl<FloorMapper, Floor> implements IFloorService {
    @Autowired
    private FloorMapper floorMapper;

    @Override
    public Floor selectFloorById(Long id) {
        return floorMapper.selectFloorById(id);
    }

    @Override
    public List<Floor> selectFloorList(Floor floor) {
        return floorMapper.selectFloorList(floor);
    }

    @Override
    public int insertFloor(Floor floor) {
        return floorMapper.insertFloor(floor);
    }

    @Override
    public int updateFloor(Floor floor) {
        return floorMapper.updateFloor(floor);
    }

    @Override
    public int deleteFloorByIds(Long[] ids) {
        return floorMapper.deleteFloorByIds(ids);
    }

    @Override
    public int deleteFloorById(Long id) {
        return floorMapper.deleteFloorById(id);
    }

    /**
     * 查询楼层房间床位
     * @param status
     * @return
     */
    @Override
    public List<TreeVo> getRoomAndBedByBedStatus(Integer status) {
        return floorMapper.getRoomAndBedByBedStatus(status);
    }
}
