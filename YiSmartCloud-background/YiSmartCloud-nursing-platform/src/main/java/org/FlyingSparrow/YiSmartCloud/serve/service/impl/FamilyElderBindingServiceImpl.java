package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import lombok.RequiredArgsConstructor;
import org.FlyingSparrow.YiSmartCloud.common.exception.ServiceException;
import org.FlyingSparrow.YiSmartCloud.common.utils.StringUtils;
import org.FlyingSparrow.YiSmartCloud.serve.domain.ElderInfo;
import org.FlyingSparrow.YiSmartCloud.serve.domain.FamilyElderBinding;
import org.FlyingSparrow.YiSmartCloud.serve.dto.FamilyElderBindRequestDto;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.FamilyElderBindingMapper;
import org.FlyingSparrow.YiSmartCloud.serve.service.IFamilyElderBindingService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FamilyElderBindingServiceImpl implements IFamilyElderBindingService {

    private final FamilyElderBindingMapper familyElderBindingMapper;

    @Override
    public List<ElderInfo> listBoundElders(Long familyMemberId, String elderNameKeyword) {
        return familyElderBindingMapper.selectBoundElders(familyMemberId, elderNameKeyword);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void bind(Long familyMemberId, FamilyElderBindRequestDto dto) {
        String elderName = StringUtils.trim(dto.getElderName());
        String phone = StringUtils.trim(dto.getPhone());
        if (StringUtils.isEmpty(elderName) || StringUtils.isEmpty(phone)) {
            throw new ServiceException("老人姓名和手机号不能为空");
        }
        ElderInfo elder = familyElderBindingMapper.selectElderByNameAndPhone(elderName, phone);
        if (elder == null) {
            throw new ServiceException("未找到可绑定的在院老人，请确认姓名和手机号");
        }
        int existed = familyElderBindingMapper.countActiveBinding(familyMemberId, elder.getId());
        if (existed > 0) {
            throw new ServiceException("该老人已绑定，无需重复操作");
        }
        FamilyElderBinding binding = new FamilyElderBinding();
        binding.setFamilyMemberId(familyMemberId);
        binding.setElderId(elder.getId());
        binding.setRelation(StringUtils.trim(dto.getRelation()));
        binding.setStatus(1);
        binding.setIsDeleted(0);
        binding.setCreateTime(new Date());
        binding.setUpdateTime(new Date());
        int inserted = familyElderBindingMapper.insert(binding);
        if (inserted <= 0) {
            throw new ServiceException("绑定失败，请稍后重试");
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void unbind(Long familyMemberId, Long elderId) {
        if (elderId == null) {
            throw new ServiceException("老人ID不能为空");
        }
        int rows = familyElderBindingMapper.softDeleteBinding(familyMemberId, elderId);
        if (rows <= 0) {
            throw new ServiceException("未找到可解绑的绑定关系");
        }
    }

    @Override
    public Long resolveAnyBoundElderId(Long familyMemberId) {
        return familyElderBindingMapper.selectAnyBoundElderId(familyMemberId);
    }
}
