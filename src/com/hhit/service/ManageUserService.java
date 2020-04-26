package com.hhit.service;

import com.hhit.entity.ManageUserBean;

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
}
