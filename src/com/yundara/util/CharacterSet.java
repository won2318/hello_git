/*
 * Created on 2004. 12. 14.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.yundara.util;

import java.io.*;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CharacterSet {
	public CharacterSet() {
	}

	/**
	 * 	KSC5601 코드의 문자열을 8859_1코드 문자열로 변환.
	 *
	 * 	@param korean : 원본 문자열
	 *	@return 8859_1 코드 문자열을 리턴한다.
	 *	@author 오영석
	 */
	public static String toEnglish(String korean) {
	 
		if (korean != null && korean.length() > 0) {
		String newString = null;		
		try {
			newString = new String(korean.getBytes("KSC5601"),"8859_1");
		} catch(UnsupportedEncodingException ex) {
			System.err.println(ex);
		}

		return newString;
		} else {
			return null;
		}
	}

	/**
	 * 	8859_1 코드의 문자열을 KSC5601코드 문자열로 변환.
	 *
	 * 	@param english : 원본 문자열
	 *	@return KSC5601코드 문자열을 리턴한다.
	 *	@author 오영석
	 */
	public static String toKorean(String english) {
 
		if (english != null && english.length() > 0) {
		String newString = null;		
		try {
			newString = new String(english.getBytes("8859_1"),"KSC5601");
		} catch(UnsupportedEncodingException ex) {
			System.err.println(ex);
		}

		return newString;
		} else {
			return null;
		}
	}

	//일반 숫자형 타입을 화페형식으로 표현 --> coded by 손재면
	public static String getCurrencyFormat(int number_format){
		long number = number_format;
		return java.text.NumberFormat.getInstance().format(number_format);
	}

	//일반 숫자형 타입을 날짜형식으로 표현 --> coded by 손재면
	//예) 1 --> 01, 11 --> 11
	public static String getDateFormat(int number_format){
		long number = number_format;
		return new java.text.DecimalFormat("00").format(number);
	}
}
