package com.hhit.entity;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:02 2020/5/2
 * @Modified By:
 */
public class MyTask {
    private String id;
    private String sendId;
    private String receiveId;
    private String type;
    private String status;
    private String url;
    private String createTime;
    private String content;

    private ManageUserBean userBean;//发送的用户信息

    public ManageUserBean getUserBean() {
        return userBean;
    }

    public void setUserBean(ManageUserBean userBean) {
        this.userBean = userBean;
    }

    public MyTask(){}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSendId() {
        return sendId;
    }

    public void setSendId(String sendId) {
        this.sendId = sendId;
    }

    public String getReceiveId() {
        return receiveId;
    }

    public void setReceiveId(String receiveId) {
        this.receiveId = receiveId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public MyTask(String id, String sendId, String receiveId, String type, String status, String url, String createTime, String content) {
        this.id = id;
        this.sendId = sendId;
        this.receiveId = receiveId;
        this.type = type;
        this.status = status;
        this.url = url;
        this.createTime = createTime;
        this.content = content;
    }
}
