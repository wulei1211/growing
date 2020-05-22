package com.hhit.service;

import com.hhit.dao.GrowsDaoMapper;
import com.hhit.entity.Grows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:01 2020/5/6
 * @Modified By:
 */
@Service("growsService")
public class GrowsServiceImpl implements GrowsService {

    @Autowired
    private GrowsDaoMapper growsDaoMapper;

    @Override
    public int getAllChuanCount(Grows paramUser) {
        return growsDaoMapper.getAllChuanCount(paramUser);
    }

    @Override
    public List<Grows> getAllChuan(Grows paramUser) {
        return growsDaoMapper.getAllChuan(paramUser);
    }

    @Override
    @Transactional
    public void addPeng(Grows grows) {
        growsDaoMapper.addPeng(grows);
    }

    @Override
    public int checkGrowName(String growName,String userId) {
        return growsDaoMapper.checkGrowName(growName,userId);
    }

    @Override
    public Grows getGrowsById(String pId) {
        return growsDaoMapper.getGrowsById(pId);
    }

    @Override
    public void updateGrow(Grows grows) {
        growsDaoMapper.updateGrow(grows);
    }

    @Override
    public void deleteGrowById(String id) {
        growsDaoMapper.deleteGrowById(id);
    }

    @Override
    public void peiAllParam(Grows grows) {
        growsDaoMapper.peiAllParam(grows);
    }
}
