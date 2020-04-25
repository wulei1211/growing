package com.hhit.entity;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 15:32 2020/4/23
 * @Modified By:
 */
public class DianZan extends BaseBean{
    private String id;
    private String articleId;
    private String userId;
    private String time;
    private String dianType;


    public DianZan(){}

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

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getDianType() {
        return dianType;
    }

    public void setDianType(String dianType) {
        this.dianType = dianType;
    }

    public DianZan(String id, String articleId, String userId, String time, String dianType) {
        this.id = id;
        this.articleId = articleId;
        this.userId = userId;
        this.time = time;
        this.dianType = dianType;
    }
}
