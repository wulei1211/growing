package com.hhit.service;

import com.hhit.entity.Replay;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:07 2020/4/24
 * @Modified By:
 */
public interface ReplayService {
    public List<Replay> getAllReplayOfPingLun(String pId);

    public void addReplay(Replay replay);

    public void deleteArticlesReplay(String articleId);
}
