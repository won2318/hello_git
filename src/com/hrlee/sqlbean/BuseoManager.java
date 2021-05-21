package com.hrlee.sqlbean;

import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

public class BuseoManager {
	private static BuseoManager instance;
	
	private BuseoSqlBean sqlbean = null;
    
	private BuseoManager() {
        sqlbean = new BuseoSqlBean();
    }
    
	public static BuseoManager getInstance() {
		if(instance == null) {
			synchronized(BuseoManager.class) {
				if(instance == null) {
					instance = new BuseoManager();
				}
			}
		}
		return instance;
	}
	
	public int deleteBuseo(String seq) throws Exception {
	    if (seq != null && seq.length() >0 ) {
		return sqlbean.delete(seq);
	    } else {
	    	return -1;
	    }
	}
	
	public int update(HttpServletRequest req) throws Exception 
	{
		return sqlbean.update(req);
		
	}
	
	/*
	 * 페이지 처리를 위한 부서 목록 전체 
	 */
	public Hashtable getBuseo_ListAll( int page, int limit, String order ) {

        Hashtable result_ht;

        String query = "";
        if(order == null || order.equals("") || order.equals("null")){
        	order = "binx";
        }
       
        	query = "select * from buseo  order by   "+ order + " desc ";
 
//select a.*, b.* from buseo as a, sosok as b where a.buseo_sosok=b.sosok_code order by a.buseo_sosok, a.buseo_code 
        try {
            result_ht = sqlbean.getBuseo_List(page, query, limit);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;


    }
	
	/*
	 * 부서 인덱스를 이용한 해당 부서 정보 
	 */
	public Vector getBuseo(String seq) {


	      String query = "select * from buseo where binx="+seq ;

			return sqlbean.selectHashQuery(query);

	    }
/*
 * 부서 목록 전체 
 */
	public Vector getBuseo_ListAll() {
	    
	    String query = "";
	    
	        query = "select * from buseo order by   buseo_code  ";
	    
	        return sqlbean.selectListAll(query);
	       
	}
	/*
	 * 소속을 이용한 부서 목록
	 */
public Vector getBuseo_ListSosok(String sosok) {
	    
	    String query = "";
	    
	        query = "select * from buseo where buseo_code='"+sosok+"' order by  buseo_code";
	    
	        return sqlbean.selectListAll(query);
	       
	}
//////////
// 부서 이름 가져 오기
//  주현
//////////

	public String getBuseoOneName(String buseo_code) {

	    String strtmp = "";

	    try {

	        if(!buseo_code.equals("") && buseo_code.length() > 0 ) {

                Vector v = sqlbean.selectTitle(buseo_code);
                if(v != null && v.size()>0){
                	strtmp = String.valueOf(v.elementAt(0));
                }
            }

	    }catch(Exception e) {
	    	System.err.println("getBuseoOneName ex : " + e);
	    }
        return strtmp;
    }
	

}
