package com.hhit.entity;

import java.util.HashMap;
import java.util.Map;

/**
 * @author shkstart
 * @create 2019-10-25 14:43
 */
public class ResponseFile {
    private String code;
    private String msg;
    private Map<String,String>  data;
    public ResponseFile(){}

    public ResponseFile(String code, String msg, String src) {
        this.code = code;
        this.msg = msg;
        data = new HashMap<>();
        data.put("src",src);
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, String> getData() {
        return data;
    }

    public void setData(Map<String, String> data) {
        this.data = data;
    }
}
