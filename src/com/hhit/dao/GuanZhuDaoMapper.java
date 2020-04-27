package com.hhit.dao;

import com.hhit.entity.GuanZhu;
import org.apache.ibatis.annotations.Param;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 16:21 2020/4/26
 * @Modified By:
 */
public interface GuanZhuDaoMapper {
    public void addGuanZhu(GuanZhu guanZhu);

    public void deleteGuanZhu(GuanZhu guanZhu);

    public int findBooleanBeiGuan(@Param("dengUserId") String dengUserId, @Param("artUserId") String artUserId);
}
