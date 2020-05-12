package com.hhit.entity;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 14:06 2020/5/6
 * @Modified By:
 */
public class Chuan extends BaseBean{
    private String id;
    private String cname;
    private String status;
    private String userId;


    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Chuan(){}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Chuan(String id, String cname, String status, String userId) {
        this.id = id;
        this.cname = cname;
        this.status = status;
        this.userId = userId;
    }
}
