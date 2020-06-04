package com.hhit.action;

import com.hhit.entity.Data;
import com.hhit.entity.GrowChuan;
import com.hhit.service.DataService;
import com.hhit.service.GrowChuanService;
import com.hhit.util.SpringBeanFactoryUtils;
import org.springframework.stereotype.Controller;

import java.util.Map;
import java.util.TimerTask;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 22:18 2020/5/8
 * @Modified By:
 */
@Controller
public class TestAction extends TimerTask {

//    private Timer timer = null;
//    private static boolean flag = false;
//
//    private static TestAction mybTimeTask = null;

    private Map<String, Data> d ;

    public static DataService dataService;

    public static GrowChuanService growChuanService;

    static{
        dataService = (DataService) SpringBeanFactoryUtils.getBean("dataService");
        growChuanService = (GrowChuanService) SpringBeanFactoryUtils.getBean("growChuanService");
    }

    public TestAction(){

    }

    public TestAction(Map<String, Data> d) {
        this.d = d;
    }

    @Override
    public void run() {
        int i = 0;
        String time = "";
        for (Map.Entry<String, Data> entry : d.entrySet()) {
            if(i==0){
                time = entry.getValue().getTime();
            }
            GrowChuan growChuan = growChuanService.findGrowByCid(entry.getKey());
            if(growChuan != null){
                entry.getValue().setGid(growChuan.getGrowId());
                entry.getValue().setTime(time);
                dataService.addData(entry.getValue());
            }
            i++;
        }

    }

    public Map<String, Data> getD() {
        return d;
    }

    public void setD(Map<String, Data> d) {
        this.d = d;
    }

//    public static TestAction getInstance(){
//        if (mybTimeTask == null || flag ) {
//            //当flag == true时，为了解决，timer.cancel()后，重新创建一个timer
//            mybTimeTask = new TestAction();
//            if (flag) {
//                flag = false;
//            }
//        }
//        return mybTimeTask;
//    }

}
