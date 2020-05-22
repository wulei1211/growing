package com.hhit.action;

import com.alibaba.fastjson.JSONObject;
import com.hhit.common.Constant;
import com.hhit.entity.*;
import com.hhit.service.*;
import com.hhit.util.CommonUtil;
import com.hhit.util.JsonUtil;
import com.yang.serialport.manager.SerialPortManager;
import com.yang.serialport.utils.ShowUtils;
import gnu.io.PortInUseException;
import gnu.io.SerialPort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 22:39 2020/5/4
 * @Modified By:
 */
@Controller
@RequestMapping("chuan")
public class ChuanAction {


    //串口对象
    private SerialPort mSerialport;

    private String userId;

    private static String s;

    private GrowChuan growChuan = null;

    private Map<String,Data> map = new HashMap<>();

    private static Data d = null;

    private Timer timer = new Timer();

    private TestAction testAction = new TestAction();

    private boolean flag = false;

    @Resource(name="dwrService")
    private IDwrService dwrService;

    @Resource(name="growChuanService")
    private GrowChuanService growChuanService;

    @Resource(name="dataService")
    private DataService dataService;

    @Resource(name="dingService")
    private DingService dingService;

    @Resource(name="errorMsgService")
    private ErrorMsgService errorMsgService;

    @Resource(name="growsService")
    private GrowsService growsService;

    @Resource(name="chuanService")
    private ChuanService chuanService;


    @RequestMapping("getData")
    @ResponseBody
    public void getData(){

        // 串口列表
        List<String> mCommList = null;
//        // 获取串口名称
        mCommList = SerialPortManager.findPorts();
        String commName = mCommList.get(0);
        // 获取波特率，默认为9600
        int baudrate = 9600;
        String bps = "115200";
        baudrate = Integer.parseInt(bps);

        // 检查串口名称是否获取正确
        if (commName == null || commName.equals("")) {
            ShowUtils.warningMessage("没有搜索到有效串口！");
        } else {
            try {
                mSerialport = SerialPortManager.openPort(commName, baudrate);
            } catch (PortInUseException e) {
//                ShowUtils.warningMessage("串口已被占用！");
            }
        }

        // 添加串口监听
        SerialPortManager.addListener(mSerialport, new SerialPortManager.DataAvailableListener() {

            @Override
            public void dataAvailable() {
                byte[] data = null;
                try {
                    if (mSerialport == null) {
                        ShowUtils.errorMessage("串口对象为空，监听失败！");
                    } else {
                        // 读取串口数据
                        data = SerialPortManager.readFromPort(mSerialport);
                        s = new String(data);
                        dwrService.send(userId,s );
                        d = changData(s);
                        map = updateData(d.getCid(),d);
                        testAction.setD(map);
//                        d.setTime(CommonUtil.getDateTimeString(new Date()));
//                        dataService.addData(d);
                    }
                } catch (Exception e) {
                    System.out.println(e.toString());
//                    ShowUtils.errorMessage(e.toString());
//                    System.exit(0);
                }
            }
        });
    }

    public Map<String, Data> updateData(String cid, Data d){
        for (Map.Entry<String, Data> entry : map.entrySet()) {
            if(cid.equals(entry.getKey())){
                entry.setValue(d);
            }
        }
        return map;
    }


    @RequestMapping("toJianCe")
    public String toJianCeCenter(HttpServletRequest request){
        userId = request.getSession().getAttribute(Constant.SESSION_USERID_LONG).toString();
        request.setAttribute("status","1");
        return "jianCe/jianCe";
    }

    @RequestMapping("toSaoChuan")
    public String toSaoChuan(){
        return "jianCe/saoChuan";
    }

    @RequestMapping("toManagerGrow")
    public String toManagerGrow(HttpServletRequest request){
        userId = request.getSession().getAttribute(Constant.SESSION_USERID_LONG).toString();
        request.setAttribute("status","1");
        Ding d = dingService.findDingByUserId(userId);
        request.setAttribute("ding",JsonUtil.getJsonString4JavaPOJO(d));
        List<Chuan> list = chuanService.findAllChuan();
        for(Chuan c : list){
            map.put(c.getId(),new Data());
        }
        if(d!=null){
            ceShi(d.getDing());
        }else{
            ceShi("3");
        }
        return "jianCe/managerGrow";
    }

    @RequestMapping("getAllChuanReact")
    @ResponseBody
    public JSONObject getAllChuanReact(Chuan param){
        param.setUserId(userId);
        List<Chuan> data = chuanService.getNoUseChuan(param);
        JSONObject json = new JSONObject();
        json.put("chuanList",data);
        return json;
    }

    @RequestMapping("getAllChuan")
    @ResponseBody
    public MMGridPageVoBean<Chuan> getAllChuan(HttpServletRequest request, Chuan paramUser){
        //int page, int pageSize, String name, String loginId, String departmentId, String status, String roleId, String roleNot

        paramUser.setUserId(userId);

        int size = chuanService.getAllChuanCount(paramUser);

        //放入分页
        int from = (paramUser.getPage()-1) * paramUser.getLimit();

        paramUser.setFromNum(from);

        List<Chuan> data = chuanService.getAllChuan(paramUser);

        MMGridPageVoBean<Chuan> vo = new MMGridPageVoBean<>();
        vo.setCount(size+"");
        vo.setCode("0");
        vo.setData(data);
        vo.setMsg("");
        return vo;
    }


    @RequestMapping("toChuanList")
    public String toChuanList(HttpServletRequest request){
        userId = request.getSession().getAttribute(Constant.SESSION_USERID_LONG).toString();
        List<Chuan> data = chuanService.getAllChuan(new Chuan());
        List<String> chuanList = new ArrayList<>();
        for(Chuan c:data){
            chuanList.add(c.getId());
        }
        request.setAttribute("chuanList",JsonUtil.getJsonString4JavaList(chuanList));
        return "jianCe/chuanList";
    }

    @RequestMapping("closeDate")
    @ResponseBody
    public void closeDate(){
        SerialPortManager.closePort(mSerialport);
        mSerialport = null;
    }




    @RequestMapping("toAllZhong")
    public String toAllZhong(){
        return "jianCe/allZhong";
    }

    @RequestMapping("getAllZhong")
    @ResponseBody
    public MMGridPageVoBean<Grows> getAllChuan(HttpServletRequest request, Grows paramUser){
        //int page, int pageSize, String name, String loginId, String departmentId, String status, String roleId, String roleNot

        paramUser.setUserId(userId);
        int size = growsService.getAllChuanCount(paramUser);

        //放入分页
        int from = (paramUser.getPage()-1) * paramUser.getLimit();

        paramUser.setFromNum(from);

        List<Grows> data = growsService.getAllChuan(paramUser);

        MMGridPageVoBean<Grows> vo = new MMGridPageVoBean<>();
        vo.setCount(size+"");
        vo.setCode("0");
        vo.setData(data);
        vo.setMsg("");
        return vo;
    }

    @RequestMapping("toAddPeng")
    public String toAddPeng(HttpServletRequest request){
        List<Chuan> list = chuanService.getNoUseChuan(new Chuan(null,null,null,userId));
        request.setAttribute("chuanList",JsonUtil.getJsonString4JavaList(list));
        return "jianCe/addPeng";
    }

    @RequestMapping("addPeng")
    @ResponseBody
    public String addPeng(@RequestBody Grows grows){
        grows.setUserId(userId);
        String gid = UUID.randomUUID().toString();
        grows.setId(gid);
        growsService.addPeng(grows);
        if(grows.getChuanId()!=null && !"".equals(grows.getChuanId())){
            String[] arr = grows.getChuanId().split(";");
            String[] pos = grows.getPosition().split(";");
            GrowChuan growChuan = new GrowChuan();
            for(int i = 0;i<arr.length;i++){
                growChuan.setId(UUID.randomUUID().toString());
                growChuan.setGrowId(gid);
                growChuan.setChuanId(arr[i]);
                growChuanService.addGrowChuan(growChuan);
                chuanService.updateChuanPosition(arr[i],pos[i]);
            }
        }
        return "success";
    }

    @RequestMapping("checkChuanNoUse")
    @ResponseBody
    public String checkChuanNoUse(){
        List<Chuan> list = chuanService.getNoUseChuan(new Chuan(null,null,null,userId));
        return list.size()+"";
    }

    @RequestMapping("checkGrowName")
    @ResponseBody
    public String checkGrowName(String growName){
        int count = growsService.checkGrowName(growName,userId);
        return count+"";
    }

    @RequestMapping("toPengEidt")
    public String toPengEidt(String pId,HttpServletRequest request){
        Grows grows = growsService.getGrowsById(pId);
        List<Chuan> list = chuanService.getNoUseChuan(new Chuan(null,null,null,userId));
        request.setAttribute("grows",JsonUtil.getJsonString4JavaPOJO(grows));
        request.setAttribute("chuanList",JsonUtil.getJsonString4JavaList(list));
        return "jianCe/pengEdit";
    }

    @RequestMapping("growUpdateReact")
    @ResponseBody
    public String growUpdateReact(Grows grows){
        growChuanService.deleteAllGrowChuan(grows.getId());
        if(grows.getChuanId() != null && !"".equals(grows.getChuanId())){
            String[] arr = grows.getChuanId().split(";");
            GrowChuan growChuan = new GrowChuan();
            for(int i = 0;i<arr.length;i++){
                growChuan.setId(UUID.randomUUID().toString());
                growChuan.setGrowId(grows.getId());
                growChuan.setChuanId(arr[i]);
                growChuanService.addGrowChuan(growChuan);
            }
        }
        growsService.updateGrow(grows);
        return "success";
    }

    @RequestMapping("growUpdate")
    @ResponseBody
    public String growUpdate(Grows grows){

        List<GrowChuan> list = growChuanService.findGrowChuanById(grows.getId());
        for(GrowChuan c:list){
            chuanService.updateChuanPosition(c.getChuanId(),"");
        }
        growChuanService.deleteAllGrowChuan(grows.getId());
        if(grows.getChuanId() != null && !"".equals(grows.getChuanId())){
            String[] arr = grows.getChuanId().split(";");
            String[] pos = grows.getPosition().split(";");
            GrowChuan growChuan = new GrowChuan();
            for(int i = 0;i<arr.length;i++){
                growChuan.setId(UUID.randomUUID().toString());
                growChuan.setGrowId(grows.getId());
                growChuan.setChuanId(arr[i]);
                growChuanService.addGrowChuan(growChuan);
                chuanService.updateChuanPosition(arr[i],pos[i]);
            }
        }
        growsService.updateGrow(grows);
        return "success";
    }

    @RequestMapping("growDel")
    @ResponseBody
    public String growDel(String id){
        growsService.deleteGrowById(id);
        growChuanService.deleteAllGrowChuan(id);
        return "success";
    }

    @RequestMapping("toJianCePingTai")
    public String toJianCePingTai(HttpServletRequest request){
        int chuanCount = chuanService.getAllChuanCount(new Chuan(null,null,null,userId));
        List<Grows> growsList = growsService.getAllChuan(new Grows(null,null,null,userId));

        request.setAttribute("chuanCount",chuanCount);
        request.setAttribute("growCount",growsList.size());
        request.setAttribute("growsList",JsonUtil.getJsonString4JavaList(growsList));
        return "jianCe/jianCePingTai";
    }

    @RequestMapping("toPeiAll")
    public String toPeiAll(){
        return "jianCe/peiAll";
    }

    @RequestMapping("peiAllParam")
    @ResponseBody
    public String peiAllParam(Grows grows){
        growsService.peiAllParam(grows);
        return "success";
    }
    public Data changData(String data){
//        ID:2 Temp:28 Humi:57 Light:128 MQ2:4  Time:0
        String cid = data.substring(data.indexOf("ID:")+3,data.indexOf("Temp:")).trim();
//        growChuan = growChuanService.findGrowByCid(cid);
//        if(growChuan == null){return null;}
        String wen = data.substring(data.indexOf("Temp:")+5,data.indexOf("Humi:")).trim();
        String er = data.substring(data.indexOf("MQ2:")+4,data.indexOf("Time:")).trim();
        String shi = data.substring(data.indexOf("Humi:")+5,data.indexOf("Light:")).trim();
        String guang = data.substring(data.indexOf("Light:")+6,data.indexOf("MQ2:")).trim();
        d = new Data(wen,shi,guang,er);
        d.setCid(cid);
        d.setId(UUID.randomUUID().toString());
        d.setTime(CommonUtil.getDateTimeString(new Date()));
        return d;
    }

    @RequestMapping("findGrowsDataById")
    @ResponseBody
    public JSONObject findGrowsDataById(String gid,String cid){
        JSONObject json = new JSONObject();
        List<Data> list = dataService.findGrowsDataById(gid,cid);
        json.put("dataList",list);
        return json;
    }


    @RequestMapping("addError")
    @ResponseBody
    public void addError(String gid,String cid,String type,String val,HttpServletRequest request){
        ManageUserBean user = (ManageUserBean) request.getSession().getAttribute("userBean");
        String str = "";
        if("wen".equals(type)){
            str = "温度数值异常，数值为："+val;
        }else if("shi".equals(type)){
            str = "湿度数值异常，数值为："+val;
        }else if("guang".equals(type)){
            str = "光照数值异常，数值为："+val;
        }else{
            str = "二氧化碳数值异常，数值为："+val;
        }
        ErrorMsg e = new ErrorMsg();
        e.setId(UUID.randomUUID().toString());
        e.setGid(gid);
        e.setCid(cid);
        e.setTime(CommonUtil.getDateTimeString(new Date()));
        e.setMsg(str);
        e.setUserId(userId);
        errorMsgService.addError(e);
        sendEmail(user.getEmail(),gid+"出现预警信息",cid+str+",请尽快前去查看！！");
    }

    @RequestMapping("toErrorMsgList")
    public String toErrorMsgList(){
        return "jianCe/errorMsgList";
    }

    @RequestMapping("getErrorList")
    @ResponseBody
    public MMGridPageVoBean<ErrorMsg> getErrorList(ErrorMsg paramUser){

        paramUser.setUserId(userId);
        int size = errorMsgService.getErrorListCount(paramUser);

        //放入分页
        int from = (paramUser.getPage()-1) * paramUser.getLimit();

        paramUser.setFromNum(from);

        List<ErrorMsg> data = errorMsgService.getErrorList(paramUser);

        MMGridPageVoBean<ErrorMsg> vo = new MMGridPageVoBean<>();
        vo.setCount(size+"");
        vo.setCode("0");
        vo.setData(data);
        vo.setMsg("");
        return vo;
    }

    @RequestMapping("getErrorListReact")
    @ResponseBody
    public JSONObject getErrorListReact(ErrorMsg paramUser){

        paramUser.setUserId(userId);

        List<ErrorMsg> data = errorMsgService.getErrorList(paramUser);

        JSONObject json = new JSONObject();
        json.put("data",data);
        return json;
    }


    @RequestMapping("caiJiData")
    @ResponseBody
    public String ceShi(String time){
        if(flag){
            timer.cancel();
            timer.purge();
            timer = new Timer();
            testAction = new TestAction(map);
            flag = true;
        }else{
            flag = true;
        }
        timer.schedule(testAction,Long.parseLong(time)*60*1000,Long.parseLong(time)*60* 1000);
        return "success";
    }

    @RequestMapping("addDing")
    @ResponseBody
    public String addDing(String time){

        Ding d = new Ding();
        d.setId(UUID.randomUUID().toString());
        d.setUserId(userId);
        d.setDing(time);
        dingService.deleteDingByUserId(userId);
        dingService.addDing(d);

        return "success";
    }

    @RequestMapping("updateChuanStatus")
    @ResponseBody
    public String updateChuanStatus(Chuan chuan){
        chuanService.updateChuanStatus(chuan);
        return "success";
    }

    @RequestMapping("toHistroyData")
    public String toHistroyData(HttpServletRequest request, HttpServletResponse response){
        Grows g = new Grows();
        g.setUserId(userId);
        List<Grows> growsList = growsService.getAllChuan(g);



        request.setAttribute("growsList",JsonUtil.getJsonString4JavaList(growsList));
        request.setAttribute("userId",userId);

        return "jianCe/histroyData";
    }

    @RequestMapping("getChuanListByGrowId")
    @ResponseBody
    public JSONObject getChuanListByGrowId(String gid){
        List<Chuan> chuanList = chuanService.getChuanListByGrowId(gid);
        JSONObject json = new JSONObject();
        json.put("chuanList",chuanList);
        return json;
    }


    @RequestMapping("getGrowsChuanById")
    @ResponseBody
    public JSONObject getGrowsChuanById(String gid,String cids,String startTime,String endTime){
        JSONObject json = new JSONObject();
        List<Data> data = new ArrayList<>();
        List<Data> list = new ArrayList<>();
        if(cids != null && cids != ""){
            String[] arr = cids.split(";");
            for(String cid:arr){
                data = dataService.getGrowsChuanById(gid,cid,startTime,endTime);
                list.addAll(data);
            }
            json.put("data",list);
        }else{
            data = dataService.getGrowsChuanById(gid,cids,startTime,endTime);
            json.put("data",data);
        }
        json.put("data",list);
        return json;
    }

    @RequestMapping("getGrowParamById")
    @ResponseBody
    public JSONObject getGrowParamById(String pId){
        Grows grows = growsService.getGrowsById(pId);
        JSONObject json = new JSONObject();
        json.put("grow",grows);
        return json;
    }

    @RequestMapping("getDateReact")
    @ResponseBody
    public JSONObject getDateReact(){
        JSONObject json = new JSONObject();
        json.put("data",d);
        return json;
    }


    @RequestMapping("addChuan")
    @ResponseBody
    public String  addChuan(@RequestBody Chuan chuan){
        chuan.setStatus("0");
        chuan.setUserId(userId);
        chuanService.addChuan(chuan);
        return "success";
    }

    @RequestMapping("addChuanReact")
    @ResponseBody
    public String addChuanReact(String gid,String cid,String poistion){
        String[] arr = cid.split(";");
        String[] pos = poistion.split(";");
        GrowChuan growChuan = new GrowChuan();
        for(int i = 0;i<arr.length;i++){
            growChuan.setId(UUID.randomUUID().toString());
            growChuan.setGrowId(gid);
            growChuan.setChuanId(arr[i]);
            growChuanService.addGrowChuan(growChuan);
            chuanService.updateChuanPosition(arr[i],pos[i]);
        }
        return "success";
    }

    @RequestMapping("deleteChuanReact")
    @ResponseBody
    public String deleteChuanReact(String gid,String cid){
        growChuanService.deleteGrowsChuanById(gid,cid);
        return "success";
    }

    public void sendEmail(String email,String title,String content) {
        Properties properties = new Properties();
        properties.put("mail.transport.protocol", "smtp");// 连接协议
        properties.put("mail.smtp.host", "smtp.qq.com");// 主机名
        properties.put("mail.smtp.port", 465);// 端口号
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.ssl.enable", "true");// 设置是否使用ssl安全连接 ---一般都使用
        properties.put("mail.debug", "true");// 设置是否显示debug信息 true 会在控制台显示相关信息
        Session session = Session.getInstance(properties);
        Message message = new MimeMessage(session);
        try{
            message.setFrom(new InternetAddress(email));
//        message.setRecipients(Message.RecipientType.TO, new InternetAddress[]{new InternetAddress("xxx@qq.com"),new InternetAddress("xxx@qq.com"),new InternetAddress("xxx@qq.com")});
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));//一个收件人
            message.setSubject(title);
            message.setText(content);
            Transport transport = session.getTransport();
            transport.connect("1468631228@qq.com", "lqavouzgkktngigc");// 密码为QQ邮箱开通的stmp服务后得到的客户端授权码
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();
        }catch (MessagingException e){

        }
    }
}
