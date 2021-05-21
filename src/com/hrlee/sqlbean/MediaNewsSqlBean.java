package com.hrlee.sqlbean;

import java.awt.Image;
import java.io.File;
import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiUtils;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.sqlbean.DirectoryNameManager;
import dbcp.SQLBeanExt;

import com.yundara.util.CharacterSet;
import com.yundara.util.PageBean;

public class MediaNewsSqlBean extends SQLBeanExt{
	 public MediaNewsSqlBean() {
			super();
		}
	 public Vector getNews(String seq){
		
		 Vector v = null;
		 if (seq != null && seq.length() > 0) {
		 String query = "select * from media_news where seq=" +seq;
		 try{
			 v= querymanager.selectEntity(query);
		 }catch(Exception ex){
			 System.err.println(ex.getMessage());
		 }
		 }
		 return v;
	 }
	 public Hashtable getNews_List(int page,String query, int limit){

			// page정보를 얻는다.
	        Vector v = querymanager.selectEntities(query);
			int totalRecord = 0;
			if(v != null && v.size() > 0){
				totalRecord  = v.size();
			}
			if(totalRecord <= 0){
				Hashtable ht = new Hashtable();
				ht.put("LIST", new Vector());
				ht.put("PAGE", new com.yundara.util.PageBean());
				return ht;
			}
	        PageBean pb = new PageBean(totalRecord, limit, 10, page);
			String rquery ="";
			rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
//			System.err.println(rquery);
			Vector result_v = querymanager.selectHashEntities(rquery);

			Hashtable ht = new Hashtable();
			if(result_v != null && result_v.size() > 0){
				ht.put("LIST",result_v);
				ht.put("PAGE",pb);
			}else{
				ht.put("LIST", new Vector());
				ht.put("PAGE", new com.yundara.util.PageBean());
			}

			return ht;
		}
	 
		public int write(HttpServletRequest req) throws Exception 
		{
			int iReturn = -1;
			try{
				MediaNewsInfoBean bean = new MediaNewsInfoBean();
			com.yundara.util.WebUtils.fill(bean, req);
			String subQuery = "select * from vod_media where ocode='"+bean.getOcode()+"'";
			Vector v = null;
			try{
				//영상 정보가 기존에 존재하는 여부 확인 
				v= querymanager.selectEntity(subQuery);
			}catch(Exception ex){
				System.err.println(ex.getMessage());
			}
			if(v != null && v.size()>0){
				String code = String.valueOf(v.elementAt(1));
				if(code != null && code.length()>0){
					//기존 코드값이 등록되어 있습니다.
					return -99;
				}
			}
			String query = "insert into media_news (ocode, title, link, wdate) values('"+bean.getOcode()+"', '"+bean.getTitle()+"', '"+bean.getLink()+"', CURDATE() )";
			//신규 정보 등록 
			iReturn = querymanager.updateEntities(query);
			}catch(Exception ex){
				System.err.println(ex.getMessage());
			}
			return iReturn;
		}
		
		
		
		public int update(HttpServletRequest req) throws Exception 
		{
			int iResult = -1;
			try{
				MediaNewsInfoBean bean = new MediaNewsInfoBean();
			    com.yundara.util.WebUtils.fill(bean, req);
			    int seq = bean.getSeq();
			    String query = "update media_news set title = '"+bean.getTitle()+"', link='"+bean.getLink()+"' where seq="+seq;
			    iResult=  querymanager.updateEntities(query);
			}catch(Exception ex){
				System.err.println(ex.getMessage());
			}
			return iResult;
			
		}

		
		
		
	public int delete(String seq) throws Exception 
		{
			int iResult = -1;
			if (seq != null && seq.length() > 0) {
			String query = "delete from media_news where seq = " + seq;
			try{
				iResult = querymanager.updateEntities(query);
				
			}catch(Exception ex){
				System.err.println(ex.getMessage());
			}
			}
			return iResult;
		}
	 public Vector selectQuery(String query) {
		    return querymanager.selectEntity(query);

		}

		public Vector selectHashQuery(String query){

			Vector rtn = null;

			try {
				rtn = querymanager.selectHashEntities(query);
			}catch(Exception e) {
				System.err.println("select hashquery sosokex " + e.getMessage());
			}

			return rtn;
		}

	public Vector selectListAll(String query){
		
		Vector rtn = null;
		
		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {}

		return rtn;
	}
    public Vector selectTitle(String seq) {
    	if (seq != null && seq.length() > 0) {
        String query = "select title from media_news where seq='" + seq+ "' ";
        return querymanager.selectEntity(query);
    	} else {
    		return null;
    	}
	}
    
    public Vector selectLink(String seq) {
    	if (seq != null && seq.length() > 0) {
        String query = "select link from media_news where seq='" + seq+ "' ";
        return querymanager.selectEntity(query);
    	} else {
    		return null;
    	}
	}
    
    
	public int delete_ocode(String ocode) throws Exception 
	{
		int iResult = -1;
		if (ocode != null && ocode.length() > 0) {
		String query = "delete from media_news where ocode = " + ocode;
		try{
			iResult = querymanager.updateEntities(query);
			
		}catch(Exception ex){
			System.err.println(ex.getMessage());
		}
		}
		return iResult;
	}
	public int insert_array(String ocode, String[] news_title, String[] news_link, String[] news_date) {
		// TODO Auto-generated method stub
System.out.println(news_title.length);
		int iResult = -1;
		if (ocode != null && ocode.length() > 0) {
		   try {

	            String query = "";
				String query1 = " INSERT INTO media_news (ocode,title, link, wdate) VALUES ";
			
			    for (int i=0; i < news_title.length ; i++) {
			    	String title = news_title[i];
			    	String link = news_link[i];
			    	String date = news_date[i];
			        query = query1 +
			                " ('" +
			                ocode + "'," +
			                " '" + com.vodcaster.utils.TextUtil.getValue(CharacterSet.toKorean(title))  + "', " +
			                " '" + com.vodcaster.utils.TextUtil.getValue(CharacterSet.toKorean(link))  + "', " +	
			                " '" + com.vodcaster.utils.TextUtil.getValue(date)  + "' " +	
			                " )";
	System.out.println(query);		    
			        querymanager.updateEntities(query);
			    }
		  } catch (Exception e) {
	          System.err.println("insertMediaNews ex : "+e.getMessage());
	      }
		}
		return iResult;
	}
	
}
