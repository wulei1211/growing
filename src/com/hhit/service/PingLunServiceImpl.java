package com.hhit.service;

import com.hhit.dao.PingLunDaoMapper;
import com.hhit.entity.PingLun;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:12 2020/4/24
 * @Modified By:
 */
@Service("pingLunService")
public class PingLunServiceImpl implements PingLunService {

    @Autowired
    private PingLunDaoMapper pingLunDaoMapper;

    @Override
    public List<PingLun> findAllPingLunByArticleId(String articleId,Integer page) {
        return pingLunDaoMapper.findAllPingLunByArticleId(articleId,page);
    }

    @Override
    public int findAllPingLunOfArticleCount(String articleId) {
        return pingLunDaoMapper.findAllPingLunOfArticleCount(articleId);
    }

    @Override
    @Transactional
    public void addPingLun(PingLun pin) {
        pingLunDaoMapper.addPingLun(pin);
    }
}
