package com.hhit.dao;

import com.hhit.entity.Chuan;
import com.hhit.entity.GrowChuan;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:34 2020/5/6
 * @Modified By:
 */
public interface GrowChuanDaoMapper {
    public List<GrowChuan> getGrowsChuanByGrowId(@Param("growId") String growId);

    void addGrowChuan(GrowChuan growChuan);

    void deleteAllGrowChuan(@Param("id") String id);

    GrowChuan findGrowByCid(@Param("cid") String cid);

    List<Chuan> getChuanListByGrowId(@Param("gid")String gid);

    void deleteGrowsChuanById(@Param("gid")String gid, @Param("cid")String cid);

    List<GrowChuan> findGrowChuanById(@Param("id")String id);
}
