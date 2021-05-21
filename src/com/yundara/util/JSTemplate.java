/*
 * 생성일 : 2004. 12. 27.
 *
 * 사용방법 : 
 */

package com.yundara.util;

import java.io.*;
import java.net.*;
import java.util.*;

import com.yundara.io.LoggerImpl;

/**
 * @author 오영석
 *
 * TODO 클래스에 대한 설명
 */
public class JSTemplate extends LoggerImpl {
    private String content = null;
    private long timeLoaded;
    private String buffContent;
    private URL url;
	protected String enc = "ko";

	protected Hashtable ht = new Hashtable();

    public JSTemplate(URL url) {
		this.url = url;
        loadURL(url);
    }

	public void setEncoding(String enc) {
		this.enc = enc;
	}

	public boolean addTag(String tag, String value) {
		boolean returnValue = false;
		if( !ht.containsKey(tag) ) {
			ht.put(tag, value);
			returnValue = true;
		}

		return returnValue;
	}

	public void setTag(String tag, String value) {
		ht.put(tag, value);
	}

	public void removeTag(String tag) {
		ht.remove(tag);
	}

    private void loadURL(URL url) {
		Date now = new Date();
		try {
			StringBuffer buffer = new StringBuffer();
			URLConnection uc = url.openConnection();
			uc.connect();
			InputStream in = uc.getInputStream();
			int i;
			while ( ( i = in.read() ) != -1 ) {
				buffer.append( ( char )i );
			}
 
			content = buffer.toString();
			timeLoaded = now.getTime();

		} catch (IOException e) {
			printLog("JSTemplate construction error --> " +  e);
		}
		buffContent = content;
    }

	public int replaceTagRange(String tag1, String tag2, String text, int howMany) {
		int pointer=0, count=0, index1, index2;
		boolean done=false;

		while(!done) {
			index1 = buffContent.indexOf(tag1,pointer);
			if(index1 > -1) {
				index2 = buffContent.indexOf(tag2,pointer + tag1.length());
				if(index2 > -1) { //Found both tags, now replace
					buffContent = buffContent.substring(0,index1) + text + buffContent.substring(index2 + tag2.length());
					pointer = index1 + text.length();
					count++;
					if(howMany > 0 && count >= howMany) {
						done=true;
					}
				} else {
					done=true;
				}
			} else {
				done=true;
			}
		}
		return count;
	}

	public int replaceTag(String tag, String text, int howMany) {
		int pointer=0, count=0, index;
		boolean done=false;
 
		while(!done) {
			index = buffContent.indexOf(tag,pointer);
			if(index > -1) {
				buffContent = buffContent.substring(0,index) + text + buffContent.substring(index + tag.length());
				pointer = index + text.length();
				count++;
				if(howMany > 0 && count >= howMany) {
					done=true;
				}
			} else {
				done=true;
			}
		}
		return count;
	}

	public int replaceTagRange(String tag1, String tag2, String text) {
		return replaceTagRange(tag1,tag2,text,-1);
	}

	public int replaceTag(String tag, String text) {
		return replaceTag(tag,text,-1);         
	}

	public String toString() {
		return buffContent;
	}
 
	public void reloadOnChanged() {
		URLConnection conn;
		try{
			conn = url.openConnection();
		} catch(IOException ex) {
			printLog("JSTemplate reloadOnChanged() error --> " +  ex);
			return;
		}

		long mod = conn.getLastModified(); // Not much traffic for this

		if((mod - timeLoaded) > 0) { // Reload if it has changed
			loadURL(url);
		}
	}

	public void reset() {
		buffContent = content;
	}

	public String getConvContent() {
		String returnValue = "";

		reloadOnChanged();

		for(Enumeration e = ht.keys();e.hasMoreElements();) {
			String key = (String)e.nextElement();
			String value = (String)ht.get(key);
			replaceTag(key, value);
		}

		if(enc.equals("ko")) {
			returnValue = CharacterSet.toKorean(toString());
		} else if(enc.equals("en")){
			returnValue = CharacterSet.toEnglish(toString());
		} else {
			returnValue = toString();
		}

		reset();
		return returnValue;
	}

    /**
     * 
     * @uml.property name="content"
     */
    public String getContent() {
        reloadOnChanged();
        return this.content;
    }

}
