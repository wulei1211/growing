package com.hhit.service;

import com.hhit.entity.Ding;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 15:06 2020/5/9
 * @Modified By:
 */
public interface DingService {
    void addDing(Ding d);

    Ding findDingByUserId(String userId);

    void deleteDingByUserId(String userId);
}
