package com.hhit.action;

import com.hhit.entity.Data;
import com.hhit.service.DataService;
import com.hhit.util.SpringBeanFactoryUtils;
import org.springframework.stereotype.Controller;

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

    private Data d ;

    public static DataService dataService;

    static{
        dataService = (DataService) SpringBeanFactoryUtils.getBean("dataService");
    }

    public TestAction(){

    }

    public TestAction(Data d) {
        this.d = d;
    }

    @Override
    public void run() {
        System.out.println(11);
        if(d != null){
            dataService.addData(d);
        }
    }

    public Data getD() {
        return d;
    }

    public void setD(Data d) {
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
