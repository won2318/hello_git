package com.news;

import java.util.*;

import com.yundara.util.PageBean;

import dbcp.SQLBeanExt2;

public class ArticleSqlBean extends SQLBeanExt2 {

	public ArticleSqlBean() {
		super();
	}
	
	public Vector selectQuery(String query) {
        return querymanager.selectEntity(query);

    }
    
    public Vector selectQuery2(String query) {
        return querymanager.selectEntities(query);
    }
    
    public Vector selechHashQuery(String query){
    	return querymanager.selectHashEntity(query);
    }
    
    public Vector selechHashQuery2(String query){
    	return querymanager.selectHashEntities(query);
    }
    
    
    public void updateArticleCount(String idx)
	{
		  
        String sql = "";
        if (idx != null && idx.length() > 0) {
	        try {
	            //insert
//	            if(!isExistance_DAY(idx)) {
//	                sql = "update t_article2_hit set hit=hit+1 where idx="+idx+"' ";
//	                querymanager.executeQuery(sql);
//	
//	            } //update
//	            else {
//	                sql = " insert into t_article2_hit(idx,hit)values("+idx+",1) ";
//	                querymanager.executeQuery(sql);
//	            }
	            
	            sql = " insert into t_article2_hit(idx,hit)values("+idx+",1)  ON DUPLICATE KEY UPDATE hit=hit+1 ";
	
	        }catch(Exception e) {
	            System.err.println(e.getMessage());
	        }
        }
	}
    
	public boolean isExistance_DAY( String idx)
	{
		boolean day_exist = false;
		if( idx != null && idx.length() > 0) {
			try {
				String query = "select idx from t_article2_hit where idx='"+idx+"'";
				Vector v = querymanager.selectEntity(query);;
				//System.err.println("vector size : "+v.size());
				if(v != null && v.size()> 0) {
		            day_exist = true;
		        }
			} catch (Exception e) {
				System.out.println(e);
				return day_exist;
			}
		} 

		return day_exist;
	}
	
//    public int updateArticleCount(String idx){
//    	String query = "";
//    	
//    	 query = " update t_article2 set hit = hit+1 where idx = " + idx;
// 
//    	return querymanager.updateEntities(query);
//    }
    
    public int updateLogCount(String code, String referer, String browser, String os, String ip){
    	
    	String query = "";
    	
    	query = " insert into counter (code,referer,browser,os,ip,wdate) " +
    			" values( '" + code + "', '" + referer + "', '" + browser + "', '" + os + "', '" + ip + "', now())";
    	
    	return querymanager.updateEntities(query);
    }
    
    public int createMailTable(String table){
    	String query = "";
    	
    	//테이블 존재하지 않는다면 생성한다.
		query = " CREATE TABLE " + table + " (  `sendkey` int(10) unsigned NOT NULL AUTO_INCREMENT, " +
    			"					`mailidx` int(10) unsigned NOT NULL DEFAULT '0', " +
    			"					`name` varchar(50) NOT NULL DEFAULT '', " +
				"					`email` varchar(60) NOT NULL DEFAULT '', " +
				"					`subscribe_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00', " +    
				"					`mtype` tinyint(4) NOT NULL DEFAULT '0', " +  
				"					`sending` tinyint(4) NOT NULL DEFAULT '0', " +    
				"					`mailflag` tinyint(3) unsigned NOT NULL DEFAULT '0', " +  
				"					`readflag` enum('0','1') NOT NULL DEFAULT '0', " +    
				"					`rejectflag` enum('0','1') NOT NULL DEFAULT '0', " +   
				"					`sent` datetime NOT NULL DEFAULT '0000-00-00 00:00:00', " +    
				"					`id_idx` tinyint(3) unsigned NOT NULL DEFAULT '0', " +  
				"					`group_idx` tinyint(3) unsigned NOT NULL DEFAULT '0', " +    
				"					`userid` varchar(60) NOT NULL DEFAULT '', " +  
				"					`errcode` tinyint(4) NOT NULL DEFAULT '0', " +    
				"					`sido` varchar(20) DEFAULT NULL, " +  
				"					`job` varchar(20) DEFAULT NULL, " +    
				"					PRIMARY KEY (`sendkey`), " +  
				"					KEY `mailidx` (`mailidx`), " +    
				"					KEY `readflag` (`readflag`), " +  
				"					KEY `email` (`email`), " +    
				"					KEY `errcode` (`errcode`)) ";
	    	
		return querymanager.updateEntities(query);
    }
    
    public int insertSender(String mailidx, String title, String content, String senderName, String senderMail){
    	String query = "";
    	
    	query = "INSERT INTO cysendbase SET group_idx=1, groupidx='', mailidx= '" + mailidx + "',subject= '" + title + "',content= '" + content + "',ctype= '1',senddate= now(),sendflag= '0',mailtype= '11',regdate= now(),id_idx= '',admin_name= '" + senderName + "',admin_email= '" + senderMail + "' , rejecttag = '0' ";
    	
    	return querymanager.updateEntities(query);
    }
    
    public int insertReceiver(String table, String mailidx, String receiverName, String receiverMail){
    	String query = "";
    	
    	query = "INSERT INTO " + table + " SET mailidx='" + mailidx + "', name='" + receiverName + "', email='" + receiverMail + "', mtype='3',id_idx='1',group_idx='1', userid='" + receiverMail + "' ";
    	
    	return querymanager.updateEntities(query);
    }
    
    
    public Hashtable getListCnt(int page,String query, String count_query, int limit, int pagePerBlock){
		// page정보를 얻는다.
		
		// page정보를 얻는다.
        Vector v = querymanager.selectEntities(count_query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			totalRecord = Integer.parseInt(String.valueOf(((Vector)(v.elementAt(0))).elementAt(0)));
		}
		if(totalRecord <= 0){
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}
		if(pagePerBlock < 1) pagePerBlock=10;
        PageBean pb = new PageBean(totalRecord, limit, pagePerBlock, page);
		String rquery ="";
		rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
		//System.out.println(rquery);
		Vector result_v = querymanager.selectHashEntities(rquery);
		
		Hashtable ht = new Hashtable();
		if(result_v != null && result_v.size() > 0){
			ht.put("LIST",result_v);
			ht.put("PAGE",pb);
		}else{
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		} 
		return ht;
		 
}
    
    
}
