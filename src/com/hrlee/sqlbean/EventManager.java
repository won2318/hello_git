/*
 * Created on 2005. 1. 13
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;
 
import java.util.*;
 

/**
 * @author Choi Hee-Sung
 *
 * photo 관리 클래스
 */
public class EventManager {

	private static EventManager instance;
	
	private EventSqlBean sqlbean = null;
    
	private EventManager() {
        sqlbean = new EventSqlBean();
        //sqlbean.printLog("PhotoManager 인스턴스 생성");
    }
    
	public static EventManager getInstance() {
		if(instance == null) {
			synchronized(EventManager.class) {
				if(instance == null) {
					instance = new EventManager();
				}
			}
		}
		return instance;
	}
    
	
	/*****************************************************
	  getEventList 목록 리스트
	  김주현 
	 
	
	******************************************************/
	
	public Hashtable getEventList(String field, String searchstring, String type, int page, int limit) {
	
	        Hashtable result_ht;
	
	        String query = "";
	        String sub_query = "";
	        searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
	        field = com.vodcaster.utils.TextUtil.getValue(field);
	        type= com.vodcaster.utils.TextUtil.getValue(type);
	        
	        if(!field.equals("") && field != null && !searchstring.equals("") && searchstring != null) {
	            if(field.equals("title"))
	                sub_query = " and title like '%" +searchstring+ "%' ";
	            else if(field.equals("all"))
	                sub_query = " and (title like '%" +searchstring+ "%' or content like '%" +searchstring +"')";
	                       
	        }
	        
	        if (type != null && type.length() > 0) {
	        	sub_query = sub_query+" and event_type = '"+type+"' ";
	        	
	        }
	
	        query = "select * from event where del_flag='N' and seq > 0 " +sub_query +" order by seq desc";
	//System.out.println(query);
	        String cnt_query= "select count(seq) from event where del_flag='N' and seq > 0 " +sub_query ;
	        try {
	            result_ht = sqlbean.getEventListCnt(page, query, limit,cnt_query);
	
	        }catch (Exception e) {
	            result_ht = new Hashtable();
	            result_ht.put("LIST", new Vector());
	            result_ht.put("PAGE", new com.yundara.util.PageBean());
	        }
			return result_ht;
	
	
	    }
		 
	
	public Hashtable getEventListUser(String field, String searchstring,String type, int page, int limit, String event_flag) {
	
	    Hashtable result_ht;
	
	    String query = "";
	    String sub_query = "";
	    searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
	    field = com.vodcaster.utils.TextUtil.getValue(field);
	    type= com.vodcaster.utils.TextUtil.getValue(type);
	    event_flag= com.vodcaster.utils.TextUtil.getValue(event_flag);
	    if(!field.equals("") && field != null && !searchstring.equals("") && searchstring != null) {
	        if(field.equals("title"))
	            sub_query = " and title like '%" +searchstring+ "%' ";
	        else if(field.equals("all"))
	            sub_query = " and (title like '%" +searchstring+ "%' or content like '%" +searchstring +"')";
	                   
	    }
	    
	    if (type != null && type.length() > 0) {
	    	sub_query = sub_query+" and event_type = '"+type+"' ";
	    	
	    }
	    if (event_flag != null && event_flag.length() > 0 ) {
	    	
	    	if (event_flag.equals("1")) { // 진행중인 이벤트
	    		sub_query = sub_query+" and sdate <= now() and (edate is null || edate = '' || edate >= now()) ";
	    	} else {
	    		sub_query = sub_query+" and edate < now() ";
	    	}
	    	
	    }
	
	
	    query = "select * from event where del_flag='N' and open_flag = 'Y' and seq > 0 " +sub_query +" order by seq desc";
	    String cnt_query ="select count(seq) from event where del_flag='N' and open_flag = 'Y' and seq > 0 " +sub_query  ;
	    try {
	        result_ht = sqlbean.getEventListCnt(page, query, limit,cnt_query);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
		return result_ht;
	
	
	}
	
	
	// 모바일 이벤트 목록
	public Hashtable getEventListM(String type, String event_flag ,int page, int limit, int pagePerBlock)
	{
		String query = "";
		String sub_query = "";
		Hashtable result_ht;
		type= com.vodcaster.utils.TextUtil.getValue(type);
		event_flag= com.vodcaster.utils.TextUtil.getValue(event_flag);
		  
	    if (type != null && type.length() > 0) {
	    	sub_query = sub_query+" and event_type = '"+type+"' ";
	    	
	    }
	    if (event_flag != null && event_flag.length() > 0 ) {
	    	
	    	if (event_flag.equals("1")) { // 진행중인 이벤트
	    		sub_query = sub_query+" and sdate <= now() and (edate is null || edate = '' || edate >= now()) ";
	    	} else {
	    		sub_query = sub_query+" and edate < now() ";
	    	}
	    	
	    }
	    
		query = "select * from event where del_flag='N' and open_flag = 'Y' " +sub_query +" order by seq desc";
		String cnt_query ="select * from event where del_flag='N' and open_flag = 'Y' " +sub_query  ;
		try {
	        result_ht = sqlbean.getEventListCnt(page, query, limit, pagePerBlock,cnt_query);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	    
		return result_ht;
	}
	
	
	/*****************************************************
	  Photo 선택 이미지 정보 목록 리스트
	  김주현 
	  ocode (하위 이미지를 위한 코드)
	  pflag = P  하위 이미지
	******************************************************/
	public Vector getEvent(String seq) {
	
		seq= com.vodcaster.utils.TextUtil.getValue(seq);
		if (seq != null && seq.length() > 0) {
		      String query = "select *,(select count(seq) from event_user where event_seq='6') as event_cnt  from event where del_flag='N'  and  seq='"+seq +"' order by seq desc";
		
				return sqlbean.selectQueryHash(query);
		} else {
			return null;
		}
	
	}
	
	public Vector getNewEvent(String limit) {

	limit= com.vodcaster.utils.TextUtil.getValue(limit);
	if (limit != null && limit.length() > 0) {
	    String query = "select * from photo where del_flag='N' and open_flag = 'Y' order by seq desc limit 0,"+limit+"";
	
			return sqlbean.selectQuery(query);
	} else {
		return null;
	}

  }

 
         
	/*****************************************************
    이벤트 정보 삭제.<p>
	<b>작성자</b> : 김주현 <br>
 
	@param seq 일련번호
	******************************************************/

	public int deleteEvent(String seq) throws Exception {
		seq= com.vodcaster.utils.TextUtil.getValue(seq);
	    if (seq != null && seq.length() > 0) {
	    	return sqlbean.deleteEvent(seq);
	    } else {
	    	return -1;
	    }
	}
 
	 
	public Vector EventList( String type) {
		type= com.vodcaster.utils.TextUtil.getValue(type);
		if (type != null && type.length() > 0) {
			String	query = "select * from event where del_flag='N' and open_flag = 'Y' and event_type='"+type+"' ";
			return sqlbean.selectEventListAll(query);
		} else {
			return null;
		}
	
	}
	
	/**
	 * order_media 조회수 증가
	 * @param ocode
	 */
	public void setEventHit(String seq) {
		seq = com.vodcaster.utils.TextUtil.getValue(seq);
	    sqlbean.updateEventHit(seq);
	}
	
	
	public Vector getUserInfo(String ocode, String event_seq){
		ocode= com.vodcaster.utils.TextUtil.getValue(ocode);
		event_seq= com.vodcaster.utils.TextUtil.getValue(event_seq);
		
		if (ocode != null && ocode.length() > 0 && event_seq != null && event_seq.length() > 0) {
			String query =" select * from event_user where event_seq='"+event_seq+"'" + " and ocode = '"+ocode+"' ";
			
			return sqlbean.selectQuery(query);
		} else {
			return null;
		}
	}

}
