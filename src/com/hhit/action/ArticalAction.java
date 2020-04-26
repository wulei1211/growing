package com.hhit.action;

import com.alibaba.fastjson.JSONObject;
import com.hhit.common.Constant;
import com.hhit.entity.*;
import com.hhit.service.*;
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
 * @Date: Created in 21:08 2020/4/21
 * @Modified By:
 */
@Controller
@RequestMapping("artical")
public class ArticalAction {

    @Resource(name = "articleService")
    private ArticleService articleService;

    @Resource(name = "replayService")
    private ReplayService replayService;

    @Resource(name = "pingLunService")
    private PingLunService pingLunService;

    @Resource(name = "pingLunDianService")
    private PingLunDianService pingLunDianService;

    @Resource(name = "guanZhuService")
    private GuanZhuService guanZhuService;

    @Resource(name = "manageUserService")
    private ManageUserService manageUserService;

    @RequestMapping("toArticalAdd")
    public String toArticalAdd(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession();
        String userId = session.getAttribute(Constant.SESSION_USERID_LONG).toString();
        request.setAttribute("userId",userId);

        return "article/articleAdd";
    }

    @RequestMapping("articleAdd")
    @ResponseBody
    public String articleAdd(Article article){
        UUID id = UUID.randomUUID();
        article.setId(id.toString());
        article.setCreateTime(CommonUtil.getDateTimeString(new Date()));
        article.setArticleCount(0);
        article.setArticleLove(0);
        articleService.articleAdd(article);

        return "success";
    }

    @RequestMapping("allArticle")
    @ResponseBody
    public JSONObject findAllArticle(String articleTitle,Integer page){
        List<Article> list = articleService.findAllArticle(articleTitle,(page-1)*10);
        int count = articleService.findAllArticleCount(articleTitle,null);
        double xx = count;
        JSONObject json = new JSONObject();
        int size = (int) ((xx%10==0)?xx/10: Math.ceil(xx / 10));
        json.put("pages",size);
        json.put("data",list);
        return json;
    }

    @RequestMapping("articleDetail")
    public String articleDetail(String articleId,HttpServletRequest request,HttpServletResponse response){
        Article article = articleService.findArticleById(articleId);
        HttpSession session = request.getSession();
        ManageUserBean dengUser = (ManageUserBean) session.getAttribute("userBean");//当前登录的用户
        ManageUserBean artUser = manageUserService.findArticleUserByArticleId(articleId);// 文章的用户信息
        List<PingLunDian> list = pingLunDianService.findBooleanPingLunDian(dengUser.getId());
        List<String> pingList = new ArrayList<>();
        List<String> reList = new ArrayList<>();
        for(PingLunDian i:list){
            if("1".equals(i.getDianType())){
                pingList.add(i.getPingLunId());
            }else{
                reList.add(i.getPingLunId());
            }
        }
        request.setAttribute("user",dengUser);
        request.setAttribute("artUser",artUser);
        request.setAttribute("pingList",pingList);
        request.setAttribute("reList",reList);
        request.setAttribute("article",article);
        request.setAttribute("articleId",articleId);

        return "article/articleDetail";
    }

    @RequestMapping("getAllPingLunByArticleId")
    @ResponseBody
    public JSONObject getAllPingLunByArticleId(String articleId,Integer page,HttpServletRequest request){
        List<PingLun> pingList = pingLunService.findAllPingLunByArticleId(articleId,(page-1)*10);
        int count = pingLunService.findAllPingLunOfArticleCount(articleId);
        double xx = count;
        JSONObject json = new JSONObject();
        int size = (int) ((xx%10==0)?xx/10: Math.ceil(xx / 10));
        json.put("pages",size);
        json.put("data",pingList);
        return json;
    }

    @RequestMapping("getAllReplayOfPingLun")
    @ResponseBody
    public List<Replay> getAllReplayOfPingLun(String pId){
        List<Replay> list = replayService.getAllReplayOfPingLun(pId);
        return list;
    }

    @RequestMapping("addPingLun")
    @ResponseBody
    public String addPingLun(PingLun pin,HttpServletRequest request){
        String userId = request.getSession().getAttribute(Constant.SESSION_USERID_LONG).toString();
        pin.setId(UUID.randomUUID().toString());
        pin.setTime(CommonUtil.getDateTimeString(new Date()));
        pin.setUserId(userId);
        pingLunService.addPingLun(pin);
        return "success";
    }

    @RequestMapping("addReplay")
    @ResponseBody
    public String addReplay(Replay replay,HttpServletRequest request){
        String userId = request.getSession().getAttribute(Constant.SESSION_USERID_LONG).toString();
        replay.setId(UUID.randomUUID().toString());
        replay.setReplayer(userId);
        replay.setTime(CommonUtil.getDateTimeString(new Date()));
        replayService.addReplay(replay);
        return "success";
    }

    @RequestMapping("changePingLunZan")
    @ResponseBody
    public String changePingLunZan(PingLunDian pingDian,String type,HttpServletRequest request){
        ManageUserBean userBean = (ManageUserBean) request.getSession().getAttribute("userBean");
        pingDian.setId(UUID.randomUUID().toString());
        pingDian.setUserId(userBean.getId());
        if("1".equals(type)){
//            加
            pingLunService.addPingLunDian(pingDian);
        }else{
//            减
            pingLunService.deletePingLunDian(pingDian);
        }
        return "success";
    }

    @RequestMapping("changeGuanZhu")
    @ResponseBody
    public String changeGuanZhu(String type,GuanZhu guanZhu,HttpServletRequest request){
        String userId = request.getSession().getAttribute(Constant.SESSION_USERID_LONG).toString();
        guanZhu.setId(UUID.randomUUID().toString());
        guanZhu.setTime(CommonUtil.getDateTimeString(new Date()));
        guanZhu.setUserId(userId);
        if("1".equals(type)){
//            加
            guanZhuService.addGuanZhu(guanZhu);
        }else{
            //减
            guanZhuService.deleteGuanZhu(guanZhu);
        }
        return "";
    }

}
