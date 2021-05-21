package com.hrlee.sqlbean;

import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

public class GrayManager {
	private static GrayManager instance;
	
	private GraySqlBean sqlbean = null;
    
	private GrayManager() {
        sqlbean = new GraySqlBean();
    }
    
	public static GrayManager getInstance() {
		if(instance == null) {
			synchronized(GrayManager.class) {
				if(instance == null) {
					instance = new GrayManager();
				}
			}
		}
		return instance;
	}
	
	public int deleteGray(String seq) throws Exception {
	    
		return sqlbean.delete(seq);
	}
	
	public Hashtable getGray_ListAll( int page, int limit, String order) {

        Hashtable result_ht;
        order= com.vodcaster.utils.TextUtil.getValue(order);
        String query = "";
        if(order == null || order.equals("") || order.equals("null")){
        	order = "ginx";
        }

        query = "select * from gray order by "+order+" desc";

        try {
            result_ht = sqlbean.getGray_List(page, query, limit);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;


    }

	
	public int update(HttpServletRequest req) throws Exception 
	{
		return sqlbean.update(req);
		
	}
	
	public Vector getGray(String seq) {

		seq= com.vodcaster.utils.TextUtil.getValue(seq);
		
		if (seq != null && seq.length()  >0 ) {
			String query = "select * from gray where ginx="+seq ;
			return sqlbean.selectHashQuery(query);
		} else {
			return null;
		}

	    }
	public Vector getGray_ListAll() {
	    
	    String query = "";
	    
	        query = "select * from gray order by ginx";
	    
	        return sqlbean.selectListAll(query);
	       
	}

//////////
// 부서 이름 가져 오기
//  주현
//////////

	public String getGrayOneName(String gray_code) {
		gray_code= com.vodcaster.utils.TextUtil.getValue(gray_code);
		
	    if(!gray_code.equals("") && gray_code.length() > 0 ) {
	    String strtmp = "";

	    try {
                Vector v = sqlbean.selectTitle(gray_code);
                strtmp = String.valueOf(v.elementAt(0));
	    }catch(Exception e) {
	    	System.err.println("getGrayOneName ex : " + e);
	    }
	    	return strtmp;
	    } else {
	    	return "";
	    }
    }

}
