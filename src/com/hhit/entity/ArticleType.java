package com.hhit.entity;

/**
 * @Author: wulei
 * @Description:
 * @Date: Created in 20:25 2020/4/27
 * @Modified By:
 */
public class ArticleType extends BaseBean {
    private String id;
    private String typeName;

    public ArticleType(){}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public ArticleType(String id, String typeName) {
        this.id = id;
        this.typeName = typeName;
    }
}
