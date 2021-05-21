/*
 * 생성일 : 2004. 12. 24.
 *
 * 사용방법 : 
 */

package com.yundara.beans;

import org.apache.commons.beanutils.BeanUtils;
import java.util.*;

import com.yundara.conf.SiteConf;
import com.yundara.io.*;
import com.yundara.util.*;

/**
 * @author 오영석
 * 
 * TODO 모델에서 데이타의 전송을 위해 사용되는 클래스
 */

public class InfoBeanExt extends LoggerImpl implements java.io.Serializable, BeansAttributeListener {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public final static String version		= "InfoBeanExt V1.1";
	
	/**
	 * 데이타 저장시 어떤 인코딩을 사용할지를 나타낸다.
	 * ko:한글로
	 * en:영문으로
	 * none:하지않음
	 */	
	private String enc						= "none"; //문자열 인코딩할지안할지....(기본은 한다)
	/**
	 * 사이트명을 저장하고 있다.
	 */		
	private String sname					= "";
	/**
	 * 속성 키와, 값을 가지고 있는 컨테이너
	 */	
	private Map data						= new HashMap();//InfoBean의 데이타필드 저장장소

	public InfoBeanExt() {
		super();
		init();
		init(data);		
	}

	/**
	 * 사이트명을 파라미터로 하는 생성자
	 */		
	public InfoBeanExt(String sname) {
	    super(sname);
	    this.sname = sname;
	    init();
	    init(data);
	}

	/**
	 * 생성자가 호출될 때 호출되는 메소드로 주로 초기화 할때 사용된다.
	 * 이 메소드를 오버라이드해서 사용할 수 있다.
	 */	
	public void init(Map data) {
	}
	
	private void init() {
	    try {
		    SiteConf conf = SiteConf.getInstance();
		    String _enc = null;
		    
		    if(sname == null || sname.equals("")) {
		        _enc = (String)conf.getConf("enc");
		    } else {
		        _enc = (String)((Hashtable)conf.getSubConf(sname)).get("enc");
       	    }
		    if(_enc == null || _enc.equals("")) _enc = "none";
	        enc = _enc.toLowerCase();
	        
	        Map map = BeanUtils.describe(this);
	        map.remove("version");
	        map.remove("logger");
	        map.remove("createTime");
	        map.remove("printable");
	        map.remove("class");
	        map.remove("data");
	        data = map;
	        
	    } catch(Exception ex) {
	        printLog("init() - 오류");
	        printLog(ex.getMessage());
	    }		   
	}
	
	/**
	 * 필드에 저장되어 있는 값들을 내부 Map 에 적용시킨다.
	 */		
	public void update() {
	    try {
	        
	        Map map = BeanUtils.describe(this);
	        map.remove("version");
	        map.remove("logger");
	        map.remove("createTime");
	        map.remove("printable");
	        map.remove("class");
	        map.remove("data");
	        
	        for(Iterator i = map.keySet().iterator();i.hasNext();) {
	            String key = (String)i.next();
	            try {
	                setAttribute(key, BeanUtils.getProperty(this, key));
	            } catch(Exception ex){}
	        }
	    } catch(Exception ex) {
	        printLog("update() - 오류");
	    }	    
	}

	/**
	 * 인코딩 방법을 바꾼다.
	 */	
	public final String setEncoding(String enc) {
		String old_enc = this.enc;
		this.enc = enc.toLowerCase();
		return old_enc;
	}

	/**
	 * 내부 Map에 저장되어 있는 값을 읽어온다.
	 */	
	public final Object getAttribute(String key) {
		attributeGetBefore(new BeansEvent(key, data.get(key), data));
	    return data.get(key);
	}

	/**
	 * 내부 Map에 데이타를 저장한다.
	 */		
	public final Object setAttribute(String key, Object value) {
		if(!data.containsKey(key))
		    attributeAddBefore(new BeansEvent(key, value, data));
		else  
		    attributeReplaceBefore(new BeansEvent(key, value, data));

		if(enc.equals("ko") && value.getClass().getName().equals("java.lang.String")) {
		    value = CharacterSet.toKorean((String)value);
		} else if(enc.equals("en") && value.getClass().getName().equals("java.lang.String")) {
		    value = CharacterSet.toEnglish((String)value);
		}
		
	    Object ret = data.put(key, value);
	    try {
	        BeanUtils.setProperty(this, key, value);
	    } catch(Exception ex) {
	        printLog(ex.getMessage());
	    }
	    
	    if(ret == null) attributeAdded(new BeansEvent(key, value, data));
	    else attributeReplaced(new BeansEvent(key, value, data));
	    
	    return ret;
	}

	/**
	 * 내부 맵에서 키에 해당되는 값을 삭제한다.
	 */	
	public Object removeAttribute(String key) {
	    attributeRemoveBefore(new BeansEvent(key, data.get(key), data));
	    Object ret = data.remove(key);
	    attributeRemoved(new BeansEvent(key, ret, data));
	    return ret;
	}

    /**
     * 내부 맵을 리턴한다.
     * 
     * @uml.property name="data"
     */
    public HashMap getData() {
        return (HashMap) data;
    }

	
    public void attributeAddBefore(BeansEvent evt) {
    }
    public void attributeAdded(BeansEvent evt) {
    }
    public void attributeGetBefore(BeansEvent evt) {
    }
    public void attributeRemoveBefore(BeansEvent evt) {
    }
    public void attributeRemoved(BeansEvent evt) {
    }
    public void attributeReplaceBefore(BeansEvent evt) {
    }
    public void attributeReplaced(BeansEvent evt) {
    }
 }
