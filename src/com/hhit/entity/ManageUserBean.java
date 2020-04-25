package com.hhit.entity;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 17:46 2020/4/20
 * @Modified By:
 */
public class ManageUserBean extends BaseBean {

    private String id; //
    private String userName;
    private String password;
    private String realName;
    private String userType;
    private String gender;
    private String phone;
    private String email;
    private String deleteFlag;
    private String qq;
    private String weiXin;
    private String weiBo;
    private String memo;
    private String headImg;

    public ManageUserBean(){}
    public ManageUserBean(String id, String userName, String password, String realName, String userType, String gender, String phone, String email, String deleteFlag, String qq, String weiXin, String weiBo, String memo, String headImg) {
        this.id = id;
        this.userName = userName;
        this.password = password;
        this.realName = realName;
        this.userType = userType;
        this.gender = gender;
        this.phone = phone;
        this.email = email;
        this.deleteFlag = deleteFlag;
        this.qq = qq;
        this.weiXin = weiXin;
        this.weiBo = weiBo;
        this.memo = memo;
        this.headImg = headImg;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(String deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getWeiXin() {
        return weiXin;
    }

    public void setWeiXin(String weiXin) {
        this.weiXin = weiXin;
    }

    public String getWeiBo() {
        return weiBo;
    }

    public void setWeiBo(String weiBo) {
        this.weiBo = weiBo;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getHeadImg() {
        return headImg;
    }

    public void setHeadImg(String headImg) {
        this.headImg = headImg;
    }
}
