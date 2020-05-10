package com.hhit.dao;

import com.hhit.entity.Chuan;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 14:10 2020/5/6
 * @Modified By:
 */
public interface ChuanDaoMapper {
    int getAllChuanCount(Chuan paramUser);

    List<Chuan> getAllChuan(Chuan paramUser);

    void addChuan(Chuan chuan);

    public Chuan getChuanById(@Param("cId") String cId);

    List<Chuan> getNoUseChuan(Chuan chuan);

    void updateChuanStatus(Chuan chuan);

    List<Chuan> getChuanListByGrowId(@Param("gid") String gid);
}
