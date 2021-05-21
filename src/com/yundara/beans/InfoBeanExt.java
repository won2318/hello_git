/*
 * ������ : 2004. 12. 24.
 *
 * ����� : 
 */

package com.yundara.beans;

import org.apache.commons.beanutils.BeanUtils;
import java.util.*;

import com.yundara.conf.SiteConf;
import com.yundara.io.*;
import com.yundara.util.*;

/**
 * @author ������
 * 
 * TODO �𵨿��� ����Ÿ�� ������ ���� ���Ǵ� Ŭ����
 */

public class InfoBeanExt extends LoggerImpl implements java.io.Serializable, BeansAttributeListener {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public final static String version		= "InfoBeanExt V1.1";
	
	/**
	 * ����Ÿ ����� � ���ڵ��� ��������� ��Ÿ����.
	 * ko:�ѱ۷�
	 * en:��������
	 * none:��������
	 */	
	private String enc						= "none"; //���ڿ� ���ڵ�����������....(�⺻�� �Ѵ�)
	/**
	 * ����Ʈ���� �����ϰ� �ִ�.
	 */		
	private String sname					= "";
	/**
	 * �Ӽ� Ű��, ���� ������ �ִ� �����̳�
	 */	
	private Map data						= new HashMap();//InfoBean�� ����Ÿ�ʵ� �������

	public InfoBeanExt() {
		super();
		init();
		init(data);		
	}

	/**
	 * ����Ʈ���� �Ķ���ͷ� �ϴ� ������
	 */		
	public InfoBeanExt(String sname) {
	    super(sname);
	    this.sname = sname;
	    init();
	    init(data);
	}

	/**
	 * �����ڰ� ȣ��� �� ȣ��Ǵ� �޼ҵ�� �ַ� �ʱ�ȭ �Ҷ� ���ȴ�.
	 * �� �޼ҵ带 �������̵��ؼ� ����� �� �ִ�.
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
	        printLog("init() - ����");
	        printLog(ex.getMessage());
	    }		   
	}
	
	/**
	 * �ʵ忡 ����Ǿ� �ִ� ������ ���� Map �� �����Ų��.
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
	        printLog("update() - ����");
	    }	    
	}

	/**
	 * ���ڵ� ����� �ٲ۴�.
	 */	
	public final String setEncoding(String enc) {
		String old_enc = this.enc;
		this.enc = enc.toLowerCase();
		return old_enc;
	}

	/**
	 * ���� Map�� ����Ǿ� �ִ� ���� �о�´�.
	 */	
	public final Object getAttribute(String key) {
		attributeGetBefore(new BeansEvent(key, data.get(key), data));
	    return data.get(key);
	}

	/**
	 * ���� Map�� ����Ÿ�� �����Ѵ�.
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
	 * ���� �ʿ��� Ű�� �ش�Ǵ� ���� �����Ѵ�.
	 */	
	public Object removeAttribute(String key) {
	    attributeRemoveBefore(new BeansEvent(key, data.get(key), data));
	    Object ret = data.remove(key);
	    attributeRemoved(new BeansEvent(key, ret, data));
	    return ret;
	}

    /**
     * ���� ���� �����Ѵ�.
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
