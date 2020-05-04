package com.hhit.entity;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 21:57 2020/5/2
 * @Modified By:
 */
public class MsgParam {
    private String id;
    private String content;

    public MsgParam(){}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public MsgParam(String id, String content) {
        this.id = id;
        this.content = content;
    }
}
