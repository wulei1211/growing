package com.hhit.action;

import com.alibaba.fastjson.JSONObject;
import com.hhit.entity.MMGridPageVoBean;
import com.hhit.entity.ManageUserBean;
import com.hhit.service.ManageUserService;
import com.hhit.util.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 14:00 2020/5/1
 * @Modified By:
 */
@Controller()
@RequestMapping("user")
public class UserAction {

    @Resource(name="manageUserService")
    private ManageUserService manageUserService;

    @RequestMapping("toUserList")
    public String toUserList(){
        return "user/userList";
    }

    @RequestMapping(value="getManageUserByMap")
    @ResponseBody
    public MMGridPageVoBean<ManageUserBean> getManageUserByMap(HttpServletRequest request, ManageUserBean paramUser){
        //int page, int pageSize, String name, String loginId, String departmentId, String status, String roleId, String roleNot

        paramUser.setDeleteFlag("0");

        int size = manageUserService.getManageUserCountByMap(paramUser);

        //放入分页
        int from = (paramUser.getPage()-1) * paramUser.getLimit();

        paramUser.setFromNum(from);

        List<ManageUserBean> data = manageUserService.getManageUserByMap(paramUser);

        MMGridPageVoBean<ManageUserBean> vo = new MMGridPageVoBean<ManageUserBean>();
        vo.setCount(size+"");
        vo.setCode("0");
        vo.setData(data);
        vo.setMsg("");
        return vo;
    }

    @RequestMapping("toUserAdd")
    public String toUserAdd(){
        return "user/userAdd";
    }

    @RequestMapping("toUserEidt")
    public String toUserEidt(String userId,String type,HttpServletRequest request){
        ManageUserBean userBean = manageUserService.findUserBeanById(userId);
        request.setAttribute("user",JSONObject.toJSONString(userBean));
        request.setAttribute("type",type);
        return "user/userEdit";
    }


    @RequestMapping("userAdd")
    @ResponseBody
    public void userAdd(ManageUserBean userBean){
        if("".equals(userBean.getHeadImg())|| userBean.getHeadImg() == null){
            userBean.setHeadImg("http://localhost:8080/growing/js/images/login_logo.png");
        }
        userBean.setId(UUID.randomUUID().toString());
        userBean.setPassword(CommonUtil.getMD5(userBean.getPassword()));
        userBean.setDeleteFlag("0");
        userBean.setUpdateTime(CommonUtil.getDateTimeString(new Date()));
        manageUserService.userAdd(userBean);
    }
    @RequestMapping("userUpdate")
    @ResponseBody
    public void userUpdate(ManageUserBean userBean){
        userBean.setUpdateTime(CommonUtil.getDateTimeString(new Date()));
        manageUserService.userUpdate(userBean);
    }

    @RequestMapping("checkUserName")
    @ResponseBody
    public String checkUserName(HttpServletRequest request, String userName){

        //组织参数
        ManageUserBean paramUser = new ManageUserBean();
        paramUser.setUserName(userName);

        int size = manageUserService.getManageUserCountByMap(paramUser);

        return size+"";
    }

    @RequestMapping("userDel")
    @ResponseBody
    public String userDel(String id){
        manageUserService.userDel(id);
        return "success";
    }
}
