package org.FlyingSparrow.YiSmartCloud.serve.domain;

import lombok.Data;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.BaseEntity;

/**
 * 家属与老人绑定关系
 */
@Data
public class FamilyElderBinding extends BaseEntity {
    private static final long serialVersionUID = 1L;

    private Long id;

    private Long familyMemberId;

    private Long elderId;

    private String relation;

    /**
     * 0-失效，1-有效
     */
    private Integer status;

    private Integer isDeleted;
}
