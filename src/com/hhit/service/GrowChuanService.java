package com.hhit.service;

import com.hhit.entity.Chuan;
import com.hhit.entity.GrowChuan;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:33 2020/5/6
 * @Modified By:
 */
public interface GrowChuanService {
    void addGrowChuan(GrowChuan growChuan);

    void deleteAllGrowChuan(String id);

    GrowChuan findGrowByCid(String cid);

    List<Chuan> getChuanListByGrowId(String gid);

    void deleteGrowsChuanById(String gid, String cid);
}
