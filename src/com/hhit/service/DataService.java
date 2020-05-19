package com.hhit.service;

import com.hhit.entity.Data;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:44 2020/5/7
 * @Modified By:
 */
public interface DataService {
    void addData(Data d);

    List<Data> findGrowsDataById(String gid,String cid);

    List<Data> getGrowsChuanById(String gid, String cid,String startTime,String endTime);
}
