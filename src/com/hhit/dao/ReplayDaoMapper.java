package com.hhit.dao;

import com.hhit.entity.PingLun;
import com.hhit.entity.Replay;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 21:43 2020/4/24
 * @Modified By:
 */
public interface ReplayDaoMapper {
    public List<Replay> getAllReplayOfPingLun(@Param("userId") String userId,@Param("pId") String pId);

    public List<Replay> getAllReplayOfPingLunPlus(@Param("id") String id,@Param("userId") String userId);

    public void addReplay(Replay replay);

    public int getReplayDianCount(@Param("replayId") String replayId);

    public void deleteArticlesReplay(@Param("articleId") String articleId);

    public void deletePingLunsReplay(@Param("pId") String pId);

    int findReplayCount(Replay paramUser);

    List<PingLun> findAllReplay(Replay paramUser);
}
