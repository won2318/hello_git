/*
 * ������: 2004. 12. 27.
 * ����:
 */

package com.yundara.beans;

import java.util.*;

/**
 * @author ������
 *
 * TODO InfoBeanExt �� �����ϱ� ���� ��ƿ��Ƽ Ŭ����
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
