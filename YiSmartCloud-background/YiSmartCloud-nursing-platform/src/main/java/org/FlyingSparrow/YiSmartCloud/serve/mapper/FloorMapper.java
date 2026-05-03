package org.FlyingSparrow.YiSmartCloud.serve.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.FlyingSparrow.YiSmartCloud.serve.vo.TreeVo;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Floor;

/**
 * ¥����ϢMapper�ӿ�
 *
 * @author Siborne
 * @date 2026-04-28
 */
@Mapper
public interface FloorMapper extends BaseMapper<Floor> {
    /**
     * ��ѯ¥����Ϣ
     *
     * @param id ¥����Ϣ����
     * @return ¥����Ϣ
     */
    public Floor selectFloorById(Long id);

    /**
     * ��ѯ¥����Ϣ�б�
     *
     * @param floor ¥����Ϣ
     * @return ¥����Ϣ����
     */
    public List<Floor> selectFloorList(Floor floor);

    /**
     * ����¥����Ϣ
     *
     * @param floor ¥����Ϣ
     * @return ���
     */
    public int insertFloor(Floor floor);

    /**
     * �޸�¥����Ϣ
     *
     * @param floor ¥����Ϣ
     * @return ���
     */
    public int updateFloor(Floor floor);

    /**
     * ɾ��¥����Ϣ
     *
     * @param id ¥����Ϣ����
     * @return ���
     */
    public int deleteFloorById(Long id);

    /**
     * ����ɾ��¥����Ϣ
     *
     * @param ids ��Ҫɾ����������������
     * @return ���
     */
    public int deleteFloorByIds(Long[] ids);

    List<TreeVo> getRoomAndBedByBedStatus(Integer status);
}
