package com.hhit.entity;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:09 2020/4/24
 * @Modified By:
 */
public class PingLun extends BaseBean {
    private String id;
    private String articleId;
    private String userId;
    private String pingLunContent;
    private String time;


    private String headImg;
    private String realName;

    private Integer pingLunDianCount;

    private Integer replayCount;

    private List<Replay> repLayList;

    private Article article;

    private Integer booleanDian;

    public Integer getBooleanDian() {
        return booleanDian;
    }

    public void setBooleanDian(Integer booleanDian) {
        this.booleanDian = booleanDian;
    }

    public Article getArticle() {
        return article;
    }

    public void setArticle(Article article) {
        this.article = article;
    }

    public List<Replay> getRepLayList() {
        return repLayList;
    }

    public void setRepLayList(List<Replay> repLayList) {
        this.repLayList = repLayList;
    }

    public Integer getPingLunDianCount() {
        return pingLunDianCount;
    }

    public void setPingLunDianCount(Integer pingLunDianCount) {
        this.pingLunDianCount = pingLunDianCount;
    }

    public Integer getReplayCount() {
        return replayCount;
    }

    public void setReplayCount(Integer replayCount) {
        this.replayCount = replayCount;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public PingLun(){}

    public String getHeadImg() {
        return headImg;
    }

    public void setHeadImg(String headImg) {
        this.headImg = headImg;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getArticleId() {
        return articleId;
    }

    public void setArticleId(String articleId) {
        this.articleId = articleId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPingLunContent() {
        return pingLunContent;
    }

    public void setPingLunContent(String pingLunContent) {
        this.pingLunContent = pingLunContent;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public PingLun(String id, String articleId, String userId, String pingLunContent, String time) {
        this.id = id;
        this.articleId = articleId;
        this.userId = userId;
        this.pingLunContent = pingLunContent;
        this.time = time;
    }
}
