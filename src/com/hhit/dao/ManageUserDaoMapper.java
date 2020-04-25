package com.hhit.dao;

import com.hhit.entity.ManageUserBean;
import org.apache.ibatis.annotations.Param;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:19 2020/4/20
 * @Modified By:
 */
public interface ManageUserDaoMapper {
    public ManageUserBean getUserByUserName(@Param("userName") String userName, @Param("deleteFlag") Integer deleteFlag);

    public int getShouCangCount(@Param("userId") String userId);

    public int getArticleCount(@Param("userId") String userId);

    public ManageUserBean findUserBeanById(@Param("userId") String userId);
}
