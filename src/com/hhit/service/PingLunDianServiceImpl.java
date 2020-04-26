package com.hhit.service;

import com.hhit.dao.PingLunDianDaoMapper;
import com.hhit.entity.PingLunDian;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 22:24 2020/4/25
 * @Modified By:
 */
@Service("pingLunDianService")
public class PingLunDianServiceImpl implements  PingLunDianService {
    @Autowired
    private PingLunDianDaoMapper pingLunDianDaoMapper;

    @Override
    public List<PingLunDian> findBooleanPingLunDian(String userId) {
        return pingLunDianDaoMapper.findBooleanPingLunDian(userId);
    }
}
