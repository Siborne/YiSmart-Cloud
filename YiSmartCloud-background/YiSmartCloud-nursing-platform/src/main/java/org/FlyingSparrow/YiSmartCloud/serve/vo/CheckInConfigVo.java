package org.FlyingSparrow.YiSmartCloud.serve.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class CheckInConfigVo {

    /**
     * 入住开始时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "入住开始时间", width = 30, dateFormat = "yyyy-MM-dd")
    private LocalDateTime startDate;

    /**
     * 入住结束时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "入住结束时间", width = 30, dateFormat = "yyyy-MM-dd")
    private LocalDateTime endDate;

    /**
     * 入住床位
     */
    @Excel(name = "入住床位")
    private String bedNumber;
}
