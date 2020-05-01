package com.hhit.dao;

import com.hhit.entity.PingLunDian;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 22:26 2020/4/25
 * @Modified By:
 */
public interface PingLunDianDaoMapper {
    public List<PingLunDian> findBooleanPingLunDian(@Param("userId") String userId);



}
