package org.FlyingSparrow.YiSmartCloud.serve.task;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.FlyingSparrow.YiSmartCloud.serve.service.IContractService;
import org.springframework.stereotype.Component;

@Component("contractJob")
@Slf4j
@AllArgsConstructor
public class ContractJob {

    private final IContractService contractService;

    public void updateContractStatusJob(){
        contractService.updateContractStatus();
        log.info("定时更新合同状态成功！");
    }
}