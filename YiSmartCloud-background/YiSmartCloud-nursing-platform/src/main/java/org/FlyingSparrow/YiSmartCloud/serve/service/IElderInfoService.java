package org.FlyingSparrow.YiSmartCloud.serve.service;

import com.baomidou.mybatisplus.extension.service.IService;
import java.util.List;
import org.FlyingSparrow.YiSmartCloud.serve.domain.ElderInfo;

/**
 * 老人档案Service接口
 *
 * @author Siborne
 * @date 2026-04-27
 */
public interface IElderInfoService extends IService<ElderInfo> {
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
     * 批量删除老人档案
     *
     * @param ids 需要删除的老人档案主键集合
     * @return 结果
     */
    public int deleteElderInfoByIds(Long[] ids);

    /**
     * 删除老人档案信息
     *
     * @param id 老人档案主键
     * @return 结果
     */
    public int deleteElderInfoById(Long id);
}