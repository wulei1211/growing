package com.hhit.entity;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:32 2020/5/6
 * @Modified By:
 */
public class GrowChuan extends BaseBean{
    private String id;
    private String growId;
    private String chuanId;

    private Chuan chuan;

    public Chuan getChuan() {
        return chuan;
    }

    public void setChuan(Chuan chuan) {
        this.chuan = chuan;
    }

    public GrowChuan(){}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getGrowId() {
        return growId;
    }

    public void setGrowId(String growId) {
        this.growId = growId;
    }

    public String getChuanId() {
        return chuanId;
    }

    public void setChuanId(String chuanId) {
        this.chuanId = chuanId;
    }

    public GrowChuan(String id, String growId, String chuanId) {
        this.id = id;
        this.growId = growId;
        this.chuanId = chuanId;
    }
}
