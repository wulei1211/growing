package com.hhit.dao;

import com.hhit.entity.PingLun;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:14 2020/4/24
 * @Modified By:
 */
public interface PingLunDaoMapper {
    public List<PingLun> findAllPingLunByArticleId(@Param("articleId") String articleId,@Param("page") Integer page);

    public int findAllPingLunOfArticleCount(@Param("articleId") String articleId);

    public int getPingLunReplayCount(@Param("pingLunId")String pingLunId);

    public void addPingLun(PingLun pin);
}
