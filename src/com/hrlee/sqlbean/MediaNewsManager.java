package com.hrlee.sqlbean;

import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

public class MediaNewsManager {
	private static MediaNewsManager instance;
	
	private MediaNewsSqlBean sqlbean = null;
    
	private MediaNewsManager() {
        sqlbean = new MediaNewsSqlBean();
    }
    
	public static MediaNewsManager getInstance() {
		if(instance == null) {
			synchronized(MediaNewsManager.class) {
				if(instance == null) {
					instance = new MediaNewsManager();
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
	
	public Hashtable getNews_ListAll( int page, int limit) {

        Hashtable result_ht;

        String query = "";

        query = "select * from media_news order by seq ";

        try {
            result_ht = sqlbean.getNews_List(page, query, limit);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;

    }
	
	public Vector getNews(String seq) {
      String query = "select * from media_news where seq="+seq ;
		return sqlbean.selectHashQuery(query);
    }
	public int update(HttpServletRequest req) throws Exception 
	{
		return sqlbean.update(req);
	}

	public Vector getNews_ListAll(String ocode) {
	    
	    String query = "";
	    
	        query = "select * from media_news where ocode="+ocode+" order by seq";
	    
	        return sqlbean.selectListAll(query);
	}
 

}
