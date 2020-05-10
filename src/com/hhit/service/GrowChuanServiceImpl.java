package com.hhit.service;

import com.hhit.dao.GrowChuanDaoMapper;
import com.hhit.entity.Chuan;
import com.hhit.entity.GrowChuan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:33 2020/5/6
 * @Modified By:
 */
@Service("growChuanService")
public class GrowChuanServiceImpl implements GrowChuanService {
    @Autowired
    private GrowChuanDaoMapper growChuanDaoMapper;

    @Override
    public void addGrowChuan(GrowChuan growChuan) {
        growChuanDaoMapper.addGrowChuan(growChuan);
    }

    @Override
    public void deleteAllGrowChuan(String id) {
        growChuanDaoMapper.deleteAllGrowChuan(id);
    }

    @Override
    public GrowChuan findGrowByCid(String cid) {
        return growChuanDaoMapper.findGrowByCid(cid);
    }

    @Override
    public List<Chuan> getChuanListByGrowId(String gid) {
        return growChuanDaoMapper.getChuanListByGrowId(gid);
    }
}
