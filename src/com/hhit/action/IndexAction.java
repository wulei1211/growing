package com.hhit.action;

import com.hhit.common.Constant;
import com.hhit.entity.DianZan;
import com.hhit.entity.ManageUserBean;
import com.hhit.service.ArticleService;
import com.hhit.service.DianZanService;
import com.hhit.util.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:08 2020/4/20
 * @Modified By:
 */
@Controller
@RequestMapping("index")
public class IndexAction {

    @Resource(name = "dianZanService")
    private DianZanService dianZanService;
    @Resource(name = "articleService")
    private ArticleService articleService;

    @RequestMapping("toIndexPage")
    public String toIndexPage(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession();
        ManageUserBean user = (ManageUserBean)session.getAttribute("userBean");
        List<DianZan> list =  dianZanService.findDianZanArticle(user.getId());
        int count = articleService.findAllArticleCount(null,user.getId());
        List<String> ids = new ArrayList<>();
        List<String> shous = new ArrayList<>();
        for (int i = 0;i<list.size();i++){
            if("1".equals(list.get(i).getDianType())){
                ids.add(list.get(i).getArticleId());
            }else{
                shous.add(list.get(i).getArticleId());
            }
        }

        request.setAttribute("dianzans",ids);
        request.setAttribute("realName",user.getRealName());
        request.setAttribute("memo",user.getMemo());
        request.setAttribute("touXiang",user.getHeadImg());
        request.setAttribute("artCount",count);
        request.setAttribute("shoucangs",shous);
        return "index/index";
    }

    @RequestMapping("changeDianZan")
    @ResponseBody
    public String changeDianZan(String dianType,String type,String articleId,HttpServletRequest request){
        HttpSession session = request.getSession();
        String userId = session.getAttribute(Constant.SESSION_USERID_LONG).toString();
        if("1".equals(dianType)){
            if("1".equals(type)){
                DianZan dian = new DianZan();
                UUID uuid = UUID.randomUUID();
                dian.setId(uuid.toString());
                dian.setArticleId(articleId);
                dian.setUserId(userId);
                dian.setDianType("1");
                dian.setTime(CommonUtil.getDateTimeString(new Date()));
                dianZanService.dianzan(dian);
                return "dian";
            }else{
                dianZanService.quXiaoZan(articleId,userId,dianType);
                return "qu";
            }
        }else{
            if("1".equals(type)){
                DianZan dian = new DianZan();
                UUID uuid = UUID.randomUUID();
                dian.setId(uuid.toString());
                dian.setArticleId(articleId);
                dian.setUserId(userId);
                dian.setDianType("2");
                dian.setTime(CommonUtil.getDateTimeString(new Date()));
                dianZanService.dianzan(dian);
                return "shou";
            }else{
                dianZanService.quXiaoZan(articleId,userId,dianType);
                return "noshou";
            }
        }
    }
}
