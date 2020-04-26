package com.hhit.service;

import com.hhit.dao.GuanZhuDaoMapper;
import com.hhit.entity.GuanZhu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 16:18 2020/4/26
 * @Modified By:
 */
@Service("guanZhuService")
public class GuanZhuServiceImpl implements GuanZhuService {

    @Autowired
    private GuanZhuDaoMapper guanZhuDaoMapper;

    @Override
    public void addGuanZhu(GuanZhu guanZhu) {
        guanZhuDaoMapper.addGuanZhu(guanZhu);
    }

    @Override
    public void deleteGuanZhu(GuanZhu guanZhu) {
        guanZhuDaoMapper.deleteGuanZhu(guanZhu);
    }
}
