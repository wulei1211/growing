package com.hhit.dao;

import com.hhit.entity.PingLun;
import com.hhit.entity.PingLunDian;
import com.hhit.entity.Replay;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:14 2020/4/24
 * @Modified By:
 */
public interface PingLunDaoMapper {
    public List<PingLun> findAllPingLunByArticleId(@Param("dengLuId") String dengLuId,@Param("articleId") String articleId,@Param("page") Integer page);

    public int findAllPingLunOfArticleCount(@Param("articleId") String articleId);


    public int getPingLunReplayCount(@Param("pingLunId")String pingLunId);

    public void addPingLun(PingLun pin);

    public int getPingLunDianCount(@Param("pinId") String pinId);

    public void addPingLunDian(PingLunDian pingDian);

    public void deletePingLunDian(PingLunDian pingDian);

    public void deleteArticlesPingLun(@Param("articleId") String articleId);


    public List<PingLun> findAllPingLunByUserId(@Param("userId") String userId,@Param("page") Integer page);

    public List<Replay> getAllReplayOfPingLun(@Param("pId") String pId,@Param("userId")String userId);

    public Integer checkBooleanDianPing(@Param("pId") String pId,@Param("userId")String userId);

    public void deletePing(@Param("pId") String pId);
}
