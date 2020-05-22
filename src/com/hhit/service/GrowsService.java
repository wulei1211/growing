package com.hhit.service;

import com.hhit.entity.Grows;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:01 2020/5/6
 * @Modified By:
 */
public interface GrowsService {
    int getAllChuanCount(Grows paramUser);

    List<Grows> getAllChuan(Grows paramUser);

    void addPeng(Grows grows);

    int checkGrowName(String growName,String userId);

    Grows getGrowsById(String pId);

    void updateGrow(Grows grows);

    void deleteGrowById(String id);

    void peiAllParam(Grows grows);
}
