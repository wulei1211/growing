package com.hhit.service;

import com.hhit.dao.PingLunDaoMapper;
import com.hhit.entity.PingLun;
import com.hhit.entity.PingLunDian;
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
    public List<PingLun> findAllPingLunByArticleId(String dengLuId,String articleId,Integer page) {
        return pingLunDaoMapper.findAllPingLunByArticleId(dengLuId,articleId,page);
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

    @Override
    @Transactional
    public void addPingLunDian(PingLunDian pingDian) {
        pingLunDaoMapper.addPingLunDian(pingDian);
    }

    @Override
    @Transactional
    public void deletePingLunDian(PingLunDian pingDian) {
        pingLunDaoMapper.deletePingLunDian(pingDian);
    }

    @Override
    @Transactional
    public void deleteArticlesPingLun(String articleId) {
        pingLunDaoMapper.deleteArticlesPingLun(articleId);
    }

    @Override
    public List<PingLun> findAllPingLunByUserId(String userId,Integer page) {
        return pingLunDaoMapper.findAllPingLunByUserId(userId,page);
    }

    @Override
    @Transactional
    public void deletePing(String pId) {
        pingLunDaoMapper.deletePing(pId);
    }
}
