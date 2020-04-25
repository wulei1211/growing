package com.hhit.entity;

import java.io.Serializable;
import java.util.List;

/**
 * @author wangjian
 * mmGrid的表格参数bean
 * @param <T>
 */
public class MMGridPageVoBean<T> implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5033466102339979707L;

	private String code;
	private String msg;
	private String count;
	private List<T> data;

	public MMGridPageVoBean(){}

	public MMGridPageVoBean(String code, String msg, String count, List<T> data) {
		this.code = code;
		this.msg = msg;
		this.count = count;
		this.data = data;
	}

	public static long getSerialVersionUID() {
		return serialVersionUID;
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

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public List<T> getData() {
		return data;
	}

	public void setData(List<T> data) {
		this.data = data;
	}
}
