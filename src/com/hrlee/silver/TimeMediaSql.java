package com.hrlee.silver;

import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.hrlee.sqlbean.BuseoInfoBean;
import com.yundara.util.PageBean;

import dbcp.SQLBeanExt;

public class TimeMediaSql extends SQLBeanExt{
	 public TimeMediaSql() {
			super();
		}
	 public Vector getTime(String seq){
		 String query = "select b.*, a.title from time_media as b, vod_media as b where b.id=" +seq+" and b.code=a.ocode";
		 Vector v = null;
		 try{
			 v= querymanager.selectEntity(query);
		 }catch(Exception ex){
			 System.err.println(ex.getMessage());
		 }
		 return v;
	 }
	 public Hashtable getTime_List(int page,String query, int limit){

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
	 
	 public int getTime_ListEntities(String query){
		 int totalRecord = 0;
		 	try{
				// page정보를 얻는다.
		        Vector v = querymanager.selectEntities(query);
				
				if(v != null && v.size() > 0){
					totalRecord  = v.size();
				}
				
		 	}catch(Exception ex)
		 	{
		 		System.out.println(ex);
		 	}
		 	return totalRecord;
		}
	 
	public int write(HttpServletRequest req) throws Exception 
	{
		int iReturn = -1;
		try{
			TimeMediaInfo bean = new TimeMediaInfo();
			com.yundara.util.WebUtils.fill(bean, req);
			
			String query = "insert into time_media (ocode, day, time, endtime ) values" +
					"('"+bean.getOcode()+"', '"+bean.getDay()+"', '"+bean.getTime()+"','"+bean.getEndtime()+"' )";
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
		TimeMediaInfo bean = new TimeMediaInfo();
		
		
		
		try{
			com.yundara.util.WebUtils.fill(bean, req);
	    
		    String query = "update time_media set ocode = '"+bean.getOcode()+"', day = '"+bean.getDay()+"', time='"+bean.getTime()+"', endtime='"+bean.getEndtime()+"'  where id="+bean.getId();
		    iResult=  querymanager.updateEntities(query);
		}catch(Exception ex){
			System.err.println(ex.getMessage());
		}
		return iResult;
		
	}

		
		
	//특정 스케쥴 삭제 
	public int delete(String seq) throws Exception 
	{
		int iResult = -1;
		
		String query = "delete from time_media where id = " + seq;
		try{
			iResult = querymanager.updateEntities(query);
			
		}catch(Exception ex){
			System.err.println(ex.getMessage());
		}
		return iResult;
	}
	
	//날짜를 입력한 삭제 - 해당 날짜의 모든 스케쥴 삭제 
	public int deleteByDay(String day) throws Exception 
	{
		int iResult = -1;
		
		String query = "delete from time_media where day = '" + day+"'";
		try{
			iResult = querymanager.updateEntities(query);
			
		}catch(Exception ex){
			System.err.println(ex.getMessage());
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


    public Vector selectTitle(String id) {
        String query = "select a.title from time_media as b, vod_media as a where b.id='" + id+ "' and b.ocode=a.ocode";
        //String query = "select a.ccode,a.mtitle,a.msimple,a.mcontents,a.mhit,a.mtotal_count,a.msecurity,a.mtype,a.mview_flag,a.mflag, b.* from media  a, real_media  b where b.mcode=a.mcode and a.mcode=" +mcode;
        return querymanager.selectEntity(query);
	}
}
