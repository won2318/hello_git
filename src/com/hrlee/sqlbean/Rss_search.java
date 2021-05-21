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
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.yundara.util.TimeUtil;

import javazoom.upload.*;

import java.io.*;

import dbcp.SQLBeanExt;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.math.NumberUtils;


/**
 * @author Choi Hee-Sung
 *
 * VOD컨텐츠 관리 클래스
 */
public class Rss_search{

	private static Rss_search instance;
	
	private MediaSqlBean sqlbean = null;
    
	private Rss_search() {
        sqlbean = new MediaSqlBean();
        //System.err.println("MediaManager 인스턴스 생성");
    }
    
	public static Rss_search getInstance() {
		if(instance == null) {
			synchronized(Rss_search.class) {
				if(instance == null) {
					instance = new Rss_search();
				}
			}
		}
		return instance;
	}
	
	public Hashtable suwon_rss(HttpServletRequest req ){
		
		   String query = " ";
		   String sub_query1 = " ";
		  
		   Hashtable result_ht;
   
		int pageNum = 1;
		if(pageNum < 1 ) pageNum = 1;
		int rowNum = 10;
		if(rowNum < 1 || rowNum > 30) rowNum = 10;
		
		String genderType = com.vodcaster.utils.TextUtil.getValue(req.getParameter("genderType"));
		if (req.getParameter("genderType") != null && req.getParameter("genderType").length() > 0) {
			sub_query1 += " and b.gender_type like '%"+genderType+"%' ";
		}
		String ageType = com.vodcaster.utils.TextUtil.getValue(req.getParameter("ageType"));
		if (req.getParameter("ageType") != null && req.getParameter("ageType").length() > 0) {
			sub_query1 += " and b.age_type like '%"+ageType+"%' ";
		}
		String sectionType = com.vodcaster.utils.TextUtil.getValue(req.getParameter("sectionType"));
		if (req.getParameter("sectionType") != null && req.getParameter("sectionType").length() > 0) {
			sub_query1 += " and b.section_type like '%"+sectionType+"%' ";
		}
		
		String preSearch = "";
		String[] prevKwds = req.getParameterValues("prevKwd");
		String xcode ="";
		for (int i = 0 ; prevKwds != null && i < prevKwds.length ; i++ ) {
			sub_query1  += "and b.tag_kwd like '%"+prevKwds[i]+"%' ";
		}
		
		
		sub_query1  += " order by b.mk_date desc, b.ocode desc ";
		//System.out.println(query);
				query = " select b.*, a.ctitle  from  vod_media b, category a " +
						" where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
						"		and a.openflag='Y' and b.openflag='Y' and a.ctype='V' and b.isended='1' " 
						 +  sub_query1;
			    
				String count_query = " select count(b.ocode) from  vod_media b, category a " +
					" where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
					"		and a.openflag='Y' and b.openflag='Y' and a.ctype='V'  and b.isended='1' " 
					 +  sub_query1;
				try {
			        result_ht = sqlbean.getMediaListCnt(pageNum, query, count_query, rowNum);

			    }catch (Exception e) {
			        result_ht = new Hashtable();
			        result_ht.put("LIST", new Vector());
			        result_ht.put("PAGE", new com.yundara.util.PageBean());
			    }

				return result_ht; 
				
	}
	public Hashtable suwon_search( String genderType, String ageType,  String sectionType, String[] tagKwd,int page, int limit) {

		 String query = " ";
		   String sub_query1 = " ";
		  
		   Hashtable result_ht;
 
		int pageNum = 1;
		if(pageNum < 1 ) pageNum = 1;
		int rowNum = 10;
		if(rowNum < 1 || rowNum > 30) rowNum = 10;
	 
		if (genderType != null && genderType.length() > 0) {
			sub_query1 += " and b.gender_type like '%"+genderType+"%' ";
		}
	 
		if (ageType != null && ageType.length() > 0) {
			sub_query1 += " and b.age_type like '%"+ageType+"%' ";
		}
		 
		if (sectionType != null && sectionType.length() > 0) {
			sub_query1 += " and b.section_type like '%"+sectionType+"%' ";
		}
		
		 
		for (int i = 0 ; tagKwd != null && i < tagKwd.length ; i++ ) {
			
			try {
				//System.out.println(new String(tagKwd[i].getBytes("iso-8859-1"), "utf-8"));
				sub_query1  += "and b.tag_kwd like '%"+new String(tagKwd[i].getBytes("iso-8859-1"), "utf-8")+"%' ";
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		sub_query1  += " order by b.mk_date desc, b.ocode desc ";
		//System.out.println(query);
				query = " select b.*, a.ctitle  from  vod_media b, category a " +
						" where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
						"		and a.openflag='Y' and b.openflag='Y' and a.ctype='V' and b.isended='1' " 
						 +  sub_query1;
			    
				String count_query = " select count(b.ocode) from  vod_media b, category a " +
					" where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
					"		and a.openflag='Y' and b.openflag='Y' and a.ctype='V'  and b.isended='1' " 
					 +  sub_query1;
				try {
			        result_ht = sqlbean.getMediaListCnt(pageNum, query, count_query, rowNum);

			    }catch (Exception e) {
			        result_ht = new Hashtable();
			        result_ht.put("LIST", new Vector());
			        result_ht.put("PAGE", new com.yundara.util.PageBean());
			    }

				return result_ht; 


	}

     
	public Hashtable getOMediaListAll( String ccode,   String sorder, String field, String searchstring,int page, int limit, String direction, String sdate, String edate) {
		
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		direction = com.vodcaster.utils.TextUtil.getValue(direction);
		
		sdate = com.vodcaster.utils.TextUtil.getValue(sdate);
		edate = com.vodcaster.utils.TextUtil.getValue(edate);
		if(page < 1 ) page = 1;
		if(limit < 1 || limit > 30) limit = 10;
	    Hashtable result_ht;
	
	    String query = "";
	    
		String sub_query = "";
	    String sub_query1 = "";
	    String sub_query2 = "";
	
	    if(sorder != null && sorder.length() > 0 ) {
	        if(sorder.equals("ccode"))
	            sub_query1 = "order by b."+sorder + " " +direction+" ,b.ocode "+direction;
	        else
	            sub_query1 = "order by b."+sorder + " " + direction+" ,b.ocode "+direction;
	    }else
	        sub_query1 = "order by b.mk_date desc, b.ocode desc";
	
	    if(field != null && field.length() > 0  && searchstring != null && searchstring.length() > 0 ) {
	        if(field.equals("title"))
	            sub_query2 = " and (b.title like '%" +searchstring+ "%') ";
	        else if(field.equals("description"))
	            sub_query2 = " and ( b.description like '%" +searchstring+ "%') ";
	        else if(field.equals("all"))
	            sub_query2 = " and ( b.title like '%" +searchstring+
	                    "%' or  b.description like '%" +searchstring+ "%') ";
	    }

		if (ccode != null && ccode.length() > 11 )
		{
			String Code = ccode;
			if (ccode.substring(9,12).equals("000"))
			{
				Code = ccode.substring(0,9);
			}
			if (ccode.substring(6,12).equals("000000"))
			{
				Code = ccode.substring(0,6);
			}
			if (ccode.substring(3,12).equals("000000000"))
			{
				Code = ccode.substring(0,3);
			}

			sub_query =" and b.ccode like '" +Code + "%' ";
		}
		
		if (sdate != null && sdate.length() > 0) {
			sub_query += " and DATE_FORMAT(mk_date, '%Y-%m-%d') >= DATE_FORMAT('"+sdate+"' , '%Y-%m-%d')  ";
		}
		if (edate != null && edate.length() > 0) {
			sub_query += " and DATE_FORMAT(mk_date, '%Y-%m-%d') <= DATE_FORMAT('"+edate+"' , '%Y-%m-%d')  ";
		}

		query =  "select  b.*, c.ctitle from   vod_media b, category c where b.ccode = c.ccode and c.ctype='V' and b.del_flag='N'    " +sub_query+ sub_query2 + sub_query1;
		String count_query =  "select  count(b.ocode) from  vod_media as b where b.del_flag='N' " +sub_query+ sub_query2;
 
	    try {
	        result_ht = sqlbean.getMediaListCnt(page, query, count_query, limit);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	
		return result_ht;
	
	
	}
	
	
public Vector getOMediaListAll_excel( String ccode,   String sorder, String field, String searchstring , String direction, String sdate, String edate) {
		
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		direction = com.vodcaster.utils.TextUtil.getValue(direction);
		
		sdate = com.vodcaster.utils.TextUtil.getValue(sdate);
		edate = com.vodcaster.utils.TextUtil.getValue(edate);
  
	
	    String query = "";
	   
		String sub_query = "";
	    String sub_query1 = "";
	    String sub_query2 = "";
	
	    if(sorder != null && sorder.length() > 0 ) {
	        if(sorder.equals("ccode"))
	            sub_query1 = "order by b."+sorder + " " +direction+" ,b.ocode "+direction;
	        else
	            sub_query1 = "order by b."+sorder + " " + direction+" ,b.ocode "+direction;
	    }else
	        sub_query1 = "order by b.mk_date desc, b.ocode desc";
	
	    if(field != null && field.length() > 0  && searchstring != null && searchstring.length() > 0 ) {
	        if(field.equals("title"))
	            sub_query2 = " and (b.title like '%" +searchstring+ "%') ";
	        else if(field.equals("description"))
	            sub_query2 = " and ( b.description like '%" +searchstring+ "%') ";
	        else if(field.equals("all"))
	            sub_query2 = " and ( b.title like '%" +searchstring+
	                    "%' or  b.description like '%" +searchstring+ "%') ";
	    }

		if (ccode != null && ccode.length() > 11 )
		{
			String Code = ccode;
			if (ccode.substring(9,12).equals("000"))
			{
				Code = ccode.substring(0,9);
			}
			if (ccode.substring(6,12).equals("000000"))
			{
				Code = ccode.substring(0,6);
			}
			if (ccode.substring(3,12).equals("000000000"))
			{
				Code = ccode.substring(0,3);
			}

			sub_query =" and b.ccode like '" +Code + "%' ";
		}
		
		if (sdate != null && sdate.length() > 0) {
			sub_query += " and DATE_FORMAT(mk_date, '%Y-%m-%d') >= DATE_FORMAT('"+sdate+"' , '%Y-%m-%d')  ";
		}
		if (edate != null && edate.length() > 0) {
			sub_query += " and DATE_FORMAT(mk_date, '%Y-%m-%d') <= DATE_FORMAT('"+edate+"' , '%Y-%m-%d')  ";
		}

		query =  "select   b.title, b.mk_date, b.openflag, b.isended, b.hitcount, c.ctitle from   vod_media b, category c where b.ccode = c.ccode and c.ctype='V' and b.del_flag='N'    " +sub_query+ sub_query2 + sub_query1;
		
 		return sqlbean.selectMediaListAllExt(query);
	
	
	}
	
}
