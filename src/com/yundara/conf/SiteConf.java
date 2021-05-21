/*
 * 생성일 : 2004. 12. 14.
 *
 * 사용법:
 */

package com.yundara.conf;

import java.io.*;
import java.util.*;

/**
 * @author 오영석 *  * TODO 설정화일을 읽어와 메모리에 객체화시킨다.
 */


public class SiteConf {

    /**
     * 
     * @uml.property name="instance"
     * @uml.associationEnd multiplicity="(0 1)"
     */
    private static SiteConf instance = null;

	private static String IMSI_DIR = "/tmp/";
	private String configFileName = "/site.properties";
	private Hashtable confs = new Hashtable();

    /**
     * 
     * @uml.property name="instance"
     */
    public static SiteConf getInstance() {
        if (instance == null) {
            synchronized (SiteConf.class) {
                if (instance == null) {
                    instance = new SiteConf();
                }
            }
        }
        return instance;
    }


	private SiteConf() {
		try {
			init();
			System.out.println("SiteConf 인스턴스 생성");
		} catch (SiteConfException e) {
			System.out.println("SiteConf 인스턴스 생성 중 오류발생");
		}

	}

	/**
	 * site.properties 파일을 읽어서 설정내용을 메모리에 저장한다.<br>
	 * <b>os</b> : windows, unix<br> 
	 * <b>log_print</b> : 로그출력여부(true, false)<br> 
	 * <b>site_log</b> : 로그파일 파일명<br>
	 * <b>imsi_dir</b> : 화일업로드등의 작업을 하기위해 사용되는 임시 디렉토리
	 * 
	 */
	private void init() throws SiteConfException {
		InputStream is;
		Properties props = new Properties();

		try {
			is = getClass().getResourceAsStream(configFileName);
			//is = new FileInputStream("d:/www/conf/site.properties");
			props.load(is);
			is.close();
			createObject(props);
		} catch (Exception e) {
			System.out.println("site.properties 파일을 읽을 수 없습니다.");
			createObjectDefault();
		}	
	}
	
	/**
	 * site.properties 파일 읽을 수 없을 때 디폴트값으로 채운다.<br>
	 * os : unix<br>
	 * log_print : false<br> 
	 * site_log : /tmp/site.log<br>
	 */
	private void createObjectDefault() {
		Hashtable h = new Hashtable();
		
	    h.put("os", "unix");
		h.put("log_print", "true");
		h.put("site_log", "/tmp/site.log");  
		confs = h;
		System.out.println("SiteConf - 디폴드값을 읽어왔습니다.");
	}

	/**
	 * site.properties 파일 내용으로 채워진 Properties 객체를 Hashtable 객체에
	 * 구조적으로 채운다.
	 */
	private void createObject(Properties props) {
		Hashtable h = new Hashtable();
		
		Enumeration propNames = props.propertyNames();
		while (propNames.hasMoreElements()) {
			String name = (String) propNames.nextElement();
			int index = name.lastIndexOf(".");
			if (index != -1) {
				String siteName = name.substring(0, index);
				Hashtable tmpHash = (Hashtable) h.get(siteName);

				if (tmpHash == null) {
					h.put(siteName, new Hashtable());
					tmpHash = (Hashtable) h.get(siteName);
				}

				String tmpName = name.substring(index + 1);

				tmpHash.put(tmpName, props.getProperty(name));
				System.out.println("SiteConf - " + props.getProperty(name));

			} else {
			    h.put(name, props.getProperty(name));
			}
		}
		
		if(!h.containsKey("os")) {
		    h.put("os", "unix");
		    h.put("site_log", "/tmp/site.log");
		}
		if(!h.containsKey("log_print")) h.put("log_print", "true");
		if(!h.containsKey("site_log")) h.put("site_log", "/tmp/site.log");	
		if(!h.containsKey("imsi_dir")) h.put("site_log", "/tmp/");
		
		confs = h;
	}

    /**
     * 다른  Property 파일명을 변경한다.<br>
     * 
     * 예)<br>
     * SiteConf cnf = SiteConf.getInstance();<br>
     * cnf.setConfigFileName("test.properties");<br>
     * cnf.init();<br>
     * 
     * @uml.property name="configFileName"
     */
    public void setConfigFileName(String fileName) {
        this.configFileName = fileName;
    }


	/**
	 * 메모리에 로딩된 값을 str 파라미터를 키로 가져온다.<br>
	 *
	 * @param str 메모리에 로딩된 값을 가져오기 위한 키
	 * @return Object
	 * @throws SiteConfException 키에 해당되는 값이 존재하지 않을때
	 */
	public Object getConf(String key) {
	    return confs.get(key);
	}

	public Hashtable getSubConf(String key) {
	    Object ret = confs.get(key);
	    if(ret != null) {
	        if(!ret.getClass().getName().equals("java.util.Hashtable")) {
	            ret = null;
	        }
	    }
	    return (Hashtable)ret;
	}

    /**
     * 전체 설정정보를 가져온다.
     * 
     * @return Hashtable
     * 
     * @uml.property name="confs"
     */
    public Hashtable getConfs() {
        return confs;
    }

	public Hashtable getSubConfs() {
	    Hashtable ret = new Hashtable();

	    Enumeration keys = confs.keys();
		while (keys.hasMoreElements()) {
			String keyname = (String) keys.nextElement();
			Object v = confs.get(keyname);
			if(v.getClass().getName().equals("java.util.Hashtable")) {
			    ret.put(keyname, v);
			}
		}
		return ret;
	}
	
	/**
	 * 싱글톤 객체를 닫는다
	 * 
	 * @return void
	 */			
	public synchronized void close() {
		confs.clear();
		confs = null;
		instance = null;
	}

	public static void main(String[] args) throws Exception {
		SiteConf sitecnf = SiteConf.getInstance();
		
		Enumeration keys = sitecnf.getConfs().keys();

		while (keys.hasMoreElements()) {
			String keyname = (String) keys.nextElement();
			Object v = sitecnf.getConf(keyname);
			if(v.getClass().getName().equals("java.util.Hashtable")) {
			    System.out.println(keyname);
				Enumeration k = ((Hashtable)v).keys();
				while (k.hasMoreElements()) {
					String kn = (String) k.nextElement();
					System.out.println(kn + ":" + ((Hashtable)v).get(kn));
				}			
			} else {
			    System.out.println(keyname + ":" + v);
			}
		}
		sitecnf.close();
	}
}