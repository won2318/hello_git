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

public class	BuseoSqlBean extends SQLBeanExt{
	 public BuseoSqlBean() {
			super();
		}
	 public Vector getBuseo(String seq){
		 String query = "select * from buseo where binx=" +seq;
		 Vector v = null;
		 try{
			 v= querymanager.selectEntity(query);
		 }catch(Exception ex){
			 System.err.println(ex.getMessage());
		 }
		 return v;
	 }
	 public Hashtable getBuseo_List(int page,String query, int limit){

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
			BuseoInfoBean bean = new BuseoInfoBean();
			com.yundara.util.WebUtils.fill(bean, req);
			String subQuery = "select * from buseo where buseo_code='"+bean.getBuseo_code()+"' ";
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
			
			subQuery = "select * from buseo where buseo_name = '"+bean.getBuseo_name()+"' ";
			v = null;
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
					return -98;
				}
			}
			String query = "insert into buseo (buseo_code, buseo_name, buseo_comment ) values('"+bean.getBuseo_code()+"', '"+bean.getBuseo_name()+"', '"+bean.getBuseo_comment()+"'  )";
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
			BuseoInfoBean bean = new BuseoInfoBean();
			com.yundara.util.WebUtils.fill(bean, req);
			
			int binx = bean.getBinx();
			
			String subQuery = "select * from buseo where buseo_code='"+bean.getBuseo_code()+"'  and binx not in ("+binx+")" ;
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
			
			
			 subQuery = "select * from buseo where buseo_name = '"+bean.getBuseo_name()+"'  and binx not in ("+binx+")" ;
			 v = null;
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
					return -98;
				}
			}
 
			try{
 
			    String query = "update buseo set buseo_code = '"+bean.getBuseo_code()+"', buseo_name = '"+bean.getBuseo_name()+"', buseo_comment='"+bean.getBuseo_comment()+"'  where binx="+binx;
			    iResult=  querymanager.updateEntities(query);
			}catch(Exception ex){
				System.err.println(ex.getMessage());
			}
			return iResult;
			
		}
 
	public int delete(String seq) throws Exception 
		{
			int iResult = -1;
			if (seq != null && seq.length()  > 0) {
				String query = "delete from buseo where binx = " + seq;
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
				System.err.println("select hashquery buseoex " + e.getMessage());
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


    public Vector selectTitle(String buseo_code) {
    	if (buseo_code != null && buseo_code.length() > 0) {
        String query = "select buseo_name from buseo where buseo_code='" + buseo_code+ "' ";
        return querymanager.selectEntity(query);
    	} else {
    		return null;
    	}
	}




}
