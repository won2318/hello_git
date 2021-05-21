/*
 * 작성일 : 2004. 12. 14.
 *
 * TODO 
 */
package com.yundara.util;

/**
 * @author 오영석
 * 
 * TODO 주로 문자열 처리를 위한 유틸리티 클래스이다.
 */

import java.util.*;

public class TextUtil {

	/**
	 *	알파벳 또는 숫자일 경우 true 리턴.
	 *
	 *	@param str : 대상 문자열
	 *	@return 알파벳 또는 숫자일경우 true, 아니면 false 리턴
	 *	@author 오영석
	 */
	public static boolean isAlphaNumeric(String str) {
		if(str == null) return false;
		
		char[] ch = str.toCharArray();
		for(int i=0;i<ch.length;i++) {
			if( !((ch[i] >= '0' && ch[i] <= '9') || (ch[i] >= 'a' && ch[i] <= 'z') ||
					(ch[i] >= 'A' && ch[i] <= 'Z')) ) return false;
		}
		return true;
	}

	/**
	 *	알파벳 문자인지 판단.
	 *
	 *	@param str : 대상 문자열
	 *	@return 알파벳 일 경우 true, 아니면 false 리턴
	 *	@author 오영석
	 */
	public static boolean isAlphabet(String str) {
		if(str == null) return false;
		
		char[] ch = str.toCharArray();
		for(int i=0;i<ch.length;i++) {
			if( !((ch[i] >= 'a' && ch[i] <= 'z') || (ch[i] >= 'A' && ch[i] <= 'Z')) ) 
				return false;
		}
		return true;
	}

	/**
	 *	숫자인지 판단.
	 *
	 *	@param str : 대상 문자열
	 *	@return 숫자 일 경우 true, 아니면 false 리턴
	 *	@author 오영석
	 */
	public static boolean isNumeric(String str) {
		if(str == null) return false;
		
		char[] ch = str.toCharArray();
		for(int i=0;i<ch.length;i++) {
			if( !Character.isDigit(ch[i]) ) 
				return false;
		}
		return true;
	}

	/**
	 *	문자열의 정확한 길이를 알아낸다.
	 *
	 *	@param str : 대상 문자열
	 *	@return 문자열의 길이 리턴
	 *	@author 오영석
	 */
	public static int length(String str) {
		char[] ch = str.toCharArray();
		int len = 0;
		for(int i=0;i<ch.length;i++) {
			if(Character.UnicodeBlock.of(ch[i]) == Character.UnicodeBlock.HANGUL_SYLLABLES ||
					Character.UnicodeBlock.of((char)i) == Character.UnicodeBlock.HANGUL_COMPATIBILITY_JAMO)
				len += 2;
			else
				len++;
		}
		return len;
	}
	
	/**
	 *	문자열을 바이트 이하로 자릅니다.
	 *
	 *	@param limitedByte  : 제한할 byte 수
	 *	@param arg          : 원본문자열
	 *	@return limitedByte byte 만큼 제한된 문자열을 반환합니다.
	 *	@author 오영석
	 */
	public static String getLimitedString(int limitedByte, String arg) {

		if(arg == null)	return null;

		int returnLength = 0;
		int LetterByte = 1;//해당 문자의 바이트 수
		StringBuffer returnString = new StringBuffer();//결과 문자열
	
		char[] ch = arg.toCharArray();
		for(int i=0;i<ch.length;i++) {
			if(Character.UnicodeBlock.of(ch[i]) == Character.UnicodeBlock.HANGUL_SYLLABLES ||
					Character.UnicodeBlock.of((char)i) == Character.UnicodeBlock.HANGUL_COMPATIBILITY_JAMO)
				LetterByte = 2;
			else
				LetterByte = 1;

			if( returnLength + LetterByte <= limitedByte) {
				returnString.append(new Character(ch[i]).toString());
				returnLength += LetterByte;
			} else break;

		}
		return returnString.toString();
	}

	/**
	 *	널값을 공백으로 변환하거나, 문자열의 양쪽 공백을 지운다.
	 *
	 *	@param tmp  : 원본 문자열
	 *	@return 빈문자열이나 양쪽 공백을 지운 문자열
	 *	@author 오영석
	 */
	public static String nvl(String tmp) {
		if(tmp == null) return "";
		else return tmp.trim();
	}

	/**
	 * 	문자열 변환.
	 *
	 * 	@param text : 원본 문자열
	 *	@param oldWord : 바꿀 문자열
	 *	@param newWord : 바뀔 문자열
	 *	@return oldWord 문자열을 newWord로 변환 후 결과 문자열 리턴
	 *	@author 오영석
	 */
	public static String replace( String text, String oldWord, String newWord ) { 
		if( text == null || text.equals("") || 
				oldWord == null || oldWord.equals("") || newWord == null )
			return text;

		String returnString = text; 
		int offset = 0;  
		while( (offset = returnString.indexOf( oldWord, offset ))>-1 ) { 
			StringBuffer temp = new StringBuffer( returnString.substring( 0, offset ) ); 
			temp.append( newWord ); 
			temp.append( returnString.substring( offset + oldWord.length() ) ); 
			returnString = temp.toString(); 
			offset = offset + newWord.length();
		}        
		return returnString; 
	} 

	/**
	 * 	유효한 휴대폰 인지 판단한다.
	 *
	 * 	@param hp : 휴대폰번호 문자열
	 *	@return 유효하면 true, 아니면 false
	 *	@author Kim JongJin
	 */
	public static boolean isValidHP(String hp){
		try{
			hp = hp.trim();

			hp = replace(hp, "-", "");

			if( !isNumeric( hp ) )//숫자확인
				return false;
			else if( hp.length() !=10 && hp.length() !=11 )//자리수 확인
				return false;
			else if( !isVaildOffiecNumber( hp ) )//국번확인
				return false;
			else
				return true;
		}catch(Exception e){
			return false;
		}
	}

	private static boolean isVaildOffiecNumber(String hp) {
		try{
			String officeNumber = hp.substring(0,3);
			if(officeNumber.equals("011") || officeNumber.equals("016") || 
					officeNumber.equals("017") || officeNumber.equals("018") ||
					officeNumber.equals("019") || officeNumber.equals("010"))
				return true;
			else
				return false;
		}catch(Exception e){
			return false;
		}
	}

	/**
	 * 	전화번호를  3개의 요소를 가지는 문자열배열로 분리시킨다.
	 *
	 * 	@param tnum : 전화번호
	 *	@return 3개의 요소를 가지는 문자열 배열
	 *	@author 오영석
	 */
	public static String [] getTPSlice(String tnum){
		String clip_phone [] = null;
	
		try {
			tnum =  tnum.trim();
			tnum = replace(tnum, "-", "");

			if(tnum.substring(0,2).equals("02")){
				clip_phone = new String[3];
				clip_phone[0] = "02";
				clip_phone[1] = tnum.substring( 2, tnum.length()-4 );
				clip_phone[2] = tnum.substring( tnum.length()-4 );
			} else {
				clip_phone = new String[3];			
				clip_phone[0] = tnum.substring(0, 3);
				clip_phone[1] = tnum.substring(3, tnum.length()-4);
				clip_phone[2] = tnum.substring( tnum.length()-4 );
			}
		} catch(Exception ex) {}
		return clip_phone;
	}

	/**
	 * 	휴대본번호를  3개의 요소를 가지는 문자열배열로 만든다.
	 *
	 * 	@param tnum : 휴대폰번호
	 *	@return 3개의 요소를 가지는 문자열 배열
	 *	@author 오영석
	 */
	public static String [] getHPSlice(String tnum) {
		String clip_phone [] = null;

		try {
			tnum =  tnum.trim();
			tnum = replace(tnum, "-", "");
			if( tnum.length() == 10 ) {
				clip_phone=new String[3];
				clip_phone[0]=tnum.substring(0,3);
				clip_phone[1]=tnum.substring(3,6);
				clip_phone[2]=tnum.substring(6,10);		
			} else if( tnum.length() == 11 ) {
				clip_phone=new String[3];
				clip_phone[0]=tnum.substring(0,3);
				clip_phone[1]=tnum.substring(3,7);
				clip_phone[2]=tnum.substring(7,11);		
			}
		} catch(Exception e){}

		return clip_phone;
	}

	/**
	 * 	전화번호 0425266783 -> 042-526-6783
	 *
	 * 	@param phone_number : 전화번호
	 *	@return 0425266783 -> 042-526-6783 형식의 문자열로 바꿔서 리턴한다.
	 *	@author 오영석
	 */
	public static String getTelephoneFormat(String phone_number){
		String phone1, phone2, phone3 = "";
		System.out.println(phone_number.substring(0,2));
		if(phone_number.substring(0,2).equals("02")){
			phone1 = "02";
			phone2 = phone_number.substring(2,phone_number.length()-4);
			phone3 = phone_number.substring(phone_number.length()-4);

		}else {
			phone1 = phone_number.substring(0,3);
			phone2 = phone_number.substring(3,phone_number.length()-4);
			phone3 = phone_number.substring(phone_number.length()-4);
		}

		return phone1 + "-" + phone2 + "-" + phone3;
	}

	/**
	 * 	핸드폰번호 01111111111 -> 011-1111-1111으로
	 *
	 * 	@param phone_number : 핸드폰번호
	 *	@return 01111111111 -> 011-1111-1111 형식의 문자열로 바꿔서 리턴한다.
	 *	@author 오영석
	 */
	public static String getHPhoneFormat(String phone_number){
		String phone1, phone2, phone3 = "";

		phone1 = phone_number.substring(0,3);
		phone2 = phone_number.substring(3,phone_number.length()-4);
		phone3 = phone_number.substring(phone_number.length()-4);

		return phone1 + "-" + phone2 + "-" + phone3;
	}
	
	/**
 	* 	문자열을 구분자로 나눈다.
 		*
 	* 	@param str : 원본 문자열
 	* 	@param delim : 구분자 
 	*	@return 문자열을 구분자로 나누어 문자열배열로 리턴
 	*	@author 오영석
 	*/
	public static String[] getSliceString(String str, String delim) {
		String strClip[] = null;
		StringTokenizer tk = new StringTokenizer(str, delim);
		int cnt = tk.countTokens();

		strClip = new String[cnt];

		for(int i=0; i < cnt ; i++) {
			strClip[i] = tk.nextToken();
		}

		return strClip;
	}

	/**
	 * 	문자열 배열을 주어진 구분자로 연결하여 하나의 문자열로 만든다.
	 *
	 * 	@param str[] : 원본 문자열 배열
	 * 	@param delim : 구분자 
	 *	@return 구분자로 연결하여 하나의 문자열을 만든후 리턴한다.
	 *	@author 오영석
	 */
	public static String getJoinString(String[] str, String delim) {
		String result = "";
		for(int i=0; i<str.length; i++) {
			result += str[i];
			if( i < (str.length-1) ) result += delim;
		}
		return result;
	}

		/**
		매개변수에 문자열 "0"을 원하는 길이(length)만큼 붙혀서 String 형으로 리턴.
		mysql의 zerofill 과 같음.
	*/
	public static String zeroFill(int length, String str) {
		String returnValue;
	
		if(str.length() >= length) returnValue = str;
		else {
			int loopcnt = length - str.length();
			StringBuffer strbfr = new StringBuffer(length);
	
			for(int i=0; i<loopcnt; i++) {
				strbfr.append("0");
			}
			strbfr.append(str);
			returnValue = strbfr.toString();
		}
	
		return returnValue;
	}
	
	/**
		매개변수에 문자열 "0"을 원하는 길이(length)만큼 붙혀서 String 형으로 리턴.
		mysql의 zerofill 과 같음.
	*/
	public static String zeroFill(int length, int intstr) {
		String returnValue;
		Integer objInt = new Integer(intstr);
		String str = objInt.toString();
	
		if(str.length() >= length) returnValue = str;
		else {
			int loopcnt = length - str.length();
			StringBuffer strbfr = new StringBuffer(length);
	
			for(int i=0; i<loopcnt; i++) {
				strbfr.append("0");
			}
			strbfr.append(str);
			returnValue = strbfr.toString();
		}
	
		return returnValue;
	}
	
	/**
		매개변수에 문자열 "0"을 원하는 위치에 길이(length)만큼 붙혀서 String 형으로 리턴.
		mysql의 zerofill 과 같음.
		interval : 0:앞에, 1:뒤에
	*/
	public static String zeroFill(int interval, int length, String str) {
		String returnValue;
	
		if(str.length() >= length) returnValue = str;
		else {
			int loopcnt = length - str.length();
			StringBuffer strbfr = new StringBuffer(length);
	
			if(interval==0) strbfr.append(str);
			for(int i=0; i<loopcnt; i++) {
				strbfr.append("0");
			}
			if(interval==1) strbfr.append(str);
			returnValue = strbfr.toString();
		}
	
		return returnValue;
	}
	
	/**
		매개변수에 문자열 "0"을 원하는 위치에 길이(length)만큼 붙혀서 String 형으로 리턴.
		mysql의 zerofill 과 같음.
		interval : 0:앞에, 1:뒤에
	*/
	public static String zeroFill(int interval, int length, int intstr) {
		String returnValue;
		Integer objInt = new Integer(intstr);
		String str = objInt.toString();
	
		if(str.length() >= length) returnValue = str;
		else {
			int loopcnt = length - str.length();
			StringBuffer strbfr = new StringBuffer(length);
	
			if(interval==0) strbfr.append(str);
			for(int i=0; i<loopcnt; i++) {
				strbfr.append("0");
			}
			if(interval==1) strbfr.append(str);
			returnValue = strbfr.toString();
		}
	
		return returnValue;
	}
	
	/**
		문자열(str)에서 찾을 문자(sch)를 순차적으로 찾아서 처음 찾은 문자의 다음 문자열만 리턴.
	*/
	public static String substr(String str, String sch) {
		try {
			int pos = str.indexOf(sch);
			if(pos != -1) str = str.substring(pos+1, str.length());
			else str = null;
		}
		catch(NullPointerException ex) {}
	
		return str;
	}
	
	public static void main(String[] args) {
		String tt[] = new String[3];
		tt[0] = "042";
		tt[1] = "526";
		tt[2] = "6783";
		
		System.out.println(getJoinString(tt, "-"));
		tt = getSliceString(getJoinString(tt, "-"), "-");
		for(int i=0;i<tt.length;i++) {
			System.out.println(tt[i]);
		}
		
		System.out.println(getTelephoneFormat("0425266783"));
		tt = getHPSlice("016-428-4326");
		
		for(int i=0;i<tt.length;i++) {
			System.out.println(tt[i]);
		}

		tt = getTPSlice("042-526-6783");
		for(int i=0;i<tt.length;i++) {
			System.out.println(tt[i]);
		}
		
		System.out.println(getLimitedString(9, "12ㅇ3음이거야.45678901234"));
		System.out.println(getLimitedString(10, "12ㅇ3음이거야.45678901234"));
		System.out.println(length("12ㅇ3음이거야.45678901234"));
		System.out.println("12ㅇ3음이거야.45678901234".length());
		
		System.out.println(isNumeric("034p3234"));
	}
}
