package com.hhit.entity;

import java.util.List;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 16:57 2020/5/6
 * @Modified By:
 */
public class Grows extends BaseBean{
    private String id;
    private String growName;
    private String memo;
    private String userId;

    private String positions;
    private String chuanId;
    private List<Chuan> chuanGanList;

    public String getPositions() {
        return positions;
    }

    public void setPositions(String positions) {
        this.positions = positions;
    }

    private Integer startWen;
    private Integer startShi;
    private Integer startGuang;
    private Integer startEr;
    private Integer endWen;
    private Integer endShi;
    private Integer endGuang;
    private Integer endEr;


    public Integer getStartWen() {
        return startWen;
    }

    public void setStartWen(Integer startWen) {
        this.startWen = startWen;
    }

    public Integer getStartShi() {
        return startShi;
    }

    public void setStartShi(Integer startShi) {
        this.startShi = startShi;
    }

    public Integer getStartGuang() {
        return startGuang;
    }

    public void setStartGuang(Integer startGuang) {
        this.startGuang = startGuang;
    }

    public Integer getStartEr() {
        return startEr;
    }

    public void setStartEr(Integer startEr) {
        this.startEr = startEr;
    }

    public Integer getEndWen() {
        return endWen;
    }

    public void setEndWen(Integer endWen) {
        this.endWen = endWen;
    }

    public Integer getEndShi() {
        return endShi;
    }

    public void setEndShi(Integer endShi) {
        this.endShi = endShi;
    }

    public Integer getEndGuang() {
        return endGuang;
    }

    public void setEndGuang(Integer endGuang) {
        this.endGuang = endGuang;
    }

    public Integer getEndEr() {
        return endEr;
    }

    public void setEndEr(Integer endEr) {
        this.endEr = endEr;
    }

    public Grows(String id, String growName, String memo, String userId, String chuanId, List<Chuan> chuanGanList, Integer startWen, Integer startShi, Integer startGuang, Integer startEr, Integer endWen, Integer endShi, Integer endGuang, Integer endEr) {
        this.id = id;
        this.growName = growName;
        this.memo = memo;
        this.userId = userId;
        this.chuanId = chuanId;
        this.chuanGanList = chuanGanList;
        this.startWen = startWen;
        this.startShi = startShi;
        this.startGuang = startGuang;
        this.startEr = startEr;
        this.endWen = endWen;
        this.endShi = endShi;
        this.endGuang = endGuang;
        this.endEr = endEr;
    }

    public String getChuanId() {
        return chuanId;
    }

    public void setChuanId(String chuanId) {
        this.chuanId = chuanId;
    }

    public List<Chuan> getChuanGanList() {
        return chuanGanList;
    }

    public void setChuanGanList(List<Chuan> chuanGanList) {
        this.chuanGanList = chuanGanList;
    }

    public Grows(){}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getGrowName() {
        return growName;
    }

    public void setGrowName(String growName) {
        this.growName = growName;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }


    public Grows(String id, String growName, String memo, String userId ) {
        this.id = id;
        this.growName = growName;
        this.memo = memo;
        this.userId = userId;
    }
}
