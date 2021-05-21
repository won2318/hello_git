package com.hrlee.silver;

import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

public class TimeMediaManager {
	private static TimeMediaManager instance;
	
	private TimeMediaSql sqlbean = null;
    
	private TimeMediaManager() {
        sqlbean = new TimeMediaSql();
    }
    
	public static TimeMediaManager getInstance() {
		if(instance == null) {
			synchronized(TimeMediaManager.class) {
				if(instance == null) {
					instance = new TimeMediaManager();
				}
			}
		}
		return instance;
	}
	
	public int deleteTimeMedia(String seq) throws Exception {
	    
		return sqlbean.delete(seq);
	}
	public int deleteByDay(String seq) throws Exception {
	    
		return sqlbean.deleteByDay(seq);
	}
	
	
	public int update(HttpServletRequest req) throws Exception 
	{
		return sqlbean.update(req);
		
	}
	
	/*
	 * 페이지 처리를 위한 스케쥴  목록 전체 
	 */
	public Hashtable getTime_ListAll( String day, int page, int limit, String order ) {

        Hashtable result_ht;
        order = com.vodcaster.utils.TextUtil.getValue(order);
        day = com.vodcaster.utils.TextUtil.getValue(day);
        String query = "";
        if(order == null || order.equals("") || order.equals("null")){
        	order = "b.id";
        }else{
        	order = "b." +order; 
        }
       
        	query = "select b.*, a.title from time_media as b, vod_media as a where b.day='"+day+"'  order by   "+ order + " desc ";
 

        try {
            result_ht = sqlbean.getTime_List(page, query, limit);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;


    }
	
	/*
	 * 페이지 처리를 위한 스케쥴  목록 전체 
	 * day = 2009-09-11(년-월-일), time = 12:15(시각:분)
	 */
	public Hashtable getTime_List5( String day, String time, int page, int limit, String order ) {

        Hashtable result_ht;
        order = com.vodcaster.utils.TextUtil.getValue(order);
        day = com.vodcaster.utils.TextUtil.getValue(day);
        
        String query = "";
        if(order == null || order.equals("") || order.equals("null")){
        	order = "c.id";
        }else{
        	order = "c." +order; 
        }
        String preQuery = "select b.time from time_media as b where b.day='"+day+"' and " +
        		"('"+time+"' between b.time and b.endtime)";
       int iPresult = sqlbean.getTime_ListEntities(preQuery);
       if(iPresult >0){
        	//query = "select b.*, a.title from time_media as b, vod_media as a where b.ocode =a.ocode and b.day='"+day+"' and substring(time,1,5)>='"+time+"'  order by   "+ order + " asc ";
    	   query = "select c.*, d.title from time_media as c, vod_media as d " +
        		"where c.ocode =d.ocode and c.day='"+day+"' and c.time >= " +
        		"( select b.time from time_media as b where b.day='"+day+"' and " +
        		"('"+time+"' between b.time and b.endtime) ) order by   c.time asc ";
       }else{
    	   query = "select c.*, d.title from time_media as c, vod_media as d " +
	   		"where c.ocode =d.ocode and c.day='"+day+"' and c.time >= " +
	   		"( select b.time from time_media as b where b.day='"+day+"' and " +
	   		" '"+time+"' <= b.time  order by b.time limit 0,1  ) order by   c.time asc ";
       }
 //select b.*, a.title from time_media as b, vod_media as a where b.ocode =a.ocode and b.day='2009-10-11' and substring(time,1,5)>='00:03'  order by   time asc limit 0,5
System.out.println(query);
        try {
            result_ht = sqlbean.getTime_List(page, query, limit);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;


    }
	
	/*
	 * 해당 년-월의 스케쥴  목록  
	 */
	public Vector getTimeListByMonth(String year_month) {
	    
		year_month= com.vodcaster.utils.TextUtil.getValue(year_month);
        
	    String query = "";
	    
	        query = "select distinct b.day  from time_media as b where substring(b.day,1,7)='"+year_month+"'  order by   b.day asc  ";
	    
	        return sqlbean.selectListAll(query);
	       
	}
	
	/*
	 * 인덱스를 이용한 해당 스케쥴  정보 
	 */
	public Vector getTime(String seq) {

		seq = com.vodcaster.utils.TextUtil.getValue(seq);
        
	      String query = "select b.*, a.title from time_media as b, vod_media as a where b.id="+seq+" and  b.ocode=a.ocode" ;

			return sqlbean.selectHashQuery(query);

	    }
/*
 * 스케쥴  목록 전체 
 */
	public Vector getTime_ListAll(String day) {
	    
	    String query = "";
	    day= com.vodcaster.utils.TextUtil.getValue(day);
        
	    
	        query = "select b.*, a.title from time_media as b, vod_media as a where b.day='"+day+"' and b.ocode=a.ocode  order by   b.time  ";
	    
	        return sqlbean.selectListAll(query);
	       
	}
	
//////////
// 스케쥴 영상 제목  가져 오기
// by hrlee
//////////

	public String getTimeOneName(String id) {

	    String strtmp = "";
	    id= com.vodcaster.utils.TextUtil.getValue(id);
        
	    try {

	        if(!id.equals("") && id.length() > 0 ) {

                Vector v = sqlbean.selectTitle(id);
                if(v != null && v.size()>0){
                	strtmp = String.valueOf(v.elementAt(0));
                }
            }

	    }catch(Exception e) {
	    	System.err.println("getTimeOneName ex : " + e);
	    }
        return strtmp;
    }
	

}
