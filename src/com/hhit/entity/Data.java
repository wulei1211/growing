package com.hhit.entity;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:20 2020/5/7
 * @Modified By:
 */
public class Data {
    private String id;
    private String gid;
    private String cid;
    private String wen;
    private String shi;
    private String guang;
    private String er;
    private String time;

    public Data(){}

    public Data(String wen, String shi, String guang, String er) {
        this.wen = wen;
        this.shi = shi;
        this.guang = guang;
        this.er = er;
    }

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

    public String getWen() {
        return wen;
    }

    public void setWen(String wen) {
        this.wen = wen;
    }

    public String getShi() {
        return shi;
    }

    public void setShi(String shi) {
        this.shi = shi;
    }

    public String getGuang() {
        return guang;
    }

    public void setGuang(String guang) {
        this.guang = guang;
    }

    public String getEr() {
        return er;
    }

    public void setEr(String er) {
        this.er = er;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public Data(String id, String gid, String cid, String wen, String shi, String guang, String er, String time) {
        this.id = id;
        this.gid = gid;
        this.cid = cid;
        this.wen = wen;
        this.shi = shi;
        this.guang = guang;
        this.er = er;
        this.time = time;
    }

}
