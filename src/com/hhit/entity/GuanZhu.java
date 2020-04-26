package com.hhit.entity;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 16:04 2020/4/26
 * @Modified By:
 */
public class GuanZhu extends BaseBean {
    private String id;
    private String userId;
    private String beiGuan;
    private String time;

    public GuanZhu(){}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getBeiGuan() {
        return beiGuan;
    }

    public void setBeiGuan(String beiGuan) {
        this.beiGuan = beiGuan;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public GuanZhu(String id, String userId, String beiGuan, String time) {
        this.id = id;
        this.userId = userId;
        this.beiGuan = beiGuan;
        this.time = time;
    }
}
