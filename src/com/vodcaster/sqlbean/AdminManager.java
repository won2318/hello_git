package com.vodcaster.sqlbean;

import java.util.Hashtable;
import java.util.Vector;

public class AdminManager {
	private static AdminManager instance;
	private AdminSqlBean sqlbean = null;
	
	private AdminManager(){
		sqlbean = new AdminSqlBean();
	}
	
	public static AdminManager getInstance(){
		if(instance == null){
			synchronized(AdminManager.class){
				if(instance == null){
					instance = new AdminManager();
				}
			}
		}
		return instance;
		
	}
	
	public Hashtable getAdminListAll(String searchField, String searchString, int page){
		Hashtable result_ht;
		String query= "";
		searchField = com.vodcaster.utils.TextUtil.getValue(searchField);
		searchString = com.vodcaster.utils.TextUtil.getValue(searchString);
		String sub_query = "";
 
		if (searchField != null && searchField.length() > 0 && searchString != null && searchString.length() > 0) {
			sub_query = " and "+searchField+" = '"+searchString+"' ";
		}
		query = " select * from login_history where 1=1 "+sub_query+" order by seq desc ";
//	 System.out.println("getAdminListAll:"+query);
		try{
		result_ht = sqlbean.selectAdminListAll(page,query);
	//	System.out.println("getAdminListAll::"+result_ht);
		}catch(Exception e){
			result_ht = new Hashtable();
			result_ht.put("LIST", new Hashtable());
			result_ht.put("PAGE", new com.yundara.util.PageBean());
			return result_ht;
		}
		return result_ht;
		
		
	}
}
