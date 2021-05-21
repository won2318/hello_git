/*
 * Created on 2005. 1. 3
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.utils;

import java.util.*;

/**
 * @author Jong-Hyun Ho
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/**
 *	문자열 관련 클래스 정보
 */

public class Function{

	/**
	 *	문자열 유효성 체크하여 널값이거나 공백문자 이면 flase를 리턴,
	 *  그렇지 않으면 true를 리턴.
	 */
	public static boolean isEmpty( String value ){
		if( value == null )
			return true;
		else if( value.trim().equals( "" ) )
			return true;
		else
			return false;
	}

	//널값을 공백으로
	public static String nvl(String tmp)
	{
		if(tmp==null)
			return "";
		else
			return tmp.trim();
	}

	//같은 경우 checked
	public static String isChecked(String val_1, String val_2){
		if( val_1 == null || val_2 == null )
			return "";
		else if(val_1.equals(val_2))
			return " checked";
		else
			return "";
	}
	public static String isChecked(String val_1, String [] val_2){
		if( val_1 == null || val_2 == null )
			return "";

		String returnString = "";
		for( int i = 0; i < val_2.length; i++ ){
			if( val_1.equals( val_2[i] ) ){
				returnString = " checked";
				break;
			}
		}

		return returnString;
	}

	//같은 경우 selected
	public static String isSelected(String val_1, String val_2)
	{
		if( val_1 == null || val_2 == null )
			return "";
		else if(val_1.equals(val_2))
			return " selected";
		else
			return "";
	}

	/**
	 *	구분자로 구분된 스트링을 배열로 바꿔서 리턴
	 */
	public static String [] toArray( String str , String delimeter ){
		try{
			StringTokenizer st = new StringTokenizer( str, delimeter );
			String [] array = new String[st.countTokens()];
			int i=0;
			while( st.hasMoreTokens() ){
				array[i] = st.nextToken();
				i++;
			}
			return array;
		}catch( Exception e ){ return null; }
	}

	/**
	 *	구분자로 구분된 스트링을 배열로 바꿔서 리턴
	 */
	public static String [] toArray( String str , String delimeter, int delimeter_count ){

		String []  array = new String [ delimeter_count ];
		StringTokenizer st = null;

		try{
			st = new StringTokenizer( str, delimeter );
			for( int i = 0 ; i < delimeter_count ; i++ )
				array[i] = st.nextToken();
		}catch( Exception e ){
			for( int i = 0 ; i < delimeter_count ; i++ )
				array[i] = "";
		}
		return array;
	}


	/**
	 *	구분자를 지워서 리턴.
	 */
	public static String removeDelimeter( String str, String delimeter ){
		try{
			String return_str = "";

			StringTokenizer st = new StringTokenizer( str, delimeter );
			while( st.hasMoreTokens() )
				return_str += st.nextToken();

			return return_str;
		}catch( Exception e ){ return null; }
	}


	/**
	 *	소수점 자리수를 관리합니다.
	 *  @param double value, String format
	 *  Ex) out.print(Function.mathRound(99.99999999, "00.00")) : return "99.99"
	 */
	public static String mathRound(double value, String format) {

		java.text.DecimalFormat formatter = new java.text.DecimalFormat(format);
		return formatter.format(value);
	}


	/**
	 *	소수점 자리수를 관리합니다.
	 *  @param double value, String format
	 *  Ex) out.print(Function.mathRound(99.99999999, "00.00")) : return "99.99"
	 */
	public static double mathRound2(double value, String format) {

		java.text.DecimalFormat formatter = new java.text.DecimalFormat(format);
		return Double.parseDouble( formatter.format(value).toString() );
	}



}

