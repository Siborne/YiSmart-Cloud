package org.FlyingSparrow.YiSmartCloud.serve.service;

import com.baomidou.mybatisplus.extension.service.IService;
import java.util.List;
import org.FlyingSparrow.YiSmartCloud.serve.domain.BillDetail;

/**
 * 费用账单明细Service接口
 *
 * @author Siborne
 * @date 2026-04-27
 */
public interface IBillDetailService extends IService<BillDetail> {
    /**
     * 查询费用账单明细
     *
     * @param id 费用账单明细主键
     * @return 费用账单明细
     */
    public BillDetail selectBillDetailById(Long id);

    /**
     * 查询费用账单明细列表
     *
     * @param billDetail 费用账单明细
     * @return 费用账单明细集合
     */
    public List<BillDetail> selectBillDetailList(BillDetail billDetail);

    /**
     * 新增费用账单明细
     *
     * @param billDetail 费用账单明细
     * @return 结果
     */
    public int insertBillDetail(BillDetail billDetail);

    /**
     * 修改费用账单明细
     *
     * @param billDetail 费用账单明细
     * @return 结果
     */
    public int updateBillDetail(BillDetail billDetail);

    /**
     * 批量删除费用账单明细
     *
     * @param ids 需要删除的费用账单明细主键集合
     * @return 结果
     */
    public int deleteBillDetailByIds(Long[] ids);

    /**
     * 删除费用账单明细信息
     *
     * @param id 费用账单明细主键
     * @return 结果
     */
    public int deleteBillDetailById(Long id);
}