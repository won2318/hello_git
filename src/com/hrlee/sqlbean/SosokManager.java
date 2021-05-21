package com.hrlee.sqlbean;

import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

public class SosokManager {
	private static SosokManager instance;
	
	private SosokSqlBean sqlbean = null;
    
	private SosokManager() {
        sqlbean = new SosokSqlBean();
    }
    
	public static SosokManager getInstance() {
		if(instance == null) {
			synchronized(SosokManager.class) {
				if(instance == null) {
					instance = new SosokManager();
				}
			}
		}
		return instance;
	}
	
	public int deleteSosok(String seq) throws Exception {
	    if (seq != null && seq.length() > 0) {
		return sqlbean.delete(seq);
	    } else {
	    	return -1;
	    }
	}
	
	public Hashtable getSosok_ListAll( int page, int limit) {

        Hashtable result_ht;

        String query = "";

        query = "select * from sosok order by sinx ";

        try {
            result_ht = sqlbean.getSosok_List(page, query, limit);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;

    }
	
	public Vector getSosok(String seq) {
      String query = "select * from sosok where sinx="+seq ;
		return sqlbean.selectHashQuery(query);
    }
	public int update(HttpServletRequest req) throws Exception 
	{
		return sqlbean.update(req);
	}

	public Vector getSosok_ListAll() {
	    
	    String query = "";
	    
	        query = "select * from sosok order by sinx";
	    
	        return sqlbean.selectListAll(query);
	}
//////////
// 부서 이름 가져 오기
//  주현
//////////

	public String getSosokOneName(String sosok_code) {

	    String strtmp = "";

	    try {

	        if(sosok_code != null && sosok_code.length() > 0) {

                Vector v = sqlbean.selectTitle(sosok_code);
                strtmp = String.valueOf(v.elementAt(0));
            }

	    }catch(Exception e) {
	    	System.err.println("getSosokOneName ex : " + e);
	    }
        return strtmp;
    }
	

}
