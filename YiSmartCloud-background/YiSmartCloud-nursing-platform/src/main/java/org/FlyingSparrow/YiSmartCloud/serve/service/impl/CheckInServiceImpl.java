package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.alibaba.fastjson2.JSON;
import lombok.AllArgsConstructor;
import org.FlyingSparrow.YiSmartCloud.common.exception.base.BaseException;
import org.FlyingSparrow.YiSmartCloud.common.utils.CodeGenerator;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Bed;
import org.FlyingSparrow.YiSmartCloud.serve.domain.CheckInConfig;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Contract;
import org.FlyingSparrow.YiSmartCloud.serve.domain.ElderInfo;
import org.FlyingSparrow.YiSmartCloud.serve.dto.CheckInApplyDto;
import org.FlyingSparrow.YiSmartCloud.serve.dto.CheckInElderDto;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.BedMapper;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.CheckInConfigMapper;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.ContractMapper;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.ElderInfoMapper;
import org.FlyingSparrow.YiSmartCloud.serve.vo.CheckInConfigVo;
import org.FlyingSparrow.YiSmartCloud.serve.vo.CheckInDetailVo;
import org.FlyingSparrow.YiSmartCloud.serve.vo.CheckInElderVo;
import org.FlyingSparrow.YiSmartCloud.serve.vo.ElderFamilyVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.CheckInMapper;
import org.FlyingSparrow.YiSmartCloud.serve.domain.CheckIn;
import org.FlyingSparrow.YiSmartCloud.serve.service.ICheckInService;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;

/**
 * 入住登记Service业务层处理
 *
 * @author Siborne
 * @date 2026-04-29
 */
@Service
@AllArgsConstructor
public class CheckInServiceImpl extends ServiceImpl<CheckInMapper, CheckIn> implements ICheckInService {
    @Autowired
    private CheckInMapper checkInMapper;


    private final ElderInfoMapper elderInfoMapper;

    private final BedMapper bedMapper;

    /**
     * 查询入住登记
     *
     * @param id 入住登记主键
     * @return 入住登记
     */
    @Override
    public CheckIn selectCheckInById(Long id) {
        return getById(id);
    }

    /**
     * 查询入住登记列表
     *
     * @param checkIn 入住登记
     * @return 入住登记
     */
    @Override
    public List<CheckIn> selectCheckInList(CheckIn checkIn) {
        return checkInMapper.selectCheckInList(checkIn);
    }

    /**
     * 新增入住登记
     *
     * @param checkIn 入住登记
     * @return 结果
     */
    @Override
    public int insertCheckIn(CheckIn checkIn) {
        return save(checkIn) == true ? 1 : 0;
    }

    /**
     * 修改入住登记
     *
     * @param checkIn 入住登记
     * @return 结果
     */
    @Override
    public int updateCheckIn(CheckIn checkIn) {
        return updateById(checkIn) == true ? 1 : 0;
    }

    /**
     * 批量删除入住登记
     *
     * @param ids 需要删除的入住登记主键
     * @return 结果
     */
    @Override
    public int deleteCheckInByIds(Long[] ids) {
        return removeByIds(Arrays.asList(ids)) == true ? 1 : 0;
    }

    /**
     * 删除入住登记信息
     *
     * @param id 入住登记主键
     * @return 结果
     */
    @Override
    public int deleteCheckInById(Long id) {
        return removeById(id) == true ? 1 : 0;
    }

    /**
     * 申请入住
     *
     * @param checkInApplyDto
     */
    @Override
    @Transactional
    public void apply(CheckInApplyDto checkInApplyDto) {
        //判断老人是否已经入住
        //查询老人  通过身份证号查询
        ElderInfo elder = findLatestElderByIdCardAndStatus(checkInApplyDto.getCheckInElderDto().getIdCardNo(), 1);
        if (ObjectUtils.isNotEmpty(elder)) {
            throw new BaseException("老人已入住");
        }

        //更新床位的状态  已入住
        Bed bed = bedMapper.selectBedById(checkInApplyDto.getCheckInConfigDto().getBedId());
        if (bed == null) {
            throw new BaseException("床位不存在");
        }
        if (!Objects.equals(bed.getBedStatus(), 0)) {
            throw new BaseException("床位不可用");
        }
        bed.setBedStatus(1);
        bedMapper.updateBed(bed);

        //保存或更新老人数据
        elder = insertOrUpdate(checkInApplyDto.getCheckInElderDto());

        //生成合同编号
        String contractNo = "HT" + CodeGenerator.generateContractNumber();

        //新增签约办理
        insertContract(contractNo, elder, checkInApplyDto);

        //新增入住信息
        CheckIn checkIn = insertCheckIn(elder, bed, checkInApplyDto);

        //新增入住配置信息
        insertCheckInConfig(checkIn.getId(), checkInApplyDto);
    }

    @Override
    public CheckInDetailVo detail(Long id) {
        CheckIn checkIn = checkInMapper.selectById(id);
        if (checkIn == null) {
            throw new BaseException("入住记录不存在");
        }

        CheckInDetailVo detailVo = new CheckInDetailVo();

        ElderInfo elderInfo = elderInfoMapper.selectElderInfoById(checkIn.getElderId());
        CheckInElderVo elderVo = new CheckInElderVo();
        if (elderInfo != null) {
            elderVo.setId(elderInfo.getId());
            elderVo.setName(elderInfo.getName());
            elderVo.setIdCardNo(elderInfo.getIdCard());
            elderVo.setAge(elderInfo.getAge());
            // elder_info：1-男，2-女；CheckInElderVo.sex：0-男，1-女，2-未知
            if (elderInfo.getGender() != null) {
                if (elderInfo.getGender() == 1) {
                    elderVo.setSex(0);
                } else if (elderInfo.getGender() == 2) {
                    elderVo.setSex(1);
                } else {
                    elderVo.setSex(2);
                }
            }
            elderVo.setPhone(elderInfo.getContactPhone());
            elderVo.setBirthday(elderInfo.getBirthday());
            elderVo.setAddress(elderInfo.getAddress());
            elderVo.setImage(elderInfo.getPortraitImg());
            elderVo.setIdCardPortraitImg(elderInfo.getIdCardPortraitImg());
            elderVo.setIdCardNationalEmblemImg(elderInfo.getIdCardNationalEmblemImg());
        }
        detailVo.setCheckInElderVo(elderVo);

        CheckInConfigVo configVo = new CheckInConfigVo();
        LambdaQueryWrapper<CheckInConfig> configWrapper = new LambdaQueryWrapper<>();
        configWrapper.eq(CheckInConfig::getCheckInId, checkIn.getId());
        CheckInConfig configEntity = checkInConfigMapper.selectOne(configWrapper);
        if (configEntity != null) {
            BeanUtils.copyProperties(configEntity, configVo);
        } else {
            configVo.setStartDate(checkIn.getStartDate());
            configVo.setEndDate(checkIn.getEndDate());
            configVo.setBedNumber(checkIn.getBedNumber());
            configVo.setNursingLevelName(checkIn.getNursingLevelName());
        }
        detailVo.setCheckInConfigVo(configVo);

        List<ElderFamilyVo> familyVoList;
        if (ObjectUtils.isEmpty(checkIn.getRemark())) {
            familyVoList = new ArrayList<>();
        } else {
            familyVoList = JSON.parseArray(checkIn.getRemark(), ElderFamilyVo.class);
            if (familyVoList == null) {
                familyVoList = new ArrayList<>();
            }
        }
        detailVo.setElderFamilyVoList(familyVoList);

        LambdaQueryWrapper<Contract> contractQueryWrapper = new LambdaQueryWrapper<>();
        contractQueryWrapper.eq(Contract::getElderId, checkIn.getElderId());
        contractQueryWrapper.orderByDesc(Contract::getId);
        contractQueryWrapper.last("limit 1");
        Contract contract = contractMapper.selectOne(contractQueryWrapper);
        detailVo.setContract(contract);

        return detailVo;
    }

    @Autowired
    private CheckInConfigMapper checkInConfigMapper;

    /**
     * 新增入住配置
     *
     * @param checkInApplyDto
     */
    private void insertCheckInConfig(Long checkInId, CheckInApplyDto checkInApplyDto) {
        CheckInConfig checkInConfig = new CheckInConfig();
        BeanUtils.copyProperties(checkInApplyDto.getCheckInConfigDto(), checkInConfig);
        checkInConfig.setCheckInId(checkInId);
        checkInConfigMapper.insert(checkInConfig);
    }

    /**
     * 新增入住信息
     *
     * @param elder
     * @param checkInApplyDto
     */
    private CheckIn insertCheckIn(ElderInfo elder, Bed bed, CheckInApplyDto checkInApplyDto) {
        if (elder == null || elder.getId() == null) {
            throw new BaseException("老人信息保存失败，无法生成入住记录");
        }
        CheckIn checkIn = new CheckIn();
        checkIn.setElderId(elder.getId());
        checkIn.setElderName(elder.getName());
        checkIn.setIdCardNo(elder.getIdCard());
        checkIn.setNursingLevelName(checkInApplyDto.getCheckInConfigDto().getNursingLevelName());
        checkIn.setStartDate(checkInApplyDto.getCheckInConfigDto().getStartDate());
        checkIn.setEndDate(checkInApplyDto.getCheckInConfigDto().getEndDate());
        checkIn.setBedNumber(bed.getBedNo());
        checkIn.setRemark(JSON.toJSONString(checkInApplyDto.getElderFamilyDtoList()));
        checkIn.setStatus(0);
        checkInMapper.insert(checkIn);
        return checkIn;
    }

    private final ContractMapper contractMapper;

    /**
     * 新增合同
     *
     * @param contractNo
     * @param elder
     * @param checkInApplyDto
     */
    private void insertContract(String contractNo, ElderInfo elderInfo, CheckInApplyDto checkInApplyDto) {

        Contract contract = new Contract();
        //属性拷贝
        BeanUtils.copyProperties(checkInApplyDto.getCheckInContractDto(), contract);
        contract.setContractNumber(contractNo);
        contract.setElderId(elderInfo.getId());
        contract.setElderName(elderInfo.getName());
        //状态、开始时间、结束时间
        //签约时间小于等于当前时间，合同生效中
        LocalDateTime checkInStartTime = checkInApplyDto.getCheckInConfigDto().getStartDate();
        LocalDateTime checkInEndTime = checkInApplyDto.getCheckInConfigDto().getEndDate();
        Integer status = checkInStartTime.isAfter(LocalDateTime.now()) ? 1 : 0;
        contract.setStatus(status);
        contract.setStartDate(checkInStartTime);
        contract.setEndDate(checkInEndTime);
        contractMapper.insert(contract);
    }

    /**
     * 新增或更新老人
     *
     * @param bed
     * @param checkInElderDto
     * @return
     */
    private ElderInfo insertOrUpdate(CheckInElderDto checkInElderDto) {

        //准备老人数据
        ElderInfo elderInfo = new ElderInfo();
        elderInfo.setName(checkInElderDto.getName());
        elderInfo.setIdCard(checkInElderDto.getIdCardNo());
        elderInfo.setAge(checkInElderDto.getAge());
        // elder_info 字典：1-男，2-女；入住 DTO：0-男，1-女
        elderInfo.setGender(checkInElderDto.getSex() == null ? null : (checkInElderDto.getSex() == 1 ? 2 : 1));
        elderInfo.setContactPhone(checkInElderDto.getPhone());
        elderInfo.setBirthday(checkInElderDto.getBirthday());
        elderInfo.setAddress(checkInElderDto.getAddress());
        elderInfo.setPortraitImg(checkInElderDto.getImage());
        elderInfo.setIdCardPortraitImg(checkInElderDto.getIdCardPortraitImg());
        elderInfo.setIdCardNationalEmblemImg(checkInElderDto.getIdCardNationalEmblemImg());
        elderInfo.setStatus(1);
        //查询老人信息，（身份证号和状态 0）
        ElderInfo elderDb = findLatestElderByIdCardAndStatus(checkInElderDto.getIdCardNo(), 0);
        if (ObjectUtils.isNotEmpty(elderDb)) {
            //修改
            elderInfo.setId(elderDb.getId());
            elderInfoMapper.updateElderInfo(elderInfo);
        } else {
            //新增
            elderInfoMapper.insertElderInfo(elderInfo);
            if (elderInfo.getId() == null) {
                ElderInfo activeElder = findLatestElderByIdCardAndStatus(checkInElderDto.getIdCardNo(), 1);
                if (activeElder != null) {
                    elderInfo.setId(activeElder.getId());
                }
            }
        }
        return elderInfo;
    }

    private ElderInfo findLatestElderByIdCardAndStatus(String idCard, Integer status) {
        ElderInfo query = new ElderInfo();
        query.setIdCard(idCard);
        query.setStatus(status);
        List<ElderInfo> elderList = elderInfoMapper.selectElderInfoList(query);
        if (elderList == null || elderList.isEmpty()) {
            return null;
        }
        return elderList.stream().max(Comparator.comparing(ElderInfo::getId)).orElse(null);
    }
}