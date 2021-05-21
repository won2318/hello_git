package com.hrlee.sqlbean;

import dbcp.SQLBeanExt;
import java.util.*;

import javax.servlet.http.*;
import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.vodcaster.sqlbean.DirectoryNameManager;



public class MenuManager2 extends SQLBeanExt{
private static MenuManager2 instance;
	
	private MenuSqlBean sqlbean = null;
    
	private MenuManager2() {
        sqlbean = new MenuSqlBean();
        //System.err.println("MenuManager 인스턴스 생성");
    }
    
	public static MenuManager2 getInstance() {
		if(instance == null) {
			synchronized(MenuManager2.class) {
				if(instance == null) {
					instance = new MenuManager2();
				}
			}
		}
		return instance;
	}
	
	public Vector getHitCount( int Year, int Month, int Day, String flag, String Type) {
		flag = com.vodcaster.utils.TextUtil.getValue(flag);
		Type = com.vodcaster.utils.TextUtil.getValue(Type);
		
	    String query = "";
	    
	    if( Year > 0 && Month > 0 && flag != null && flag.length() > 0 && Type != null && Type.length() > 0) {
	    	if (Type.equals("V")) {
	        query = " select a.ctitle, "+
	        		" coalesce((select counter from counter b where gubunCtn = '1' and a.ccode = b.gubunCode and countFlag = '"+flag+"' and countYField = '"+Year+"'),0)as Cyear,		"+
	        		" coalesce((select counter from counter b where gubunCtn = '2' and a.ccode = b.gubunCode and countFlag = '"+flag+"' and countYField = '"+Year+"' and countMField = '"+Month+"' ),0)as Cmonth,	"+
	        		" coalesce((select counter from counter b where gubunCtn = '4' and a.ccode = b.gubunCode and countFlag = '"+flag+"' and countYField = '"+Year+"' and countMField = '"+Month+"'  and countDField = '"+Day+"' ),0)as Cday		"+
	        		" from category a "+
	        		" where a.ctype = '"+Type+"' and a.del_flag='N' ";
	    	} else {
	        
	        query = " select 'live' as ctitle, "+
	        		" coalesce((select counter from counter b where gubunCtn = '1' and countFlag = '"+flag+"' and countYField = '"+Year+"'),0)as Cyear,		"+
	        		" coalesce((select counter from counter b where gubunCtn = '2' and countFlag = '"+flag+"' and countYField = '"+Year+"' and countMField = '"+Month+"' ),0)as Cmonth,	"+
	        		" coalesce((select counter from counter b where gubunCtn = '4' and countFlag = '"+flag+"' and countYField = '"+Year+"' and countMField = '"+Month+"'  and countDField = '"+Day+"' ),0)as Cday	";
	        	 
	    	}
	        
	        //System.out.println(query);
	        return sqlbean.selectMenuListAll(query);
 
	    } else
	        return null;
	}
	
	public Vector getSelectMenu(String flag) {
		
		flag = com.vodcaster.utils.TextUtil.getValue(flag);
		
	    String query = "";
	    if( flag != null && flag.length() > 0) {
	        query = " select ctitle, ccode from category where ctype = '"+flag+"' ";
	        return sqlbean.selectMenuListAll(query);
	    } else
	        return null;
	}
	
	public Vector getSelectMCount(String month, String flag, String type) {
	    String query = "";
	    
	    month = com.vodcaster.utils.TextUtil.getValue(month);
	    flag = com.vodcaster.utils.TextUtil.getValue(flag);
	    type = com.vodcaster.utils.TextUtil.getValue(type);
	    
	    if( month != null && month.length() > 0 && flag != null && flag.length() > 0 && type != null && type.length() > 0) {
	        query = " select a.ccode, b.countDField as day, b.counter as cnt from category a, counter b where a.ccode = b.gubunCode and b.countYField = substring('"+month+"',1,4) and b.countMField = substring('"+month+"',5,6) and b.countFlag = '"+flag+"' and gubunCtn = '4' and a.ctype = '"+type+"' ";		        	
	       // System.out.println(query);
	        return sqlbean.selectMenuListAll(query);
	    } 
	    return null;
	}
	
	public Vector getSelectYCount(String month, String flag, String type) {
		
		month = com.vodcaster.utils.TextUtil.getValue(month);
		flag = com.vodcaster.utils.TextUtil.getValue(flag);
		type = com.vodcaster.utils.TextUtil.getValue(type);
		
	    String query = "";
	    
	    
	    if( month != null && month.length() > 0 && flag != null && flag.length() > 0 && type != null && type.length() > 0) {
	        query = " select a.ccode, b.countMField as day, b.counter as cnt from category a, counter b where a.ccode = b.gubunCode and b.countYField = substring('"+month+"',1,4) and b.countFlag = '"+flag+"' and gubunCtn = '2' and a.ctype = '"+type+"' ";	        		  
	        //System.out.println(query);
	        return sqlbean.selectMenuListAll(query);
	    } 
	    return null;
	}
	
	
	
	public void insertHit(String ccode, int year, int month, int date, String GB)throws Exception{
		
		ccode = com.vodcaster.utils.TextUtil.getValue(ccode);
		GB = com.vodcaster.utils.TextUtil.getValue(GB);
		 
		if(year <= 0) {
			year = 0;
	    }
		
		Vector vt1 = new Vector();
        Vector vt2 = new Vector();
        Vector vt3 = new Vector();
        Vector vt4 = new Vector();
        Vector vt5 = new Vector();
        Vector vt6 = new Vector();
        int nb = 0;
        
        vt1.add(ccode);
        vt1.add(ccode);
        vt1.add(ccode);
        
        vt2.add(year);
        vt2.add(year);
        vt2.add(year);
        
        vt3.add(nb);
        vt3.add(month);
        vt3.add(month);
        
        vt4.add(nb);
        vt4.add(nb);
        vt4.add(date);
        
        vt5.add(GB);
        vt5.add(GB);
        vt5.add(GB);
        
        vt6.add("1");
        vt6.add("2");
        vt6.add("4");
        
        
        try{
	    	if( ccode != null && ccode.length() > 0 && year >= 0 && month >= 0 && date >= 0 && GB != null && GB.length() > 0) {
	        int iResult = querymanager.setVisitCounter(vt1, vt2, vt3, vt4, vt5, vt6);
	    	}
        } catch (Exception e){
        	System.out.println("insertHit:"+e);
        }
        
	}
	
}
