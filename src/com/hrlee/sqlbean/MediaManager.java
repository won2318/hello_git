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
 * VOD������ ���� Ŭ����
 */
public class MediaManager {

	private static MediaManager instance;
	
	private MediaSqlBean sqlbean = null;
    
	private MediaManager() {
        sqlbean = new MediaSqlBean();
        //System.err.println("MediaManager �ν��Ͻ� ����");
    }
    
	public static MediaManager getInstance() {
		if(instance == null) {
			synchronized(MediaManager.class) {
				if(instance == null) {
					instance = new MediaManager();
				}
			}
		}
		return instance;
	}
    
	
	
   
    /*****************************************************
	    �ֹ��� �̵���� ����.<p>
		<b>�ۼ���</b> : ����� <br>
		@return �ֹ��� �̵�� ���<br>
		@param mtype �̵��Ÿ��, ��¼���, �˻��ʵ�, �˻���, ��������ȣ
	******************************************************/
	//search_ccode, xcode, search_Ycode,order, searchField,  searchString, pg, listCnt, direction, Integer.parseInt(vod_level)
	
	public Hashtable getOMediaListAllSearch( String ccode , String xcode, String ycode,   String sorder, String field, String searchstring,int page, int limit, String direction,  int vod_level) {
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		xcode = com.vodcaster.utils.TextUtil.getValue(xcode);
		ycode = com.vodcaster.utils.TextUtil.getValue(ycode);
		sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		direction = com.vodcaster.utils.TextUtil.getValue(direction);
		if(page < 1 ) page = 1;
		if(limit < 1 || limit > 30) limit = 10;
	    Hashtable result_ht;
	
	    String query = "";
	    String code = "";
		String sub_query = "";
	    String sub_query1 = "";
	    String sub_query2 = "";
	    String sub_query3 = "";
	
	    if(sorder != null && sorder.length() > 0  ) {
	        if(sorder.equals("ccode"))
	            sub_query1 = "order by b."+sorder + " " +direction;
	        else
	            sub_query1 = "order by b."+sorder + " " + direction;
	    }else
	        sub_query1 = "order by b.mk_date desc, b.ocode desc";
	    
	    String temp_xcode = "";
	    
//	    System.out.println("xcode:"+xcode);
//	    System.out.println("ycode:"+ycode);
//	    System.out.println("ccode:"+ccode);
	    
	   
	    
		if (xcode != null && xcode.length() > 0) {
			String[] xcodeArray = xcode.split("/");
			
			temp_xcode += " and (";
					
			for (int i = 0 ; i < xcodeArray.length ; i++) {
				temp_xcode += " b.xcode like('%"+xcodeArray[i]+"%')  "; 
				if (xcodeArray.length > 1 && i < (xcodeArray.length-1) ) {
					temp_xcode +=" or ";
				}
			}
			temp_xcode += " ) ";
		}
		
		if (searchstring != null && searchstring.length() > 0) {
	
			String[] searchstringArray = searchstring.split(" ");
			
			 if(field != null && field.length() > 0  && searchstringArray.length == 1 ) {
				if (field.equals("title")) {
					temp_xcode += " and b.title like('%"+searchstring+"%')  "; 
				} else if (field.equals("description")) {
					temp_xcode += " and b.description like('%"+searchstring+"%')  "; 
				} else if (field.equals("tag_kwd")) {
					temp_xcode += " and b.tag_kwd like('%"+searchstring+"%')  "; 
				} else if (field.equals("all")) {
					temp_xcode += " and ( b.title like('%"+searchstring+"%')  "; 
					temp_xcode += " or b.tag_kwd like('%"+searchstring+"%')  "; 
					temp_xcode += " or b.description like('%"+searchstring+"%') ) "; 
				}
			} else if (field != null && field.length() > 0  && searchstringArray.length >  1 ){
				
				if (field.equals("title")) {

					temp_xcode += " and (";
					
					for (int i = 0 ; i < searchstringArray.length ; i++) {
						temp_xcode += " b.title like('%"+searchstringArray[i]+"%')  "; 
						if (searchstringArray.length > 1 && i < (searchstringArray.length-1) ) {
							temp_xcode +=" and ";
						}
					}
					temp_xcode += " ) ";
					
					 
				} else if (field.equals("tag_kwd")) {
					temp_xcode += " and (";
					for (int i = 0 ; i < searchstringArray.length ; i++) {
						temp_xcode += " b.tag_kwd like('%"+searchstringArray[i]+"%')  "; 
						if (searchstringArray.length > 1 && i < (searchstringArray.length-1) ) {
							temp_xcode +=" and ";
						}
					}
					temp_xcode += " ) ";
				} else if (field.equals("description")) {
					temp_xcode += " and (";
					for (int i = 0 ; i < searchstringArray.length ; i++) {
						temp_xcode += " b.description like('%"+searchstringArray[i]+"%')  "; 
						if (searchstringArray.length > 1 && i < (searchstringArray.length-1) ) {
							temp_xcode +=" and ";
						}
					}
					temp_xcode += " ) ";
				 
				} else if (field.equals("all")) {
				 
					
					temp_xcode += " and ( (";
					
					for (int i = 0 ; i < searchstringArray.length ; i++) {
						temp_xcode += " b.title like('%"+searchstringArray[i]+"%')  "; 
						if (searchstringArray.length > 1 && i < (searchstringArray.length-1) ) {
							temp_xcode +=" and ";
						}
					}
					temp_xcode += " ) ";
					temp_xcode += " or (";
					for (int i = 0 ; i < searchstringArray.length ; i++) { 
					 
						temp_xcode += " b.tag_kwd like('%"+searchstringArray[i]+"%')  "; 
						if (searchstringArray.length > 1 && i < (searchstringArray.length-1) ) {
							temp_xcode +=" and ";
						}
					} 
					temp_xcode += " ) ";
					temp_xcode += " or (";
					for (int i = 0 ; i < searchstringArray.length ; i++) { 
					 
						temp_xcode += " b.description like('%"+searchstringArray[i]+"%')  "; 
						if (searchstringArray.length > 1 && i < (searchstringArray.length-1) ) {
							temp_xcode +=" and ";
						}
					} 
					
					temp_xcode += " ) )";
					
				} 
				
			}
		}  
		
	   	sub_query3 = " and b.filename <> '' and b.filename <> 'null' "; 
	    

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

			sub_query +=" and b.ccode like '" +Code + "%' ";
		}
		 if (ycode != null && ycode.length() > 11 )
			{
				String Y_code = ycode;
				if (ycode.substring(9,12).equals("000"))
				{
					Y_code = ycode.substring(0,9);
				}
				if (ycode.substring(6,12).equals("000000"))
				{
					Y_code = ycode.substring(0,6);
				}
				if (ycode.substring(3,12).equals("000000000"))
				{
					Y_code = ycode.substring(0,3);
				}

				sub_query +=" and b.ycode like '" +Y_code + "%' ";
			}
		 

		query =  "select  b.*, a.ctitle, (SELECT COUNT(muid) FROM content_memo WHERE b.ocode=ocode) AS memo_cnt  from vod_media b, category a " +
			" where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
			" and a.openflag='Y' and b.openflag='Y' and a.ctype='V' and b.isended='1'  " +
		    " and b.olevel <= "+vod_level + sub_query + sub_query3 + sub_query2 + temp_xcode+ sub_query1 ;
		String count_query =  "select  count(b.ocode) from  vod_media b, category a " +
				" where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
				" and a.openflag='Y' and b.openflag='Y' and a.ctype='V' and b.isended='1'  " +
			    " and b.olevel <= "+vod_level + sub_query + sub_query3 + sub_query2 + temp_xcode+ sub_query1 ;
		
//System.out.println(query);

	    try {
	        result_ht = sqlbean.getMediaListCnt(page, query,count_query, limit);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	
		return result_ht; 
	} 
	
	
	public Hashtable getOMediaListAll( String ccode,   String sorder, String field, String searchstring,int page, int limit, String direction) {
	
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		direction = com.vodcaster.utils.TextUtil.getValue(direction);
		if(page < 1 ) page = 1;
		if(limit < 1 || limit > 30) limit = 10;
	    Hashtable result_ht;
	
	    String query = "";
	    String code = "";
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
	
	 
	
	public Hashtable getOMediaListAllSearch( String ccode , String sorder, String field, String searchstring,int page, int limit, String direction) {
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		direction = com.vodcaster.utils.TextUtil.getValue(direction);
		if(page < 1 ) page = 1;
		if(limit < 1 || limit > 30) limit = 10;
	    Hashtable result_ht;
	
	    String query = "";
	    String code = "";
		String sub_query = "";
	    String sub_query1 = "";
	    String sub_query2 = "";
	    String sub_query3 = "";
	
	    if(sorder != null && sorder.length() > 0  ) {
	        if(sorder.equals("ccode"))
	            sub_query1 = "order by b."+sorder + " " +direction;
	        else
	            sub_query1 = "order by b."+sorder + " " + direction;
	    }else
	        sub_query1 = "order by b.mk_date desc, b.ocode desc";
	    
	    
	
	    if(field != null && field.length() > 0  && searchstring != null && searchstring.length() > 0 ) {
	        if(field.equals("title"))
	            sub_query2 = " and (b.title like '%" +searchstring+ "%') ";
	        else if(field.equals("description"))
	            sub_query2 = " and ( b.description like '%" +searchstring+ "%') ";
	       
	        else if(field.equals("all"))
	            sub_query2 = " and ( b.title like '%" +searchstring+ "%' "+
	                    " or  b.descriptions like '%" +searchstring+ "%') ";
	    }
	   	sub_query3 = " and b.filename <> '' and b.filename <> 'null' ";
		    
	    

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

		query =  "select  b.* from  vod_media as b where del_flag='N' and openflag='Y' " + sub_query + sub_query3 + sub_query2 + sub_query1;
		String count_query =  "select  count(b.ocode) from  vod_media as b where del_flag='N' and openflag='Y' " + sub_query + sub_query3 + sub_query2 ;

	    try {
	        result_ht = sqlbean.getMediaListCnt(page, query,count_query, limit);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	
		return result_ht;
	
	
	}
	
    /*****************************************************
    ������ �̵���� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ������ �̵�� ���<br>
	@param ccode ī�װ��ڵ�, ����̵������, ����ڱ���, �������, ������, ������, �˻��ʵ�, �˻���, ��������ȣ
******************************************************/
	public Hashtable getRMediaListAll(String rflag, String rstart_time,String rend_time,String field,String searchstring, int page){
	
		rflag = com.vodcaster.utils.TextUtil.getValue(rflag);
		rstart_time = com.vodcaster.utils.TextUtil.getValue(rstart_time);
		rend_time = com.vodcaster.utils.TextUtil.getValue(rend_time);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		if(page < 1 ) page = 1;
				
	    Hashtable result_ht;
	
	    String query = "";
	    String code = "";
	    String order_query = "";                    // ����
	    String search_query = "";
	    String strtmp = "";
	
	    if(rflag != null && rflag.equals("R"))
	        order_query = "order by rstart_time";
	    else
	        order_query = "order by rwdate desc";
	
	    if( field != null && field.length() > 0  && searchstring != null && searchstring.length() > 0 ) {
	        if(field.equals("title"))
	            search_query = " rtitle like '%" +searchstring+ "%' ";
	        else if(field.equals("content"))
	            search_query = " and rcontents like '%" +searchstring+ "%' ";
	        else if(field.equals("all"))
	            search_query = " and (rtitle like '%" +searchstring+ "%' or rcontents like '%" +searchstring+ "%') ";
	    }
	
	
	    if( rstart_time != null && rstart_time.length() > 0  && rend_time != null && rend_time.length() > 0 ){
	        strtmp += " and ((rstart_time <= '" +rstart_time+ " 23:59') and " +
	                "(rend_time >= '" +rend_time+ "')) ";
	    }
	
	
	    query = "select * from live_media where openflag = 'Y' and rflag='" +rflag+ "' " + search_query + strtmp + order_query;
	    String count_query = "select count(rcode) from live_media where openflag = 'Y' and rflag='" +rflag+ "' " + search_query + strtmp ;
	
	    try {
	        result_ht = sqlbean.getMediaListCnt(page,query,count_query, 10);
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	        
	    }
	
		return result_ht;
	}
    /*****************************************************
        �ֹ��� �̵�� ������ ����.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return �ֹ��� �̵�� ����<br>
    	@param ocode �ֹ����̵�� �����ڵ�
    ******************************************************/
	public Vector getOMediaInfo(String ocode) {
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
	    if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
	    	return sqlbean.selectOMediaInfo(ocode);
	    } else {
	    	return null;
	    }
	    
	}
	
	public String getReturn_Thumbnil(String ocode) {
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		String new_ocode="";
	    if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
			String query = "select thumbnail_file from vod_media where del_flag='N' and ocode='" +ocode+"'";
			 Vector v = sqlbean.selectQuery(query); 
			  if(v != null && v.size() > 0) {
				  new_ocode = String.valueOf(v.elementAt(0)); 
			  	}  
		} 
	    return new_ocode; 
	}
	
	
	public String getReturn_ocode(String ocode) {
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		String new_ocode="";
	    if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
			String query = "select ocode from vod_media where del_flag='N' and old_ocode='" +ocode+"'";
			 Vector v = sqlbean.selectQuery(query); 
			  if(v != null && v.size() > 0) {
				  new_ocode = String.valueOf(v.elementAt(0)); 
			  	}  
		} 
	    return new_ocode; 
	}
	
	
	public Vector getOMediaInfo_cate(String ocode) {
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
	    if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
	    	return sqlbean.selectOMediaInfo_cate(ocode);
	    } else {
	    	return null;
	    }
	    
	}
	
	public Vector getOMediaInfo_admin(String ocode) {
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		 if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
			 return sqlbean.selectOMediaInfo_admin(ocode);
		 } else {
			 return null;
		 }
	    
	}


	
	/**
     * vod_images ����� �̹��� ���
     * @param ocode
     * @return Vector
     */
    public Vector getMediaImages(String ocode) {
    	ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
    	
    	 if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
    		 return sqlbean.selectMediaImages(ocode);
    	 } else {
    		 return null;
    	 }
    }

    /*****************************************************
        �̵���ڵ�� �ֻ��� ī�װ��ڵ� ��ȯ.<p>
    	<b>�ۼ���</b> : ����� <br>
    	@return �ֻ��� ī�װ��ڵ�<br>
    ******************************************************/
    public String getMTcode(String ocode ) {
    	ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		
        String ccode = "";
	 if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {         
	        Vector v = sqlbean.selectQuery("select ccode from vod_media where del_flag='N' and ocode=ocode='"+ocode+"' " );
	        if(v != null && v.size() > 0) {
	
	            ccode = String.valueOf(v.elementAt(0));
	           
	        }
	
	        return ccode;
	 } else {
		 return "";
	 }
    }



    /*****************************************************
        �̵�� ���� ����.<p>  // 
    	<b>�ۼ���</b> : ����<br>
    	@return �̵�� ����<br>
    	@param ocode �ֹ����̵�� �����ڵ�
    ******************************************************/
    public String gettitle(String ocode) {
    	ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		
        String rtnstr = "";
		if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
		        String query = "select b.title from vod_media as b where  del_flag='N' and b.ocode='"+ocode+"' ";
		        Vector v = sqlbean.selectQuery(query);
		
		        if(v != null && v.size() > 0) {
		
		            rtnstr = String.valueOf(v.elementAt(0));
		            //ccode = ccode.substring(0,3);
		            //ccode = TextUtil.zeroFill(0,9,ccode);
		        }
		
		        return rtnstr;
		} else {
			return "";
		}
    }



    public Vector selectQuery(String query) {
        return sqlbean.selectQuery(query);
    }


    public Vector selectQueryList(String query) {
        return sqlbean.selectMediaListAll(query);
    }




    /*****************************************************
        �̵���ڵ��� ���ε����� ����.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return ���ε����� ���ڿ��� ����<br>
    	@param code �̵���ڵ�, ī�װ�Ÿ��, �̵��Ÿ��
    ******************************************************/
	public String getUploadFolder(String ccode, String ctype) {

		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		ctype = com.vodcaster.utils.TextUtil.getValue(ctype);
				
	    String strtmp = "";
	    String strfolder1 = "";
	    String strfolder2 = "";
	    String strfolder3 = "";
	    String strfolder4 = "";
        String query = "";
        String str = ccode;

	    if(ccode != null && ccode.length()  >0 &&  ctype != null && ctype.length() > 0) {
	        
	        try {
		        
		        // ī�װ����̺��� ��,��,�Һз� ����.

		        Vector v2 = sqlbean.selectQuery("select cinfo from category where ccode='" +ccode+ "' and ctype='" +ctype+ "'");
		        String cinfo = "A";
		        if (v2 != null && v2.size() > 0) {
		            cinfo = String.valueOf(v2.elementAt(0));
		        }

		        String strFolderRoot = "";
		        if(ctype.equals("A"))
		            strFolderRoot = "/AOD/";
		        else if(ctype.equals("V"))
		            strFolderRoot = "/VOD/";
		        else if(ctype.equals("C"))
		            strFolderRoot = "/CONTENT/";
				else if (ctype.equals("P"))
					strFolderRoot = "/PHOTO/";
				else if (ctype.equals("L"))
					strFolderRoot = "/VOD/";

		        if(cinfo.equals("A")) {
		            strfolder1 = str;

		            strtmp = strFolderRoot + strfolder1;
		           // System.err.println(">>>>>>>>>>>>>>>>>>>>>>>" + strtmp);

		        } else if(cinfo.equals("B") && str!=null && str.length() > 3) {
			        strfolder1 = str.substring(0,3);
			        strfolder1 = TextUtil.zeroFill(0,12,strfolder1); //�ڷ� 9��°���� ����
			        strfolder2 = str;

			        strtmp = strFolderRoot +strfolder1+ "/" +strfolder2;
			       // System.err.println(">>>>>>>>>>>>>>>>>>>>>>>" + strtmp);

		        } else if(cinfo.equals("C") && str!=null && str.length() > 6) {
		            strfolder1 = str.substring(0,3);
		            strfolder1 = TextUtil.zeroFill(0,12,strfolder1); //�ڷ� 9��°���� ����
			        strfolder2 = str.substring(0,6);
			        strfolder2 = TextUtil.zeroFill(0,12,strfolder2); //�ڷ� 9��°���� ����
			        strfolder3 = str;

			        strtmp = strFolderRoot +strfolder1+ "/" +strfolder2+ "/" +strfolder3;
			      //  System.err.println(">>>>>>>>>>>>>>>>>>>>>>>" + strtmp);
		        }else if(cinfo.equals("D") && str!=null && str.length() > 6) {
		            strfolder1 = str.substring(0,3);
		            strfolder1 = TextUtil.zeroFill(0,12,strfolder1); //�ڷ� 9��°���� ����
			        strfolder2 = str.substring(0,6);
			        strfolder2 = TextUtil.zeroFill(0,12,strfolder2); //�ڷ� 9��°���� ����
			        strfolder3 = str.substring(0,9);
			        strfolder3 = TextUtil.zeroFill(0,12,strfolder3); //�ڷ� 9��°���� ����
			        strfolder4 = str;

			        strtmp = strFolderRoot +strfolder1+ "/" +strfolder2+ "/" +strfolder3+ "/" +strfolder4;
			       // System.err.println(">>>>>>>>>>>>>>>>>>>>>>>" + strtmp);
		        }

		       
	        } catch (Exception e) {
	            System.err.println("getUploadFolder2 ex : "+e.toString());
	        }

	        return strtmp;
	    } else {
	    	return null;
	    }

	}
    /*****************************************************
        �̵���ڵ��� ���ε����� ����.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return ���ε����� ���ڿ��� ����<br>
    	@param code �̵���ڵ�, ī�װ�Ÿ��, �̵��Ÿ��
    ******************************************************/
	public String getUploadFolder(String code, String ctype, String media_type) {

		code = com.vodcaster.utils.TextUtil.getValue(code);
		ctype = com.vodcaster.utils.TextUtil.getValue(ctype);
		media_type = com.vodcaster.utils.TextUtil.getValue(media_type);
				
	    String strtmp = "";
	    String strfolder1 = "";
	    String strfolder2 = "";
	    String strfolder3 = "";
	    String strfolder4 = "";
        String query = "";
        String str = "";
 
	    if(code != null && code.length()  >0 && com.yundara.util.TextUtil.isNumeric(code) &&  media_type != null && media_type.length() > 0) {

	        try {
		        // ī�װ� �ڵ� ����.
                if(media_type.equals("order_media")){
                    query = "select b.ccode from  vod_media as b where  b.ocode='" +code+"' ";
                    Vector v = sqlbean.selectQuery(query);
                    if(v != null && v.size() > 0){
                    	str = String.valueOf(v.elementAt(0));
                    }else{
                    	str = code;
                    }
                
                } else if(media_type.equals("")){
                    str = code;
                }

		        // ī�װ����̺��� ��,��,�Һз� ����.

		        Vector v2 = sqlbean.selectQuery("select cinfo from category where ccode='" +str+ "' and ctype='" +ctype+ "'");
		        String cinfo = "A";
		        if (v2 != null && v2.size() > 0) {
		            cinfo = String.valueOf(v2.elementAt(0));
		        }

		        String strFolderRoot = "";
		        if(ctype.equals("A"))
		            strFolderRoot = "/AOD/";
		        else if(ctype.equals("V"))
		            strFolderRoot = "/VOD/";
		        else if(ctype.equals("C"))
		            strFolderRoot = "/CONTENT/";
				else if (ctype.equals("P"))
					strFolderRoot = "/PHOTO/";
				else if (ctype.equals("L"))
					strFolderRoot = "/VOD/";


		        if(cinfo.equals("A")) {
		            strfolder1 = str;

		            strtmp = strFolderRoot + strfolder1;

		        } else if(cinfo.equals("B") && str!=null && str.length() > 3) {
			        strfolder1 = str.substring(0,3);
			        strfolder1 = TextUtil.zeroFill(0,12,strfolder1); //�ڷ� 9��°���� ����
			        strfolder2 = str;

			        strtmp = strFolderRoot +strfolder1+ "/" +strfolder2;

		        } else if(cinfo.equals("C") && str!=null && str.length() > 6) {
		            strfolder1 = str.substring(0,3);
		            strfolder1 = TextUtil.zeroFill(0,12,strfolder1); //�ڷ� 9��°���� ����
			        strfolder2 = str.substring(0,6);
			        strfolder2 = TextUtil.zeroFill(0,12,strfolder2); //�ڷ� 9��°���� ����
			        strfolder3 = str;

			        strtmp = strFolderRoot +strfolder1+ "/" +strfolder2+ "/" +strfolder3;
			        //System.err.println(">>>>>>>>>>>>>>>>>>>>>>>" + strtmp);
		        }else if(cinfo.equals("D") && str!=null && str.length() > 9) {
		            strfolder1 = str.substring(0,3);
		            strfolder1 = TextUtil.zeroFill(0,12,strfolder1); //�ڷ� 9��°���� ����
			        strfolder2 = str.substring(0,6);
			        strfolder2 = TextUtil.zeroFill(0,12,strfolder2); //�ڷ� 9��°���� ����
			        strfolder3 = str.substring(0,9);
			        strfolder3 = TextUtil.zeroFill(0,12,strfolder3); //�ڷ� 9��°���� ����
			        strfolder4 = str;

			        strtmp = strFolderRoot +strfolder1+ "/" +strfolder2+ "/" +strfolder3+ "/" +strfolder4;
			        //System.err.println(">>>>>>>>>>>>>>>>>>>>>>>" + strtmp);
		        }

		        // �ǽð��� ��� ��� ������
		        if (media_type.equals("live_media")) {
		            strtmp = strFolderRoot + str;
		        } 
	        } catch (Exception e) {
	            System.err.println("getUploadFolder ex : "+e.toString());
	        }

	        return strtmp;
	    } else {
	    	return null;
	    }

	}



    /*****************************************************
        ÷��ȭ�ϸ� ����.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return ÷��ȭ�ϸ�<br>
    	@param ocode �ֹ��� �̵���ڵ�
    ******************************************************/
	public String getAttachFile(String ocode) {

		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		String strtmp = "";
	    
	    if(ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
	        

	        try {
		        // ȭ�ϸ� ����.
		        String query = "select attach_file from vod_media where del_flag='N' and ocode='"+ocode+"' ";
		        Vector v = sqlbean.selectQuery(query);
		        if(v != null && v.size() > 0){
		        	strtmp = String.valueOf(v.elementAt(0));
		        }

	        } catch (Exception e) {
	            System.err.println("getAttachFile ex : "+e.getMessage());
	        }
	        return strtmp;
	    } else {
	    	return null;
	    }
	}




    /*****************************************************
        ���ε�� �̹��� ÷��ȭ�ϸ� ����.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return �̹��� ÷��ȭ�ϸ�<br>
    	@param ocode �ֹ��� �̵���ڵ�, �̹�����ȣ
    ******************************************************/
	public String getImageFile(String ocode) {

		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		
	    String strtmp = "";

	    if(ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
	    
	        try {
		        // ȭ�ϸ� ����.
		        String query = "select ModelImage from vod_media where del_flag='N' and ocode='"+ocode+"' ";
		        Vector v = sqlbean.selectQuery(query);
		        if(v != null && v.size() > 0){
		        	strtmp = String.valueOf(v.elementAt(0));
		        }

	        } catch (Exception e) {
	            System.err.println("getUploadFile ex : "+e.getMessage());

	        }

	        return strtmp;
	    } else{
	    	return null;
	    }

	}



    /*****************************************************
        ������ ��û�� ȸ�������� �α����̺� ����.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return ������ �̵������ ����<br>
    	@param vod_id ȸ�����̵�, ȸ���̸�, �̵���ڵ�, ȸ��������, �̵������ ���̺��
    ******************************************************/
	public int insertVodLog(String vod_id, String vod_name, String vod_buseo, String vod_gray, String vod_code, String vod_ip, String ctype) {
	 
		vod_id = com.vodcaster.utils.TextUtil.getValue(vod_id);
		vod_name = com.vodcaster.utils.TextUtil.getValue(vod_name);
		vod_buseo = com.vodcaster.utils.TextUtil.getValue(vod_buseo);
		vod_gray = com.vodcaster.utils.TextUtil.getValue(vod_gray);
		vod_code = com.vodcaster.utils.TextUtil.getValue(vod_code);
		vod_ip = com.vodcaster.utils.TextUtil.getValue(vod_ip);
		ctype = com.vodcaster.utils.TextUtil.getValue(ctype);
		
		
		
        if(vod_id == null || vod_id.equals("")) {
            vod_id = "guest";
        }
        if(vod_name == null || vod_name.equals("")) {
            vod_name = "�մ�";
        }
        if(vod_code.equals("")) {
            return -99;         //�����ڵ� ����
        }
        
		sqlbean.insertVodLog(vod_id, vod_name, vod_buseo, vod_gray, vod_code, vod_ip, ctype);
        return 0;
	}

	

    /*****************************************************
        �̵� ��û�� �� ȸ���� ����.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return �̵�� ��û�� �� ȸ����<br>
    	@param vod_code �̵���ڵ�, �̵��Ÿ��
    ******************************************************/
	public int getTotalViewMember2(String vod_code ){

		vod_code = com.vodcaster.utils.TextUtil.getValue(vod_code);
		
		 if (vod_code != null && vod_code.length() > 0 && com.yundara.util.TextUtil.isNumeric(vod_code)) {
		        String query = "select count(no) from vod_log where vod_code='" +vod_code + "'  ";
		 
		        Vector v = sqlbean.selectQuery(query);
		        if(v != null && v.size() > 0){
		        	return Integer.parseInt(String.valueOf(v.elementAt(0)));
		        }
		        else{
		        	return 0;
		        }
		 } else {
			 return 0;
		 }
	}

				 
	
	 /*****************************************************
    �ֹ����̵�� ��û ȸ����� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return �̵�� ��û�� ȸ������<br>
	@param vod_code �̵���ڵ�, �˻��ʵ�, �˻���, �̵��Ÿ��
******************************************************/
public Vector getOVODMemberList(String vod_code, String field, String searchstring ){

	vod_code = com.vodcaster.utils.TextUtil.getValue(vod_code);
	field = com.vodcaster.utils.TextUtil.getValue(field);
	searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
	
    String subquery = "";
	 if (vod_code != null && vod_code.length() > 0 && com.yundara.util.TextUtil.isNumeric(vod_code)) {
	    if(field!=null && !field.equals("")) {
	        if(field.equals("all")) {
	            subquery = " and ( vod_id like '%" +searchstring+ "%') and " +
	                    "( vod_name like '%" +searchstring+ "%')";
	        }else
	            subquery = " and ( " +field+ " like '%" +searchstring+ "%')";
	    }
	
	
	    String query = "select * from vod_log where vod_code='" +vod_code+ "' " +subquery+ "   order by no desc";
		return sqlbean.selectMediaListAllExt(query) ;
	 } else {
		 return null;
	 }
}
 
   
	//order_media ��ü �ڷ�
	// ocode, title �� �����Ѵ�.
	public Vector getAllOrderMedia(){
		return sqlbean.getAllOrderMedia();
	}
 

	 /*****************************************************
        �̵�����Ŀ� �´� �ֹ��� �̵���� ����.<p>
    	<b>�ۼ���</b> : ������<br>
    	@return �ֹ��� �̵�� ���<br>
    	@param mtype �̵������  CCode �� ���� �����Ͽ� ��������
    ******************************************************/
	public Vector getMediaListCode(String ccode, int limit){
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		if(limit > 30 || limit < 1) limit = 10;
		if (ccode != null && ccode.length() > 0) {
			String query = "";
			String Code = ccode;
			if ( ccode!=null && ccode.length() > 11 && ccode.substring(9,12).equals("000"))
			{
				Code = ccode.substring(0,9);
			}
			if ( ccode!=null && ccode.length() > 11  && ccode.substring(6,12).equals("000000"))
			{
				Code = ccode.substring(0,6);
			}
			if ( ccode!=null && ccode.length() > 11  && ccode.substring(3,12).equals("000000000"))
			{
				Code = ccode.substring(0,3);
			}
			query = "select * from   vod_media where del_flag='N'   and openflag='Y' and ccode like '" +Code+ "%' order by  mk_date desc, ocode desc limit 0,"+limit;
	
			return sqlbean.selectMediaListAll(query);
		} else {
			return null;
		}
	}


 
    /**
     * order_media ��ȸ�� ����
     * @param ocode
     */
    public void setOrdermediaHit(String ocode) {
    	ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		if(ocode != null && ocode.length()>0 && com.yundara.util.TextUtil.isNumeric(ocode)){
			sqlbean.updateOrdermediaHit(ocode);
		}
    }

	 
	 

	 /*****************************************************
	    �ֹ��� ���<p>
		<b>�ۼ���</b> : ����<br>
		@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
		@param ocode �ֹ����̵���ڵ�, �̵���ȣ
	******************************************************/

	public Vector getOMediaListAll2(  String field, String searchstring, String sorder, String direction, String ccode){

		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		direction = com.vodcaster.utils.TextUtil.getValue(direction);
		
        if (StringUtils.isEmpty(sorder)) {
            sorder = "mk_date";
        }
        if (StringUtils.isEmpty(direction)) {
            direction = "desc";
        }
        String subquery = "";
        if(field!=null && field.length() > 0) {
            if(field.equals("all")) {
                subquery = " and ( title like '%" +searchstring+ "%' " +
                        "or description like '%" +searchstring+ "%') ";
            }else if(field.equals("title")){
                subquery = " and ( title like '%" +searchstring+ "%' )";
            }else if(field.equals("tag") && !searchstring.equals("")) {
            	Vector v = null;
            	String tag_id = "null";
            	
            	String query = "select tag_id from tag_info where title='"+searchstring+"'";
            	
            	try {
            		v = sqlbean.selectQuery(query);
            	} catch(Exception e) {
            		System.err.println("tag_id ex : "+e.getMessage());
            	}
            	
		        if(v != null && v.size() > 0){
		        	tag_id = String.valueOf(v.elementAt(0));
		        }
		        
		        subquery = " and ( tag_info like '%/" +tag_id+ "/%' )";
            	
            }
        }

		String sub_query = "";

		if (ccode != null && ccode.length() > 0 )
		{
			
			if (ccode!= null && !ccode.equals("") && ccode.length() > 11)
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
		
				sub_query =" and  ccode like '" +Code + "%' ";
			}
 
		}


		//String query = "select * from  vod_media where oflag='" +oflag+ "'" +sub_query +subquery+ " order by " + sorder + " "  + direction;
		String query = "select * from  vod_media where del_flag='N' and filename <> '' and filename <> 'null'  " +sub_query +subquery+ " order by " + sorder + " "  + direction;

	//	System.out.println(query);

        return sqlbean.selectMediaListAll(query);
	}
	
	public Vector getOMediaListAll2_cate(  String field, String searchstring, String sorder, String direction, String ccode){

		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		direction = com.vodcaster.utils.TextUtil.getValue(direction);
		
        if (StringUtils.isEmpty(sorder)) {
            sorder = "mk_date";
        }
        if (StringUtils.isEmpty(direction)) {
            direction = "desc";
        }
        String subquery = "";
        if(field!=null && field.length() > 0) {
            if(field.equals("all")) {
                subquery = " and ( a.title like '%" +searchstring+ "%' " +
                        "or a.description like '%" +searchstring+ "%') ";
            }else if(field.equals("title")){
                subquery = " and ( a.title like '%" +searchstring+ "%' )";
            }else if(field.equals("tag") && !searchstring.equals("")) {
            	Vector v = null;
            	String tag_id = "null";
            	
            	String query = "select tag_id from tag_info where title='"+searchstring+"'";
            	
            	try {
            		v = sqlbean.selectQuery(query);
            	} catch(Exception e) {
            		System.err.println("tag_id ex : "+e.getMessage());
            	}
            	
		        if(v != null && v.size() > 0){
		        	tag_id = String.valueOf(v.elementAt(0));
		        }
		        
		        subquery = " and ( a.tag_info like '%/" +tag_id+ "/%' )";
            	
            }
        }

		String sub_query = "";

		if (ccode != null && ccode.length() > 0 )
		{
		
			sub_query =" and a.ccode like '" +ccode + "%' ";
		}
 
		//String query = "select * from  vod_media where oflag='" +oflag+ "'" +sub_query +subquery+ " order by " + sorder + " "  + direction;
		String query = " select a.*, b.ctitle from  vod_media a, category b " +
					   " where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' and a.openflag='Y' and b.openflag='Y' and b.ctype='V' and a.isended='1' " +
					   " 	   and a.filename <> '' and a.filename <> 'null'  " +sub_query +subquery+ " order by a." + sorder + " "  + direction;

        return sqlbean.selectMediaListAll(query);
	}



   
    /*****************************************************
	    �ֹ��� �̵���� ����.<p>
		<b>�ۼ���</b> : ����� <br>
		@return �ֹ��� �̵�� ���<br>
		@param mtype �̵��Ÿ��, ��¼���, �˻��ʵ�, �˻���, ��������ȣ
	******************************************************/
	
	public Hashtable getOMediaListAll_open( String ccode, String sorder, String field, String searchstring,int page, int limit, String direction) {
	
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		direction = com.vodcaster.utils.TextUtil.getValue(direction);
		if(page < 1 ) page = 1;
		if(limit < 1 || limit > 30) limit = 10;
		
		Hashtable result_ht;
	
	    String query = "";
	    String code = "";
		String sub_query = "";
	    String sub_query1 = "";
	    String sub_query2 = "";
		
	
	    if(sorder != null && sorder.length() > 0) {
	            sub_query1 = "order by b."+sorder ;
				if (direction!= null && !direction.equals("") && direction.length() > 0){
					sub_query1 = sub_query1 + " " + direction;
				}
	    }else {
	        sub_query1 = "order by b.mk_date desc, b.ocode desc";
		}
	
	    if(field != null && field.length() > 0 && searchstring != null && searchstring.length() > 0 ) {
	        if(field.equals("title"))
	            sub_query2 = " and (b.title like '%" +searchstring+ "%') ";
	        else if(field.equals("description"))
	            sub_query2 = " and ( b.description like '%" +searchstring+ "%') ";
	        else if(field.equals("user"))
	            sub_query2 = " and ( b.ownerID like '%" +searchstring+ "%') ";
	        else if(field.equals("all"))
	            sub_query2 = " and ( " +
	            		"       b.title like  '%" +searchstring+ "%'"+
	            		" or  b.ownerID like   '%" +searchstring+ "%'"+
	                    " or  b.description like '%" +searchstring+ "%') ";
	    }

		if (ccode!= null && !ccode.equals("") && ccode.length() > 11)
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

		query =  "select  b.* from  vod_media as b where b.del_flag='N' and b.openflag='Y' " +sub_query+ sub_query2 + sub_query1;
		String count_query =  "select  count(b.ocode) from  vod_media as b where b.del_flag='N' and b.openflag='Y' " +sub_query+ sub_query2 ;
//System.out.println(query);
	    try {
	        result_ht = sqlbean.getMediaListCnt(page, query, count_query, limit);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	
		return result_ht;
	
	
	}
	
public Hashtable getOMediaListAll_open2( String ccode, String mtype,  String sorder, String field, String searchstring,int page, int limit, String direction, int vod_level) {

	ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
	mtype = com.vodcaster.utils.TextUtil.getValue(mtype);
	sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
	field = com.vodcaster.utils.TextUtil.getValue(field);
	searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
	direction = com.vodcaster.utils.TextUtil.getValue(direction);
	if(page < 1 ) page = 1;
	if(limit < 1 || limit > 30) limit = 10;
	
	Hashtable result_ht;

    String query = "";
    String code = "";
	String sub_query = "";
    String sub_query1 = "";
    String sub_query2 = "";

    if(sorder!= null && sorder.length() > 0) {
            sub_query1 = "order by b."+sorder ;
			if (direction!= null && !direction.equals("") && direction.length() > 0){
				sub_query1 = sub_query1 + " " + direction;
			}
    }else {
        sub_query1 = "order by b.mk_date desc, b.ocode desc";
	}

    if(field != null && field.length() > 0 && searchstring != null && searchstring.length() > 0 ) {
        if(field.equals("title"))
            sub_query2 = " and (b.title like '%" +searchstring+ "%') ";
        else if(field.equals("description"))
            sub_query2 = " and ( b.description like '%" +searchstring+ "%') ";
        else if(field.equals("user"))
            sub_query2 = " and ( b.ownerID like '%" +searchstring+ "%') ";
        else if(field.equals("all"))
            sub_query2 = " and ( " +
            		" b.title like  '%" +searchstring+ "%'"+") "; 
    }

	if (ccode!= null && !ccode.equals("") && ccode.length() > 11)
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

//System.out.println(query);
	query =  "select  b.* from  vod_media as b where b.olevel<="+vod_level+" and b.del_flag='N' and b.openflag='Y'  " +sub_query+ sub_query2 + sub_query1;
	String count_query =  "select  count(b.ocode) from  vod_media as b where b.olevel<="+vod_level+" and b.del_flag='N' and b.openflag='Y'  " +sub_query+ sub_query2 ;
    try {
        result_ht = sqlbean.getMediaListCnt(page, query, count_query, limit);

    }catch (Exception e) {
        result_ht = new Hashtable();
        result_ht.put("LIST", new Vector());
        result_ht.put("PAGE", new com.yundara.util.PageBean());
    }

	return result_ht;

}

public Hashtable getOMediaListAll_admin_cate( String ccode, String mtype,  String sorder, String field, String searchstring,int page, int limit, String direction , String event_seq) {

	ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
	mtype = com.vodcaster.utils.TextUtil.getValue(mtype);
	sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
	field = com.vodcaster.utils.TextUtil.getValue(field);
	searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
	direction = com.vodcaster.utils.TextUtil.getValue(direction);
	event_seq = com.vodcaster.utils.TextUtil.getValue(event_seq);
	if(page < 1 ) page = 1;
	if(limit < 1 || limit > 30) limit = 10;
	
    Hashtable result_ht;

    String query = "";
 
	String sub_query = "";
    String sub_query1 = "";
    String sub_query2 = "";
	

    if(sorder!= null && sorder.length() > 0) {
            sub_query1 = "order by b."+sorder ;
			if (direction!= null && !direction.equals("") && direction.length() > 0){
				sub_query1 = sub_query1 + " " + direction;
			}
    }else {
        sub_query1 = "order by b.mk_date desc, b.ocode desc";
	}

    if(field != null && field.length() > 0 && searchstring != null && searchstring.length() > 0 ) {
        if(field.equals("title"))
            sub_query2 = " and (b.title like '%" +searchstring+ "%') ";
        else if(field.equals("description"))
            sub_query2 = " and ( b.description like '%" +searchstring+ "%') ";
        else if(field.equals("user"))
            sub_query2 = " and ( b.ownerID like '%" +searchstring+ "%') ";
        else if(field.equals("all"))
            sub_query2 = " and ( " +
            		" b.title like  '%" +searchstring+ "%'"+") "; 
    }

	if (ccode!= null && !ccode.equals("") && ccode.length() > 11)
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
	
	if (event_seq != null && event_seq.length() > 0) {
	sub_query += " and b.event_seq ='"+event_seq+"' ";
	}

	query = " select b.*,  u.user_key, u.user_tel, u.user_email, u.etc from vod_media b left join event_user u  on b.ocode = u.ocode , category a  " +
			" where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
			" and a.ctype='V' " +
			 sub_query + sub_query2 + sub_query1;
	String count_query = " select count(b.ocode) from vod_media b left join event_user u  on b.ocode = u.ocode , category a  " +
		" where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
		" and a.ctype='V' " +
		sub_query + sub_query2 ;
//System.out.println(query);	
    try {
        result_ht = sqlbean.getMediaListCnt(page, query, count_query, limit);

    }catch (Exception e) {
    	System.out.println("getOMediaListAll_admin_cate:"+e);
        result_ht = new Hashtable();
        result_ht.put("LIST", new Vector());
        result_ht.put("PAGE", new com.yundara.util.PageBean());
    }

	return result_ht;


}


public Vector getOMediaListAll_admin_cateExcel( String ccode, String mtype,  String sorder, String field, String searchstring, String direction , String event_seq) {

	ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
	mtype = com.vodcaster.utils.TextUtil.getValue(mtype);
	sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
	field = com.vodcaster.utils.TextUtil.getValue(field);
	searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
	direction = com.vodcaster.utils.TextUtil.getValue(direction);
	event_seq = com.vodcaster.utils.TextUtil.getValue(event_seq);
	
	Hashtable result_ht;

    String query = "";
 
	String sub_query = "";
    String sub_query1 = "";
    String sub_query2 = "";
	

    if(sorder!= null && sorder.length() > 0 ) {
            sub_query1 = "order by b."+sorder ;
			if (direction!= null && !direction.equals("") && direction.length() > 0){
				sub_query1 = sub_query1 + " " + direction;
			}
    }else {
        sub_query1 = "order by  b.mk_date desc, b.ocode desc";
	}

    if(field != null && field.length() > 0 && searchstring != null && searchstring.length() > 0 ) {
        if(field.equals("title"))
            sub_query2 = " and (b.title like '%" +searchstring+ "%') ";
        else if(field.equals("description"))
            sub_query2 = " and ( b.description like '%" +searchstring+ "%') ";
        else if(field.equals("user"))
            sub_query2 = " and ( b.ownerID like '%" +searchstring+ "%') ";
        else if(field.equals("all"))
            sub_query2 = " and ( " +
            		" b.title like  '%" +searchstring+ "%'"+") "; 
    }

	if (ccode!= null && !ccode.equals("") && ccode.length() > 11)
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
	
	if (event_seq != null && event_seq.length() > 0 && com.yundara.util.TextUtil.isNumeric(event_seq)) {
		sub_query += " and b.event_seq ='"+event_seq+"' ";
	}

	query = " select b.event_gread, b.ownerid, u.user_tel, u.user_email, b.title, b.event_seq, b.ocode from vod_media b left join event_user u  on b.ocode = u.ocode , category a  " +
			" where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
			" and a.ctype='V' and b.event_gread > 0 " +
			 sub_query + sub_query2 + sub_query1;
 
	//System.err.println(query);
	return sqlbean.selectMediaListAllExt(query) ;


}

public Hashtable getOMediaListAll_open2_cate( String ccode, String mtype,  String sorder, String field, String searchstring,int page, int limit, String direction, int vod_level) {

	ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
	mtype = com.vodcaster.utils.TextUtil.getValue(mtype);
	sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
	field = com.vodcaster.utils.TextUtil.getValue(field);
	searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
	direction = com.vodcaster.utils.TextUtil.getValue(direction);
	if(page < 1 ) page = 1;
	if(limit < 1 || limit > 30) limit = 10;
	
	Hashtable result_ht;

    String query = " ";
    String code = "";
	String sub_query = " ";
    String sub_query1 = " ";
    String sub_query2 = " ";
	

    if(sorder!= null && sorder.length() > 0) {
            sub_query1 = " order by b."+sorder ;
			if (direction!= null && !direction.equals("") && direction.length() > 0){
				sub_query1 = sub_query1 + " " + direction +", b.ocode desc ";
			}
    }else {
        sub_query1 = " order by b.mk_date desc, b.ocode desc";
	}

    if(field != null && field.length() > 0 && searchstring != null && searchstring.length() > 0 ) {
        if(field.equals("title"))
            sub_query2 = " and (b.title like '%" +searchstring+ "%') ";
        else if(field.equals("description"))
            sub_query2 = " and ( b.description like '%" +searchstring+ "%') ";
        else if(field.equals("user"))
            sub_query2 = " and ( b.ownerID like '%" +searchstring+ "%') ";
        else if(field.equals("all"))
            sub_query2 = " and ( " +
            		" b.title like  '%" +searchstring+ "%'"+") "; 
    }

	if (ccode!= null && !ccode.equals("") && ccode.length() > 11)
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

//System.out.println(query);
	query = " select b.*, a.ctitle, (SELECT COUNT(muid) FROM content_memo WHERE b.ocode=ocode) AS memo_cnt  from  vod_media b, category a " +
			" where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
			"		and a.openflag='Y' and b.openflag='Y' and a.ctype='V' and b.isended='1' " +
			" 		and b.olevel <= "+vod_level + sub_query + sub_query2 + sub_query1;
    
	String count_query = " select count(b.ocode) from  vod_media b, category a " +
		" where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
		"		and a.openflag='Y' and b.openflag='Y' and a.ctype='V'  and b.isended='1' " +
		" 		and b.olevel <= "+vod_level + sub_query + sub_query2;
	try {
        result_ht = sqlbean.getMediaListCnt(page, query, count_query, limit);

    }catch (Exception e) {
        result_ht = new Hashtable();
        result_ht.put("LIST", new Vector());
        result_ht.put("PAGE", new com.yundara.util.PageBean());
    }

	return result_ht;


}

public Hashtable getOMediaListAll_open3( String ccode, String mtype,  String sorder, String field, String searchstring,int page, int limit, String direction, String gcode, int vod_level) {

	ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
	mtype = com.vodcaster.utils.TextUtil.getValue(mtype);
	sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
	field = com.vodcaster.utils.TextUtil.getValue(field);
	searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
	direction = com.vodcaster.utils.TextUtil.getValue(direction);
	gcode = com.vodcaster.utils.TextUtil.getValue(gcode);
	if(page < 1 ) page = 1;
	if(limit < 1 || limit > 30) limit = 10;
	
    Hashtable result_ht;

    String query = "";
    String code = "";
	String sub_query = "";
    String sub_query1 = "";
    String sub_query2 = "";
	

    if(sorder!= null && sorder.length() > 0) {
            sub_query1 = "order by b."+sorder ;
			if (direction!= null && !direction.equals("") && direction.length() > 0){
				sub_query1 = sub_query1 + " " + direction;
			}
    }else {
        sub_query1 = "order by  b.mk_date desc,  b.ocode desc";
	}

    if(field != null && field.length() > 0 && searchstring != null && searchstring.length() > 0 ) {
        if(field.equals("title"))
            sub_query2 = " and (b.title like '%" +searchstring+ "%') ";
        else if(field.equals("description"))
            sub_query2 = " and ( b.description like '%" +searchstring+ "%') ";
        else if(field.equals("user"))
            sub_query2 = " and ( b.ownerID like '%" +searchstring+ "%') ";
        else if(field.equals("all"))
            sub_query2 = " and ( " +
            		" b.title like  '%" +searchstring+ "%'"+") "; 
    }

	if (ccode!= null && !ccode.equals("") && ccode.length() > 11)
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
	
	if (gcode != null && gcode.length() > 0) {
		sub_query =" and b.gcode = '" +gcode + "' ";
	}

//System.out.println(query);
	query =  "select  b.* from  vod_media as b where b.olevel<="+vod_level+" and b.del_flag='N' and b.openflag='Y'  " +sub_query+ sub_query2 + sub_query1;
	String count_query =  "select  count(b.ocode) from  vod_media as b where b.olevel<="+vod_level+" and b.del_flag='N' and b.openflag='Y'  " +sub_query+ sub_query2;
    try {
        result_ht = sqlbean.getMediaListCnt(page, query,count_query, limit);

    }catch (Exception e) {
        result_ht = new Hashtable();
        result_ht.put("LIST", new Vector());
        result_ht.put("PAGE", new com.yundara.util.PageBean());
    }

	return result_ht;

}

public Hashtable getOMediaListAll_open3_cate( String ccode, String mtype,  String sorder, String field, String searchstring,int page, int limit, String direction, String gcode, int vod_level) {

	ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
	mtype = com.vodcaster.utils.TextUtil.getValue(mtype);
	sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
	field = com.vodcaster.utils.TextUtil.getValue(field);
	searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
	direction = com.vodcaster.utils.TextUtil.getValue(direction);
	gcode = com.vodcaster.utils.TextUtil.getValue(gcode);
	if(page < 1 ) page = 1;
	if(limit < 1 || limit > 30) limit = 10;
	
    Hashtable result_ht;

    String query = " ";
    String code = "";
	String sub_query = " ";
    String sub_query1 = " ";
    String sub_query2 = " ";
	

    if(sorder!= null && sorder.length() > 0) {
            sub_query1 = " order by b."+sorder ;
			if (direction!= null && !direction.equals("") && direction.length() > 0){
				sub_query1 = sub_query1 + " " + direction +" , b.ocode desc " ;
			}
    }else {
        sub_query1 = " order by b.mk_date desc , b.ocode desc ";
	}

    if(field != null && field.length() > 0 && searchstring != null && searchstring.length() > 0 ) {
        if(field.equals("title"))
            sub_query2 = " and (b.title like '%" +searchstring+ "%') ";
        else if(field.equals("description"))
            sub_query2 = " and ( b.description like '%" +searchstring+ "%') ";
        else if(field.equals("user"))
            sub_query2 = " and ( b.ownerID like '%" +searchstring+ "%') ";
        else if(field.equals("tag_title"))
            sub_query2 = " and ( b.tag_title like '%" +searchstring+ "%') ";
        else if(field.equals("all")){
            sub_query2 = " and ( " +
            		"    b.title like  '%" +searchstring+ "%'" +
    				" or b.description like '%" +searchstring+ "%'" +
    				" or b.tag_title like '%" +searchstring+ "%'"+") ";
        }
    }

	if (ccode!= null && !ccode.equals("") && ccode.length() > 11)
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
	
	if (gcode != null && gcode.length() > 0) {
		sub_query =" and b.gcode = '" +gcode + "' ";
	}

	query = " select b.*, a.ctitle from  vod_media b, category a " +
			" where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
			"		and a.openflag='Y' and b.openflag='Y' and a.ctype='V' " +
			" 		and b.olevel <= "+vod_level + sub_query + sub_query2 + sub_query1;
	String count_query = " select count(b.ocode) from  vod_media b, category a " +
			" where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
			"		and a.openflag='Y' and b.openflag='Y' and a.ctype='V' " +
			" 		and b.olevel <= "+vod_level + sub_query + sub_query2;
	//System.out.println(query);
    try {
        result_ht = sqlbean.getMediaListCnt(page, query, count_query, limit);

    }catch (Exception e) {
        result_ht = new Hashtable();
        result_ht.put("LIST", new Vector());
        result_ht.put("PAGE", new com.yundara.util.PageBean());
    }

	return result_ht;

}

	/*****************************************************
        �ֹ��� �̵�� ������ ����.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return �ֹ��� �̵�� ����<br>
    	@param ccode, direction ( desd, asc) ���ļ���
    ******************************************************/
	public Vector getCode_1(String ccode, String direction, int vod_level) {
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		direction = com.vodcaster.utils.TextUtil.getValue(direction);
		
	    if (ccode != null && ccode.length() > 0 && direction != null && direction.length() > 0 && vod_level >= 0 ) {
	    	return sqlbean.selectCode_1(ccode, direction, vod_level);
	    } else {
	    	return null;
	    }
	    
	}
	
	public Vector getCode_1_cate(String ccode, String direction, int vod_level) {
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		direction = com.vodcaster.utils.TextUtil.getValue(direction);
		
		if (ccode != null && ccode.length() > 0 && direction != null && direction.length() > 0 && vod_level >= 0 ) {
			return sqlbean.selectCode_1_cate(ccode, direction, vod_level);
		} else {
			return null;
		}
	    
	}
	
	/*****************************************************
        �ֹ��� �̵�� ��õ����(point) ����.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return �ֹ��� �̵�� ����<br>
    	@param mtype, ocode ����Ű
    ******************************************************/
	public int getOMediaPoint(  String ocode) {
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
  		int point = 0;
		if (ocode != null && ocode.length() > 0 ) {
			Vector return_value = sqlbean.selectOMediaPoint(  ocode);
			if (return_value != null && return_value.size() > 0) {
				 
				point = Integer.parseInt(String.valueOf(return_value.elementAt(0)));
			}
			
		}  
		return point;
		
	}
	
	/*****************************************************
    ���� �� ������ ����Ʈ<p>
	<b>�ۼ���</b> : ����<br>
	@return ���� �� ������ ����Ʈ<br>
	@param vod_id, mtype ����Ű
******************************************************/

public Hashtable getMySeenList( String vod_id,   String field, String searchstring,int page, int limit) {
	vod_id = com.vodcaster.utils.TextUtil.getValue(vod_id);
	field = com.vodcaster.utils.TextUtil.getValue(field);
	searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
	if(page < 1 ) page = 1;
	if(limit < 1 || limit > 30) limit = 10;
	
    Hashtable result_ht;

    String query = "";
    String sub_query = ""; 
    
    if(field != null && field.length() > 0 && searchstring != null && searchstring.length() > 0 ) {
        if(field.equals("title"))
        	sub_query = " and (m.title like '%" +searchstring+ "%') ";
        else if(field.equals("description"))
        	sub_query = " and ( m.description like '%" +searchstring+ "%') ";
        else if(field.equals("user"))
        	sub_query = " and ( m.ownerID like '%" +searchstring+ "%') ";
    }
 
	query =  "select l.no, l.ip, l.vod_code, l.regdate, l.oflag as logflag, m.* " +
			 "from vod_log l, vod_media m " +
			 "where m.del_flag='N' and l.vod_code=m.ocode and l.vod_id='"+vod_id+"'   " + sub_query +
			 "order by l.regDate,l.no desc";
	String count_query =  "select count(l.no)" +
			 "from vod_log l, vod_media m " +
			 "where m.del_flag='N' and l.vod_code=m.ocode and l.vod_id='"+vod_id+"'   " + sub_query;
    try {
        result_ht = sqlbean.getMediaListCnt(page, query, count_query, limit);

    }catch (Exception e) {
        result_ht = new Hashtable();
        result_ht.put("LIST", new Vector());
        result_ht.put("PAGE", new com.yundara.util.PageBean());
    }

	return result_ht;


}

public Hashtable getMySeenList_cate( String vod_id,   String field, String searchstring,int page, int limit) {
	vod_id = com.vodcaster.utils.TextUtil.getValue(vod_id);
	field = com.vodcaster.utils.TextUtil.getValue(field);
	searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
	if(page < 1 ) page = 1;
	if(limit < 1 || limit > 30) limit = 10;
	
    Hashtable result_ht;

    String query = "";
    String sub_query = "";
    
    if(field != null && field.length() > 0 && searchstring != null && searchstring.length() > 0 ) {
        if(field.equals("title"))
        	sub_query = " and (m.title like '%" +searchstring+ "%') ";
        else if(field.equals("description"))
        	sub_query = " and ( m.description like '%" +searchstring+ "%') ";
        else if(field.equals("user"))
        	sub_query = " and ( m.ownerID like '%" +searchstring+ "%') ";
    }



	query =  " select l.no, l.ip, l.vod_code, l.regdate, l.oflag as logflag, m.* " +
			 " from vod_log l, (select a.* from vod_media a, category b where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' and a.openflag='Y' and b.openflag='Y' and b.ctype='V') m " +
			 " where l.vod_code=m.ocode and l.vod_id='"+vod_id+"'   " + sub_query +
			 " order by l.regDate,l.no desc";
	String count_query =  " select count(l.no) " +
			 " from vod_log l, (select a.* from vod_media a, category b where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' and a.openflag='Y' and b.openflag='Y' and b.ctype='V') m " +
			 " where l.vod_code=m.ocode and l.vod_id='"+vod_id+"'   " + sub_query ;
    try {
        result_ht = sqlbean.getMediaListCnt(page, query,count_query,  limit);

    }catch (Exception e) {
        result_ht = new Hashtable();
        result_ht.put("LIST", new Vector());
        result_ht.put("PAGE", new com.yundara.util.PageBean());
    }

	return result_ht;


}

	//////////
	//����
	//����� ��� ��ü ����Ʈ
	/////////
	public Vector getRMediaListAll(){
	
	    String query = "";
	
	    query = "select * from live_media  order by rwdate desc" ;
	
		return sqlbean.selectMediaListAll(query);
	}

///////////
// ����
// �̵�� �α����� ���
//////////

	public Vector getOVODMemberList3(String rstime,String retime,String ocode, String ownerID, String cate  ){

		rstime = com.vodcaster.utils.TextUtil.getValue(rstime);
		retime = com.vodcaster.utils.TextUtil.getValue(retime);
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		ownerID = com.vodcaster.utils.TextUtil.getValue(ownerID);
		cate = com.vodcaster.utils.TextUtil.getValue(cate);
		
		
		String sub_query = "";
	    	
	    String table = "";
		String table2 = "";

			table = "vod_log"; 
			table2= "vod_media";

		if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode))
		{
			sub_query = sub_query + " and a.vod_code = '"+ ocode+"'";
		}

		if (ownerID != null && ownerID.length() > 0)
		{
			sub_query = sub_query + " and a.vod_id = '"+ ownerID+"' ";
		}

		if (rstime != null && rstime.length() > 0 && retime != null && retime.length() > 0 )
		{
			sub_query = sub_query + " and a.regDate between '" +rstime+ "' and '"+retime +" 23:59' ";
		} 
		else if (rstime != null && rstime.length() > 0 && (retime == null || retime.equals("")) )
		{
			sub_query = sub_query + " and a.regDate >= '" +rstime +"' ";
		}else if (retime != null && retime.length() > 0 && (rstime == null || rstime.equals("")) )
		{
			sub_query = sub_query + " and a.regDate <= '" +retime +"' ";
		}

		if (cate != null && cate.length() > 0 )
		{
			sub_query = sub_query +  "  and b.ccode like '"+cate+"%' ";
		}

		String query = "";
		
			 query ="select distinct(a.no),a.ip,a.vod_id,a.vod_name,a.vod_code, a.regDate, b.title from " +table+ " a, "+table2+"" +
			 		" b where b.del_flag='N' and a.vod_code = b.ocode "+sub_query+" order by a.no desc";
		
		return sqlbean.selectMediaListAllExt(query) ;


		}


//////////
//  ����
//  �α����� ���
/////////



public Vector getVodLog_(String rstime,String retime,String ctype, String ocode, String ownerID, String cate, String oflag , String sosok, String buseo, String gray ){

	rstime = com.vodcaster.utils.TextUtil.getValue(rstime);
	retime = com.vodcaster.utils.TextUtil.getValue(retime);
	ctype = com.vodcaster.utils.TextUtil.getValue(ctype);
	ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
	ownerID = com.vodcaster.utils.TextUtil.getValue(ownerID);
	cate = com.vodcaster.utils.TextUtil.getValue(cate);
	oflag = com.vodcaster.utils.TextUtil.getValue(oflag);
	sosok = com.vodcaster.utils.TextUtil.getValue(sosok);
	buseo = com.vodcaster.utils.TextUtil.getValue(buseo);
	gray = com.vodcaster.utils.TextUtil.getValue(gray);
	
		String sub_query = "";
		String query2 = "";

		String table = "";
		String table2 = "";

		
			table = "vod_log"; 
			table2="vod_media";
		

		if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode))
		{
			sub_query = sub_query + " and a.vod_code = '"+ ocode+"'";
		}

		if (ownerID != null && ownerID.length() > 0)
		{
			sub_query = sub_query + " and a.vod_id = '"+ ownerID+"' ";
		}

		if (rstime != null && rstime.length() > 0 && retime != null && retime.length() > 0 )
		{
			sub_query = sub_query + " and a.regDate between " +rstime+ " and "+retime ;
		} else if (rstime != null && rstime.length() > 0 && (retime == null || retime.equals("")) )
		{
			sub_query = sub_query + " and a.regDate >= " +rstime ;
		}else if (retime != null && retime.length() > 0 && (rstime == null || rstime.equals("")) )
		{
			sub_query = sub_query + " and a.regDate <= " +retime ;
		}

		if (cate != null && cate.length() > 0)
		{
			sub_query = sub_query +  "  and b.ccode like '"+cate+"%' ";
		}
 
	   if (sosok != null && sosok.length()> 0 )
	   {
			sub_query = sub_query + " and a.sosok='"+sosok+"' ";
			if (buseo != null && buseo.length()> 0 )
			   {
					sub_query = sub_query + " and a.buseo='"+buseo+"' ";
					if (gray != null && gray.length()> 0 )
					   {
							sub_query = sub_query + " and a.gray='"+gray+"' ";

					   }
			   }
	   }
 
		String query ="select distinct(a.no),a.ip,a.vod_id,a.vod_name,a.vod_code,a.regDate,b.title from " +table+ " a, "+table2+" b where b.del_flag='N' and a.vod_code = b.ocode "+sub_query+"   order by a.no desc";

//System.out.println(query);				

		return sqlbean.selectMediaListAllExt(query) ;


		}

///////////
//  ÷������ ���
//  ����
////////////

	


    /*****************************************************
        �̵��з��� Limit������ ���� �ֹ��� �̵���� ����.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return ��û�� ������ �ֹ��� �̵�� ���<br>
    	@param oflag �̵��з�, ��°���
    ******************************************************/
	public Vector getOMediaListLimit(String oflag, int limit2){
		oflag = com.vodcaster.utils.TextUtil.getValue(oflag);
		if(limit2 < 1 || limit2 > 30) limit2 = 10;
		if (oflag != null && oflag.length() > 0 && limit2 > 0) {
			String query = "";
			String sub_query =  " filename <> '' and filename <> 'null' ";
	 
			query = "select * from vod_media  where del_flag='N' and " +sub_query+ " order by  mk_date desc, ocode desc limit 0," +limit2;
			return sqlbean.selectMediaListAll(query);
		} else {
			return null;
		}
	}

///////////////////
// ��û ī��Ʈ ����
// ����
///////////////////
	public int getTotalVcount(String rstime, String retime, String ocode, String ownerID, String cate, String Sosok,String Buseo,String Gray){

		rstime = com.vodcaster.utils.TextUtil.getValue(rstime);
		retime = com.vodcaster.utils.TextUtil.getValue(retime);
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		ownerID = com.vodcaster.utils.TextUtil.getValue(ownerID);
		cate = com.vodcaster.utils.TextUtil.getValue(cate);
		Sosok = com.vodcaster.utils.TextUtil.getValue(Sosok);
		Buseo = com.vodcaster.utils.TextUtil.getValue(Buseo);
		Gray = com.vodcaster.utils.TextUtil.getValue(Gray);
		
		String sub_query = "";
		String table = "";
		String table2 = "";

	
			table = "vod_log"; 
			table2 = "vod_media";
		
 

		if (ocode != null && ocode.length() >  0 && com.yundara.util.TextUtil.isNumeric(ocode))
		{
			sub_query = sub_query + " and a.vod_code = '"+ ocode+"'";
		}

		if (ownerID != null && ownerID.length() >  0 )
		{
			sub_query = sub_query + " and a.vod_id = '"+ ownerID+"' ";
		}

		if (rstime != null && rstime.length() >  0  && retime != null && retime.length() >  0  )
		{
			sub_query = sub_query + " and a.regDate between '" +rstime+ "' and '"+retime+" 23:59'" ;
		} else if (rstime != null && rstime.length() >  0  && (retime == null || retime.equals("")) )
		{
			sub_query = sub_query + " and a.regDate >= '" +rstime +"'";
		}else if (retime != null && retime.length() >  0  && (rstime == null || rstime.equals("")) )
		{
			sub_query = sub_query + " and a.regDate <= '" +retime+" 23:59'" ;
		}

		if (cate != null && cate.length() > 0 )
		{

			sub_query = sub_query + " and b.ccode like '" +cate + "%' ";
		}
		
 		
		String query = " select count(a.vod_id) from "+table+" a, "+table2+" b where b.del_flag='N' and a.vod_code = b.ocode "+sub_query;



		 Vector v = sqlbean.selectQuery(query);
        if(v != null && v.size() > 0){
        	return Integer.parseInt(String.valueOf(v.elementAt(0)));
        }
        else{
        	return 0;
        }
		
	}


	////////////////
	// �� hit ��
	////////////////
	public int getTotalhit(  String ccode, String del_flag){
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		del_flag = com.vodcaster.utils.TextUtil.getValue(del_flag);
		String sub_query = "";
 
		if (ccode!= null && !ccode.equals("") && ccode.length() > 11)
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

			sub_query =sub_query + " and b.ccode like '" +Code + "%' ";
		}
		
		if (del_flag != null && !del_flag.equals("") && del_flag.length() > 0)
		{
			sub_query = sub_query + " and a.del_flag = '"+ del_flag+"' and b.del_flag='"+del_flag+"' ";
		}
		
		String query = " select sum(a.hitcount) from vod_media a , category b where a.ccode=b.ccode and b.ctype='V' "+sub_query;



		 Vector v = sqlbean.selectQuery(query);
        if(v != null && v.size() > 0){
        	return Integer.parseInt(String.valueOf(v.elementAt(0)));
        }
        else{
        	return 0;
        }
		
	}
	
	
	public int getTotalvod( String ccode, String del_flag){
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		del_flag = com.vodcaster.utils.TextUtil.getValue(del_flag);
		String sub_query = "";
	 
		 
		if (ccode!= null && !ccode.equals("") && ccode.length() > 11)
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

			sub_query =sub_query + " and b.ccode like '" +Code + "%' ";
		} 
		
		if (del_flag != null && !del_flag.equals("") && del_flag.length() > 0)
		{
			sub_query = sub_query + " and a.del_flag = '"+ del_flag+"' and b.del_flag='"+del_flag+"' ";
		}
		
		String query = " select count(a.ocode) from vod_media a , category b where a.ccode=b.ccode and b.ctype='V' "+sub_query;



		 Vector v = sqlbean.selectQuery(query);
        if(v != null && v.size() > 0){
        	return Integer.parseInt(String.valueOf(v.elementAt(0)));
        }
        else{
        	return 0;
        }
		
	}
	
	public int getTotalvod_date( String ccode, String del_flag , String rstime, String retime){
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		del_flag = com.vodcaster.utils.TextUtil.getValue(del_flag);
		String sub_query = "";
	 
		 
		if (ccode!= null && !ccode.equals("") && ccode.length() > 11)
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

			sub_query =sub_query + " and b.ccode like '" +Code + "%' ";
		} 
		
		if (rstime != null && rstime.length() > 0 && retime != null && retime.length() > 0 )
		{
			sub_query = sub_query + " and a.mk_date between '" +rstime+ "' and '"+retime +"' ";
		} else if (rstime != null && rstime.length() > 0 && (retime == null || retime.equals("")) )
		{
			sub_query = sub_query + " and a.mk_date >= '" +rstime +"' ";
		}else if (retime != null && retime.length() > 0 && (rstime == null || rstime.equals("")) )
		{
			sub_query = sub_query + " and a.mk_date <= '" +retime +"' ";
		}

		if (del_flag != null && !del_flag.equals("") && del_flag.length() > 0)
		{
			sub_query = sub_query + " and a.del_flag = '"+ del_flag+"' and b.del_flag='"+del_flag+"' ";
		}
		
		String query = " select count(a.ocode) from vod_media a , category b where a.ccode=b.ccode and b.ctype='V' "+sub_query;

 
		 Vector v = sqlbean.selectQuery(query);
        if(v != null && v.size() > 0){
        	return Integer.parseInt(String.valueOf(v.elementAt(0)));
        }
        else{
        	return 0;
        }
		
	}
	
	
	public Vector getTotalvod_date_all( String rstime, String retime){
		
		String sub_query = "";
 
		if (rstime != null && rstime.length() > 0 && retime != null && retime.length() > 0 )
		{
			sub_query = sub_query + " and a.mk_date between '" +rstime+ "' and '"+retime +"' ";
		} else if (rstime != null && rstime.length() > 0 && (retime == null || retime.equals("")) )
		{
			sub_query = sub_query + " and a.mk_date >= '" +rstime +"' ";
		}else if (retime != null && retime.length() > 0 && (rstime == null || rstime.equals("")) )
		{
			sub_query = sub_query + " and a.mk_date <= '" +retime +"' ";
		}

		String query = "SELECT b.ctitle, b.ccode , COUNT(a.ocode)AS cnt, IFNULL(SUM(a.hitcount),0) AS hit FROM category AS b LEFT JOIN vod_media AS a ON b.ccode = a.ccode "
				+ " AND a.del_flag = 'N' "+sub_query
				+ " WHERE b.ctype='V'   AND b.del_flag='N' "
				+ " GROUP BY b.ccode ";
 
		 return 	sqlbean.selectMediaListAllExt(query);
		
	}
	
///////////////////////
// �ֱ� ������ ��������
// ����
///////////////////////
		public Vector getMediaListNew(int limit){
			if(limit < 1 || limit > 30) limit = 10;
			
			if (limit > 0) {
				String query  = " select a.*, c.ctitle from vod_media a, category c where a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V' order by a.mk_date desc, a.ocode desc  limit 0," + limit;
				//System.out.println(query);
			return sqlbean.selectMediaListAll(query);
			} else {
				return null;
		}
	}

		public Hashtable getMediaListNew_page( int page, int limit){
			//System.out.println(query);
			
			Hashtable result_ht;
			if(page < 1 ) page = 1;
			if(limit < 1 || limit > 30) limit = 10;
			
			String query  = " select a.*, c.ctitle from vod_media a, category c where a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V' order by a.mk_date desc, a.ocode desc ";
			
		    
			String count_query = " select count(a.ocode) from vod_media a, category c where a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V' order by a.mk_date desc, a.ocode desc ";
			try {
		        result_ht = sqlbean.getMediaListCnt(page, query, count_query, limit);

		    }catch (Exception e) {
		        result_ht = new Hashtable();
		        result_ht.put("LIST", new Vector());
		        result_ht.put("PAGE", new com.yundara.util.PageBean());
		    }

			return result_ht;

	}
		
		
		public Vector getMediaList_count(String ccode, int limit){
			if(limit < 1 || limit > 30) limit = 10;
			
			if (limit > 0) {
				String query  = " select a.*, c.ctitle from vod_media a, category c where a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V' and a.ccode like '"+ccode+"%' order by a.mk_date desc, a.ocode desc  limit 0," + limit;
				//System.out.println(query);
			return sqlbean.selectMediaListAll(query);
			} else {
				return null;
		}
	}
		
	public Vector getMediaList_count_order(String ccode,String order, int limit){
			if(limit < 1 || limit > 30) limit = 10;
			
			if (limit > 0) {
				String query  = " select a.*, c.ctitle from vod_media a, category c where a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V' and a.ccode like '"+ccode+"%' order by a."+order+" desc ,a.mk_date desc, a.ocode desc limit 0," + limit;
				//System.out.println(query);
			return sqlbean.selectMediaListAll(query);
			} else {
				return null;
		}
	}
	
	// ����� ���� ����Ʈ 
	public Hashtable getMediaList_count_order(String ccode,  int page, int limit, int pagePerBlock)
	{
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		if(page < 1 ) page = 1;
		if(limit < 1 || limit > 30) limit = 10;
		if(pagePerBlock < 1 || pagePerBlock > 10) pagePerBlock = 10;
		
		String query = "";
		Hashtable result_ht;
	 
		String where = "";
//		if (ccode != null && ccode.length() > 0){
//			where = " and  b.ccode like '"+ccode+"%' ";
//		} 
		
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

			where +=" and b.ccode like '" +Code + "%' ";
		}
	 
		
		query = " select b.* , c.ctitle from  vod_media b, category c where b.ccode = c.ccode and c.ctype='V'  "+where+" and b.del_flag='N' and b.openflag_mobile='Y' and b.isended='1' order by  b.mk_date desc, b.ocode desc ";
		String count_query = "select count(b.ocode) from  vod_media b, category c where b.ccode = c.ccode and c.ctype='V'  "+where+" and b.del_flag='N' and b.openflag_mobile='Y' and b.isended='1' order by  b.mk_date desc, b.ocode desc ";
//System.out.println("news:"+query);
			
			try {
		        result_ht = sqlbean.getMediaListCnt(page, query, count_query, limit, pagePerBlock);
		
		    }catch (Exception e) {
		        result_ht = new Hashtable();
		        result_ht.put("LIST", new Vector());
		        result_ht.put("PAGE", new com.yundara.util.PageBean());
		    }
	 
		return result_ht;
	}
	
	
	public Vector getMediaList_count_order_1week(String ccode,String order, int limit){
		if(limit < 1 || limit > 30) limit = 10;
		
		if (limit > 0) {
			String query  = " select a.*, c.ctitle from vod_media a, category c where a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1'  and (to_days(now()) - to_days(a.mk_date) <= 14)  and c.ctype='V' and a.ccode like '"+ccode+"%' order by a."+order+" desc, a.mk_date desc, a.ocode desc  limit 0," + limit;
			//System.out.println(query);
		return sqlbean.selectMediaListAll(query);
		} else {
			return null;
	}
}
	
	public Vector getMediaList_count_order_not_1week(String ccode,String order, int limit){
		if(limit < 1 || limit > 30) limit = 10;
		
		if (limit > 0) {
			String query  = " select a.*, c.ctitle from vod_media a, category c where a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and (to_days(now()) - to_days(a.mk_date) <= 14)  and c.ctype='V' and a.ccode not like '"+ccode+"%' order by a."+order+" desc , a.mk_date desc, a.ocode desc limit 0," + limit;
			//System.out.println(query);
		return sqlbean.selectMediaListAll(query);
		} else {
			return null;
	}
}

	public Vector getMediaList_count_order_not(String ccode,String order, int limit){
		if(limit < 1 || limit > 30) limit = 10;
		
		if (limit > 0) {
			String query  = " select a.*, c.ctitle from vod_media a, category c where a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and  c.ctype='V' and a.ccode not like '"+ccode+"%' order by a."+order+" desc , a.mk_date desc, a.ocode desc limit 0," + limit;
			//System.out.println(query);
		return sqlbean.selectMediaListAll(query);
		} else {
			return null;
	}
}
	
	// ����� �ֽſ��� ����Ʈ  (���� ����)
		public Hashtable getMediaList_count_order_not(String ccode,  int page, int limit, int pagePerBlock)
		{
			ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
			if(page < 1 ) page = 1;
			if(limit < 1 || limit > 30) limit = 10;
			if(pagePerBlock < 1 || pagePerBlock > 10) pagePerBlock = 10;
			
			String query = "";
			Hashtable result_ht;
		 
			String where = "";
//			if (ccode != null && ccode.length() > 0){
//				where = " and  b.ccode like '"+ccode+"%' ";
//			} 
			
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

				where +=" and b.ccode not like '" +Code + "%' ";  // �ش� ī�װ� ����
			}
			
 
			query = " select b.* , c.ctitle from  vod_media b, category c where b.ccode = c.ccode and c.ctype='V'  "+where+" and b.del_flag='N' and b.openflag_mobile='Y' and b.isended='1' order by  b.mk_date desc, b.ocode desc ";
			String count_query = "select count(b.ocode) from  vod_media b, category c where b.ccode = c.ccode and c.ctype='V'  "+where+" and b.del_flag='N' and b.openflag_mobile='Y' and b.isended='1' order by  b.mk_date desc, b.ocode desc ";
//	System.out.println("vod:"+query);
				
				try {
			        result_ht = sqlbean.getMediaListCnt(page, query, count_query, limit, pagePerBlock);
			
			    }catch (Exception e) {
			        result_ht = new Hashtable();
			        result_ht.put("LIST", new Vector());
			        result_ht.put("PAGE", new com.yundara.util.PageBean());
			    }
		 
			return result_ht;
		}
		
	
	//xcode �о� (������ ����)
	public Vector getMediaList_Xcode(String xcode, String ocode, String order, int limit){
		if(limit < 1 || limit > 30) limit = 10;
		
		String temp_xcode = "";
		if (xcode != null && xcode.length() > 0) {
			String[] xcodeArray = xcode.split("/");
			
			temp_xcode += " and (";
					
			for (int i = 0 ; i < xcodeArray.length ; i++) {
				temp_xcode += " a.xcode like('%"+xcodeArray[i]+"%')  ";
				
				if (xcodeArray.length > 1 && i < (xcodeArray.length-1) ) {
					temp_xcode +=" or ";
				}
			}
			temp_xcode += " ) ";
		}
		
		if (limit > 0) {
			//String query  = " select a.*, c.ctitle from vod_media a, category c where a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V' and a.ocode not in ('"+ocode+"')  "+temp_xcode+" order by a."+order+" desc , a.mk_date desc, a.ocode desc limit 0," + limit;
			String query  = " select a.*, c.ctitle from vod_media a, category c where a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V' and a.ocode  < '"+ocode+"'  "+temp_xcode+" order by a."+order+" desc , a.mk_date desc, a.ocode desc limit 0," + limit;
			//System.out.println(query);
		    return sqlbean.selectMediaListAll(query);
	    
		} else {
			return null;
	    }

}
	//ycode �з�
	public Vector getMediaList_Ycode(String ycode, String ocode, String order, int limit){
		if(limit < 1 || limit > 30) limit = 10;
		
		if (limit > 0) {
			//String query  = " select a.*, c.ctitle from vod_media a, category c where a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V' and a.ycode like '"+ycode+"%' and a.ocode not in ('"+ocode+"') order by a."+order+" desc , a.mk_date desc, a.ocode desc limit 0," + limit;
			String query  = " select a.*, c.ctitle from vod_media a, category c where a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V' and a.ycode like '"+ycode+"%' and a.ocode <'"+ocode+"' order by a."+order+" desc , a.mk_date desc, a.ocode desc limit 0," + limit;
			//System.out.println(query);
		return sqlbean.selectMediaListAll(query);
		} else {
			return null;
	}
}
	

	
	public Vector getMediaList_count_week(String ccode,String order, int limit){
		if(limit < 1 || limit > 30) limit = 10;
		
		String temp_ccode = "";
		if (ccode != null && ccode.length() > 0) {
			temp_ccode = " and a.ccode like '"+ccode+"%' ";
		}
		if (limit > 0) {
			//String query  = " select a.*, c.ctitle from vod_media a, category c where ( TO_DAYS(NOW()) - TO_DAYS(a.ocode) <= 7) and a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V'  "+temp_ccode+" order by a."+order+" desc , a.ocode desc limit 0," + limit;
			String query  = " select a.*, c.ctitle from vod_media a, category c where ( TO_DAYS(CURDATE()) - TO_DAYS(a.mk_date) <= 7) and a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V'  "+temp_ccode+" order by a."+order+" desc , a.mk_date desc, a.ocode desc limit 0," + limit;
			//System.out.println(query);
		return sqlbean.selectMediaListAll(query);
		} else {
			return null;
	}
}
	
	public Vector getMediaList_count_month(String ccode,String order, int limit){
		if(limit < 1 || limit > 30) limit = 10;
		
		String temp_ccode = "";
		if (ccode != null && ccode.length() > 0) {
			temp_ccode = " and a.ccode like '"+ccode+"%' ";
		}
		
		
		if (limit > 0) {
			//String query  = " select a.*, c.ctitle from vod_media a, category c where (TO_DAYS(NOW()) - TO_DAYS(a.ocode) <= TO_DAYS(DATE_ADD(NOW(), INTERVAL -1 MONTH)) ) and a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V'  "+temp_ccode+" order by a."+order+" desc , a.ocode desc limit 0," + limit;
			String query  = " select a.*, c.ctitle from vod_media a, category c where (TO_DAYS(a.mk_date) >= TO_DAYS(DATE_ADD(CURDATE(), INTERVAL -1 MONTH)) ) and a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V'  "+temp_ccode+" order by a."+order+" desc , a.mk_date desc, a.ocode desc limit 0," + limit;
			//System.out.println(query);
		return sqlbean.selectMediaListAll(query);
		} else {
			return null;
	}
}
	
	public Vector getMediaList_count_year(String ccode,String order, int limit){
		if(limit < 1 || limit > 30) limit = 10;
		
		String temp_ccode = "";
		if (ccode != null && ccode.length() > 0) {
			temp_ccode = " and a.ccode like '"+ccode+"%' ";
		}
		
		if (limit > 0) {
			//String query  = " select a.*, c.ctitle from vod_media a, category c where (TO_DAYS(NOW()) - TO_DAYS(a.ocode) <= TO_DAYS(DATE_ADD(NOW(), INTERVAL -1 YEAR)) ) and a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V' "+temp_ccode+" order by a."+order+" desc , a.ocode desc  limit 0," + limit;
			String query  = " select a.*, c.ctitle from vod_media a, category c where (TO_DAYS(a.mk_date) >= TO_DAYS(DATE_ADD(CURDATE(), INTERVAL -1 YEAR)) ) and a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V' "+temp_ccode+" order by a."+order+" desc , a.mk_date desc, a.ocode desc  limit 0," + limit;
			//System.out.println(query);
		return sqlbean.selectMediaListAll(query);
		} else {
			return null;
	}
}
	
	 
   
//////////////////
// ����� id�� �˻� count
/////////////////

		public Vector getOMedia_media_id(String media_id) {
			media_id = com.vodcaster.utils.TextUtil.getValue(media_id);
			Vector vt = null;
			if(media_id != null && media_id.length()>0){
				String query = "select playtime, title,ocode from vod_media where del_flag='N' and   filename='" +media_id+"'";
 
				  try {
				
					vt = sqlbean.selectQuery(query);
				   
				  }catch (Exception e) {
				   System.err.println("getOMedia_media_id ex : "+e.getMessage());
				  }
			}
			return vt;
		  
		 }

//////////////////
// ����� id�� �˻�  
/////////////////

	public Vector getOMediaListAllCountByUserid(String ownerID, String search){
		ownerID = com.vodcaster.utils.TextUtil.getValue(ownerID);
		search = com.vodcaster.utils.TextUtil.getValue(search);
		String query = "";
		if (ownerID != null && ownerID.length() > 0) {
			if(search != null && search.length() > 0){
					query = "select count(ocode) from vod_media where del_flag='N' and  ownerID='"+ownerID+"'  and (description like '%"+search+"%' or title like '%"+search+"%')";		
			}
			else{
				query = "select count(ocode) from order_media where del_flag='N' and  ownerID='"+ownerID+"'  ";
			}
			
			return sqlbean.selectQuery(query);
		} else {
			return null;
		}
	}

//////////////////
// ����� id�� �˻�
/////////////////


	public Vector getOMediaListByUserid(String ownerID, String search, int limit1, int limit2){
	
		ownerID = com.vodcaster.utils.TextUtil.getValue(ownerID);
		search = com.vodcaster.utils.TextUtil.getValue(search);
		if(limit2 < 1 || limit2 > 30) limit2 = 10;
		
		String query = "";

		if (ownerID != null && ownerID.length() > 0 && limit1 > 0 && limit2 > 0) {
			if(search != null && search.length() > 0){
				query = "select * from vod_media where del_flag='N' and  ownerID='"+ownerID+"'  and (description like '%"+search+"%' or title like '%"+search+"%') order by mk_date desc, ocode asc limit " +limit1+ "," +limit2;		
			}
			else{
				query = "select * from vod_media where del_flag='N' and  ownerID='"+ownerID+"' and oflag='V' order by  mk_date desc, ocode asc limit " +limit1+ "," +limit2;
			}
			
			return sqlbean.selectMediaListAll(query);
		
		} else {
			return null;
		}
	}



//////////
// ������
//////////
	public Vector getVod_pre(String ccode, String ocode, String ctype) {
		ctype = com.vodcaster.utils.TextUtil.getValue(ctype);
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		
	        String query = "";
	        if (ccode != null && ccode.length() > 0 && ocode != null && ocode.length() > 0  && com.yundara.util.TextUtil.isNumeric(ocode)) {
				query = "select * from vod_media where del_flag='N' and  ccode='"+ccode+"'   and openflag='Y' and ocode > "+ocode+" order by mk_date desc,  ocode desc limit 0,1";
				return sqlbean.selectMediaListAll(query);
	        } else {
	        	return null;
	        }
	    
	}

//////////
// ������
//////////
	public Vector getVod_next(String ccode, String ocode , String ctype) {
		ctype = com.vodcaster.utils.TextUtil.getValue(ctype);
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		
	        String query = "";
	        if (ccode != null && ccode.length() > 0 && ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode) ) {
				query = "select * from vod_media where del_flag='N' and  ccode='"+ccode+"'   and openflag='Y' and ocode < "+ocode+" order by mk_date desc,  ocode desc limit 0,1";
				return sqlbean.selectMediaListAll(query);
	        } else {
	        	return null;
	        }
	    
	}



	/*****************************************************
	���� ��û �� ���
	<b>�ۼ���</b> : ���� <br>
	@param vod_code �̵���ڵ�, �˻��ʵ�, �˻���, �̵��Ÿ��
	******************************************************/
	public Hashtable getViewList(String ownerID,String ctype, String searchstring, int page, int limit){
	
		ctype = com.vodcaster.utils.TextUtil.getValue(ctype);
		ownerID = com.vodcaster.utils.TextUtil.getValue(ownerID);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		if(page < 1 ) page = 1;
		if(limit < 1 || limit > 30) limit = 10;
		
		String subquery = "";
		if (ownerID != null && ownerID.length() > 0 ) {
			if(searchstring!=null && searchstring.length() > 0 ) {
			        subquery = " and  a.title like '%" +searchstring+ "%' " ;
			}
			
			String query = " select a.* from vod_media as a , vod_log as b where  a.del_flag='N' and  a.ocode =  b.vod_code  "+subquery+" and b.vod_id ='"+ownerID+"' order by  a.mk_date desc, a.ocode desc";
			String count_query = " select count(a.*) from vod_media as a , vod_log as b where  a.del_flag='N' and  a.ocode =  b.vod_code  "+subquery+" and b.vod_id ='"+ownerID+"' ";
		
			return sqlbean.getMediaListCnt(page,query,count_query, limit) ;
		} else {
			return null;
		}
	}


/////////////
//  ��õ �ϱ�
// insertBest_countExt(mtype,Integer.parseInt(ocode),Integer.parseInt(point));
/////////////
	public int insertBest_PointExt( String ocode, int point) throws Exception {
 
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
 		
		if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode) && point > 0) {
			return sqlbean.insertBest_Point( ocode, point);
		} else {
			return -1;
		}
	}
	
	
	/*****************************************************
	��õ ���� Ȯ��
	<b>�ۼ���</b> : ���� <br>
	@param ocode, vod_id 
	******************************************************/
	public boolean getExistBest_Point(String ocode, String vod_id) {
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		vod_id = com.vodcaster.utils.TextUtil.getValue(vod_id);
		
		if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode) && vod_id != null && vod_id.length() > 0) {
		Vector v = sqlbean.selectBest_Point_user(ocode, vod_id);
		
			if(v != null && v.size() > 0) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
		
	}
	
	/*****************************************************
	�̵�� ��������
	<b>�ۼ���</b> : ���� <br>
	@param deptcode, gradecode 
	******************************************************/

	public Vector selectTargetInfo(String deptcode, String gradecode) throws Exception {
		deptcode = com.vodcaster.utils.TextUtil.getValue(deptcode);
		gradecode = com.vodcaster.utils.TextUtil.getValue(gradecode);
		
		if (deptcode != null && deptcode.length() > 0 && gradecode != null && gradecode.length()> 0 ) {
			return sqlbean.selectTargetInfoSql(deptcode, gradecode);
		} else {
			return null;
		}
	}
	
	
/////////////////
// ���� ��� (�α��� id �� ��������)
//  ����
////////////////

	public Hashtable getOMediaListAll_userid( String ccode,   String sorder, String field, String searchstring,int page, int limit, String direction, String ownerID) {
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		sorder = com.vodcaster.utils.TextUtil.getValue(sorder);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		direction = com.vodcaster.utils.TextUtil.getValue(direction);
		ownerID = com.vodcaster.utils.TextUtil.getValue(ownerID);
		if(page < 1 ) page = 1;
		if(limit < 1 || limit > 30) limit = 10;
		
	    Hashtable result_ht;

	    String query = "";
	    String code = "";
		String sub_query = "";
	    String sub_query1 = "";
	    String sub_query2 = "";

	    if(!sorder.equals("")) {
	        if(sorder.equals("ccode"))
	            sub_query1 = "order by b."+sorder + " " +direction;
	        else
	            sub_query1 = "order by b."+sorder + " " + direction;
	    }else
	        sub_query1 = "order by b.mk_date desc, b.ocode desc";

	    if(!field.equals("") && !searchstring.equals("")) {
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
		
		if (ownerID != null && ownerID.length() > 0) {
			sub_query= sub_query + " and b.ownerID = '"+ ownerID + "' ";
		}

		query =  "select  b.* from  vod_media as b where b.del_flag='N'   " +sub_query+ sub_query2 + sub_query1;
		String count_query =  "select  count(b.ocode) from  vod_media as b where b.del_flag='N'   " +sub_query+ sub_query2 ;

	    try {
	        result_ht = sqlbean.getMediaListCnt(page, query, count_query, limit);

	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }

		return result_ht;


	}

	

///////////
//����
//�̵�� �α����� ���
// ace �׷� ����
//////////

	public Vector getOVODMemberList3_group(String rstime,String retime,String ocode, String ownerID, String cate, String ctype, String dept, String grade ){

		rstime = com.vodcaster.utils.TextUtil.getValue(rstime);
		retime = com.vodcaster.utils.TextUtil.getValue(retime);
		ctype = com.vodcaster.utils.TextUtil.getValue(ctype);
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		ownerID = com.vodcaster.utils.TextUtil.getValue(ownerID);
		cate = com.vodcaster.utils.TextUtil.getValue(cate);
		dept = com.vodcaster.utils.TextUtil.getValue(dept);
		grade = com.vodcaster.utils.TextUtil.getValue(grade);
		
		String sub_query = "";
	    	
	    String table = "";
		String table2 = "";

		if (ctype != null && ( ctype.equals("R")  || ctype.equals("L") )  )  // �����
		{
			
			table = "live_log";
			table2= "live_media";
 
		} else  
		{
			table = "vod_log"; 
			table2= "vod_media";
		}

		if (ocode != null && ocode.length() > 0 && !ocode.equals("none") && com.yundara.util.TextUtil.isNumeric(ocode))
		{
			sub_query = sub_query + " and a.vod_code = '"+ ocode+"'";
		}

		if (ownerID != null && ownerID.length() > 0 )
		{
			sub_query = sub_query + " and a.vod_id = '"+ ownerID+"' ";
		}

		if (rstime != null && rstime.length() > 0 && retime != null && retime.length() > 0 )
		{
			sub_query = sub_query + " and a.regDate between '" +rstime+ "' and '"+retime +" 23:59' ";
		} else if (rstime != null && rstime.length() > 0 && (retime == null || retime.equals("")) )
		{
			sub_query = sub_query + " and a.regDate >= '" +rstime +"' ";
		}else if (retime != null && retime.length() > 0 && (rstime == null || rstime.equals("")) )
		{
			sub_query = sub_query + " and a.regDate <= '" +retime +"' ";
		}

		if (cate != null && cate.length() > 0)
		{
			sub_query = sub_query +  "  and b.ccode like '"+cate+"%' ";
		}
 
		if (ctype != null && ctype.length() > 0)
		{
			sub_query = sub_query +  "  and a.oflag = '"+ctype+"' ";
		}
 	
		if (dept != null && dept.length() > 0)
		{
			sub_query = sub_query +  "  and a.vod_buseo = '"+dept+"' ";
		}
		
		if (grade != null && grade.length() > 0)
		{
			sub_query = sub_query +  "  and a.vod_gray = '"+grade+"' ";
		}

		String query = "";
 
		 if (ctype != null &&( ctype.equals("R")|| ctype.equals("L") ))
		{
			 query ="select distinct(a.no),a.ip,a.vod_id,a.vod_name,a.vod_code, a.regDate, b.rtitle, 'live' AS ctitle from " +table+ " a, "+table2+" b where b.del_flag='N' and a.vod_code = b.rcode  "+sub_query+" order by a.no desc";
		} else {
			query ="select distinct(a.no),a.ip,a.vod_id,a.vod_name,a.vod_code, a.regDate, b.title, c.ctitle from "
					
					+ "" +table+ " a left join "+table2+" b on a.vod_code = b.ocode and b.del_flag='N' left join category c on b.ccode = c.ccode  where  1=1  "+sub_query+"   order by a.no desc";
		}
			  
System.out.println(query);		

		return sqlbean.selectMediaListAllExt(query) ;


		}
	
	public Vector getOVODMemberList_Excel(String rstime,String retime,String ocode, String user_id, String cate, String ctype, String dept, String grade ){

		rstime = com.vodcaster.utils.TextUtil.getValue(rstime);
		retime = com.vodcaster.utils.TextUtil.getValue(retime);
		ctype = com.vodcaster.utils.TextUtil.getValue(ctype);
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		user_id = com.vodcaster.utils.TextUtil.getValue(user_id);
		cate = com.vodcaster.utils.TextUtil.getValue(cate);
		dept = com.vodcaster.utils.TextUtil.getValue(dept);
		grade = com.vodcaster.utils.TextUtil.getValue(grade);
		
		String sub_query = "";
	    	
	    String table = "";
		String table2 = "";

		if (ctype != null && (ctype.equals("V") || ctype.equals("A") || ctype.equals("P") || ctype.equals("H")) )  // ����
		{
			table = "vod_log"; 
			table2= "vod_media";
		} else if (  ctype != null && ( ctype.equals("R") || ctype.equals("L")) )  // �����
		{
			table = "live_log";
			table2= "live_media";
		}

		if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode))
		{
			sub_query = sub_query + " and a.vod_code = '"+ ocode+"' ";
		}

		if (user_id != null && user_id.length() > 0)
		{
			sub_query = sub_query + " and a.vod_id = '"+ user_id+"' ";
		}

		if (rstime != null && rstime.length() > 0 && retime != null && retime.length() > 0 )
		{
			sub_query = sub_query + " and a.regDate between '" +rstime+ "' and '"+retime +" 23:59' ";
		} else if (rstime != null && rstime.length() > 0 && (retime == null || retime.equals("")) )
		{
			sub_query = sub_query + " and a.regDate >= '" +rstime +"' ";
		}else if (retime != null && retime.length() > 0 && (rstime == null || rstime.equals("")) )
		{
			sub_query = sub_query + " and a.regDate <= '" +retime +"' ";
		}

		if (cate != null && cate.length() > 0)
		{
			sub_query = sub_query +  "  and b.ccode like '"+cate+"%' ";
		}
/*
		if (ctype != null && !ctype.equals(""))
		{
			sub_query = sub_query +  "  and b.oflag = '"+ctype+"' ";
		}
*/		
		if (dept != null && dept.length() > 0)
		{
			sub_query = sub_query +  "  and a.vod_buseo = '"+dept+"' ";
		}
		
		if (grade != null && grade.length() > 0)
		{
			sub_query = sub_query +  "  and a.vod_gray = '"+grade+"' ";
		}

		String query = "";

		if (ctype != null && (ctype.equals("V") || ctype.equals("A") ||  ctype.equals("C")|| ctype.equals("P") || ctype.equals("H"))) 
		{
			 query ="select distinct(a.no),a.ip,a.vod_id,a.vod_name,a.vod_code, a.regDate, b.otitle from " +table+ " a, "+table2+" b where a.vod_code = b.ocode "+sub_query+" and a.oflag='"+ctype+"' order by a.no desc";
		} else if (ctype != null && (ctype.equals("R") || ctype.equals("L")))
		{
			 query ="select distinct(a.no),a.ip,a.vod_id,a.vod_name,a.vod_code, a.regDate, b.rtitle from " +table+ " a, "+table2+" b where a.vod_code = b.rcode  "+sub_query+" and a.oflag='"+ctype+"' order by a.no desc";
		}
 
		return sqlbean.selectMediaListAllExt(query) ;
		}

 	
	/**
	 * ����������� ���󸮽�Ʈ
	 * @param ccode
	 * @param page
	 * @param limit
	 * @return
	 */
	public Hashtable getMediaList(String ccode, int page, int limit)
	{
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		if(page < 1 ) page = 1;
		if(limit < 1 || limit > 30) limit = 10;
		
		String query = "";
		Hashtable result_ht;
		if (ccode != null && ccode.length() > 0){
			query = "select * from vod_media where ccode like '"+ccode+"%' and del_flag='N' and openflag_mobile='Y' and isended='1' order by   mk_date desc,  ocode desc";
			String count_query = "select count(ocode) from vod_media where ccode like '"+ccode+"%' and del_flag='N' and openflag_mobile='Y' and isended='1' ";
			try {
		        result_ht = sqlbean.getMediaListCnt(page, query,count_query, limit);
		
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
	
	/**
	 * ����������� ���󸮽�Ʈ
	 * @param ccode
	 * @param page
	 * @param limit
	 * @param pagePerBlock
	 * @return
	 */
	public Hashtable getMediaList(String ccode, int page, int limit, int pagePerBlock)
	{
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		if(page < 1 ) page = 1;
		if(limit < 1 || limit > 30) limit = 10;
		if(pagePerBlock < 1 || pagePerBlock > 10) pagePerBlock = 10;
		
		String query = "";
		Hashtable result_ht;
	 
		String sub_query = "";
//			if (ccode != null && ccode.length() > 0){
//				sub_query = " and  b.ccode like '"+ccode+"%' ";
//			} 
		
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

			sub_query +=" and b.ccode like '" +Code + "%' ";
		}
		
			
			query = "select b.* , c.ctitle from  vod_media b, category c where b.ccode = c.ccode and c.ctype='V'  "+sub_query+" and b.del_flag='N' and b.openflag_mobile='Y' and b.isended='1' order by  b.mk_date desc, b.ocode desc";
			String count_query = "select count(b.ocode) from vod_media b, category c where b.ccode = c.ccode and c.ctype='V' "+sub_query+" and b.del_flag='N' and b.openflag_mobile='Y' and b.isended='1' ";

			
			try {
		        result_ht = sqlbean.getMediaListCnt(page, query, count_query, limit, pagePerBlock);
		
		    }catch (Exception e) {
		        result_ht = new Hashtable();
		        result_ht.put("LIST", new Vector());
		        result_ht.put("PAGE", new com.yundara.util.PageBean());
		    }
	 
		return result_ht;
	}

	/**
	 * ����������� ���󸮽�Ʈ �˻�
	 * @param ccode
	 * @param page
	 * @param limit
	 * @param pagePerBlock
	 * @return
	 */
	
	public Hashtable getMediaList_search(String ccode, String field, String searchstring, String date, int page, int limit, int pagePerBlock)
	{
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		if(page < 1 ) page = 1;
		if(limit < 1 || limit > 30) limit = 10;
		if(pagePerBlock < 1 || pagePerBlock > 10) pagePerBlock = 10;
		
		String query = "";
		Hashtable result_ht;
	 
		String where = "";
//		if (ccode != null && ccode.length() > 0){
//			where = " and  b.ccode like '"+ccode+"%' ";
//		} 
		
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

			where +=" and b.ccode like '" +Code + "%' ";
		}
		
		
		if (searchstring != null && searchstring.length() > 0) {
			
			String[] searchstringArray = searchstring.split(" ");
			
			 if(field != null && field.length() > 0  && searchstringArray.length == 1 ) {
				if (field.equals("title")) {
					where += " and b.title like('%"+searchstring+"%')  "; 
				} else if (field.equals("description")) {
					where += " and b.description like('%"+searchstring+"%')  "; 
				} else if (field.equals("tag_kwd")) {
					where += " and b.tag_kwd like('%"+searchstring+"%')  "; 
				} else if (field.equals("all")) {
					where += " and ( b.title like('%"+searchstring+"%')  "; 
					where += " or b.tag_kwd like('%"+searchstring+"%')  "; 
					where += " or b.description like('%"+searchstring+"%') ) "; 
				}
			} else if (field != null && field.length() > 0  && searchstringArray.length >  1 ){
				
				if (field.equals("title")) {

					where += " and (";
					
					for (int i = 0 ; i < searchstringArray.length ; i++) {
						where += " b.title like('%"+searchstringArray[i]+"%')  "; 
						if (searchstringArray.length > 1 && i < (searchstringArray.length-1) ) {
							where +=" and ";
						}
					}
					where += " ) ";
					
					 
				} else if (field.equals("tag_kwd")) {
					where += " and (";
					for (int i = 0 ; i < searchstringArray.length ; i++) {
						where += " b.tag_kwd like('%"+searchstringArray[i]+"%')  "; 
						if (searchstringArray.length > 1 && i < (searchstringArray.length-1) ) {
							where +=" and ";
						}
					}
					where += " ) ";
				} else if (field.equals("description")) {
					where += " and (";
					for (int i = 0 ; i < searchstringArray.length ; i++) {
						where += " b.description like('%"+searchstringArray[i]+"%')  "; 
						if (searchstringArray.length > 1 && i < (searchstringArray.length-1) ) {
							where +=" and ";
						}
					}
					where += " ) ";
				 
				} else if (field.equals("all")) {
				 
					
					where += " and ( (";
					
					for (int i = 0 ; i < searchstringArray.length ; i++) {
						where += " b.title like('%"+searchstringArray[i]+"%')  "; 
						if (searchstringArray.length > 1 && i < (searchstringArray.length-1) ) {
							where +=" and ";
						}
					}
					where += " ) ";
					where += " or (";
					for (int i = 0 ; i < searchstringArray.length ; i++) { 
					 
						where += " b.tag_kwd like('%"+searchstringArray[i]+"%')  "; 
						if (searchstringArray.length > 1 && i < (searchstringArray.length-1) ) {
							where +=" and ";
						}
					} 
					where += " ) ";
					where += " or (";
					for (int i = 0 ; i < searchstringArray.length ; i++) { 
					 
						where += " b.description like('%"+searchstringArray[i]+"%')  "; 
						if (searchstringArray.length > 1 && i < (searchstringArray.length-1) ) {
							where +=" and ";
						}
					} 
					
					where += " ) )";
					
				} 
				
			}
		}  
		
//		if(searchField != null && searchString != null && searchField.length() > 0 && searchString.length() > 0 && !searchField.equals("null") && !searchString.equals("")){
//			if(searchField.equals("all")){
//				where += " and (b.title like '%" + searchString + "%' or b.description like '%" + searchString +  "%')";
//			}else if(searchField.equals("title")){
//				where += " and b.title like '%" + searchString + "%'";
//			}else if(searchField.equals("content")){
//				where += " and b.description like '%" + searchString + "%'";
//			}
//		}
		
		if(date.equals("week")){
			where += " and to_days(now()) - to_days(b.mk_date) <= 7";
		}else if(date.equals("month")){
			where += " and to_days(now()) - to_days(b.mk_date) <= 30";
		}else if(date.equals("year")){
			where += " and to_days(now()) - to_days(b.mk_date) <= 365";
		}
		
		
		query = " select b.* , c.ctitle from  vod_media b, category c where b.ccode = c.ccode and c.ctype='V'  "+where+" and b.del_flag='N' and b.openflag_mobile='Y' and b.isended='1' order by  b.mk_date desc, b.ocode desc ";
		String count_query = "select count(b.ocode) from  vod_media b, category c where b.ccode = c.ccode and c.ctype='V'  "+where+" and b.del_flag='N' and b.openflag_mobile='Y' and b.isended='1' order by  b.mk_date desc, b.ocode desc ";
//System.out.println(query);
			
			try {
		        result_ht = sqlbean.getMediaListCnt(page, query, count_query, limit, pagePerBlock);
		
		    }catch (Exception e) {
		        result_ht = new Hashtable();
		        result_ht.put("LIST", new Vector());
		        result_ht.put("PAGE", new com.yundara.util.PageBean());
		    }
	 
		return result_ht;
	}
	
	public int getMediaList_search_count(String ccode, String searchField, String searchString, String date )
	{ 
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
	 
		
		String query = "";
	 	 
		String where = "";
			if (ccode != null && ccode.length() > 0){
				where = " and  b.ccode like '"+ccode+"%' ";
			} 
			
			if(searchField != null && searchString != null && searchField.length() > 0 && searchString.length() > 0 && !searchField.equals("null") && !searchString.equals("")){
				if(searchField.equals("all")){
					where += " and (b.title like '%" + searchString + "%' or b.description like '%" + searchString +  "%')";
				}else if(searchField.equals("title")){
					where += " and b.title like '%" + searchString + "%'";
				}else if(searchField.equals("content")){
					where += " and b.description like '%" + searchString + "%'";
				}
			}
			
			if(date.equals("week")){
				where += " and to_days(now()) - to_days(b.mk_date) <= 7";
			}else if(date.equals("month")){
				where += " and to_days(now()) - to_days(b.mk_date) <= 30";
			}else if(date.equals("year")){
				where += " and to_days(now()) - to_days(b.mk_date) <= 365";
			}
			
			
			query = "select count(b.ocode) from  vod_media b, category c where b.ccode = c.ccode and c.ctype='V'  "+where+" and b.del_flag='N' and b.openflag_mobile='Y' and b.isended='1' order by  b.mk_date desc, b.ocode desc ";
	 			 
			try{
			     
			        Vector v = sqlbean.selectQuery(query);
			        if(v != null && v.size() > 0){
			        	return Integer.parseInt(String.valueOf(v.elementAt(0)));
			        }
			        else{
			        	return 0;
			        }
			}catch(Exception e){
				return 0;
			} 
	}
	
	
	
	public Vector getMediaList_search(String ccode, String searchField, String searchString, String date , int limit )
	{ 
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		 
		if(limit < 1 || limit > 30) limit = 10; 
		
		String query = "";
	 	 
		String where = "";
			if (ccode != null && ccode.length() > 0){
				where = " and  b.ccode like '"+ccode+"%' ";
			} 
			
			if(searchField != null && searchString != null && searchField.length() > 0 && searchString.length() > 0 && !searchField.equals("null") && !searchString.equals("")){
				if(searchField.equals("all")){
					where += " and (b.title like '%" + searchString + "%' or b.description like '%" + searchString +  "%')";
				}else if(searchField.equals("title")){
					where += " and b.title like '%" + searchString + "%'";
				}else if(searchField.equals("content")){
					where += " and b.description like '%" + searchString + "%'";
				}
			}
			
			if(date.equals("week")){
				where += " and to_days(now()) - to_days(b.mk_date) <= 7";
			}else if(date.equals("month")){
				where += " and to_days(now()) - to_days(b.mk_date) <= 30";
			}else if(date.equals("year")){
				where += " and to_days(now()) - to_days(b.mk_date) <= 365";
			}
			
			
			query = "select b.* , c.ctitle from  vod_media b, category c where b.ccode = c.ccode and c.ctype='V'  "+where+" and b.del_flag='N' and b.openflag_mobile='Y' and b.isended='1' order by  b.mk_date desc, b.ocode desc limit 0, "+ limit;
	 			 
			return sqlbean.selectMediaListAll(query);
	}
	/**
	 * 
	 * @param ocode
	 * @return
	 */
	public Vector getMediaList(String ocode)
	{
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		if (ocode != null && ocode.length() > 0  && com.yundara.util.TextUtil.isNumeric(ocode)) {
			String query = "select title, playtime, description, filename, modelimage, hitcount, subfolder, ccode, download_flag from vod_media where ocode='"+ocode+"'";
			Vector result = null;
			try{
				//System.err.println(query);
				result = sqlbean.selectQuery(query);
			}catch(Exception e){
				result = null;
			}
			return result;
		} else {
			return null;
		}
	}
	
	public Vector getMediaMobile(String ocode)
	{
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		if (ocode != null && ocode.length() > 0 && com.yundara.util.TextUtil.isNumeric(ocode)) {
			String query = "select title, playtime, description, mobilefilename, modelimage, hitcount, subfolder, ccode, download_flag, mk_date from vod_media where ocode='"+ocode+"' and openflag_mobile = 'Y' and isended='1' ";
			Vector result = null;
			try{
				//System.err.println(query);
				result = sqlbean.selectQuery(query);
			}catch(Exception e){
				result = null;
			}
			return result;
		} else {
			return null;
		}
	}
 
	
	/**
	 * 20110720
	 * ����� ����α�
	 * @param rstime
	 * @param retime
	 * @param ocode
	 * @param ownerID
	 * @param cate
	 * @param ctype
	 * @param dept
	 * @param grade
	 * @return
	 */
	public Vector getOVODMemberList3_group__mobile(String rstime,String retime,String ocode, String ownerID, String cate, String dept, String grade ){

		rstime = com.vodcaster.utils.TextUtil.getValue(rstime);
		retime = com.vodcaster.utils.TextUtil.getValue(retime);
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		ownerID = com.vodcaster.utils.TextUtil.getValue(ownerID);
		cate = com.vodcaster.utils.TextUtil.getValue(cate);
		dept = com.vodcaster.utils.TextUtil.getValue(dept);
		grade = com.vodcaster.utils.TextUtil.getValue(grade);
		
		String sub_query = "";
	    	
	    String table = "";
		String table2 = "";

		table = "vod_log";
		table2= "vod_media";

		if (ocode != null && ocode.length() > 0  && !ocode.equals("none") && com.yundara.util.TextUtil.isNumeric(ocode))
		{
			sub_query = sub_query + " and a.vod_code = '"+ ocode+"'";
		}

		if (ownerID != null && ownerID.length() > 0)
		{
			sub_query = sub_query + " and a.vod_id = '"+ ownerID+"' ";
		}

		if (rstime != null && rstime.length() >0 && retime != null && retime.length() >0 )
		{
			sub_query = sub_query + " and a.regDate between '" +rstime+ "' and '"+retime +" 23:59' ";
		} else if (rstime != null && rstime.length() >0 && (retime == null || retime.equals("")) )
		{
			sub_query = sub_query + " and a.regDate >= '" +rstime +"' ";
		}else if (retime != null && retime.length() >0 && (rstime == null || rstime.equals("")) )
		{
			sub_query = sub_query + " and a.regDate <= '" +retime +"' ";
		}

		if (cate != null && cate.length() >0)
		{
			sub_query = sub_query +  "  and b.ccode like '"+cate+"%' ";
		}

		if (dept != null && dept.length() >0 )
		{
			sub_query = sub_query +  "  and a.vod_buseo = '"+dept+"' ";
		}
		
		if (grade != null && grade.length() >0)
		{
			sub_query = sub_query +  "  and a.vod_gray = '"+grade+"' ";
		}

		String query = "";
 		query ="select distinct(a.no),a.ip,a.vod_id,a.vod_name,a.vod_code, a.regDate, b.title from " +table+ " a, "+table2+" b where  b.del_flag='N' and a.vod_code = b.ocode "+sub_query+" and a.oflag='H'  order by a.no desc";

		//System.err.println(query);
		return sqlbean.selectMediaListAllExt(query) ;
		}
	
	
	/**
	 * 20110720
	 * ����� ����α� ����
	 * @param rstime
	 * @param retime
	 * @param ocode
	 * @param user_id
	 * @param cate
	 * @param ctype
	 * @param dept
	 * @param grade
	 * @return
	 */
	public Vector getOVODMemberListMobile_Excel(String rstime,String retime,String ocode, String user_id, String cate, String dept, String grade ){

		rstime = com.vodcaster.utils.TextUtil.getValue(rstime);
		retime = com.vodcaster.utils.TextUtil.getValue(retime);
		ocode = com.vodcaster.utils.TextUtil.getValue(ocode);
		user_id = com.vodcaster.utils.TextUtil.getValue(user_id);
		cate = com.vodcaster.utils.TextUtil.getValue(cate);
		dept = com.vodcaster.utils.TextUtil.getValue(dept);
		grade = com.vodcaster.utils.TextUtil.getValue(grade);
		
		String sub_query = "";
	    	
	    String table = "vod_log";
		String table2 = "vod_media";

		if (ocode != null && ocode.length() >0 && com.yundara.util.TextUtil.isNumeric(ocode))
		{
			sub_query = sub_query + " and a.vod_code = '"+ ocode+"' ";
		}

		if (user_id != null && user_id.length() >0)
		{
			sub_query = sub_query + " and a.vod_id = '"+ user_id+"' ";
		}

		if (rstime != null && rstime.length() >0 && retime != null && retime.length() >0 )
		{
			sub_query = sub_query + " and a.regDate between '" +rstime+ "' and '"+retime +" 23:59' ";
		} else if (rstime != null && rstime.length() >0 && (retime == null || retime.equals("")) )
		{
			sub_query = sub_query + " and a.regDate >= '" +rstime +"' ";
		}else if (retime != null && retime.length() >0 && (rstime == null || rstime.equals("")) )
		{
			sub_query = sub_query + " and a.regDate <= '" +retime +"' ";
		}

		if (cate != null && cate.length() >0)
		{
			sub_query = sub_query +  "  and b.ccode like '"+cate+"%' ";
		}
/*
		if (ctype != null && ctype.length() >0)
		{
			sub_query = sub_query +  "  and b.oflag = '"+ctype+"' ";
		}
*/		
		if (dept != null && dept.length() >0)
		{
			sub_query = sub_query +  "  and a.vod_buseo = '"+dept+"' ";
		}
		
		if (grade != null && grade.length() >0)
		{
			sub_query = sub_query +  "  and a.vod_gray = '"+grade+"' ";
		}

		String query = "";
		query =query ="select distinct(a.no),a.ip,a.vod_id,a.vod_name,a.vod_code, a.regDate, b.title from " +table+ " a, "+table2+" b where  b.del_flag='N' and a.vod_code = b.ocode "+sub_query+" and a.oflag='H'  order by a.no desc";
 
		//System.err.println(query);
		return sqlbean.selectMediaListAllExt(query) ;
		}
	

	public Vector month_cnt_log(String year, String month, String ctype) throws Exception {
		
		year = com.vodcaster.utils.TextUtil.getValue(year);
		month = com.vodcaster.utils.TextUtil.getValue(month);
		ctype = com.vodcaster.utils.TextUtil.getValue(ctype);
 	
		String month1 = "";
		String month2 = "";
		if ( year != null && year.length()>0 && com.yundara.util.TextUtil.isNumeric(year) &&  month != null && month.length() > 0 && com.yundara.util.TextUtil.isNumeric(month) ) {
			try {
			month1 = month;
			int temp_year = Integer.parseInt(year);
			int temp_month = Integer.parseInt(month);
			if (temp_month -1 <= 0) {
				month2= (temp_year-1)+"12";
			} else {
				if (temp_month > 10) {
					month2= ""+(temp_month-1);
				} else {
					month2= "0"+(temp_month-1);
				}
			}
 	
			return sqlbean.month_cnt_vod(temp_year, month1, month2);
			 
			}catch(Exception e){
				System.out.println("month_cnt_log:"+e);
				return null;
			}
		} else {
			return null;
		}

	}
	

	public int insertMohth_log() throws Exception {

		 String year ="";
		 String month ="";
		 int iResult = -1;
		SimpleDateFormat fommatter = new SimpleDateFormat("yyyyMMddHHmmss");
	    Calendar cal = Calendar.getInstance();
	    String today = null;
	    today = fommatter.format(cal.getTime());
  
		cal.add(cal.MONTH, -1);
		today = fommatter.format(cal.getTime());
 
		year = today.substring(0,4);
		month = today.substring(4,6);
 
		if (isExistance_DAY(year, month)) {
			iResult = sqlbean.month_hit_log(year, month);
		}
		return iResult;
	}
	
	public boolean isExistance_DAY(String year ,String month)
	{
		year = com.vodcaster.utils.TextUtil.getValue(year);
		month = com.vodcaster.utils.TextUtil.getValue(month);
 	
		if ( year != null && year.length()>0 && com.yundara.util.TextUtil.isNumeric(year) &&  month != null && month.length() > 0 && com.yundara.util.TextUtil.isNumeric(month) ) {
 
		boolean day_exist = true;

		Vector v = sqlbean.month_hit_cnt(year, month);
 
		if(v != null && v.size()>0) {
            day_exist = false;
        }

		return day_exist;
		} else {
			return false;
		}
	}

	public Vector getNew_xml_not_in(int limit, String ccode){
		if(limit < 1 || limit > 30) limit = 10;
		
		if (limit > 0) {
			String query  = " select a.*, c.ctitle from vod_media a, category c where a.ccode = c.ccode and a.del_flag='N'  and a.openflag='Y' and a.isended='1' and c.ctype='V' and a.ccode not in ( '"+ccode+"%' ) order by a.mk_date desc, a.ocode desc  limit 0," + limit;
			//System.out.println(query);
		return sqlbean.selectMediaListAll(query);
		} else {
			return null;
	    }
	}

}
