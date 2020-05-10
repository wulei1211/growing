package com.hhit.entity;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 15:04 2020/5/9
 * @Modified By:
 */
public class Ding extends BaseBean{
    private String id;
    private String ding;
    private String userId;

    public Ding(){}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDing() {
        return ding;
    }

    public void setDing(String ding) {
        this.ding = ding;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Ding(String id, String ding, String userId) {
        this.id = id;
        this.ding = ding;
        this.userId = userId;
    }
}
