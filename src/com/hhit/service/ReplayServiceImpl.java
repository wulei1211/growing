package com.hhit.service;

import com.hhit.dao.ReplayDaoMapper;
import com.hhit.entity.Replay;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:08 2020/4/24
 * @Modified By:
 */
@Service("replayService")
public class ReplayServiceImpl implements ReplayService {

    @Autowired
    private ReplayDaoMapper replayDaoMapper;

    @Override
    public List<Replay> getAllReplayOfPingLun(String pId) {
        return replayDaoMapper.getAllReplayOfPingLun(pId);
    }

    @Override
    @Transactional
    public void addReplay(Replay replay) {
        replayDaoMapper.addReplay(replay);
    }

    @Override
    @Transactional
    public void deleteArticlesReplay(String articleId) {
        replayDaoMapper.deleteArticlesReplay(articleId);
    }

    @Override
    @Transactional
    public void deletePingLunsReplay(String pId) {
        replayDaoMapper.deletePingLunsReplay(pId);
    }
}
