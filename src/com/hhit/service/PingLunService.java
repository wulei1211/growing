package com.hhit.service;

import com.hhit.entity.PingLun;
import com.hhit.entity.PingLunDian;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:12 2020/4/24
 * @Modified By:
 */
public interface PingLunService {
    public List<PingLun> findAllPingLunByArticleId(String articleId,Integer page);

    public int findAllPingLunOfArticleCount(String articleId);

    public void addPingLun(PingLun pin);

    public void addPingLunDian(PingLunDian pingDian);

    public void deletePingLunDian(PingLunDian pingDian);
}
