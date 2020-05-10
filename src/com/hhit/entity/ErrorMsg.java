package com.hhit.entity;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 21:17 2020/5/8
 * @Modified By:
 */
public class ErrorMsg extends BaseBean {
    private String id;
    private String gid;
    private String cid;
    private String msg;
    private String time;
    private String userId;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public ErrorMsg(){}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getGid() {
        return gid;
    }

    public void setGid(String gid) {
        this.gid = gid;
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public ErrorMsg(String id, String gid, String cid, String msg, String time) {
        this.id = id;
        this.gid = gid;
        this.cid = cid;
        this.msg = msg;
        this.time = time;
    }
}
