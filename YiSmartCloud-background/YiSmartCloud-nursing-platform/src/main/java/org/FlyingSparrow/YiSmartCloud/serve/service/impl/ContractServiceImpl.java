package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.time.LocalDateTime;
import java.util.List;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.ContractMapper;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Contract;
import org.FlyingSparrow.YiSmartCloud.serve.service.IContractService;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import java.util.Arrays;

/**
 * 合同Service业务层处理
 *
 * @author Siborne
 * @date 2026-04-29
 */
@Service
@RequiredArgsConstructor
public class ContractServiceImpl extends ServiceImpl<ContractMapper, Contract> implements IContractService {
    private final ContractMapper contractMapper;

    /**
     * 查询合同
     *
     * @param id 合同主键
     * @return 合同
     */
    @Override
    public Contract selectContractById(Long id) {
                return getById(id);
    }

    /**
     * 查询合同列表
     *
     * @param contract 合同
     * @return 合同
     */
    @Override
    public List<Contract> selectContractList(Contract contract) {
        return contractMapper.selectContractList(contract);
    }

    /**
     * 新增合同
     *
     * @param contract 合同
     * @return 结果
     */
    @Override
    public int insertContract(Contract contract) {
                        return save(contract) == true? 1 : 0;
    }

    /**
     * 修改合同
     *
     * @param contract 合同
     * @return 结果
     */
    @Override
    public int updateContract(Contract contract) {
                return updateById(contract) == true ? 1 : 0;
    }

    /**
     * 批量删除合同
     *
     * @param ids 需要删除的合同主键
     * @return 结果
     */
    @Override
    public int deleteContractByIds(Long[] ids) {
                return removeByIds(Arrays.asList(ids)) == true ? 1 : 0;
    }

    /**
     * 删除合同信息
     *
     * @param id 合同主键
     * @return 结果
     */
    @Override
    public int deleteContractById(Long id) {
                return removeById(id) == true ? 1 : 0;
    }

    /**
     * 更新合同状态
     */
    @Override
    public void updateContractStatus() {
        //1.查询状态为0的合同  && 合同开始时间小于等于当前时间
        List<Contract> list = list(Wrappers.<Contract>lambdaQuery()
                .eq(Contract::getStatus, 0)
                .le(Contract::getStartDate, LocalDateTime.now()));

        //2.修改状态为1
        list.forEach(item->{
            item.setStatus(1);
        });

        //3.批量更新
        updateBatchById(list);
    }
}