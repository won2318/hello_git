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

public class SosokSqlBean extends SQLBeanExt{
	 public SosokSqlBean() {
			super();
		}
	 public Vector getSosok(String seq){
		
		 Vector v = null;
		 if (seq != null && seq.length() > 0) {
		 String query = "select * from sosok where sinx=" +seq;
		 try{
			 v= querymanager.selectEntity(query);
		 }catch(Exception ex){
			 System.err.println(ex.getMessage());
		 }
		 }
		 return v;
	 }
	 public Hashtable getSosok_List(int page,String query, int limit){

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
			SosokInfoBean bean = new SosokInfoBean();
			com.yundara.util.WebUtils.fill(bean, req);
			String subQuery = "select * from sosok where sosok_code='"+bean.getSosok_code()+"'";
			Vector v = null;
			try{
				//신규 정보가 기존에 존재하는 여부 확인 
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
			String query = "insert into sosok (sosok_code, sosok_name, sosok_comment) values('"+bean.getSosok_code()+"', '"+bean.getSosok_name()+"', '"+bean.getSosok_comment()+"')";
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
				SosokInfoBean bean = new SosokInfoBean();
			    com.yundara.util.WebUtils.fill(bean, req);
			    int sinx = bean.getSinx();
			    String query = "update sosok set sosok_code = '"+bean.getSosok_code()+"', sosok_name = '"+bean.getSosok_name()+"', sosok_comment='"+bean.getSosok_comment()+"' where sinx="+sinx;
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
			String query = "delete from sosok where sinx = " + seq;
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
    public Vector selectTitle(String sosok_code) {
    	if (sosok_code != null && sosok_code.length() > 0) {
        String query = "select sosok_name from sosok where sosok_code='" + sosok_code+ "' ";
        return querymanager.selectEntity(query);
    	} else {
    		return null;
    	}
	}
}
