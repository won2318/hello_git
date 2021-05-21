/*
 * ������ : 2004. 12. 14.
 *
 * ����:
 */

package com.yundara.conf;

import java.io.*;
import java.util.*;

/**
 * @author ������ *  * TODO ����ȭ���� �о�� �޸𸮿� ��üȭ��Ų��.
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
			System.out.println("SiteConf �ν��Ͻ� ����");
		} catch (SiteConfException e) {
			System.out.println("SiteConf �ν��Ͻ� ���� �� �����߻�");
		}

	}

	/**
	 * site.properties ������ �о ���������� �޸𸮿� �����Ѵ�.<br>
	 * <b>os</b> : windows, unix<br> 
	 * <b>log_print</b> : �α���¿���(true, false)<br> 
	 * <b>site_log</b> : �α����� ���ϸ�<br>
	 * <b>imsi_dir</b> : ȭ�Ͼ��ε���� �۾��� �ϱ����� ���Ǵ� �ӽ� ���丮
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
			System.out.println("site.properties ������ ���� �� �����ϴ�.");
			createObjectDefault();
		}	
	}
	
	/**
	 * site.properties ���� ���� �� ���� �� ����Ʈ������ ä���.<br>
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
		System.out.println("SiteConf - �����尪�� �о�Խ��ϴ�.");
	}

	/**
	 * site.properties ���� �������� ä���� Properties ��ü�� Hashtable ��ü��
	 * ���������� ä���.
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
     * �ٸ�  Property ���ϸ��� �����Ѵ�.<br>
     * 
     * ��)<br>
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
	 * �޸𸮿� �ε��� ���� str �Ķ���͸� Ű�� �����´�.<br>
	 *
	 * @param str �޸𸮿� �ε��� ���� �������� ���� Ű
	 * @return Object
	 * @throws SiteConfException Ű�� �ش�Ǵ� ���� �������� ������
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
     * ��ü ���������� �����´�.
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
	 * �̱��� ��ü�� �ݴ´�
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