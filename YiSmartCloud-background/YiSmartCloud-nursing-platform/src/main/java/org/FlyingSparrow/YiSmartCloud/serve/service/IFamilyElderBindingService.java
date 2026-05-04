package org.FlyingSparrow.YiSmartCloud.serve.service;

import org.FlyingSparrow.YiSmartCloud.serve.domain.ElderInfo;
import org.FlyingSparrow.YiSmartCloud.serve.dto.FamilyElderBindRequestDto;

import java.util.List;

public interface IFamilyElderBindingService {

    List<ElderInfo> listBoundElders(Long familyMemberId, String elderNameKeyword);

    void bind(Long familyMemberId, FamilyElderBindRequestDto dto);

    void unbind(Long familyMemberId, Long elderId);

    Long resolveAnyBoundElderId(Long familyMemberId);
}
