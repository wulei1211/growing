package com.hhit.dao;

import com.hhit.entity.Grows;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:03 2020/5/6
 * @Modified By:
 */
public interface GrowsDaoMapper {
    int getAllChuanCount(Grows paramUser);

    List<Grows> getAllChuan(Grows paramUser);

    void addPeng(Grows grows);

    int checkGrowName(@Param("growName") String growName);

    Grows getGrowsById(@Param("pId") String pId);

    void updateGrow(Grows grows);

    void deleteGrowById(@Param("id") String id);

    void peiAllParam(Grows grows);
}
