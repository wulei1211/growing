package com.hhit.service;

import com.hhit.dao.ManageUserDaoMapper;
import com.hhit.entity.ManageUserBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:14 2020/4/20
 * @Modified By:
 */
@Service("manageUserService")
public class ManageUserServiceImpl implements ManageUserService {

    @Resource(name = "manageUserDaoMapper")
    private ManageUserDaoMapper manageUserDaoMapper;

    @Override
    @Transactional
    public ManageUserBean getUserByUserName(String userName, Integer deleteFlag) {
        return manageUserDaoMapper.getUserByUserName(userName,deleteFlag);
    }

    @Override
    public ManageUserBean findUserBeanById(String userId) {
        return manageUserDaoMapper.findUserBeanById(userId);
    }

    @Override
    public ManageUserBean findArticleUserByArticleId(String articleId) {
        return manageUserDaoMapper.findArticleUserByArticleId(articleId);
    }

    @Override
    @Transactional
    public void changePassword(String userId,String newPass) {
        manageUserDaoMapper.changePassword(userId,newPass);
    }
}
