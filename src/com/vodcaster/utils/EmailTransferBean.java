/*
 * Created on 2004. 12. 29
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.utils;

import java.util.*;
import java.io.*;
import javax.activation.*;
import javax.mail.*;
import javax.mail.Address;
import javax.mail.internet.*;
import com.yundara.util.*;
import com.vodcaster.sqlbean.DirectoryNameManager;

/**
 * @author Jong-Hyun Ho
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
/**
이 클래스는 메일 전송을 위한 함수를 모아놓은 클래스이다.
@author  Jong-Hyun Ho
@version 2004/12/29
*/
public class EmailTransferBean 
{

/**
	from_email로부터 to_email로 titleStr 타이틀과 content 내용으로 메일을 발송합니다.
	@param from_name  : 보내는 이름
	@param from_email : 보내는 사람 이메일 주소
	@param to_email : 받는사람 이메일 주소
	@param titleStr : 메일 제목
	@param content  : 메일 내용
	@return 메일 발송이 송공이면 1 실패이면 -1을 반환합니다.
*/
public int sendMail(String from_name, String from_email, String to_email, String titleStr, String content)
{
	int result = -1;	


	// JavaMail의 Session의 Debug 속성 세팅을 위해
	// boolean 형 자료를 선언하고 false를 할당합니다.
	boolean debug = false;
	
	// Session을 생성하기 위해 java.util.Properties 클래스를
	// 생성하고 SMTP 호스트 주소를 할당합니다.
	Properties props = new Properties();
	props.put("mail.smtp.host", DirectoryNameManager.MAIL_SERVER);

	// 기본 Session을 생성하고 할당합니다.
//	Session msgSession = Session.getInstance(props, null);
	Session msgSession = Session.getDefaultInstance(props, null);
	msgSession.setDebug(debug);

	try {
		// Message 클래스의 객체를 Session을 이용해 생성합니다.
		MimeMessage msg = new MimeMessage(msgSession);

		// From을 세팅합니다.
		//InternetAddress from = new InternetAddress(from_email);
		InternetAddress from = new InternetAddress(from_email, from_name, "euc-kr" );
		msg.setFrom(from);

		// 받는이를 세팅합니다.
		InternetAddress to = new InternetAddress(to_email);
		msg.setRecipient(Message.RecipientType.TO, to);
		
		// 제목을 설정합니다.
		msg.setSubject(titleStr, "euc-kr");

		// 내용을 설정합니다.
		msg.setText(content, "euc-kr");

		//헤더를 설정합니다.
		msg.setHeader("Content-Type", "text/html");
		
		// 메일을 전송합니다.
		Transport.send(msg);
    
		result = 1;
	}catch (Exception e) {
		System.err.println(e);
		result = -1;
	}
	return result;
}



/*****************************************************
관리자가 고객들에게 메일 보내기.<p>
<b>작성자</b>       : 호종현<br>
<b>관련 JSP</b>     : 이메일관련<br>
******************************************************/

public int sendEmailAllMemeber(String from_name,String from_email,String title, String [] email_array, String [] name_array, String message){

	int result = -1;

	for(int i = 0 ; i < email_array.length ; i++ ){
		if( !email_array[i].equals("") || email_array[i] != null ){
		result = sendMail( CharacterSet.toKorean(from_name), from_email, email_array[i], CharacterSet.toKorean( from_name)+" 에서 "+name_array[i]+" 님에게 "+CharacterSet.toKorean( title ), CharacterSet.toKorean(message) );

		}
	}
	return result;

}

/**
관리자가 전체회원들에게 메일을 보내고자 할때
@return 메일 발송이 성공이면 1 실패이면 -1을 반환합니다.
@see #sendMail(String, String, String[], String, String)
@author  호종현
*/

public int sendAllMember(String from_name, String from_email,String to_email[],String title, String message){

int result = -1;
for(int i = 0 ; i < to_email.length ; i++ ){
	if( !to_email[i].equals("") || to_email[i] != null ){
		result = sendMail( from_name, from_email, to_email[i],  title, message );
	
	}
}
return result;
}




}
