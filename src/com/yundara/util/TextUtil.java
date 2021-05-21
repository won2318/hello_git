/*
 * �ۼ��� : 2004. 12. 14.
 *
 * TODO 
 */
package com.yundara.util;

/**
 * @author ������
 * 
 * TODO �ַ� ���ڿ� ó���� ���� ��ƿ��Ƽ Ŭ�����̴�.
 */

import java.util.*;

public class TextUtil {

	/**
	 *	���ĺ� �Ǵ� ������ ��� true ����.
	 *
	 *	@param str : ��� ���ڿ�
	 *	@return ���ĺ� �Ǵ� �����ϰ�� true, �ƴϸ� false ����
	 *	@author ������
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
	 *	���ĺ� �������� �Ǵ�.
	 *
	 *	@param str : ��� ���ڿ�
	 *	@return ���ĺ� �� ��� true, �ƴϸ� false ����
	 *	@author ������
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
	 *	�������� �Ǵ�.
	 *
	 *	@param str : ��� ���ڿ�
	 *	@return ���� �� ��� true, �ƴϸ� false ����
	 *	@author ������
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
	 *	���ڿ��� ��Ȯ�� ���̸� �˾Ƴ���.
	 *
	 *	@param str : ��� ���ڿ�
	 *	@return ���ڿ��� ���� ����
	 *	@author ������
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
	 *	���ڿ��� ����Ʈ ���Ϸ� �ڸ��ϴ�.
	 *
	 *	@param limitedByte  : ������ byte ��
	 *	@param arg          : �������ڿ�
	 *	@return limitedByte byte ��ŭ ���ѵ� ���ڿ��� ��ȯ�մϴ�.
	 *	@author ������
	 */
	public static String getLimitedString(int limitedByte, String arg) {

		if(arg == null)	return null;

		int returnLength = 0;
		int LetterByte = 1;//�ش� ������ ����Ʈ ��
		StringBuffer returnString = new StringBuffer();//��� ���ڿ�
	
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
	 *	�ΰ��� �������� ��ȯ�ϰų�, ���ڿ��� ���� ������ �����.
	 *
	 *	@param tmp  : ���� ���ڿ�
	 *	@return ���ڿ��̳� ���� ������ ���� ���ڿ�
	 *	@author ������
	 */
	public static String nvl(String tmp) {
		if(tmp == null) return "";
		else return tmp.trim();
	}

	/**
	 * 	���ڿ� ��ȯ.
	 *
	 * 	@param text : ���� ���ڿ�
	 *	@param oldWord : �ٲ� ���ڿ�
	 *	@param newWord : �ٲ� ���ڿ�
	 *	@return oldWord ���ڿ��� newWord�� ��ȯ �� ��� ���ڿ� ����
	 *	@author ������
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
	 * 	��ȿ�� �޴��� ���� �Ǵ��Ѵ�.
	 *
	 * 	@param hp : �޴�����ȣ ���ڿ�
	 *	@return ��ȿ�ϸ� true, �ƴϸ� false
	 *	@author Kim JongJin
	 */
	public static boolean isValidHP(String hp){
		try{
			hp = hp.trim();

			hp = replace(hp, "-", "");

			if( !isNumeric( hp ) )//����Ȯ��
				return false;
			else if( hp.length() !=10 && hp.length() !=11 )//�ڸ��� Ȯ��
				return false;
			else if( !isVaildOffiecNumber( hp ) )//����Ȯ��
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
	 * 	��ȭ��ȣ��  3���� ��Ҹ� ������ ���ڿ��迭�� �и���Ų��.
	 *
	 * 	@param tnum : ��ȭ��ȣ
	 *	@return 3���� ��Ҹ� ������ ���ڿ� �迭
	 *	@author ������
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
	 * 	�޴뺻��ȣ��  3���� ��Ҹ� ������ ���ڿ��迭�� �����.
	 *
	 * 	@param tnum : �޴�����ȣ
	 *	@return 3���� ��Ҹ� ������ ���ڿ� �迭
	 *	@author ������
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
	 * 	��ȭ��ȣ 0425266783 -> 042-526-6783
	 *
	 * 	@param phone_number : ��ȭ��ȣ
	 *	@return 0425266783 -> 042-526-6783 ������ ���ڿ��� �ٲ㼭 �����Ѵ�.
	 *	@author ������
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
	 * 	�ڵ�����ȣ 01111111111 -> 011-1111-1111����
	 *
	 * 	@param phone_number : �ڵ�����ȣ
	 *	@return 01111111111 -> 011-1111-1111 ������ ���ڿ��� �ٲ㼭 �����Ѵ�.
	 *	@author ������
	 */
	public static String getHPhoneFormat(String phone_number){
		String phone1, phone2, phone3 = "";

		phone1 = phone_number.substring(0,3);
		phone2 = phone_number.substring(3,phone_number.length()-4);
		phone3 = phone_number.substring(phone_number.length()-4);

		return phone1 + "-" + phone2 + "-" + phone3;
	}
	
	/**
 	* 	���ڿ��� �����ڷ� ������.
 		*
 	* 	@param str : ���� ���ڿ�
 	* 	@param delim : ������ 
 	*	@return ���ڿ��� �����ڷ� ������ ���ڿ��迭�� ����
 	*	@author ������
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
	 * 	���ڿ� �迭�� �־��� �����ڷ� �����Ͽ� �ϳ��� ���ڿ��� �����.
	 *
	 * 	@param str[] : ���� ���ڿ� �迭
	 * 	@param delim : ������ 
	 *	@return �����ڷ� �����Ͽ� �ϳ��� ���ڿ��� ������ �����Ѵ�.
	 *	@author ������
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
		�Ű������� ���ڿ� "0"�� ���ϴ� ����(length)��ŭ ������ String ������ ����.
		mysql�� zerofill �� ����.
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
		�Ű������� ���ڿ� "0"�� ���ϴ� ����(length)��ŭ ������ String ������ ����.
		mysql�� zerofill �� ����.
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
		�Ű������� ���ڿ� "0"�� ���ϴ� ��ġ�� ����(length)��ŭ ������ String ������ ����.
		mysql�� zerofill �� ����.
		interval : 0:�տ�, 1:�ڿ�
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
		�Ű������� ���ڿ� "0"�� ���ϴ� ��ġ�� ����(length)��ŭ ������ String ������ ����.
		mysql�� zerofill �� ����.
		interval : 0:�տ�, 1:�ڿ�
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
		���ڿ�(str)���� ã�� ����(sch)�� ���������� ã�Ƽ� ó�� ã�� ������ ���� ���ڿ��� ����.
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
		
		System.out.println(getLimitedString(9, "12��3���̰ž�.45678901234"));
		System.out.println(getLimitedString(10, "12��3���̰ž�.45678901234"));
		System.out.println(length("12��3���̰ž�.45678901234"));
		System.out.println("12��3���̰ž�.45678901234".length());
		
		System.out.println(isNumeric("034p3234"));
	}
}
