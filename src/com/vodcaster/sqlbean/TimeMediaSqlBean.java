package com.vodcaster.sqlbean;

import dbcp.SQLBeanExt;
import com.yundara.util.CharacterSet;

import java.util.*;
import java.text.*;


public class TimeMediaSqlBean extends SQLBeanExt {

    public TimeMediaSqlBean() {
		super();
	}
    /********************************************** select ****************************************************/    
    public Vector selectTimeMedia(String clickDate) throws Exception{
    	String query = "select a.id, a.day, a.time, a.endtime, a.ccode, b.* from time_media a, vod_media b where a.ocode=b.ocode and a.day='"+clickDate+"' order by CONVERT(a.time, UNSIGNED) asc";	
		return querymanager.selectHashEntities(query);
	}
    
    public String input_media_return(String clickDate) throws Exception{

    	Vector v = null;
        String query = "  SELECT MAX(id)  from time_media  where day='"+clickDate+"' ";
        v = querymanager.selectEntity(query);

        if(v != null && v.size() > 0)
            return String.valueOf(v.elementAt(0));
        else
            return "";
            	     
    	     
	}
    
	public Vector selectQuery(String query) {
	    return querymanager.selectEntity(query);

	}
	
	public Vector selectQueries(String query) {
	    return querymanager.selectHashEntities(query);

	}
	
	public Vector selectListAll(String query){
		
		Vector rtn = null;
		
		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {}

		return rtn;
	}
    
    
    /********************************************** insert ****************************************************/
    public int insertTimeMedia(String ccode, String ocode, String clickDate, String runningtime, String hour, String minute) throws Exception{
    	String query = "";
    	int maxtime = 24*60*60;
    	int time = 0;
    	int endtime = 0;
    	boolean insertFlg = true;
    	
    	 	
    	int temp_runtime = TimeMediaManager.formTime(runningtime); 
    	 
    	Vector vt = querymanager.selectEntity("select * from time_media where day='" + clickDate +"' order by CONVERT(time, UNSIGNED) desc");
    	 
    	if(vt != null && vt.size() > 0) {
    		time = Integer.parseInt(String.valueOf(vt.elementAt(4))) + 1;
    		endtime = time + temp_runtime;
    		
    		if(time >= maxtime) {
    			return -1;
    		}
    		if(endtime > maxtime) {
    			endtime = maxtime;
    		}
    	} else {
    		if(!hour.equals("") && !minute.equals("")) {
    			int stert_time = Integer.parseInt(hour)*3600 + Integer.parseInt(minute)*60;
	    		time = stert_time;
	    		endtime= stert_time + temp_runtime;
	    	 
    		} else {
    			insertFlg = false;
    			System.out.println("insertTimeMedia error");
    		}
    	}
    	
    	if(insertFlg) {
	    	query = " insert into time_media ( ocode,day,time,endtime,ccode,temp1) ";
	    	query +=" values ( '"+ocode+"', '"+clickDate+"', '"+time+"','"+endtime+"','"+ccode+"','"+temp_runtime+"') ";
	    	
	    	//System.out.println(query);
	    	if(querymanager.updateEntities(query) > -1) {
	    		return 1;
	    	}
    	} else {
    		return -2;
    	}
    	return -99;
	}
    
    public int insertTimeMediaAll( String day, String clickDate ) throws Exception{
    	
    	String delete_query = "delete from time_media where day='" + day + "' ";
    	if(querymanager.updateEntities(delete_query) == -1) {
    		return -1;
    	}
    	
    	String query = " insert into time_media( ocode,day,time,endtime,ccode, temp1)"
    		 + " select ocode, '"+day+"', time, endtime, ccode, temp1 from time_media where day='"+clickDate+"' ";
    	return querymanager.updateEntities(query);
	}
    
    /********************************************** update ****************************************************/
    
    public int updateTimeMedia(int id, int time, int endtime) {

    	String query = "update time_media set time='"+time+"', endtime='"+endtime+"' where id="+id; 

    	return querymanager.updateEntities(query);
    }
    
    /********************************************** delete ****************************************************/
    
    public int deleteTimeMedia(int id, String day) throws Exception {

    	String query = "delete from time_media where id="+id+" and day='"+day+"' "; 

    	return querymanager.updateEntities(query);
    }
    
    public int deleteTimeMediaAll(String day) throws Exception {

    	String query = "delete from time_media where day='"+day+"' "; 

    	return querymanager.updateEntities(query);
    }
    
    /*
     금일 방송 스케줄 불러 오기 
     주현 
  2009-11-20
    오늘, 내일 일자중 5개 목록을 가져옴 (24시가 마지막이므로 내일 일자까지 쿼리 함)
     */
     
    
	    public Vector selectTimeMedia_today(int limit) throws Exception{
    	
		java.util.Date day = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String strToday = sdf.format(day);
 	    Date tomorrow = new Date ( day.getTime ( ) + (long) ( 1000 * 60 * 60 * 24 ) );
	    String tomorrow_s = sdf.format(tomorrow);    	

	    String to_day = "";
	    int to_time = 0;
	    	    
	    if (strToday != null && strToday.length() > 0) {
	    	
	    	to_day = strToday.substring(0,8);
	    	int	HH    = Integer.parseInt(strToday.substring(8,10));
	    	int	mm    = Integer.parseInt(strToday.substring(10,12));
	    	int	ss    = Integer.parseInt(strToday.substring(12,14));
	    	to_time = HH * 60*60 + mm * 60 + ss;
	    }
	    if (tomorrow_s != null && tomorrow_s.length() > 0) {
	    	tomorrow_s = tomorrow_s.substring(0,8);
	    }
	    
    	String query = "  select * from(select list.*, rownum rnum from ( select a.id, a.day, a.time, a.endtime, a.ccode, b.* from time_media a, vod_media b where a.ocode=b.ocode and (a.day='"+to_day+"' or a.day='"+tomorrow_s+"') and ( CONVERT(time, UNSIGNED) >= '"+to_time+"' or (  CONVERT(time, UNSIGNED) <= '"+to_time+"' and CONVERT(endtime, UNSIGNED) > '"+to_time+"' ) )   order by a.day, CONVERT(a.time, UNSIGNED) asc ) list  )where rnum <= "+limit+" ";
//    	System.out.println(query);
		return querymanager.selectHashEntities(query);
	}
}