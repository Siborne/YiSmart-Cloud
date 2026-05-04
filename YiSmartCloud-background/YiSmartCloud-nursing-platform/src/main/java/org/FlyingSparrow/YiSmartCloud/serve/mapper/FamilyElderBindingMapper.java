package org.FlyingSparrow.YiSmartCloud.serve.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.FlyingSparrow.YiSmartCloud.serve.domain.ElderInfo;
import org.FlyingSparrow.YiSmartCloud.serve.domain.FamilyElderBinding;

import java.util.List;

@Mapper
public interface FamilyElderBindingMapper extends BaseMapper<FamilyElderBinding> {

    ElderInfo selectElderByNameAndPhone(@Param("elderName") String elderName, @Param("phone") String phone);

    int countActiveBinding(@Param("familyMemberId") Long familyMemberId, @Param("elderId") Long elderId);

    List<ElderInfo> selectBoundElders(@Param("familyMemberId") Long familyMemberId, @Param("name") String name);

    int softDeleteBinding(@Param("familyMemberId") Long familyMemberId, @Param("elderId") Long elderId);

    Long selectAnyBoundElderId(@Param("familyMemberId") Long familyMemberId);
}
