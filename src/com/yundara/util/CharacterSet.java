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
	 * 	KSC5601 �ڵ��� ���ڿ��� 8859_1�ڵ� ���ڿ��� ��ȯ.
	 *
	 * 	@param korean : ���� ���ڿ�
	 *	@return 8859_1 �ڵ� ���ڿ��� �����Ѵ�.
	 *	@author ������
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
	 * 	8859_1 �ڵ��� ���ڿ��� KSC5601�ڵ� ���ڿ��� ��ȯ.
	 *
	 * 	@param english : ���� ���ڿ�
	 *	@return KSC5601�ڵ� ���ڿ��� �����Ѵ�.
	 *	@author ������
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

	//�Ϲ� ������ Ÿ���� ȭ���������� ǥ�� --> coded by �����
	public static String getCurrencyFormat(int number_format){
		long number = number_format;
		return java.text.NumberFormat.getInstance().format(number_format);
	}

	//�Ϲ� ������ Ÿ���� ��¥�������� ǥ�� --> coded by �����
	//��) 1 --> 01, 11 --> 11
	public static String getDateFormat(int number_format){
		long number = number_format;
		return new java.text.DecimalFormat("00").format(number);
	}
}
