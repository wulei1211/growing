package com.hhit.service;

import com.hhit.entity.MyTask;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:05 2020/5/2
 * @Modified By:
 */
public interface MyTaskService {
    public List<MyTask> findAllTaskByUserId(String userId);

    public void addMsg(MyTask task);

    public int findMsgCount(String id);

    public void readMsg(String msgId, String userId);
}
