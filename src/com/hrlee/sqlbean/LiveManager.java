/*
 * Created on 2005. 1. 13
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;


import com.vodcaster.utils.WebutilsExt;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
import com.vodcaster.sqlbean.DirectoryNameManager;
import java.io.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.yundara.util.TimeUtil;
import javazoom.upload.*;
import java.io.*;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.math.NumberUtils;


/**
 * @author Choi Hee-Sung
 *
 * photo 관리 클래스
 */
public class LiveManager {

	private static LiveManager instance;
	
	private LiveSqlBean sqlbean = null;
    
	private LiveManager() {
        sqlbean = new LiveSqlBean();
        //System.err.println("PhotoManager 인스턴스 생성");
    }
    
	public static LiveManager getInstance() {
		if(instance == null) {
			synchronized(LiveManager.class) {
				if(instance == null) {
					instance = new LiveManager();
				}
			}
		}
		return instance;
	}
    

/*****************************************************
  live 정보 목록 리스트
  김주현 

******************************************************/

public Hashtable getLive_List(String field, String searchstring,String openflag, String group_id, String rflag, int page, int limit) {

        Hashtable result_ht;

        String query = "";
        String sub_query = "";
        
        searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
	    field = com.vodcaster.utils.TextUtil.getValue(field);
	    openflag= com.vodcaster.utils.TextUtil.getValue(openflag);
	    group_id= com.vodcaster.utils.TextUtil.getValue(group_id);
	    rflag= com.vodcaster.utils.TextUtil.getValue(rflag);
	    

        if(!field.equals("") && field != null && !searchstring.equals("") && searchstring != null) {
            if(field.equals("rtitle"))
                sub_query = " and rtitle like '%" +searchstring+ "%' ";
            else if(field.equals("rcontents"))
                sub_query = " and rcontents like '%" +searchstring+ "%' ";
            else if(field.equals("all"))
                sub_query = " and (rtitle like '%" +searchstring+ "%' or rcontents like '%" +searchstring+ "%' ) ";
        }

			if (!openflag.equals("") && openflag != null){
				sub_query = sub_query + " and openflag = '" +openflag + "' ";

			}
			if (!group_id.equals("") && group_id != null){
				sub_query = sub_query + " and group_id = '" +group_id + "' ";

			}
			if (!rflag.equals("") && rflag != null){
				sub_query = sub_query + " and rflag = '" +rflag + "' ";

			}

        query = "select * from live_media where rcode is not null " +sub_query +" order by title";
        String cnt_query = "select * from live_media where rcode is not null " +sub_query ;
        try {
            result_ht = sqlbean.getLive_ListCnt(page, query, limit,cnt_query);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;


    }
	


/*****************************************************
  live 정보 목록 리스트
  김주현 

******************************************************/

public Vector getLiveByMonth(String year_month, String openflag) {

        Vector result_vt;

        String query = "";
        String sub_query = "";

        year_month = com.vodcaster.utils.TextUtil.getValue(year_month);
	    openflag = com.vodcaster.utils.TextUtil.getValue(openflag);
	    
        if(year_month != null && year_month.length()>0){
        	//sub_query = sub_query + " and  substring(rstart_time,1,7) = '"+year_month+"' ";
        	
        	sub_query = sub_query + " and ( (substring(rstart_time,1,7) <=  '"+year_month+"'  and substring(rend_time,1,7) =  '"+year_month+"' ) " +
        	" or " +
        	" (substring(rstart_time,1,7) =  '"+year_month+"'  and substring(rend_time,1,7) =  '"+year_month+"' ) " +
        	" or " +
        	" (substring(rstart_time,1,7) =  '"+year_month+"'  and substring(rend_time,1,7) >  '"+year_month+"' )  )" ;

        }

		if (!openflag.equals("") && openflag != null){
			sub_query = sub_query + " and openflag = '" +openflag + "' ";

		}
	
        query = " select * from live_media where rcode is not null " +sub_query +" order by rstart_time asc ";
//System.out.println("getLiveByMonth::"+query);
        try {
        	result_vt = sqlbean.getLive_List( query);

        }catch (Exception e) {
        	result_vt = new Vector();
        }
		return result_vt;

    }

/*****************************************************
live 정보 목록 리스트
김주현 

******************************************************/

public Vector getLiveByDay(String today, String openflag)
{
	today= com.vodcaster.utils.TextUtil.getValue(today);
    openflag= com.vodcaster.utils.TextUtil.getValue(openflag);
	    
    String query = "";
    String sub_query = "";
    if(today != null && today.length() > 0)
        sub_query = (new StringBuilder(String.valueOf(sub_query))).append(" and  substring(rstart_time,1,10) <= '").append(today).append("' and  substring(rend_time,1,10) >= '").append(today).append("' ").toString();
    if(!openflag.equals("") && openflag != null)
        sub_query = (new StringBuilder(String.valueOf(sub_query))).append(" and openflag = '").append(openflag).append("' ").toString();
    query = (new StringBuilder(" select * from live_media where rcode is not null ")).append(sub_query).append(" order by rstart_time asc ").toString();
    Vector result_vt;
    try
    {
        result_vt = sqlbean.getLive_List(query);
    }
    catch(Exception e)
    {
        result_vt = new Vector();
    }
    return result_vt;
}

/*****************************************************
live 정보 목록 리스트
김주현 

******************************************************/

public Vector getLiveByDayTime(String year_month_day, String openflag) {

	year_month_day = com.vodcaster.utils.TextUtil.getValue(year_month_day);
	openflag= com.vodcaster.utils.TextUtil.getValue(openflag);
	    
      Vector result_vt;

      String query = "";
      String sub_query = "";

      if(year_month_day != null && year_month_day.length()>0){
      	sub_query = sub_query + " and ( rstart_time < '"+year_month_day+"' or substring(rstart_time,1,10) = '"+year_month_day.substring(0,10)+"')  and  rend_time >= '"+year_month_day+"' ";
      }

		if (!openflag.equals("") && openflag != null){
			sub_query = sub_query + " and openflag = '" +openflag + "' ";

		}
	
      query = " select * from live_media where rcode is not null " +sub_query +" order by rstart_time asc limit 0,1 ";
//System.out.println(query);
      try {
      	result_vt = sqlbean.getLive_List( query);

      }catch (Exception e) {
      	result_vt = new Vector();
      }
		return result_vt;

  }


public Vector getLiveByDayTime_tomorrow(String year_month_day, String openflag, String tomorrow_s) {

	year_month_day = com.vodcaster.utils.TextUtil.getValue(year_month_day);
	openflag= com.vodcaster.utils.TextUtil.getValue(openflag);
	tomorrow_s = com.vodcaster.utils.TextUtil.getValue(tomorrow_s);
	
      Vector result_vt;

      String query = "";
      String sub_query = "";

      if(year_month_day != null && year_month_day.length()>0){
      	sub_query = sub_query + " and ( (( rstart_time < '"+year_month_day+"' or substring(rstart_time,1,10) = '"+year_month_day.substring(0,10)+"')  and  rend_time >= '"+year_month_day+"') or substring(rstart_time,1,10) = '"+tomorrow_s.substring(0,10)+"' ) ";
      }

		if (!openflag.equals("") && openflag != null){
			sub_query = sub_query + " and openflag = '" +openflag + "' ";

		}
	
      query = " select * from live_media where rcode is not null " +sub_query +" order by rstart_time asc ";
//System.out.println(query);
      try {
      	result_vt = sqlbean.getLive_List( query);

      }catch (Exception e) {
      	result_vt = new Vector();
      }
		return result_vt;

  }
/*****************************************************
  live 정보 목록 리스트
  김주현 

******************************************************/

public Vector getLive_List(String yearMonth,String openflag,  String rflag) {
	yearMonth= com.vodcaster.utils.TextUtil.getValue(yearMonth);
	openflag= com.vodcaster.utils.TextUtil.getValue(openflag);
	
        Vector vt = new Vector();

        String query = "";
        String sub_query = "";

        
			if (!openflag.equals("") && openflag != null){
				sub_query = sub_query + " and openflag = '" +openflag + "' ";

			}
			
			if (!rflag.equals("") && rflag != null){
				sub_query = sub_query + " and rflag = '" +rflag + "' ";

			}

        query = "select * from live_media where rcode is not null " +sub_query +" order by rstart_time";

        try {
            vt = sqlbean.getLive_List(query);

        }catch (Exception e) {
        	System.out.println(e);
        	return null;
 
        }
		return vt;


    }
/*****************************************************
  live 선택 이미지 정보 목록 리스트
  김주현 
******************************************************/
public Vector getLive(String seq, String rflag) {

	seq = com.vodcaster.utils.TextUtil.getValue(seq);
	rflag= com.vodcaster.utils.TextUtil.getValue(rflag);
	
	if(seq == null || seq.length() <= 0 ) return null;
	if(rflag == null || rflag.length() <= 0 ) return null;
	
      String query = "select * from live_media where rcode="+seq + " and rflag = '"+rflag+"' ";

		return sqlbean.selectHashQuery(query);

    }


/*****************************************************
  LIve 전체 이미지 정보 목록 리스트
  김주현

******************************************************/
public Hashtable getLive_ListAll(String rflag, int page, int limit) {

        Hashtable result_ht;

    	rflag= com.vodcaster.utils.TextUtil.getValue(rflag);

        String query = "";
        if ( rflag != null && rflag.length() > 0) {
        	 query = "select * from live_media where rflag = '"+rflag+"' order by rcode desc ";
        	 String cnt_query= "select count(rcode) from live_media where rflag = '"+rflag+"'  ";
        	//System.out.println(query);	
 	        try {
 	            result_ht = sqlbean.getLive_ListCnt(page, query, limit,cnt_query);
 	
 	        }catch (Exception e) {
 	            result_ht = new Hashtable();
 	            result_ht.put("LIST", new Vector());
 	            result_ht.put("PAGE", new com.yundara.util.PageBean());
 	        }
        } else {

      	  	result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;


    }


public Hashtable getLive_ListSearch(String searchFild, String searchString, String rflag, int page, int limit) {

    Hashtable result_ht;

	rflag= com.vodcaster.utils.TextUtil.getValue(rflag);
	searchString= com.vodcaster.utils.TextUtil.getValue(searchString);
	searchFild =  com.vodcaster.utils.TextUtil.getValue(searchFild);;
    String query = "";
    String subQuery = "";
    if (searchString != null && searchString.length() > 0 && searchFild != null && searchFild.length() > 0) {
    	subQuery = " and "+searchFild+" like '%"+searchString+"%' ";
    }
    if ( rflag != null && rflag.length() > 0) {
    	 query = "select * from live_media where rflag = '"+rflag+"' "+ subQuery+" order by rcode desc ";
    	 String cnt_query= "select count(rcode) from live_media where rflag = '"+rflag+"' "+ subQuery+" ";
    	//System.out.println(query);	
	        try {
	            result_ht = sqlbean.getLive_ListCnt(page, query, limit,cnt_query);
	
	        }catch (Exception e) {
	            result_ht = new Hashtable();
	            result_ht.put("LIST", new Vector());
	            result_ht.put("PAGE", new com.yundara.util.PageBean());
	        }
    } else {

  	  	result_ht = new Hashtable();
        result_ht.put("LIST", new Vector());
        result_ht.put("PAGE", new com.yundara.util.PageBean());
    }
	return result_ht;


}


public Vector getLive_ListAll(String rflag, String year) {

	Vector result = null;
	year = com.vodcaster.utils.TextUtil.getValue(year);
	rflag= com.vodcaster.utils.TextUtil.getValue(rflag);
	

    String query = "";
    if ( rflag != null && rflag.length() > 0) {
    	 query = " select * from live_media where rflag = '"+rflag+"' and rstart_time like '"+year+"%' order by  rstart_time desc ";
 
	        try {
	        	result = sqlbean.selectHashQuery( query );
	
	        }catch (Exception e) {
	        	result = null;
	        	System.out.println("getLive_ListAll:"+e);
	           
	        }
    }  
	return result ;


}

public Vector getLive_ListAll_out(String rflag, String year) {

	Vector result = null;
	year = com.vodcaster.utils.TextUtil.getValue(year);
	rflag= com.vodcaster.utils.TextUtil.getValue(rflag);
	

    String query = "";
    if ( rflag != null && rflag.length() > 0) {
    	 query = " select * from live_media where rflag = '"+rflag+"' and rstart_time like '"+year+"%' and inoutflag <> 'Y' and openflag='Y' order by  rstart_time desc ";
 
	        try {
	        	result = sqlbean.selectHashQuery( query );
	
	        }catch (Exception e) {
	        	result = null;
	        	System.out.println("getLive_ListAll:"+e);
	           
	        }
    }  
	return result ;


}


	/*****************************************************
    정보 삭제.<p>
	<b>작성자</b> : 김주현 <br>
	@return <br>
	@param seq 일련번호
	******************************************************/

	public int deleteLive(String seq) throws Exception {
		seq = com.vodcaster.utils.TextUtil.getValue(seq);
		
		if(seq == null || seq.length() <= 0 ) return -1;
		return sqlbean.deleteLive(seq);
	}

	public int deletefile(String seq, String flag) throws Exception {
		seq = com.vodcaster.utils.TextUtil.getValue(seq);
		flag= com.vodcaster.utils.TextUtil.getValue(flag);
		
		if(seq == null || seq.length() <= 0 ) return -1;
		if(flag == null || flag.length() <= 0 ) return -1;
		return sqlbean.deletefile(seq, flag);
	}

   /**
     * order_media 조회수 증가
     * @param ocode
     */
    public void setLive_Hit(String seq) {
    	seq = com.vodcaster.utils.TextUtil.getValue(seq);
        sqlbean.updateLive_Hit(seq);
    }



    
    /**
     * 모든 라이브 목록
     * @param page
     * @param limit
     * @return
     */
    public Hashtable getLive_ListAll(int year, int month, int page, int limit)
    {
        String fm = "";
    	if(month < 10)
    		fm = "0"+(month+1);
    	else
    		fm = Integer.toString(month+1);
        
    	String query = "select rcode, substring(rstart_time, 1, 10) as date, rtitle, substring(rstart_time, 12, 5) as time, inoutflag" +
    			" from live_media where substring(rstart_time,1,7) <='"+String.valueOf(year)+"-"+String.valueOf(fm)+"' and substring(rend_time,1,7) >= '"+String.valueOf(year)+"-"+String.valueOf(fm)+"'" +
        		" and del_flag='N' and openflag='Y' order by rstart_time desc";
     
    	//System.err.println(query);
		Hashtable result_ht;
		try {
	        result_ht = sqlbean.getMediaListCnt(page, query, limit, "rcode");
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	    
		return result_ht;
    }
    
    
    public Vector getLive(String rcode)
    {
    	rcode = com.vodcaster.utils.TextUtil.getValue(rcode);
    	
    	Vector result = null;
    	
    	if (rcode != null && rcode.length() > 0 ) {
	    	String query = "select * from live_media where rcode="+rcode;
	    	try{
	    		result = sqlbean.selectQuery(query);
	    	}catch(Exception e){
	    		result = null;
	    	}
    	} else {
    		result = null;
    	}
    	return result;
    }
    
    public Vector getLive()
    {
    	
    	Vector result = null;
    	 
		String query = " SELECT * FROM live_media WHERE del_flag='N' and openflag='Y' and inoutflag <> 'Y' and rflag='L' " +
				" AND rstart_time <=  DATE_FORMAT(NOW(),'%Y-%m-%d %H:%i') AND  DATE_FORMAT(NOW(),'%Y-%m-%d %H:%i') <= rend_time ";
 //  System.out.println(query);

    	try{
    		result = sqlbean.selectQuery(query);
    	}catch(Exception e){
    		result = null;
    	}
    	 
    	return result;
    }
    
    
    
}
