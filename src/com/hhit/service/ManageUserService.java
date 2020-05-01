package com.hhit.service;

import com.hhit.entity.ManageUserBean;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:14 2020/4/20
 * @Modified By:
 */

public interface ManageUserService {
    public ManageUserBean getUserByUserName(String userName,Integer deleteFlag);

    public ManageUserBean findUserBeanById(String userId);

    public ManageUserBean findArticleUserByArticleId(String articleId);

    public void changePassword(String userId,String newPass);

    public int getManageUserCountByMap(ManageUserBean paramUser);

    List<ManageUserBean> getManageUserByMap(ManageUserBean paramUser);

    public void userAdd(ManageUserBean userBean);

    public void userDel(String id);

    public void userUpdate(ManageUserBean userBean);
}
