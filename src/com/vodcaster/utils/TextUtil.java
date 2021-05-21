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
 * �ؽ�Ʈ ������ �о� ���� �ٲ� �� ���� �Ѵ�. 
 */

public class TextUtil
{

	/*---------------------------
	 * �ؽ�Ʈ ������ �о� ������ ����
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
	 * ���ڿ� ��ȯ
	 *
	 * text : ���� ���ڿ�
	 * oldWord : �ٲ� ���ڿ�
	 * newWord : �ٲ� ���ڿ�
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
	 * 1����Ʈ �������� Ȯ��
	 *
	 * getLimitedString(int limitedByte, String arg)���� ���
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
	 * ���ڿ��� ����Ʈ ���Ϸ� �ڸ���.
	 *
	 * limitedByte  : ������ byte ��
	 * arg          : �������ڿ�
	 * returnString : limitedByte byte ��ŭ ���ѵ� ���ڿ�
	 * Jong-Hyun Ho
	 *-------------------------------------------*/
	public static String getLimitedString(int limitedByte, String arg)
	{

		if(arg == null)
			return null;

		int returnLength=0;
		int LetterByte = 1;//�ش� ������ ����Ʈ ��
		StringBuffer returnString = new StringBuffer();//��� ���ڿ�

		for( int i=0; i < arg.length() ; i++ )
		{
			char a=arg.charAt(i);

			if( Character.isLetter(a) &&  Character.toUpperCase(a) >= 'A' && Character.toUpperCase(a) <= 'Z' )//����(���� 1byte)
				LetterByte = 1;
			else if( Character.isLetter(a) )//����(�ѱ� 2byte)
				LetterByte = 2;
			else if( Character.isDigit(a) )//���� 1byte
				LetterByte = 1;
			else if( Character.isWhitespace(a) )//���鹮��( ' ' ) 1byte
				LetterByte = 1;
			else if(isOneByteSpecialCharacter(a))//Ư�� ���� 1byte 
				LetterByte = 1;
			else//�׿� Ư�� ���� 2byte
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
		���ڿ��� ����Ʈ ���Ϸ� �ڸ��ϴ�.

		@param limit        : ������ byte ��
		@param arg          : �������ڿ�
		@return limit byte ��ŭ ���ѵ� ���ڿ��� ��ȯ�մϴ�.
		@author Jong-Hyun Ho
	*/
	public static String getLimitedString_(int limit, String arg)
	{

		if(arg == null)
			return null;

		int returnLength=0;//��� ���ڿ��� ����Ʈ �� : limit - 1 ~ limit (byte)
		int LetterByte = 1;//�ش� ������ ����Ʈ ��
		StringBuffer returnString = new StringBuffer();//��� ���ڿ�

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
	���� ���ε�� ���� Ȯ���ڸ� �����Ѵ�.
	<b>�ۼ���</b>       : �����<br>
	@return ���� Ȯ���� üũ �� ����� ����<br>
	@param filename �����̸�
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
	���� ���ε�� ���� Ȯ���ڸ� üũ�ؼ� ��� ���� ���� ����
	<b>�ۼ���</b>       : �����<br>
	@return ���� Ȯ���� ������ ��� ���� ���� ����<br>
	@param extension Ȯ���� �̸�
	@param strType Ȯ���� Ÿ�� : IMG(�̹��� ����), ATTACH(÷������)
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
			.replaceAll("��","&#39;")
			.replaceAll("'","&#39;")
			.replaceAll("��","&#39;")
			.replaceAll("��","&#39;")
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
		���ڿ�(str)���� ã�� ����(sch)�� ���ڿ�(str)�� �޺κк��� ã�Ƽ� interval ���� ���ڿ� ��ȯ
		*interval : -1:�չ��ڸ� ��ȯ, 1:�޹��ڿ��� ��ȯ
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
		if(flag) { // HTML tag�� ����ϰ� �� ��� �κ� ���
		//HTML tag�� ��� ����
			memo = memo.replaceAll("<","&lt;");
			memo = memo.replaceAll(">","&gt;");
			// ����� HTML tag�� ����
			memo = memo.replaceAll("&lt;p&gt;", "<p>");
			memo = memo.replaceAll("&lt;P&gt;", "<P>");
			memo = memo.replaceAll("&lt;br&gt;", "<br>");
			memo = memo.replaceAll("&lt;BR&gt;", "<BR>");
			memo = memo.replaceAll("&#39;", "'");
			memo = memo.replaceAll("&#37;", "%");
		//��ũ��Ʈ ���ڿ� ���͸� (������ - �ʿ��� ��� ���Ȱ��̵忡 ÷�ε� ���� �߰�)
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
		}else { // HTML tag�� ������� ���ϰ� �� ���
			memo = memo.replaceAll("<","&lt;");
			memo = memo.replaceAll(">","&gt;");
			memo = memo.replaceAll("'","&#39;");
			memo = memo.replaceAll("`","&#39;");		
			memo = memo.replaceAll("��","&#39;");
			memo = memo.replaceAll("��","&#39;");
			memo = memo.replaceAll("��","&#39;");
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
