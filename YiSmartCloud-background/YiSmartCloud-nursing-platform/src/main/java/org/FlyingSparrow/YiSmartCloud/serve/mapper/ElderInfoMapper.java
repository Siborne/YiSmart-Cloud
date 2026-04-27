package org.FlyingSparrow.YiSmartCloud.serve.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import org.FlyingSparrow.YiSmartCloud.serve.domain.ElderInfo;

/**
 * 老人档案Mapper接口
 *
 * @author Siborne
 * @date 2026-04-27
 */
@Mapper
public interface ElderInfoMapper extends BaseMapper<ElderInfo> {
    /**
     * 查询老人档案
     *
     * @param id 老人档案主键
     * @return 老人档案
     */
    public ElderInfo selectElderInfoById(Long id);

    /**
     * 查询老人档案列表
     *
     * @param elderInfo 老人档案
     * @return 老人档案集合
     */
    public List<ElderInfo> selectElderInfoList(ElderInfo elderInfo);

    /**
     * 新增老人档案
     *
     * @param elderInfo 老人档案
     * @return 结果
     */
    public int insertElderInfo(ElderInfo elderInfo);

    /**
     * 修改老人档案
     *
     * @param elderInfo 老人档案
     * @return 结果
     */
    public int updateElderInfo(ElderInfo elderInfo);

    /**
     * 删除老人档案
     *
     * @param id 老人档案主键
     * @return 结果
     */
    public int deleteElderInfoById(Long id);

    /**
     * 批量删除老人档案
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteElderInfoByIds(Long[] ids);
}