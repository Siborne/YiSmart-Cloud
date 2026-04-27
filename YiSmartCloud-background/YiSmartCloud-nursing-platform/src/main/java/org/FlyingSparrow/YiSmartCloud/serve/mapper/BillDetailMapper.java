package org.FlyingSparrow.YiSmartCloud.serve.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import org.FlyingSparrow.YiSmartCloud.serve.domain.BillDetail;

/**
 * 费用账单明细Mapper接口
 *
 * @author Siborne
 * @date 2026-04-27
 */
@Mapper
public interface BillDetailMapper extends BaseMapper<BillDetail> {
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
     * 删除费用账单明细
     *
     * @param id 费用账单明细主键
     * @return 结果
     */
    public int deleteBillDetailById(Long id);

    /**
     * 批量删除费用账单明细
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteBillDetailByIds(Long[] ids);
}