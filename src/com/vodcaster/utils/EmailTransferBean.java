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
�� Ŭ������ ���� ������ ���� �Լ��� ��Ƴ��� Ŭ�����̴�.
@author  Jong-Hyun Ho
@version 2004/12/29
*/
public class EmailTransferBean 
{

/**
	from_email�κ��� to_email�� titleStr Ÿ��Ʋ�� content �������� ������ �߼��մϴ�.
	@param from_name  : ������ �̸�
	@param from_email : ������ ��� �̸��� �ּ�
	@param to_email : �޴»�� �̸��� �ּ�
	@param titleStr : ���� ����
	@param content  : ���� ����
	@return ���� �߼��� �۰��̸� 1 �����̸� -1�� ��ȯ�մϴ�.
*/
public int sendMail(String from_name, String from_email, String to_email, String titleStr, String content)
{
	int result = -1;	


	// JavaMail�� Session�� Debug �Ӽ� ������ ����
	// boolean �� �ڷḦ �����ϰ� false�� �Ҵ��մϴ�.
	boolean debug = false;
	
	// Session�� �����ϱ� ���� java.util.Properties Ŭ������
	// �����ϰ� SMTP ȣ��Ʈ �ּҸ� �Ҵ��մϴ�.
	Properties props = new Properties();
	props.put("mail.smtp.host", DirectoryNameManager.MAIL_SERVER);

	// �⺻ Session�� �����ϰ� �Ҵ��մϴ�.
//	Session msgSession = Session.getInstance(props, null);
	Session msgSession = Session.getDefaultInstance(props, null);
	msgSession.setDebug(debug);

	try {
		// Message Ŭ������ ��ü�� Session�� �̿��� �����մϴ�.
		MimeMessage msg = new MimeMessage(msgSession);

		// From�� �����մϴ�.
		//InternetAddress from = new InternetAddress(from_email);
		InternetAddress from = new InternetAddress(from_email, from_name, "euc-kr" );
		msg.setFrom(from);

		// �޴��̸� �����մϴ�.
		InternetAddress to = new InternetAddress(to_email);
		msg.setRecipient(Message.RecipientType.TO, to);
		
		// ������ �����մϴ�.
		msg.setSubject(titleStr, "euc-kr");

		// ������ �����մϴ�.
		msg.setText(content, "euc-kr");

		//����� �����մϴ�.
		msg.setHeader("Content-Type", "text/html");
		
		// ������ �����մϴ�.
		Transport.send(msg);
    
		result = 1;
	}catch (Exception e) {
		System.err.println(e);
		result = -1;
	}
	return result;
}



/*****************************************************
�����ڰ� ���鿡�� ���� ������.<p>
<b>�ۼ���</b>       : ȣ����<br>
<b>���� JSP</b>     : �̸��ϰ���<br>
******************************************************/

public int sendEmailAllMemeber(String from_name,String from_email,String title, String [] email_array, String [] name_array, String message){

	int result = -1;

	for(int i = 0 ; i < email_array.length ; i++ ){
		if( !email_array[i].equals("") || email_array[i] != null ){
		result = sendMail( CharacterSet.toKorean(from_name), from_email, email_array[i], CharacterSet.toKorean( from_name)+" ���� "+name_array[i]+" �Կ��� "+CharacterSet.toKorean( title ), CharacterSet.toKorean(message) );

		}
	}
	return result;

}

/**
�����ڰ� ��üȸ���鿡�� ������ �������� �Ҷ�
@return ���� �߼��� �����̸� 1 �����̸� -1�� ��ȯ�մϴ�.
@see #sendMail(String, String, String[], String, String)
@author  ȣ����
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
