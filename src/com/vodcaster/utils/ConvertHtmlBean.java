/*
 * Created on 2005. 1. 3
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.utils;

/**
 * @author Jong-Hyun Ho
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/**
TextArea의 내용글에 대한 일반 텍스트형태와 HTML형태를 처리하는 클래스입니다.
*/

public class ConvertHtmlBean {

	private String content;

	public ConvertHtmlBean(){}


	/*****************************************************
	일반 텍스트글에 HTML 테그가 포함될 경우 태그가 HTML형태로 지원하지 않도록 처리합니다.<p>

	<b>작성자</b>       : 호종현<br>
	cf) '<', '\n', ' '문자를 '&lt', '<br>', '&nbsp;'로 바꾸어줍니다.
	******************************************************/
	public String getContent(String content){
		String temp = content;
		int pos;
		
		pos = 0;
		while((pos = temp.indexOf("<", pos + 1)) != -1) {
			String left = temp.substring(0, pos);
			String right = temp.substring(pos + 1, temp.length());
			temp = left + "&lt;" + right;
		}

		pos = 0;
		while((pos = temp.indexOf("\n")) != -1) {
			String left = temp.substring(0, pos);
			String right = temp.substring(pos + 1, temp.length());
			temp = left + "<br>" + right;
		}
		
		pos = 0;
		while((pos = temp.indexOf("  ", pos)) != -1) {
			String left = temp.substring(0, pos);
			String right = temp.substring(pos + 1, temp.length());
			temp = left + "&nbsp;" + right;
			pos += 4;
		}
		return temp;
	}
	/*****************************************************
	일반 텍스트글에 HTML 테그가 포함될 경우 태그가 HTML형태로 지원하지 않도록 처리합니다.이를 구분하기 위해
	<code>html</code>플래그를 둡니다.<p>

	<b>작성자</b>       : 호종현<br>
	cf) '<', '\n', ' '문자를 '&lt', '<br>', '&nbsp;'로 바꾸어줍니다.
	******************************************************/
	public String getContent(String content, String html){
		String temp = content;
		
		if(html.equals("false")){
			int pos;
			pos = 0;
			while((pos = temp.indexOf("<", pos + 1)) != -1) {
				String left = temp.substring(0, pos);
				String right = temp.substring(pos + 1, temp.length());
				temp = left + "&lt;" + right;
			}
	 
			pos = 0;
			while((pos = temp.indexOf("\n")) != -1) {
				String left = temp.substring(0, pos);
				String right = temp.substring(pos + 1, temp.length());
				temp = left + "<br>" + right;
			}
		
			pos = 0;
			while((pos = temp.indexOf("  ", pos)) != -1) {
				String left = temp.substring(0, pos);
				String right = temp.substring(pos + 1, temp.length());
				temp = left + "&nbsp;" + right;
				pos += 4;
			}
		}
		return temp;
	 }
	
	public String getContent_2(String content, String html){
		String temp = content;
		
		if(html.equals("false")){
			temp = temp
			.replaceAll("&","&amp;")
	    	.replaceAll("#","&#35;")
	    	.replaceAll("\"","&#34;")
	    	.replaceAll("<","&lt;")
	    	.replaceAll(">","&gt;")
	    	.replaceAll("%","&37;")
	    	.replaceAll("‘","&#39;")
			.replaceAll("`","&#39;")			
			.replaceAll("′","&#39;")
			.replaceAll("'","&#39;")
			.replaceAll("’","&#39;")
			.replaceAll("‘","&#39;")
			.replaceAll(";","&#59")
			.replaceAll("'","&#39;")
	    	.replaceAll("\\(","&#40;")
	    	.replaceAll("\\)","&#41;");
		} else {
			temp = temp
			.replaceAll("&amp;","&")
			.replaceAll("&quot;","'")
	    	.replaceAll("&#35;","#")
	    	.replaceAll("&#34;","\"")
	    	.replaceAll("&lt;","<")
	    	.replaceAll("&gt;",">")
	    	.replaceAll("&#39;","'")
	    	.replaceAll("&#37;","%")
	    	.replaceAll("&#40;","\\(")
	    	.replaceAll("&#41;","\\)");

			
		}
			int pos;
			pos = 0;
			while((pos = temp.indexOf("\n")) != -1) {
				String left = temp.substring(0, pos);
				String right = temp.substring(pos + 1, temp.length());
				temp = left + "<br/>" + right;
			}
		
		return temp;
	 }
}
