/*
 * Created on 2004. 12. 28.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.yundara.mail;

import java.util.HashMap;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class EmailTest {

	public static void main(String[] args) {
		try {
			MailManager mgr = MailManager.getInstance();
			MailInfoBean info = new MailInfoBean();
			info.setEncoding("none");
			info.setContents("<html><font color=\"red\">테스트</font></html>");
			info.setFrom("ohysuk@itnc21.co.kr");
			info.setName("(주)아이티엔씨21");
			info.setTitle("테스트중입니다.");
			info.setHost("mail.globalpc.co.kr");
			info.setTo("ohysuk@hanmail.net");
			info.update();
			HashMap at = new HashMap();
			at.put("test.jar", "C:\\java_lib\\jdbc\\msutil.jar");
			at.put("test2.jar", "C:\\java_lib\\jdbc\\mssqlserver.jar");
			//mgr.sendMail(info);
			//mgr.sendOldMail(info);
			mgr.sendHtmlMailAttach(info, null);
			System.out.println("전송완료");

		} catch(Exception ex){
			ex.printStackTrace();
		}
	}
}
