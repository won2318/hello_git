/*
 * Created on 2004. 12. 27.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.yundara.util;

import java.util.*;
import javax.servlet.http.HttpServletRequest;
import com.oreilly.servlet.MultipartRequest;
import org.apache.commons.beanutils.BeanUtils;
import com.yundara.beans.*;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class WebUtils {
	/**
	 * 	두 문자열을 비교하여 같으면 "checked" 리턴
	 *
	 * 	@param val_1 : 원본 문자열1
	 *	@param val_2 : 원본 문자열2
	 *	@return val_1 과 val_2가 동일한 문자열일 경우 "checked"문자열 리턴, 아니면, 빈문자열 리턴
	 *	@author 모름
	 */
	public static String isChecked(String val_1, String val_2) {
		if(val_1.equals(val_2)) return " checked";
		else return "";
	}

	/**
	 * 	두 문자열을 비교하여 같으면 "selected" 리턴
	 *
	 * 	@param val_1 : 원본 문자열1
	 *	@param val_2 : 원본 문자열2
	 *	@return val_1 과 val_2가 동일한 문자열일 경우 "selected"문자열 리턴, 아니면, 빈문자열 리턴
	 *	@author 모름
	 */
	public static String isSelected(String val_1, String val_2) {
		if(val_1.equals(val_2)) return " selected";
		else return "";
	}
	
	public static void fill(InfoBeanExt bean, HttpServletRequest req) {
		Map map = req.getParameterMap();
		try {
			for(Iterator i=map.keySet().iterator();i.hasNext();) {
				String key = (String)i.next();
				BeanUtils.setProperty(bean, key, map.get(key));
			}
		} catch(Exception ex) {}
	}
	
	public static void fill(InfoBeanExt bean, MultipartRequest req) {
		try {
			for(Enumeration e = req.getParameterNames();e.hasMoreElements();) {
				String key = (String)e.nextElement();
				BeanUtils.setProperty(bean, key, req.getParameter(key));
			}
			
			for(Enumeration e = req.getFileNames();e.hasMoreElements();) {
				String key = (String)e.nextElement();
				BeanUtils.setProperty(bean, key, req.getFilesystemName(key));
			}
		} catch(Exception ex){}
	}
	
	public static HashMap getFileSystemName(MultipartRequest req) {
		HashMap map = new HashMap();
		for(Enumeration e = req.getFileNames();e.hasMoreElements();) {
			String key = (String)e.nextElement();
			map.put(key, req.getFilesystemName(key));
		}
		return map;
	}
}
