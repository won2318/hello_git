/*
 * ������ : 2004. 12. 27.
 *
 * ����� : 
 */

package com.yundara.util;

import java.net.*;
import java.util.*;

/**
 * @author ������
 *
 * TODO Ŭ������ ���� ����
 */
public class JSTemplateExt extends JSTemplate {
	protected Hashtable loopKey = new Hashtable();

    public JSTemplateExt(URL url) {
		super( url );
    }



	/**
	 *  ŷ���̸Ӵ� ����/��� ������ �����Ͽ� �Ѱ��ݴϴ�.
	 *  <br><font size=2>2003/08/26. Kim JongJin</font>
	 *  <p>
	 *
	 *	@param tag1 ���� ���� ��ġ
	 *	@param tag2 ���� �� ��ġ
	 *	@param rows ġȯ ���� ���� ����
	 *  -------------------------------------------------
	 *	Vector rows = new Vector();
	 *	Hashtable hash = new Hashtable();
	 *	hash.put( "#prd_name#", "1111111111" );
	 *	hash.put( "#prd_price#", "2222222222" );
	 *	hash.put( "#prd_amount#", "3333333333" );
	 *	hash.put( "#sum_price#", "4444444444" );
	 *	hash.put( "#mileage#", "5555555555" );
	 *	rows.add( hash );
	 *  -------------------------------------------------
	 *
	 *	@return ������ ���Ϳ� ��� �Ѱ��ݴϴ�.
	 */
	public void setTag(String tag1, String tag2, Vector rows) {
		tag1.replaceAll( " ", "" );
		tag2.replaceAll( " ", "" );
		loopKey.put( tag1 + "$$$$$" + tag2, rows );
	}

	public void removeTag(String tag1, String tag2) {
		tag1.replaceAll( " ", "" );
		tag2.replaceAll( " ", "" );
		loopKey.remove( tag1 + "$$$$$" + tag2 );
	}


	public int loopTagRange(String tag1, String tag2, Vector rows) {
		String content_ = getContent();
		int count = 0;
		int begin_idx = content_.indexOf( tag1 );
		int end_idx = content_.indexOf( tag2 );
		int begin_len = tag1.length();
		int end_len = tag2.length();
		String src = content_.substring( begin_idx + begin_len , end_idx );
		String loopTag = "";
		Hashtable rows_ = null;
		String temp = null;
		for( int i = 0 ; i < rows.size(); i++ ){
			temp = src;
			rows_ = (Hashtable)rows.elementAt(i);
			for(Enumeration e = rows_.keys();e.hasMoreElements();) {
				String key = (String)e.nextElement();
				String value = (String)rows_.get(key);
				temp = temp.replaceAll( key, value );
			}
			loopTag += temp;
			count++;
		}
		replaceTagRange(tag1, tag2, loopTag);
		return count;
	}


	// ���� �޴� ����
	public String getConvContent() {
		String returnValue = "";

		reloadOnChanged();

		for(Enumeration e = ht.keys();e.hasMoreElements();) {
			String key = (String)e.nextElement();
			String value = (String)ht.get(key);
			replaceTag(key, value);
		}

		StringTokenizer st = null;
		for(Enumeration e = loopKey.keys();e.hasMoreElements();) {

			String keyTag = (String)e.nextElement();

			st = new StringTokenizer( keyTag, "$$$$$" );
			String tag1 = st.nextToken();
			String tag2 = st.nextToken();

			Vector rows = (Vector)loopKey.get( keyTag );

			loopTagRange( tag1, tag2, rows );
		}

		if(enc.equals("ko")) {
			returnValue = CharacterSet.toKorean(toString());
		} else if(enc.equals("en")) {
			returnValue = CharacterSet.toEnglish(toString());
		} else {
			returnValue = toString();
		}

		reset();
		return returnValue;
	}
}
