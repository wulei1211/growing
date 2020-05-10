package com.hhit.service;

import com.hhit.dao.DingDaoMapper;
import com.hhit.entity.Ding;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 15:06 2020/5/9
 * @Modified By:
 */
@Service("dingService")
public class DingServiceImpl implements DingService {

    @Autowired
    private DingDaoMapper dingDaoMapper;

    @Override
    public void addDing(Ding d) {
        dingDaoMapper.addDing(d);
    }

    @Override
    public Ding findDingByUserId(String userId) {
        return dingDaoMapper.findDingByUserId(userId);
    }

    @Override
    public void deleteDingByUserId(String userId) {
        dingDaoMapper.deleteDingByUserId(userId);
    }
}
