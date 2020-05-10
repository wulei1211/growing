package com.hhit.service;

import com.hhit.dao.ChuanDaoMapper;
import com.hhit.entity.Chuan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 14:08 2020/5/6
 * @Modified By:
 */
@Service("chuanService")
public class ChuanServiceImpl implements ChuanService {

    @Autowired
    private ChuanDaoMapper chuanDaoMapper;

    @Override
    public int getAllChuanCount(Chuan paramUser) {
        return chuanDaoMapper.getAllChuanCount(paramUser);
    }

    @Override
    public List<Chuan> getAllChuan(Chuan paramUser) {
        return chuanDaoMapper.getAllChuan(paramUser);
    }

    @Override
    @Transactional
    public void addChuan(Chuan chuan) {
        chuanDaoMapper.addChuan(chuan);
    }

    @Override
    public List<Chuan> getNoUseChuan(Chuan chuan) {
        return chuanDaoMapper.getNoUseChuan(chuan);
    }

    @Override
    public void updateChuanStatus(Chuan chuan) {
        chuanDaoMapper.updateChuanStatus(chuan);
    }

    @Override
    public List<Chuan> getChuanListByGrowId(String gid) {
        return chuanDaoMapper.getChuanListByGrowId(gid);
    }


}
