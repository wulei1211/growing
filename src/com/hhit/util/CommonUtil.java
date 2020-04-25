package com.hhit.util;

import java.io.File;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

/**
 * CommonUtil.java
 */
public class CommonUtil {
	
	/**
	 * Method name: formatDateByDay <BR>
	 * Description: 格式化日期<BR>
	 * Remark:yyyy-MM-dd <BR>
	 * @param date 日期（Date或者String）
	 * @return String <BR>
	 */
	public static String getDateString(Object date) {
		if (date == null) {
			return null;
		} else {
			return (new SimpleDateFormat("yyyy-MM-dd")).format(date);
		}
	}
	
	/**
	 * Method name: formatDateByDay <BR>
	 * Description: 格式化日期<BR>
	 * Remark:yyyy-MM-dd <BR>
	 * @param date 日期（Date或者String）
	 * @return String <BR>
	 * @throws ParseException 
	 */
	public static Date getDateByString(String ymd) throws ParseException {
		return (new SimpleDateFormat("yyyy-MM-dd")).parse(ymd);
	}

	/**
	 * Method name: formatDateByDay <BR>
	 * Description: 格式化日期<BR>
	 * Remark:yyyy-MM-dd HH:mm:ss <BR>
	 * @param date 日期（Date或者String）
	 * @return String <BR>
	 */
	public static String getDateTimeString(Object date) {
		if (date == null) {
			return null;
		} else {
			return (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(date);
		}
	}
	
	/**
	 * Method name: formatDateByDay <BR>
	 * Description: 格式化日期<BR>
	 * Remark:yyyy-MM-dd HH:mm:ss <BR>
	 * @param date 日期（Date或者String）
	 * @return String <BR>
	 */
	public static String getDateTimeStringYMDH(Object date) {
		if (date == null) {
			return null;
		} else {
			return (new SimpleDateFormat("yyyyMMddHH")).format(date);
		}
	}
	
	/**
	 * Method name: formatDateByDay <BR>
	 * Description: 格式化日期<BR>
	 * Remark:yyyy-MM-dd HH:mm:ss <BR>
	 * @param date 日期（Date或者String）
	 * @return String <BR>
	 */
	public static String getDateTimeStringYMDHMS(Object date) {
		if (date == null) {
			return null;
		} else {
			return (new SimpleDateFormat("yyyyMMddHHmmss")).format(date);
		}
	}
	
	/**
	 * Method name: formatDateByDay <BR>
	 * Description: 格式化日期<BR>
	 * Remark:yyyy-MM-dd HH:mm:ss <BR>
	 * @param date 日期（Date或者String）
	 * @return String <BR>
	 * @throws ParseException 
	 */
	public static Date getDateTimeByString(String ymdhms) throws ParseException {
		
		return (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).parse(ymdhms);
	}

	/**
	 * @param 将字符串MD5加密
	 * @return
	 */
	public static String getMD5(String password) { 
		
		MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		md5.update(password.getBytes());
		String md5String = new BigInteger(1, md5.digest()).toString(16);// 加密之后的字符串
		
		return md5String;
    }
	
	/**
	 * 获取文件名，保证不重复
	 */
	public static String getFileName(String filePath, String fileExt)throws Exception{
		//以"yyyyMMddHHmmss_"加随机数作为文件名
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String newFileName = df.format(new Date()) + "_" + new Random().nextInt(10000) + "." + fileExt;
		
		if(fileExt.equals("")){
			newFileName = df.format(new Date()) + "_" + new Random().nextInt(10000);
		}
		
		String newFilePath = filePath + "/" + newFileName;
		if(new File(newFilePath).exists()){
			//存在，再生成
			return getFileName(filePath, fileExt);
		}else{
			return newFileName;
		}
	}
	
	/**
	 * 
	 * Author: GeMing <BR>
	 * Method name: getCurrentDatetime <BR>
	 * Description: 获得系统当前日期和时间 <BR>
	 * Remark: <BR>
	 * @return  String<BR>
	 */
	public static String getCurrentDatetime(){
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateString = f.format(Calendar.getInstance().getTime());
		return dateString;
	}
	
}
