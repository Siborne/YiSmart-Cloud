package org.FlyingSparrow.YiSmartCloud.serve.domain;

import java.math.BigDecimal;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Excel;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 房间信息对象 room
 * 
 * @author Siborne
 * @date 2026-04-27
 */
@Data
public class Room extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 房间编号 (例: 101) */
    @Excel(name = "房间编号 (例: 101)")
    private String roomNo;

    /** 楼层ID */
    @Excel(name = "楼层ID")
    private Long floorId;

    /** 房间图片 */
    @Excel(name = "房间图片")
    private String roomImage;

    /** 床位费用 */
    @Excel(name = "床位费用")
    private BigDecimal bedFee;

    /** 房间类型: 1-单人间, 2-双人间, 3-多人间 */
    @Excel(name = "房间类型: 1-单人间, 2-双人间, 3-多人间")
    private Long roomType;

    /** 房间介绍 */
    @Excel(name = "房间介绍")
    private String roomDesc;

    /** 状态: 0-停用, 1-启用 */
    @Excel(name = "状态: 0-停用, 1-启用")
    private Integer status;

    /** 逻辑删除: 0-未删除, 1-已删除 */
    private Integer isDeleted;


}
