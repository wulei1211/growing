package com.hhit.service;

import com.hhit.entity.PingLun;
import com.hhit.entity.Replay;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:07 2020/4/24
 * @Modified By:
 */
public interface ReplayService {
    public List<Replay> getAllReplayOfPingLun(String userId,String pId);

    public void addReplay(Replay replay);

    public void deleteArticlesReplay(String articleId);

    public void deletePingLunsReplay(String pId);

    int findReplayCount(Replay paramUser);

    List<PingLun> findAllReplay(Replay paramUser);
}
