package com.hhit.service;

import com.hhit.dao.DataDaoMapper;
import com.hhit.entity.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:45 2020/5/7
 * @Modified By:
 */
@Service("dataService")
public class DataServiceImpl implements DataService {

    @Autowired
    private DataDaoMapper dataDaoMapper;

    @Override
    public void addData(Data d) {
        dataDaoMapper.addData(d);
    }

    @Override
    public List<Data> findGrowsDataById(String gid,String cid) {
        return dataDaoMapper.findGrowsDataById(gid,cid);
    }

    @Override
    public List<Data> getGrowsChuanById(String gid, String cid,String startTime,String endTime) {
        return dataDaoMapper.getGrowsChuanById(gid,cid,startTime,endTime);
    }
}
