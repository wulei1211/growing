package com.hhit.dao;

import com.hhit.entity.Ding;
import org.apache.ibatis.annotations.Param;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 15:08 2020/5/9
 * @Modified By:
 */
public interface DingDaoMapper {
    void addDing(Ding d);

    Ding findDingByUserId(@Param("userId") String userId);

    void deleteDingByUserId(@Param("userId") String userId);
}
