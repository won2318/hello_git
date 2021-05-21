/*
 * 생성일: 2004. 12. 27.
 * 사용법:
 */

package com.yundara.beans;

import java.util.*;

/**
 * @author 오영석
 *
 * TODO InfoBeanExt 를 조작하기 위한 유틸리티 클래스
 */
public class BeanUtils {
	public static void fill(InfoBeanExt tbean, InfoBeanExt sbean) {
		try {
			org.apache.commons.beanutils.BeanUtils.copyProperties(tbean, sbean);
		} catch(Exception ex) {}
	}

	public static void fill(InfoBeanExt tbean, Hashtable ht) {
		try {
			for(Iterator i = ht.keySet().iterator();i.hasNext();) {
				String key = (String)i.next();
				org.apache.commons.beanutils.BeanUtils.setProperty(tbean, key, ht.get(key));
			}
		} catch(Exception ex) {}
	}
}
