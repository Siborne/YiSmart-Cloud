package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.List;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.BillDetailMapper;
import org.FlyingSparrow.YiSmartCloud.serve.domain.BillDetail;
import org.FlyingSparrow.YiSmartCloud.serve.service.IBillDetailService;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import java.util.Arrays;

/**
 * 费用账单明细Service业务层处理
 *
 * @author Siborne
 * @date 2026-04-27
 */
@Service
@RequiredArgsConstructor
public class BillDetailServiceImpl extends ServiceImpl<BillDetailMapper, BillDetail> implements IBillDetailService {
    private final BillDetailMapper billDetailMapper;

    /**
     * 查询费用账单明细
     *
     * @param id 费用账单明细主键
     * @return 费用账单明细
     */
    @Override
    public BillDetail selectBillDetailById(Long id) {
                return getById(id);
    }

    /**
     * 查询费用账单明细列表
     *
     * @param billDetail 费用账单明细
     * @return 费用账单明细
     */
    @Override
    public List<BillDetail> selectBillDetailList(BillDetail billDetail) {
        return billDetailMapper.selectBillDetailList(billDetail);
    }

    /**
     * 新增费用账单明细
     *
     * @param billDetail 费用账单明细
     * @return 结果
     */
    @Override
    public int insertBillDetail(BillDetail billDetail) {
                        return save(billDetail) == true? 1 : 0;
    }

    /**
     * 修改费用账单明细
     *
     * @param billDetail 费用账单明细
     * @return 结果
     */
    @Override
    public int updateBillDetail(BillDetail billDetail) {
                return updateById(billDetail) == true ? 1 : 0;
    }

    /**
     * 批量删除费用账单明细
     *
     * @param ids 需要删除的费用账单明细主键
     * @return 结果
     */
    @Override
    public int deleteBillDetailByIds(Long[] ids) {
                return removeByIds(Arrays.asList(ids)) == true ? 1 : 0;
    }

    /**
     * 删除费用账单明细信息
     *
     * @param id 费用账单明细主键
     * @return 结果
     */
    @Override
    public int deleteBillDetailById(Long id) {
                return removeById(id) == true ? 1 : 0;
    }
}