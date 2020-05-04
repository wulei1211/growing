package com.hhit.dao;

import com.hhit.entity.ManageUserBean;
import com.hhit.entity.MyTask;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:07 2020/5/2
 * @Modified By:
 */
public interface MyTaskDaoMapper {
    public List<MyTask> findAllTaskByUserId(@Param("userId") String userId);

    public ManageUserBean getSendUserMsg(@Param("userId") String userId);

    public void addMsg(MyTask task);

    public int findMsgCount(@Param("id") String id);

    public void readMsg(@Param("msgId") String msgId, @Param("userId") String userId);
}
