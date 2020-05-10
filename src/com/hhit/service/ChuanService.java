package com.hhit.service;

import com.hhit.entity.Chuan;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 14:09 2020/5/6
 * @Modified By:
 */
public interface ChuanService {
    public int getAllChuanCount(Chuan paramUser);

    List<Chuan> getAllChuan(Chuan paramUser);

    void addChuan(Chuan chuan);

    List<Chuan> getNoUseChuan(Chuan chuan);

    void updateChuanStatus(Chuan chuan);

    List<Chuan> getChuanListByGrowId(String gid);
}
