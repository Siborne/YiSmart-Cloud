package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.BedMapper;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Bed;
import org.FlyingSparrow.YiSmartCloud.serve.service.IBedService;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 床位信息Service业务层处理
 *
 * @author Siborne
 * @date 2026-04-27
 */
@Service
public class BedServiceImpl extends ServiceImpl<BedMapper, Bed> implements IBedService {
    @Autowired
    private BedMapper bedMapper;

    /**
     * 查询床位信息
     *
     * @param id 床位信息主键
     * @return 床位信息
     */
    @Override
    public Bed selectBedById(Long id) {
        return bedMapper.selectBedById(id);
    }

    /**
     * 查询床位信息列表
     *
     * @param bed 床位信息
     * @return 床位信息
     */
    @Override
    public List<Bed> selectBedList(Bed bed) {
        return bedMapper.selectBedList(bed);
    }

    /**
     * 新增床位信息
     *
     * @param bed 床位信息
     * @return 结果
     */
    @Override
    public int insertBed(Bed bed) {
        return bedMapper.insertBed(bed);
    }

    /**
     * 修改床位信息
     *
     * @param bed 床位信息
     * @return 结果
     */
    @Override
    public int updateBed(Bed bed) {
        return bedMapper.updateBed(bed);
    }

    /**
     * 批量删除床位信息
     *
     * @param ids 需要删除的床位信息主键
     * @return 结果
     */
    @Override
    public int deleteBedByIds(Long[] ids) {
        return bedMapper.deleteBedByIds(ids);
    }

    /**
     * 删除床位信息信息
     *
     * @param id 床位信息主键
     * @return 结果
     */
    @Override
    public int deleteBedById(Long id) {
        return bedMapper.deleteBedById(id);
    }
}