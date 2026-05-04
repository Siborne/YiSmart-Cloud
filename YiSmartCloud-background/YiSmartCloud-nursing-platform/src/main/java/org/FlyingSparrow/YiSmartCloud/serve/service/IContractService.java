package org.FlyingSparrow.YiSmartCloud.serve.service;

import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

import org.FlyingSparrow.YiSmartCloud.serve.domain.Contract;

/**
 * 合同Service接口
 *
 * @author Siborne
 * @date 2026-04-29
 */
public interface IContractService extends IService<Contract> {
    /**
     * 查询合同
     *
     * @param id 合同主键
     * @return 合同
     */
    public Contract selectContractById(Long id);

    /**
     * 查询合同列表
     *
     * @param contract 合同
     * @return 合同集合
     */
    public List<Contract> selectContractList(Contract contract);

    /**
     * 新增合同
     *
     * @param contract 合同
     * @return 结果
     */
    public int insertContract(Contract contract);

    /**
     * 修改合同
     *
     * @param contract 合同
     * @return 结果
     */
    public int updateContract(Contract contract);

    /**
     * 批量删除合同
     *
     * @param ids 需要删除的合同主键集合
     * @return 结果
     */
    public int deleteContractByIds(Long[] ids);

    /**
     * 删除合同信息
     *
     * @param id 合同主键
     * @return 结果
     */
    public int deleteContractById(Long id);

    /**
     * 更新合同状态
     */
    void updateContractStatus();
}