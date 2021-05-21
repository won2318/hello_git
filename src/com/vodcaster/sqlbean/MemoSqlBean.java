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
 * 메모 DB Query 클래스
 * Date: 2009. 07. 16.
 */
public class MemoSqlBean extends SQLBeanExt {

    public MemoSqlBean() {
		super();
	}

	/*****************************************************
		메모 리스트 리턴.<p>
		<b>작성자</b> : 박종성<br>
		@return Hashtable ht<br>
		@param page 페이지번호, query 쿼리,count 쿼리, limit 제한
	******************************************************/
	public Hashtable getMemoListLimit(int page, String query, String count_query, int limit ) {
		// page정보를 얻는다.
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

		// 해당 페이지의 리스트를 얻는다.
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
	특정 검색에 의해 메뉴 전체 리스트 리턴.<p>
	<b>작성자</b> : 이희락<br>
	@return 검색된 메뉴 리스트<br>
	@param 검색 Query문
******************************************************/
	public Vector selectHashListAll(String query){
		
		Vector rtn = null;
		
		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {}

		return rtn;
	}
	
	/*****************************************************
		검색 결과 리턴.<p>
		<b>작성자</b> : 박종성<br>
		@return 결과값<br>
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
		메모 리스트 갯수 리턴.<p>
		<b>작성자</b> : 박종성<br>
		@return <br>
		@param 검색 query
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
		메모저장.<p>
		<b>작성자</b> : 박종성<br>
		@return <br>
		@param ocode 콘텐츠 코드, flag 콘텐츠 구분
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
		메모삭제.<p>
		<b>작성자</b> : 박종성<br>
		@return rtn<br>
		@param ocode 콘텐츠 코드, flag 콘텐츠 구분
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
