package com.hhit.entity;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 23:52 2020/4/21
 * @Modified By:
 */
public class Article extends BaseBean {
    private String id;
    private String articleType;
    private String articleTitle;
    private String articleContent;
    private Integer articleCount;

    private String master;
    private String createTime;
    private String editTime;

    private Integer pingLunCount;
    private Integer articleLove;
    private Integer shouCangCount;

    public Integer getShouCangCount() {
        return shouCangCount;
    }

    public void setShouCangCount(Integer shouCangCount) {
        this.shouCangCount = shouCangCount;
    }

    public Article(){}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getArticleType() {
        return articleType;
    }

    public void setArticleType(String articleType) {
        this.articleType = articleType;
    }

    public String getArticleTitle() {
        return articleTitle;
    }

    public void setArticleTitle(String articleTitle) {
        this.articleTitle = articleTitle;
    }

    public String getArticleContent() {
        return articleContent;
    }

    public void setArticleContent(String articleContent) {
        this.articleContent = articleContent;
    }

    public Integer getArticleCount() {
        return articleCount;
    }

    public void setArticleCount(Integer articleCount) {
        this.articleCount = articleCount;
    }

    public Integer getArticleLove() {
        return articleLove;
    }

    public void setArticleLove(Integer articleLove) {
        this.articleLove = articleLove;
    }

    public String getMaster() {
        return master;
    }

    public void setMaster(String master) {
        this.master = master;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getEditTime() {
        return editTime;
    }

    public void setEditTime(String editTime) {
        this.editTime = editTime;
    }

    public Integer getPingLunCount() {
        return pingLunCount;
    }

    public void setPingLunCount(Integer pingLunCount) {
        this.pingLunCount = pingLunCount;
    }

    public Article(String id, String articleType, String articleTitle, String articleContent, Integer articleCount, Integer articleLove, String master, String createTime, String editTime, Integer pingLunCount) {
        this.id = id;
        this.articleType = articleType;
        this.articleTitle = articleTitle;
        this.articleContent = articleContent;
        this.articleCount = articleCount;
        this.articleLove = articleLove;
        this.master = master;
        this.createTime = createTime;
        this.editTime = editTime;
        this.pingLunCount = pingLunCount;
    }
}
