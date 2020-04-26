package com.hhit.service;

import com.hhit.entity.PingLunDian;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 22:23 2020/4/25
 * @Modified By:
 */
public interface PingLunDianService {
    public List<PingLunDian> findBooleanPingLunDian(String userId);
}
