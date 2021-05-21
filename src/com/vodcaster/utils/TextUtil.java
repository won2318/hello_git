/*
 * Created on 2005. 1. 3
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.utils;


import java.io.*;

/**
 * @author Jong-Hyun Ho
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/**
 * 텍스트 파일을 읽어 내용 바꿔 을 리턴 한다. 
 */

public class TextUtil
{

	/*---------------------------
	 * 텍스트 파일을 읽어 내용을 리턴
	 *
	 * Jong-Hyun Ho
	 *--------------------------*/
	public static String getText(String file_path)
	{
		RandomAccessFile file  = null;
		StringBuffer buffer = new StringBuffer("");

		String debugString = "";
		//int i=0;
		try{
			file = new RandomAccessFile(file_path, "r"); 
			while(file.getFilePointer() < file.length())   { 
				//i++;
				buffer.append( file.readLine() + "\n");
			} 
			
			file.close();
		}catch(Exception e){
			//System.out.println( "Exception -------> " + e );
			debugString += e;
		}

		//System.out.println("file.length()--->"+i);
		//System.out.println("text------------>"+buffer.toString()+debugString);
		return buffer.toString()+debugString;
	}


	/*--------------------------------
	 * 문자열 변환
	 *
	 * text : 원본 문자열
	 * oldWord : 바꿀 문자열
	 * newWord : 바뀔 문자열
	 *
	 * Jong-Hyun Ho
	 *--------------------------------*/
	public static String replace (String text, String oldWord, String newWord)
	{
		if( text == null || text.equals("") || 
			oldWord == null || oldWord.equals("") || newWord == null )
			return text;

		String returnString = text; 
		int offset = 0;  
		while( (offset = returnString.indexOf( oldWord, offset ))>-1 ) 
		{ 
			StringBuffer temp = new StringBuffer( returnString.substring( 0, offset ) ); 
			temp.append( newWord ); 
			temp.append( returnString.substring( offset + oldWord.length() ) ); 
			returnString = temp.toString(); 
			offset = offset + newWord.length();
		}        
		return returnString; 
	} 


	/*-------------------------------------------------------
	 * 1바이트 문자인자 확인
	 *
	 * getLimitedString(int limitedByte, String arg)에서 사용
	 * Jong-Hyun Ho
	 *-------------------------------------------------------*/
	public static boolean isOneByteSpecialCharacter(char char_letter)
	{	
		boolean isOneByte = false;
		char [] OneByteSpecialCharacter = 
			{'~','`','\'','\"',':',';','<','>',',','.','?','/','\\','|','[',
			 ']','{','}','\t','\r','\n','\f',
			 '!','@','#','$','%','^','&','*','(',')','-','_','+','='};
		for( int i = 0; i < OneByteSpecialCharacter.length; i++ )
			if( char_letter == OneByteSpecialCharacter [i] )
			{
				isOneByte = true;
				break;
			}
		return isOneByte;
	}


	/*--------------------------------------------
	 * 문자열을 바이트 이하로 자른다.
	 *
	 * limitedByte  : 제한할 byte 수
	 * arg          : 원본문자열
	 * returnString : limitedByte byte 만큼 제한된 문자열
	 * Jong-Hyun Ho
	 *-------------------------------------------*/
	public static String getLimitedString(int limitedByte, String arg)
	{

		if(arg == null)
			return null;

		int returnLength=0;
		int LetterByte = 1;//해당 문자의 바이트 수
		StringBuffer returnString = new StringBuffer();//결과 문자열

		for( int i=0; i < arg.length() ; i++ )
		{
			char a=arg.charAt(i);

			if( Character.isLetter(a) &&  Character.toUpperCase(a) >= 'A' && Character.toUpperCase(a) <= 'Z' )//문자(영문 1byte)
				LetterByte = 1;
			else if( Character.isLetter(a) )//문자(한글 2byte)
				LetterByte = 2;
			else if( Character.isDigit(a) )//숫자 1byte
				LetterByte = 1;
			else if( Character.isWhitespace(a) )//공백문자( ' ' ) 1byte
				LetterByte = 1;
			else if(isOneByteSpecialCharacter(a))//특수 문자 1byte 
				LetterByte = 1;
			else//그외 특수 문자 2byte
				LetterByte = 2;


			if( returnLength + LetterByte <= limitedByte)
			{
				returnString.append(new Character(a).toString());
				returnLength += LetterByte;
			}
			else
				break;
		}

		return returnString.toString();
	}

	/**
		문자열을 바이트 이하로 자릅니다.

		@param limit        : 제한할 byte 수
		@param arg          : 원본문자열
		@return limit byte 만큼 제한된 문자열을 반환합니다.
		@author Jong-Hyun Ho
	*/
	public static String getLimitedString_(int limit, String arg)
	{

		if(arg == null)
			return null;

		int returnLength=0;//결과 문자열의 바이트 수 : limit - 1 ~ limit (byte)
		int LetterByte = 1;//해당 문자의 바이트 수
		StringBuffer returnString = new StringBuffer();//결과 문자열

		for( int i=0; i < arg.length() ; i++ )
		{
			String a = arg.substring(i,i+1);
			LetterByte = a.getBytes().length;

			if( returnLength + LetterByte <= limit)
			{
				returnString.append(a);
				returnLength += LetterByte;
			}
			else
				break;
		}
		return returnString.toString();
	}

	public static String last_substr(String str, String sch) {
		try {
			int pos = str.lastIndexOf(sch);
			if(pos != -1) str = str.substring(pos+1, str.length());
			else str = null;
		}
		catch(NullPointerException ex) {}

		return str;
	}

	/*****************************************************
	파일 업로드시 파일 확장자를 리턴한다.
	<b>작성자</b>       : 이희락<br>
	@return 파일 확장자 체크 후 결과값 리턴<br>
	@param filename 파일이름
	******************************************************/
	public static String getExtension(String filename){
		if(filename == null || filename.length()<= 0 || filename.equals("") || filename.equals("null")){
			return "";
		}
		int index = filename.lastIndexOf(".");
		if(index > 0){
			String fileName = filename.substring(0, index);
			String fileExtension = filename.substring(index + 1);
			return fileExtension;
		}else{
			return ""; 
		}

	}
	
	/*****************************************************
	파일 업로드시 파일 확장자를 체크해서 사용 가능 여부 리턴
	<b>작성자</b>       : 이희락<br>
	@return 파일 확장자 종류별 사용 가능 여부 리턴<br>
	@param extension 확장자 이름
	@param strType 확장자 타입 : IMG(이미지 파일), ATTACH(첨부파일)
	******************************************************/
	public static boolean getEnableExtension(String extension, String strType){
		if(extension == null || extension.length()<= 0 || extension.equals("") || extension.equals("null")){
			return false;
		}
		if(strType.equals("IMG")){
			if(extension.toUpperCase().equals("JPG") ||
					extension.toUpperCase().equals("BMP") ||
					extension.toUpperCase().equals("JPEG") ||
					extension.toUpperCase().equals("TIF") ||
					extension.toUpperCase().equals("GIF") ||
					extension.toUpperCase().equals("TIFF") ||
					extension.toUpperCase().equals("PNG")){
				return true;
				
			}else{
				return false;
			}
		}else if(strType.equals("ATTACH")){
			if(!extension.toUpperCase().equals("JSP") ||
					!extension.toUpperCase().equals("PHP") ||
					!extension.toUpperCase().equals("CGI") || 
					!extension.toUpperCase().equals("CPL") ||
					!extension.toUpperCase().equals("DCP") ||
					!extension.toUpperCase().equals("DRV") ||
					!extension.toUpperCase().equals("EML") ||
					!extension.toUpperCase().equals("HTA") ||
					!extension.toUpperCase().equals("ASP") ||
					!extension.toUpperCase().equals("ASPX") ||
					!extension.toUpperCase().equals("EXE") || 
					!extension.toUpperCase().equals("COM") || 
					!extension.toUpperCase().equals("DLL") ||
					!extension.toUpperCase().equals("LNK") ||
					!extension.toUpperCase().equals("OCX") ||
					!extension.toUpperCase().equals("JS") ||
					!extension.toUpperCase().equals("BIN") ||
					!extension.toUpperCase().equals("AS") || 
					!extension.toUpperCase().equals("PL") ||
					!extension.toUpperCase().equals("BAK") ||
					!extension.toUpperCase().equals("PHP3") ||
					!extension.toUpperCase().equals("SWF") ||
					!extension.toUpperCase().equals("VBS") ||
					!extension.toUpperCase().equals("SQL") ||
					!extension.toUpperCase().equals("URL") ||
					!extension.toUpperCase().equals("HTML") ||
					!extension.toUpperCase().equals("HTM") ||
					!extension.toUpperCase().equals("XML") ||
					!extension.toUpperCase().equals("BAT") ||
					!extension.toUpperCase().equals("MSI") || 
					!extension.toUpperCase().equals("CLASS") ||
					!extension.toUpperCase().equals("SH")){
				return true;
			}
		}
		return false;

	}

	public static String getValue(String value){
 
    	if (value != null && value.length() > 0 && !value.equals("null")) {
    	
	    	value = value
	    	.replaceAll("&","&amp;")
	    	.replaceAll("#","&#35;")
	    	.replaceAll("\"","&#34;")
	    	.replaceAll("<","&lt;")
	    	.replaceAll(">","&gt;")
			.replaceAll("`","&#39;")			
			.replaceAll("′","&#39;")
			.replaceAll("'","&#39;")
			.replaceAll("’","&#39;")
			.replaceAll("‘","&#39;")
			.replaceAll("%","&#37;")
//			.replaceAll(";","&#59")
	    	.replaceAll("\\(","&#40;")
	    	.replaceAll("\\)","&#41;");
	    	
	    	return value;
    	} else {
    		return "";
    	}
    }
	/**
		문자열(str)에서 찾을 문자(sch)를 문자열(str)의 뒷부분부터 찾아서 interval 따라 문자열 반환
		*interval : -1:앞문자를 반환, 1:뒷문자열을 반환
	*/
	public static String resstr(String str, String sch, int interval) {

		try {
			int pos = str.lastIndexOf(sch);
			if(pos != -1) {
				if(interval == -1) {
					str = str.substring(0, pos);
				}
				else if(interval == 1) {
					str = str.substring(pos+1, str.length());
				}
			}
		}
		catch(Exception e) {
			System.out.println("CommonUtil.resstr(String str, String sch) method error : "+ e);
		}

		return str;
	}
	
	public static String text_replace(String memo, boolean flag){
		
		String memo_low = "";
		if(flag) { // HTML tag를 사용하게 할 경우 부분 허용
		//HTML tag를 모두 제거
			memo = memo.replaceAll("<","&lt;");
			memo = memo.replaceAll(">","&gt;");
			// 허용할 HTML tag만 변경
			memo = memo.replaceAll("&lt;p&gt;", "<p>");
			memo = memo.replaceAll("&lt;P&gt;", "<P>");
			memo = memo.replaceAll("&lt;br&gt;", "<br>");
			memo = memo.replaceAll("&lt;BR&gt;", "<BR>");
			memo = memo.replaceAll("&#39;", "'");
			memo = memo.replaceAll("&#37;", "%");
		//스크립트 문자열 필터링 (선별함 - 필요한 경우 보안가이드에 첨부된 구문 추가)
			memo_low= memo.toLowerCase();
			if(memo_low.contains("javascript") || memo_low.contains("script") ||
				memo_low.contains("iframe") || memo_low.contains("document") ||
				memo_low.contains("vbscript") || memo_low.contains("applet") ||
				memo_low.contains("embed") || memo_low.contains("object") ||
				memo_low.contains("frame") || memo_low.contains("grameset") ||
				memo_low.contains("layer") || memo_low.contains("bgsound") ||
				memo_low.contains("alert") || memo_low.contains("onblur") ||
				memo_low.contains("onchange") || memo_low.contains("onclick") ||
				memo_low.contains("ondblclick") || memo_low.contains("enerror") ||
				memo_low.contains("onfocus") || memo_low.contains("onload") ||
				memo_low.contains("onmouse") || memo_low.contains("onscroll") ||
				memo_low.contains("onsubmit") || memo_low.contains("onunload")) {
				memo = memo_low;
				memo = memo.replaceAll("javascript", "x-javascript");
				memo = memo.replaceAll("script", "x-script");
				memo = memo.replaceAll("iframe", "x-iframe");
				memo = memo.replaceAll("document", "x-document");
				memo = memo.replaceAll("vbscript", "x-vbscript");
				memo = memo.replaceAll("applet", "x-applet");
				memo = memo.replaceAll("embed", "x-embed");
				memo = memo.replaceAll("object", "x-object");
				memo = memo.replaceAll("frame", "x-frame");
				memo = memo.replaceAll("grameset", "x-grameset");
				memo = memo.replaceAll("layer", "x-layer");
				memo = memo.replaceAll("bgsound", "x-bgsound");
				memo = memo.replaceAll("alert", "x-alert");
				memo = memo.replaceAll("onblur", "x-onblur");
				memo = memo.replaceAll("onchange", "x-onchange");
				memo = memo.replaceAll("onclick", "x-onclick");
				memo = memo.replaceAll("ondblclick","x-ondblclick");
				memo = memo.replaceAll("enerror", "x-enerror");
				memo = memo.replaceAll("onfocus", "x-onfocus");
				memo = memo.replaceAll("onload", "x-onload");
				memo = memo.replaceAll("onmouse", "x-onmouse");
				memo = memo.replaceAll("onscroll", "x-onscroll");
				memo = memo.replaceAll("onsubmit", "x-onsubmit");
				memo = memo.replaceAll("onunload", "x-onunload");
			}
		}else { // HTML tag를 사용하지 못하게 할 경우
			memo = memo.replaceAll("<","&lt;");
			memo = memo.replaceAll(">","&gt;");
			memo = memo.replaceAll("'","&#39;");
			memo = memo.replaceAll("`","&#39;");		
			memo = memo.replaceAll("′","&#39;");
			memo = memo.replaceAll("’","&#39;");
			memo = memo.replaceAll("‘","&#39;");
			memo = memo.replaceAll("%","&#37;");
			//System.out.println(memo);
		}
		
		
		return memo;
		
	}
	
	public static boolean isNumber(String arg)
	{
		if(arg == null || arg.equals("")){
			return false;
		}

		boolean isNumber = true;
		for( int i=0; i < arg.length() ; i++ ){
			char a=arg.charAt(i);
			if( !Character.isDigit(a) ){
				isNumber = false;
				break;
			}
		}
		return isNumber;
	}


}
