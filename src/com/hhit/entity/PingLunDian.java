package com.hhit.entity;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 21:30 2020/4/25
 * @Modified By:
 */
public class PingLunDian extends BaseBean {
    private String id;
    private String pingLunId;
    private String userId;
    private String dianType;

    public PingLunDian(){}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPingLunId() {
        return pingLunId;
    }

    public void setPingLunId(String pingLunId) {
        this.pingLunId = pingLunId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getDianType() {
        return dianType;
    }

    public void setDianType(String dianType) {
        this.dianType = dianType;
    }

    public PingLunDian(String id, String pingLunId, String userId, String dianType) {
        this.id = id;
        pingLunId = pingLunId;
        this.userId = userId;
        this.dianType = dianType;
    }
}
