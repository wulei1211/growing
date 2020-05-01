package com.hhit.dao;

import com.hhit.entity.ManageUserBean;
import org.apache.ibatis.annotations.Param;

import java.util.List;

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

    public int getGuanZhuCount(@Param("beiGuanId") String beiGuanId);

    public ManageUserBean findUserBeanById(@Param("userId") String userId);

    public ManageUserBean findArticleUserByArticleId(@Param("articleId") String articleId);

    public void changePassword(@Param("userId")String userId,@Param("newPass") String newPass);

    public int getManageUserCountByMap(ManageUserBean paramUser);

    public List<ManageUserBean> getManageUserByMap(ManageUserBean paramUser);

    public void userAdd(ManageUserBean userBean);

    public void userDel(@Param("id")String id);

    public void userUpdate(ManageUserBean userBean);
}
