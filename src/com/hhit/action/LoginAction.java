package com.hhit.action;

import com.hhit.common.Constant;
import com.hhit.entity.ManageUserBean;
import com.hhit.service.ArticleService;
import com.hhit.service.ManageUserService;
import com.hhit.util.CommonUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:08 2020/4/20
 * @Modified By:
 */
@Controller
@RequestMapping("login")
public class LoginAction {

    static Logger log = LogManager.getLogger();

    @Resource(name = "manageUserService")
    private ManageUserService manageUserService;

    @Resource(name = "articleService")
    private ArticleService articleService;


    @RequestMapping("tologin")
    @ResponseBody
    public String login(HttpServletRequest request, HttpServletResponse response, String userName, String password){
        log.debug("系统登陆 参数信息 UserName: " + userName);
        ManageUserBean userBean = manageUserService.getUserByUserName(userName.trim(),0);
        if (null != userBean) {
            if (CommonUtil.getMD5(password).equalsIgnoreCase(userBean.getPassword())) {

                // 设置Session
                HttpSession session = request.getSession();
                session.setAttribute(Constant.SESSION_USERID_LONG, userBean.getId());
                session.setAttribute(Constant.SESSION_USER_NAME_STRING, userBean.getUserName());
                session.setAttribute("userBean", userBean);
                log.debug(userName+" 登陆成功");
                if("2".equals(userBean.getUserType())){
                    return "manager";
                }else{
                    return userBean.getId();
                }

            } else {

                log.debug(userName+" 密码错误");

                return "PASSWORD_ERROR";
            }

        } else {

            log.debug(userName+" 不存在");

            return "NO_EXIST";
        }
    }

    @RequestMapping("userArticleMsg")
    @ResponseBody
    public ManageUserBean getUserArticleMsg(String manageUserId){
        ManageUserBean userBean = manageUserService.findUserBeanById(manageUserId);
        return userBean;
    }

}
