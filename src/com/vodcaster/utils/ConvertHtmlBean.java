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
TextArea�� ����ۿ� ���� �Ϲ� �ؽ�Ʈ���¿� HTML���¸� ó���ϴ� Ŭ�����Դϴ�.
*/

public class ConvertHtmlBean {

	private String content;

	public ConvertHtmlBean(){}


	/*****************************************************
	�Ϲ� �ؽ�Ʈ�ۿ� HTML �ױװ� ���Ե� ��� �±װ� HTML���·� �������� �ʵ��� ó���մϴ�.<p>

	<b>�ۼ���</b>       : ȣ����<br>
	cf) '<', '\n', ' '���ڸ� '&lt', '<br>', '&nbsp;'�� �ٲپ��ݴϴ�.
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
	�Ϲ� �ؽ�Ʈ�ۿ� HTML �ױװ� ���Ե� ��� �±װ� HTML���·� �������� �ʵ��� ó���մϴ�.�̸� �����ϱ� ����
	<code>html</code>�÷��׸� �Ӵϴ�.<p>

	<b>�ۼ���</b>       : ȣ����<br>
	cf) '<', '\n', ' '���ڸ� '&lt', '<br>', '&nbsp;'�� �ٲپ��ݴϴ�.
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
	    	.replaceAll("��","&#39;")
			.replaceAll("`","&#39;")			
			.replaceAll("��","&#39;")
			.replaceAll("'","&#39;")
			.replaceAll("��","&#39;")
			.replaceAll("��","&#39;")
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
