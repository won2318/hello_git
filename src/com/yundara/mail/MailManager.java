/*
 * 생성일 : 2004. 12. 27.
 *
 * 사용방법 : 
 */

package com.yundara.mail;

import com.yundara.io.LoggerImpl;

import java.util.*;
import java.io.*;
import javax.activation.*;
import javax.mail.*;
import javax.mail.internet.*;

import com.yundara.util.*;
import com.yundara.conf.*;
import com.oreilly.servlet.MultipartRequest;
import org.apache.commons.mail.*;

/**
 * @author 오영석 *  * TODO 클래스에 대한 설명
 */

public class MailManager extends LoggerImpl {

    /**
     * 
     * @uml.property name="instance"
     * @uml.associationEnd multiplicity="(0 1)"
     */
    private static MailManager instance = new MailManager();

    /**
     * 
     * @uml.property name="instance"
     */
    public static MailManager getInstance() {
        return instance;
    }

	private MailManager() {
		super();
		printLog("MailManager 초기화");
	}

	public boolean sendOldMail(MailInfoBean bean) {
		
		boolean returnValue = false;

		String host = bean.getHost();
		String to = bean.getTo();
		String name = bean.getName();
		String from = bean.getFrom();
		String title = bean.getTitle();
		String contents = bean.getContents();
		String type = bean.getContentType();

		try{
			Properties prop = System.getProperties();
			Session session = Session.getInstance(prop, null);
			MimeMessage message = new MimeMessage(session);
			message.setFrom( new InternetAddress(name + "<" + from + ">") );
			message.addRecipient( Message.RecipientType.TO, new InternetAddress(to) );
			message.setSubject( title, "EUC-KR" );
			message.setSentDate( new Date() );
			message.setText( contents );
			message.setHeader("Content-Type", type);

			Transport transport = session.getTransport("smtp");
			transport.connect(host, "", "");
			transport.sendMessage(message, message.getAllRecipients() );
			transport.close();
			returnValue = true;
		} catch(Exception ex) {
			printLog( "메일전송 실패:" + ex.getMessage() );
		}

		return returnValue;
	}
	
	public boolean sendMail(MailInfoBean bean) {
		
		boolean returnValue = false;

		String host = bean.getHost();
		String to = bean.getTo();
		String name = bean.getName();
		String from = bean.getFrom();
		String title = bean.getTitle();
		String contents = bean.getContents();
		String type = bean.getContentType();

		try{
			SimpleEmail email = new SimpleEmail();
			email.setCharset("EUC-KR");
			email.setHostName(host);
			email.addTo(to);
			email.setFrom(from, name);
			email.setSubject(title);
			//email.setContent(contents, "text/html");
			email.setMsg(contents);
			email.send();
			returnValue = true;
		} catch(Exception ex) {
			printLog( "메일전송 실패:" + ex.getMessage() );
		}

		return returnValue;
	}

	public boolean sendMail(MailInfoBean bean, String[] tos) {
		
		boolean returnValue = false;

		String host = bean.getHost();
		String to = bean.getTo();
		String name = bean.getName();
		String from = bean.getFrom();
		String title = bean.getTitle();
		String contents = bean.getContents();
		String type = bean.getContentType();

		try{
			SimpleEmail email = new SimpleEmail();
			email.setCharset("EUC-KR");
			email.setHostName(host);

			for(int i=0; i < tos.length; i++) {
				email.addTo(tos[i]);
			}
			
			email.setFrom(from, name);
			email.setSubject(title);
			email.setMsg(contents);
			email.send();
			
			returnValue = true;
		} catch(Exception ex) {
			printLog( "메일전송 실패:" + ex.getMessage() );
		}

		return returnValue;
	}

	public boolean sendMailAttach(MailInfoBean bean, HashMap attach) {
		
		boolean returnValue = false;

		String host = bean.getHost();
		String to = bean.getTo();
		String name = bean.getName();
		String from = bean.getFrom();
		String title = bean.getTitle();
		String contents = bean.getContents();
		String type = bean.getContentType();

		try{
			MultiPartEmail email = new MultiPartEmail();
			email.setCharset("EUC-KR");
			email.setHostName(host);
			email.addTo(to);
			email.setFrom(from, name);
			email.setSubject(title);
			email.setMsg(contents);

			for(Iterator i=attach.keySet().iterator();i.hasNext();) {
				String key = (String)i.next();
				EmailAttachment attachment = new EmailAttachment();
				attachment.setPath((String)attach.get(key));
				attachment.setDisposition(EmailAttachment.ATTACHMENT);
				attachment.setName(key);
				email.attach(attachment);
			}

			email.send();
			returnValue = true;
		} catch(Exception ex) {
			printLog( "메일전송 실패:" + ex.getMessage() );
		}

		return returnValue;
	}

	public boolean sendMailAttach(MailInfoBean bean, HashMap attach, String[] tos) {
		
		boolean returnValue = false;

		String host = bean.getHost();
		String name = bean.getName();
		String from = bean.getFrom();
		String title = bean.getTitle();
		String contents = bean.getContents();
		String type = bean.getContentType();

		try{
			MultiPartEmail email = new MultiPartEmail();
			email.setCharset("EUC-KR");
			email.setHostName(host);
			for(int i=0; i < tos.length; i++) {
				email.addTo(tos[i]);
			}
			email.setFrom(from, name);
			email.setSubject(title);
			email.setMsg(contents);

			for(Iterator i=attach.keySet().iterator();i.hasNext();) {
				String key = (String)i.next();
				EmailAttachment attachment = new EmailAttachment();
				attachment.setPath((String)attach.get(key));
				attachment.setDisposition(EmailAttachment.ATTACHMENT);
				attachment.setName(key);
				email.attach(attachment);
			}

			email.send();
			returnValue = true;

		} catch(Exception ex) {
			printLog( "메일전송 실패:" + ex.getMessage() );
		}

		return returnValue;
	}
	
	public boolean sendHtmlMailAttach(MailInfoBean bean, HashMap attach) {
		
		boolean returnValue = false;

		String host = bean.getHost();
		String to = bean.getTo();
		String name = bean.getName();
		String from = bean.getFrom();
		String title = bean.getTitle();
		String contents = bean.getContents();
		String type = bean.getContentType();

		try{
			HtmlEmail  email = new HtmlEmail ();
			email.setCharset("EUC-KR");
			email.setHostName(host);
			email.addTo(to);
			email.setFrom(from, name);
			email.setSubject(title);
			email.setHtmlMsg(contents);
			email.setTextMsg("Your email client does not support HTML messages");
			
			if(attach != null) {
			    for(Iterator i=attach.keySet().iterator();i.hasNext();) {
			        String key = (String)i.next();
			        EmailAttachment attachment = new EmailAttachment();
					attachment.setPath((String)attach.get(key));
					attachment.setDisposition(EmailAttachment.ATTACHMENT);
					attachment.setName(key);
					email.attach(attachment);
			    }
			}
			email.send();
			returnValue = true;
		} catch(Exception ex) {
			printLog( "메일전송 실패:" + ex.getMessage() );
		}

		return returnValue;
	}

	public boolean sendHtmlMailAttach(MailInfoBean bean, HashMap attach, String[] tos) {
		
		boolean returnValue = false;

		String host = bean.getHost();
		String name = bean.getName();
		String from = bean.getFrom();
		String title = bean.getTitle();
		String contents = bean.getContents();
		String type = bean.getContentType();

		try{
			HtmlEmail email = new HtmlEmail();
			email.setCharset("EUC-KR");
			email.setHostName(host);
			for(int i=0; i < tos.length; i++) {
				email.addTo(tos[i]);
			}
			email.setFrom(from, name);
			email.setSubject(title);
			email.setTextMsg("Your email client does not support HTML messages");
			email.setHtmlMsg(contents);

			if(attach != null) {
				for(Iterator i=attach.keySet().iterator();i.hasNext();) {
					String key = (String)i.next();
					EmailAttachment attachment = new EmailAttachment();
					attachment.setPath((String)attach.get(key));
					attachment.setDisposition(EmailAttachment.ATTACHMENT);
					attachment.setName(key);
					email.attach(attachment);
				}
			}
			email.send();
			returnValue = true;

		} catch(Exception ex) {
			printLog( "메일전송 실패:" + ex.getMessage() );
		}

		return returnValue;
	}
		
}
