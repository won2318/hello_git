package com.vodcaster.sqlbean;

import dbcp.SQLBeanExt;

import java.util.*;

import org.apache.commons.lang.StringEscapeUtils;

import javax.servlet.http.*;

import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.yundara.util.FileUtil;
import com.yundara.util.PageBean;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;

/**
 * @author Jong-Sung Park
 * �޸� DB Query Ŭ����
 * Date: 2009. 07. 16.
 */
public class MemoSqlBean extends SQLBeanExt {

    public MemoSqlBean() {
		super();
	}

	/*****************************************************
		�޸� ����Ʈ ����.<p>
		<b>�ۼ���</b> : ������<br>
		@return Hashtable ht<br>
		@param page ��������ȣ, query ����,count ����, limit ����
	******************************************************/
	public Hashtable getMemoListLimit(int page, String query, String count_query, int limit ) {
		// page������ ��´�.
        Vector v = querymanager.selectEntities(count_query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			totalRecord = Integer.parseInt(String.valueOf(((Vector)(v.elementAt(0))).elementAt(0)));
		}
		if(totalRecord <= 0){
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}
		
		PageBean pb = null;
		Hashtable ht = new Hashtable();
		if(totalRecord <= 0){
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}
        
        pb = new PageBean(totalRecord, limit, 10, page);

		// �ش� �������� ����Ʈ�� ��´�.
		String rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
        
		Vector result_v = querymanager.selectHashEntities(rquery);
		
		//if(result_v.size() < 1){
		//	ht = new Hashtable();
		//	ht.put("LIST", new Hashtable());
		//	ht.put("PAGE", new com.yundara.util.PageBean());
		//}
		//else{
			ht.put("LIST",result_v);
			ht.put("PAGE",pb);
		//}

		return ht;
    }

	/*****************************************************
	Ư�� �˻��� ���� �޴� ��ü ����Ʈ ����.<p>
	<b>�ۼ���</b> : �����<br>
	@return �˻��� �޴� ����Ʈ<br>
	@param �˻� Query��
******************************************************/
	public Vector selectHashListAll(String query){
		
		Vector rtn = null;
		
		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {}

		return rtn;
	}
	
	/*****************************************************
		�˻� ��� ����.<p>
		<b>�ۼ���</b> : ������<br>
		@return �����<br>
		@param  querymanager#selectEntity
	******************************************************/
	public Vector selectQuery(String query) {
	    //System.err.println(">>>>>>>>>>>>>>>>>>>>>>>>>>query " + query);
	    return querymanager.selectEntity(query);

	}
	public Vector selectQuerylist(String query) {
	    //System.err.println(">>>>>>>>>>>>>>>>>>>>>>>>>>query " + query);
		return querymanager.selectEntities(query);

	}
	

	/*****************************************************
		�޸� ����Ʈ ���� ����.<p>
		<b>�ۼ���</b> : ������<br>
		@return <br>
		@param �˻� query
	******************************************************/
	public int selectMemoCount(String query){
		Vector v = querymanager.selectEntity(query);
			if(v != null && v.size() > 0){
	        	 String count = String.valueOf(v.elementAt(0));
	        	 try{
	        		 return Integer.parseInt(count);
	        	 }catch(Exception ex){
	        		 return 0;
	        	 }
	         } else {
				 return 0;
			 }
	}

	/*****************************************************
		�޸�����.<p>
		<b>�ۼ���</b> : ������<br>
		@return <br>
		@param ocode ������ �ڵ�, flag ������ ����
	******************************************************/
	public int saveMemo(String query) {
        try {
            return querymanager.updateEntities(query);
	    } catch(Exception e) {
	        System.err.println(e.toString());
	        return -1;
	    }
    }
	/*****************************************************
		�޸����.<p>
		<b>�ۼ���</b> : ������<br>
		@return rtn<br>
		@param ocode ������ �ڵ�, flag ������ ����
	******************************************************/
	public int deleteMemo(String ocode, String flag) {

		
        int rtn = -1;
        if (ocode != null && ocode.length() > 0 && flag != null && flag.length() > 0) {
	        try {
	            String query = "delete from content_memo where ocode='" +ocode+ "'  and flag ='"+flag+"'";
	            rtn = querymanager.updateEntities(query);
	        }catch(Exception e) {
	            System.err.println(e.getMessage());
	        }
        }

        return rtn;
	}

}
