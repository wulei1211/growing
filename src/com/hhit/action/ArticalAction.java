package com.hhit.action;

import com.alibaba.fastjson.JSONObject;
import com.hhit.common.Constant;
import com.hhit.entity.*;
import com.hhit.service.*;
import com.hhit.util.CommonUtil;
import com.hhit.util.JsonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
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

    @Resource(name = "dianZanService")
    private DianZanService dianZanService;

    @Resource(name = "articleService")
    private ArticleService articleService;

    @Resource(name="dwrService")
    private IDwrService dwrService;

    @Resource(name = "replayService")
    private ReplayService replayService;

    @Resource(name = "pingLunService")
    private PingLunService pingLunService;

    @Resource(name = "articleTypeService")
    private ArticleTypeService articleTypeService;

    @Resource(name = "pingLunDianService")
    private PingLunDianService pingLunDianService;

    @Resource(name = "guanZhuService")
    private GuanZhuService guanZhuService;

    @Resource(name = "manageUserService")
    private ManageUserService manageUserService;

    @Resource(name = "myTaskService")
    private MyTaskService myTaskService;

    @RequestMapping("toArticalAdd")
    public String toArticalAdd(String articleId,HttpServletRequest request, HttpServletResponse response){
        if(articleId!=null && !"".equals(articleId)){
            Article article = articleService.findArticleById(articleId);
            String json = JsonUtil.getJsonString4JavaPOJO(article);
            request.setAttribute("articleMsg",json);
        }else{
            HttpSession session = request.getSession();
            String userId = session.getAttribute(Constant.SESSION_USERID_LONG).toString();
            request.setAttribute("userId",userId);
        }
        return "article/articleAdd";
    }

    @RequestMapping("articleAdd")
    @ResponseBody
    public String articleAdd(@RequestBody Article article,String type){
        if("1".equals(type)){
            // 添加文章
            UUID id = UUID.randomUUID();
            article.setId(id.toString());
            article.setCreateTime(CommonUtil.getDateTimeString(new Date()));
            article.setArticleCount(0);
            article.setArticleLove(0);
            articleService.articleAdd(article);
        }else{
            // 更新文章
            article.setEditTime(CommonUtil.getDateTimeString(new Date()));
            articleService.updateArticleById(article);
        }
        return "success";
    }


    @RequestMapping("articleDetail")
    public String articleDetail(String articleId,HttpServletRequest request,HttpServletResponse response){
        Article article = articleService.findArticleById(articleId);
        articleService.addLiuLanCount(article.getArticleCount()+1,articleId);
        HttpSession session = request.getSession();
        ManageUserBean dengUser = (ManageUserBean) session.getAttribute("userBean");//当前登录的用户
        ManageUserBean artUser = manageUserService.findArticleUserByArticleId(articleId);// 文章的用户信息
        int count = guanZhuService.findBooleanBeiGuan(dengUser.getId(),artUser.getId());
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
        request.setAttribute("booleanGuan",count);
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
        String dengLuId = request.getSession().getAttribute(Constant.SESSION_USERID_LONG).toString();
        List<PingLun> pingList = pingLunService.findAllPingLunByArticleId(dengLuId,articleId,(page-1)*10);
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
    public List<Replay> getAllReplayOfPingLun(String pId,HttpServletRequest request){
        String userId = request.getSession().getAttribute(Constant.SESSION_USERID_LONG).toString();
        List<Replay> list = replayService.getAllReplayOfPingLun(userId,pId);
        return list;
    }

    @RequestMapping("addPingLun")
    @ResponseBody
    public String addPingLun(PingLun pin,String articleMasterId,HttpServletRequest request){
        String userId = request.getSession().getAttribute(Constant.SESSION_USERID_LONG).toString();
        pin.setId(UUID.randomUUID().toString());
        pin.setTime(CommonUtil.getDateTimeString(new Date()));
        pin.setUserId(userId);
        pingLunService.addPingLun(pin);

        if(!articleMasterId.equals(pin.getUserId())){
            MyTask task = new MyTask();
            String id = UUID.randomUUID().toString();
            task.setId(id);
            task.setCreateTime(CommonUtil.getDateTimeString(new Date()));
            task.setContent(pin.getPingLunContent());
            task.setSendId(pin.getUserId());
            task.setReceiveId(articleMasterId);
            task.setStatus("0");
            task.setType("1");
            myTaskService.addMsg(task);
            dwrService.send(articleMasterId,JSONObject.toJSONString(new MsgParam(id,"您的文章有一条新评论")));
        }
        return "success";
    }

    @RequestMapping("addReplay")
    @ResponseBody
    public String addReplay(@RequestBody Replay replay,HttpServletRequest request){
        String userId = request.getSession().getAttribute(Constant.SESSION_USERID_LONG).toString();
        replay.setId(UUID.randomUUID().toString());
        replay.setReplayer(userId);
        replay.setTime(CommonUtil.getDateTimeString(new Date()));
        replayService.addReplay(replay);

        if(!userId.equals(replay.getToPlayer())){
            MyTask task = new MyTask();
            String id = UUID.randomUUID().toString();
            task.setId(id);
            task.setCreateTime(CommonUtil.getDateTimeString(new Date()));
            task.setContent(replay.getReplayContent());
            task.setSendId(userId);
            task.setReceiveId(replay.getToPlayer());
            task.setStatus("0");
            task.setType("2");
            myTaskService.addMsg(task);
            dwrService.send(replay.getToPlayer(),JSONObject.toJSONString(new MsgParam(id,"您的评论有一条新回复")));
        }
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

    @RequestMapping("toPerson")
    public String toPerson(String userId,HttpServletRequest request){
        ManageUserBean dianUser = manageUserService.findUserBeanById(userId);//点进去的用户
        ManageUserBean dengUser = (ManageUserBean) request.getSession().getAttribute("userBean");
        List<DianZan> list =  dianZanService.findDianZanArticle(dengUser.getId());

        List<String> ids = new ArrayList<>();//我的点赞
        List<String> shous = new ArrayList<>();//我的收藏
        for (int i = 0;i<list.size();i++){
            if("1".equals(list.get(i).getDianType())){
                ids.add(list.get(i).getArticleId());
            }else{
                shous.add(list.get(i).getArticleId());
            }
        }
        request.setAttribute("user",dianUser);
        request.setAttribute("dengUser",dengUser);
        request.setAttribute("shoucangs",shous);
        request.setAttribute("dianzans",ids);
        return "article/person";
    }

    @RequestMapping("deleteArticle")
    @ResponseBody
    public String deleteArticle(String articleId){
        articleService.deleteArticleById(articleId);
        pingLunService.deleteArticlesPingLun(articleId);
        replayService.deleteArticlesReplay(articleId);
        return "success";
    }

    @RequestMapping("allArticlePing")
    @ResponseBody
    public JSONObject allArticlePing(Integer page, String userId,HttpServletRequest request){
        ManageUserBean userBean = (ManageUserBean) request.getSession().getAttribute("userBean");
        JSONObject json = new JSONObject();
//        if("2".equals(type)) {
            List<PingLun> list = pingLunService.findAllPingLunByUserId(userId, (page - 1) * 10);
            List<PingLun> listAll = pingLunService.findAllPingLunByUserId(userId, null);
            int count = 0;
            for (PingLun i : listAll) {
                count += i.getReplayCount();
            }
            double xx = count;
            int size = (int) ((xx % 10 == 0) ? xx / 10 : Math.ceil(xx / 10));
            json.put("pages", size);
            json.put("data", list);
//        }else{
//            List<PingLun> pingList = pingLunService.findAllPingLunByUserId(userId,(page-1)*10);
//        }
        return json;
    }

    @RequestMapping("allArticle")
    @ResponseBody
    public JSONObject findAllArticle(String articleTitle,String guanzhu,String articleType,String master,String shouCang,Integer page){
        List<Article> list = articleService.findAllArticle(articleTitle,guanzhu,articleType,master,shouCang,(page-1)*10);

        int count = articleService.findAllArticleCount(articleTitle,guanzhu,articleType,master,shouCang,null);
        double xx = count;
        JSONObject json = new JSONObject();
        int size = (int) ((xx%10==0)?xx/10: Math.ceil(xx / 10));
        json.put("pages",size);
        json.put("data",list);
        return json;
    }

    @RequestMapping("articleDetailReact")
    @ResponseBody
    public JSONObject articleDetailReact(String articleId,HttpServletRequest request){
        Article article = articleService.findArticleById(articleId);
        ManageUserBean dengUser = (ManageUserBean) request.getSession().getAttribute("userBean");//登录的用户
        int count = guanZhuService.checkBooleanGuan(dengUser.getId(),article.getMaster());
        boolean flag = true;
        JSONObject json = new JSONObject();
        flag = count>0?true:false;
        json.put("articleMsg",article);
        json.put("booleanGuan",flag);
        return json;
    }

    @RequestMapping("deletePing")
    @ResponseBody
    public String deletePing(String pId){
        pingLunService.deletePing(pId);
        replayService.deletePingLunsReplay(pId);
        return "success";
    }

    @RequestMapping("checkBooleanDian")
    @ResponseBody
    public JSONObject checkBooleanDian(String articleId,HttpServletRequest request){
        JSONObject json = new JSONObject();
        ManageUserBean userBean = (ManageUserBean) request.getSession().getAttribute("userBean");
        List<DianZan> list = dianZanService.checkBooleanDian(articleId,userBean.getId());
        json.put("dian",list);
        return json;
    }

    @RequestMapping("readMsg")
    @ResponseBody
    public void readMsg(String msgId,HttpServletRequest request){
        String userId = request.getSession().getAttribute(Constant.SESSION_USERID_LONG).toString();
        myTaskService.readMsg(msgId,userId);
    }

    @RequestMapping("toAllArticleList")
    public String toAllArticleList(HttpServletRequest request){
        List<ArticleType> artTypeList = articleTypeService.findAllArticleType();
        request.setAttribute("artTypeList",JsonUtil.getJsonString4JavaList(artTypeList));
        return "article/articleList";
    }

    @RequestMapping("getAllArticles")
    @ResponseBody
    public MMGridPageVoBean<Article> getAllArticles(Article article){
        MMGridPageVoBean<Article> data = new MMGridPageVoBean<>();
        int count = articleService.getAllArticlesCount(article);
        int from = (article.getPage()-1) * article.getLimit();
        article.setFromNum(from);
        List<Article> list = articleService.getAllArticles(article);

        data.setCount(count+"");
        data.setCode("0");
        data.setData(list);
        data.setMsg("");
        return data;
    }

    @RequestMapping("toAllPingLun")
    public String toAllPingLun(){
        return "article/pingLunList";
    }

    @RequestMapping("getAllPingLun")
    @ResponseBody
    public MMGridPageVoBean<PingLun> getAllPingLun(PingLun paramUser){


        int size = pingLunService.getPingLunCount(paramUser);

        //放入分页
        int from = (paramUser.getPage()-1) * paramUser.getLimit();

        paramUser.setFromNum(from);

        List<PingLun> data = pingLunService.getAllPingLun(paramUser);

        MMGridPageVoBean<PingLun> vo = new MMGridPageVoBean<PingLun>();
        vo.setCount(size+"");
        vo.setCode("0");
        vo.setData(data);
        vo.setMsg("");
        return vo;
    }

    @RequestMapping("toAllReplay")
    public String toAllReplay(){
        return "article/replayLst";
    }

    @RequestMapping("getAllReplay")
    @ResponseBody
    public MMGridPageVoBean<PingLun> getAllReplay(Replay paramUser){

        int size = replayService.findReplayCount(paramUser);
        //放入分页
        int from = (paramUser.getPage()-1) * paramUser.getLimit();

        paramUser.setFromNum(from);

        List<PingLun> data = replayService.findAllReplay(paramUser);

        MMGridPageVoBean<PingLun> vo = new MMGridPageVoBean<PingLun>();
        vo.setCount(size+"");
        vo.setCode("0");
        vo.setData(data);
        vo.setMsg("");
        return vo;
    }

}
