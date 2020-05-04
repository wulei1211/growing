package com.hhit.service;

import com.hhit.dao.MyTaskDaoMapper;
import com.hhit.entity.MyTask;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:05 2020/5/2
 * @Modified By:
 */
@Service("myTaskService")
public class MyTaskServiceImpl implements  MyTaskService {

    @Autowired
    private MyTaskDaoMapper myTaskDaoMapper;

    @Override
    public List<MyTask> findAllTaskByUserId(String userId) {
        return myTaskDaoMapper.findAllTaskByUserId(userId);
    }

    @Override
    @Transactional
    public void addMsg(MyTask task) {
        myTaskDaoMapper.addMsg(task);
    }

    @Override
    public int findMsgCount(String id) {
        return myTaskDaoMapper.findMsgCount(id);
    }

    @Override
    @Transactional
    public void readMsg(String msgId, String userId) {
        myTaskDaoMapper.readMsg(msgId,userId);
    }
}
