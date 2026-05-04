package org.FlyingSparrow.YiSmartCloud.serve.service;

import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

import org.FlyingSparrow.YiSmartCloud.serve.domain.Floor;
import org.FlyingSparrow.YiSmartCloud.serve.vo.TreeVo;

/**
 * Floor Information Service Interface
 *
 * @author Siborne
 * @date 2026-04-28
 */
public interface IFloorService extends IService<Floor> {
    /**
     * Query floor information by ID
     *
     * @param id Floor information ID
     * @return Floor information
     */
    public Floor selectFloorById(Long id);

    /**
     * Query floor information list
     *
     * @param floor Floor information
     * @return Floor information collection
     */
    public List<Floor> selectFloorList(Floor floor);

    /**
     * Add floor information
     *
     * @param floor Floor information
     * @return Result
     */
    public int insertFloor(Floor floor);

    /**
     * Modify floor information
     *
     * @param floor Floor information
     * @return Result
     */
    public int updateFloor(Floor floor);

    /**
     * Batch delete floor information
     *
     * @param ids Array of floor information IDs to be deleted
     * @return Result
     */
    public int deleteFloorByIds(Long[] ids);

    /**
     * Delete floor information
     *
     * @param id Floor information ID
     * @return Result
     */
    public int deleteFloorById(Long id);

    /**
     * Query rooms and beds by bed status
     *
     * @param status Bed status
     * @return Tree structure of rooms and beds
     */
    List<TreeVo> getRoomAndBedByBedStatus(Integer status);
}
