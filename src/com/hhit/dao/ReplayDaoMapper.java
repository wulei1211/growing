package com.hhit.dao;

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
    public List<Replay> getAllReplayOfPingLun(@Param("pId") String pId);

    public void addReplay(Replay replay);

    public int getReplayDianCount(@Param("replayId") String replayId);
}
