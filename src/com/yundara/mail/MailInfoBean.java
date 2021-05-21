/*
 * 생성일 : 2004. 12. 27.
 *
 * 사용방법 : 
 */

package com.yundara.mail;

import com.yundara.util.*;

/**
 * @author 오영석 *  * TODO 클래스에 대한 설명
 */

public class MailInfoBean extends com.yundara.beans.InfoBeanExt {
	private String name			= "";
	private String from			= "";
	private String to			= "";
	private String title		= "제목없음";
	private String contents		= "내용없음";
	private String contentType	= "text/html";
	private String host			= "localhost";

    /**
     * 
     * @uml.property name="jsTemp"
     * @uml.associationEnd multiplicity="(0 1)"
     */
    private JSTemplate jsTemp = null;

    /**
     * 
     * @uml.property name="contents"
     */
    public String getContents() {
        String returnValue = "";

        if (jsTemp != null) {
            returnValue = jsTemp.getConvContent();
        } else {
            returnValue = this.contents;
        }

        return returnValue;
    }

    /**
     * 
     * @uml.property name="contents"
     */
    public void setContents(String contents) {
        this.contents = contents;
    }

    /**
     * 
     * @uml.property name="contentType"
     */
    public String getContentType() {
        return contentType;
    }

    /**
     * 
     * @uml.property name="contentType"
     */
    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    /**
     * 
     * @uml.property name="from"
     */
    public String getFrom() {
        return from;
    }

    /**
     * 
     * @uml.property name="from"
     */
    public void setFrom(String from) {
        this.from = from;
    }

    /**
     * 
     * @uml.property name="host"
     */
    public String getHost() {
        return host;
    }

    /**
     * 
     * @uml.property name="host"
     */
    public void setHost(String host) {
        this.host = host;
    }

    /**
     * 
     * @uml.property name="name"
     */
    public String getName() {
        return name;
    }

    /**
     * 
     * @uml.property name="name"
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * 
     * @uml.property name="title"
     */
    public String getTitle() {
        return title;
    }

    /**
     * 
     * @uml.property name="title"
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * 
     * @uml.property name="to"
     */
    public String getTo() {
        return to;
    }

    /**
     * 
     * @uml.property name="to"
     */
    public void setTo(String to) {
        this.to = to;
    }

    
	public JSTemplate getJSTemplate() {
		return jsTemp;
	}
	
	public void setJSTemplate( JSTemplate jsTemp) {
		this.jsTemp = jsTemp;
	}
	
	
	public void printDebug() {
		printLog("name : " + getName() );
		printLog("from : " + getFrom() );
		printLog("to : " + getTo() );
		printLog("title : " + getTitle() );
		printLog("contents : " + getContents() );
		printLog("contentType : " + getContentType());
		printLog("host : " + getHost() );
	}
	
	public static void main(String[] args) {
		MailInfoBean info = new MailInfoBean();
		info.printDebug();
	}
}
