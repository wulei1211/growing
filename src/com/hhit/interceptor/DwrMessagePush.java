package com.hhit.interceptor;

import com.hhit.util.DwrScriptSessionManagerUtil;
import org.directwebremoting.*;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import java.util.Collection;

/**
 * @author shkstart
 * @create 2019-11-09 14:22
 */
@Component("dwrMessagePush")
public class DwrMessagePush {
    public void onPageLoad(String userId) {
        ScriptSession scriptSession = WebContextFactory.get().getScriptSession();
        scriptSession.setAttribute("userId", userId);
        //注册一个dwr ScriptSession,  并用DwrScriptSessionManagerUtil管理
        System.out.println("注册ID  " + userId);
        DwrScriptSessionManagerUtil dwrScriptSessionManagerUtil = new DwrScriptSessionManagerUtil();
        try {
            dwrScriptSessionManagerUtil.init();
        } catch (ServletException e) {
            e.printStackTrace();
        }
    }
    //过滤 dwr ScriptSession，满足条件（userid相同）发送消息
    //调用页面的showMessage方法，打印消息
    //满足过滤器的 ScriptSession 遍历，发送消息
    //发送消息
    public void sendMessageAuto(String userid, String message) {
        final String userId = userid;
        final String autoMessage = message;
        System.out.println("sendMessageAuto  " + userId + " " + autoMessage);
        Browser.withAllSessionsFiltered(new ScriptSessionFilter() {
        public boolean match(ScriptSession session) {
            if (session.getAttribute("userId") == null) {
                return false;
            } else {
                return (session.getAttribute("userId")).equals(userId);
            }
        }
    }, new Runnable() {
        private ScriptBuffer script = new ScriptBuffer();
        public void run() {
            script.appendCall("showMessage", message);
            Collection<ScriptSession> sessions = Browser.getTargetSessions();
            for (ScriptSession scriptSession : sessions) {
                scriptSession.addScript(script);
            }
        }
    }
        );
    }
}
