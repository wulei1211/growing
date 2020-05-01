package com.hhit.entity;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 19:52 2020/4/24
 * @Modified By:
 */
public class Replay extends BaseBean{
    private String id;
    private String pingLunId;
    private String articleId;
    private String replayContent;
    private String replayer;
    private String toPlayer;
    private String time;

    private String huiName;
    private String huiTou;
    private String beiName;

    private Integer replayDianCount;

    private Integer booleanReDian;


    public Integer getBooleanReDian() {
        return booleanReDian;
    }

    public void setBooleanReDian(Integer booleanReDian) {
        this.booleanReDian = booleanReDian;
    }

    public Integer getReplayDianCount() {
        return replayDianCount;
    }

    public void setReplayDianCount(Integer replayDianCount) {
        this.replayDianCount = replayDianCount;
    }

    public String getHuiName() {
        return huiName;
    }

    public void setHuiName(String huiName) {
        this.huiName = huiName;
    }

    public String getHuiTou() {
        return huiTou;
    }

    public void setHuiTou(String huiTou) {
        this.huiTou = huiTou;
    }

    public String getBeiName() {
        return beiName;
    }

    public void setBeiName(String beiName) {
        this.beiName = beiName;
    }

    public Replay(){}

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

    public String getArticleId() {
        return articleId;
    }

    public void setArticleId(String articleId) {
        this.articleId = articleId;
    }

    public String getReplayContent() {
        return replayContent;
    }

    public void setReplayContent(String replayContent) {
        this.replayContent = replayContent;
    }

    public String getReplayer() {
        return replayer;
    }

    public void setReplayer(String replayer) {
        this.replayer = replayer;
    }

    public String getToPlayer() {
        return toPlayer;
    }

    public void setToPlayer(String toPlayer) {
        this.toPlayer = toPlayer;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public Replay(String id, String pingLunId, String articleId, String replayContent, String replayer, String toPlayer, String time) {
        this.id = id;
        this.pingLunId = pingLunId;
        this.articleId = articleId;
        this.replayContent = replayContent;
        this.replayer = replayer;
        this.toPlayer = toPlayer;
        this.time = time;
    }
}
