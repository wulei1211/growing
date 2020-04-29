package com.hhit.service;

import com.hhit.interceptor.DwrMessagePush;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author shkstart
 * @create 2019-11-09 14:00
 */
@Service("dwrService")
public class DwrService implements IDwrService {
    @Resource(name="dwrMessagePush")
    private DwrMessagePush dwrMessagePush;


//    将消息发送给具体哪个人
    public void send(String username,String mess) {
        dwrMessagePush.sendMessageAuto(username,mess);
    }
}
