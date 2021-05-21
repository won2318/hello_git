package com.vodcaster.sqlbean;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import com.hrlee.sqlbean.MediaManager;
import com.hrlee.sqlbean.MediaSqlBean;
import com.yundara.util.PageBean;

import dbcp.SQLBeanExt;

public class WebLogManager extends SQLBeanExt implements java.io.Serializable{

	public WebLogManager() 
	{ 
		super();

	}
	
	
	private static WebLogManager instance;
	 
	public static WebLogManager getInstance() {
		if(instance == null) {
			synchronized(MediaManager.class) {
				if(instance == null) {
					instance = new WebLogManager();
				}
			}
		}
		return instance;
	}
    
	
	 /**
	 * 방문 정보 저장
	 * 2013-04-15
	 * by hrlee
	 */
	
	public void setStatVisitInfo(HttpServletRequest req) {
	  
	    try {
    	    String query = "";
    	   /*
    	        query = " INSERT INTO web_log (log_ip, log_date, log_referer, log_uri, " +
    	        		"log_query, log_agent, log_sessionID, log_day, log_method) " +
    	        		"VALUES ( " 
    	        		+ " '" + req.getRemoteAddr()  + "',"   
    	                + "  now(), " 
    	                + " '" + req.getHeader("referer")+ "', " 
    	                + " '" + req.getRequestURI()+ "', "
    	                + " '" + req.getQueryString()+ "', "
    	                + " '" + req.getHeader("user-agent")+ "', "
    	                + " '"+ req.getRequestedSessionId() + "',"
    	                + " DAYOFWEEK(NOW()),  "
    	                + " '" + req.getMethod()+ "' "
    	                + " )";
    	        */
    	        query = "INSERT INTO web_log (log_ip, log_date, log_referer, log_uri, log_query," +
    	        		" log_agent, log_sessionID,  log_day, log_method)" + 
						" SELECT " +
							" '" + req.getRemoteAddr()  + "'," +
							" NOW()," +
							" '" + req.getHeader("referer")+ "'," +
							" '" + req.getRequestURI()+ "', " + 
							" '" + req.getQueryString()+ "'," +
							" '" + req.getHeader("user-agent")+ "', "+  
							" '"+ ((HttpSession)req.getSession(true)).getId() + "'," +
							" DAYOFWEEK(NOW())," +
							" '" + req.getMethod()+ "' "+
							" FROM DUAL " +
						" WHERE NOT EXISTS " +
						" ( "  +
						" 	SELECT log_ip, log_date, log_referer, log_uri, log_query, log_agent, " +
						"		log_sessionID, log_day, log_method FROM web_log " + 
						"  WHERE (log_sessionID is not null and log_sessionID<>'null') and log_sessionID='"+ req.getRequestedSessionId() + "' " +
						"		AND CURDATE()= DATE_FORMAT(log_date,'%Y-%m-%d') " +
						" )";
    	        //System.out.println(query); 
    	        querymanager.updateEntities(query);
    	   
		} catch (Exception e) {
	        System.err.println(e.toString());
	    }
	}
	/* 방문자 정보 검색
	 * 시작일, 종료일, 브라우저 종류, GET/POST, 접속자 IP, 유입경로, 동영상/게시판/메인화면/생방송, 세션id, 페이지번호, 페이지당 목록 개수
	 * 2013-04-16
	 * by hrlee
	 */
	public Vector getWebLog(String rstime,String retime,String browser, String method,
			String ip, String referer, String uri, String sessionID ){

		rstime = com.vodcaster.utils.TextUtil.getValue(rstime);
		retime = com.vodcaster.utils.TextUtil.getValue(retime);
		referer = com.vodcaster.utils.TextUtil.getValue(referer);
		browser = com.vodcaster.utils.TextUtil.getValue(browser);
		method = com.vodcaster.utils.TextUtil.getValue(method);
		ip = com.vodcaster.utils.TextUtil.getValue(ip);
		uri = com.vodcaster.utils.TextUtil.getValue(uri);
		sessionID = com.vodcaster.utils.TextUtil.getValue(sessionID);
		
		String sub_query = "";
	    	
 
		if (browser != null && browser.length() > 0 && !browser.equals("none"))
		{
			sub_query = sub_query + " and log_agent like %'"+ browser+"'";
		}

		if (method != null && method.length() > 0 )
		{
			sub_query = sub_query + " and log_method = '"+ method+"' ";
		}

		if (rstime != null && rstime.length() > 0 && retime != null && retime.length() > 0 )
		{
			sub_query = sub_query + " and log_date between '" +rstime+ "' and '"+retime +" 23:59' ";
		} else if (rstime != null && rstime.length() > 0 && (retime == null || retime.equals("")) )
		{
			sub_query = sub_query + " and log_date >= '" +rstime +"' ";
		}else if (retime != null && retime.length() > 0 && (rstime == null || rstime.equals("")) )
		{
			sub_query = sub_query + " and log_date <= '" +retime +"' ";
		}

		if (ip != null && ip.length() > 0)
		{
			sub_query = sub_query +  "  and log_ip = '"+ip+"' ";
		}
 
		if (referer != null && referer.length() > 0)
		{
			sub_query = sub_query +  "  and referer like '%"+referer+"%' ";
		}
 	
		if (uri != null && uri.length() > 0)
		{
			if(uri.equals("main")){
				sub_query = sub_query +  "  and log_uri = '%main%' ";	
			}else if(uri.equals("board")){
				sub_query = sub_query +  "  and log_uri = '%board%' ";	
			}else if(uri.equals("video")){
				sub_query = sub_query +  "  and log_uri = '%video%' ";	
			}else if(uri.equals("live")){
				sub_query = sub_query +  "  and log_uri = '%live%' ";	
			}
			
		}
		
		if (sessionID != null && sessionID.length() > 0)
		{
			sub_query = sub_query +  "  and log_sessionID = '"+sessionID+"' ";
		}

		String query = "";
 
		query ="select * from web_log where  log_seq is not null "+sub_query+"   order by log_seq desc";
	 
		//System.out.println(query);
		return querymanager.selectHashEntities(query);


	}
	
	public Hashtable getWebLog(String rstime,String retime,String browser, String method,
			String ip, String referer, String uri, String sessionID, int page, int limit ){

		rstime = com.vodcaster.utils.TextUtil.getValue(rstime);
		retime = com.vodcaster.utils.TextUtil.getValue(retime);
		referer = com.vodcaster.utils.TextUtil.getValue(referer);
		browser = com.vodcaster.utils.TextUtil.getValue(browser);
		method = com.vodcaster.utils.TextUtil.getValue(method);
		ip = com.vodcaster.utils.TextUtil.getValue(ip);
		uri = com.vodcaster.utils.TextUtil.getValue(uri);
		sessionID = com.vodcaster.utils.TextUtil.getValue(sessionID);
		
		String sub_query = "";
	    	
 
		if (browser != null && browser.length() > 0 && !browser.equals("none"))
		{
			sub_query = sub_query + " and log_agent like %'"+ browser+"'";
		}

		if (method != null && method.length() > 0 )
		{
			sub_query = sub_query + " and log_method = '"+ method+"' ";
		}

		if (rstime != null && rstime.length() > 0 && retime != null && retime.length() > 0 )
		{
			sub_query = sub_query + " and log_date between '" +rstime+ "' and '"+retime +" 23:59' ";
		} else if (rstime != null && rstime.length() > 0 && (retime == null || retime.equals("")) )
		{
			sub_query = sub_query + " and log_date >= '" +rstime +"' ";
		}else if (retime != null && retime.length() > 0 && (rstime == null || rstime.equals("")) )
		{
			sub_query = sub_query + " and log_date <= '" +retime +"' ";
		}

		if (ip != null && ip.length() > 0)
		{
			sub_query = sub_query +  "  and log_ip = '"+ip+"' ";
		}
 
		if (referer != null && referer.length() > 0)
		{
			sub_query = sub_query +  "  and referer like '%"+referer+"%' ";
		}
 	
		if (uri != null && uri.length() > 0)
		{
			if(uri.equals("main")){
				sub_query = sub_query +  "  and log_uri = '%main%' ";	
			}else if(uri.equals("board")){
				sub_query = sub_query +  "  and log_uri = '%board%' ";	
			}else if(uri.equals("video")){
				sub_query = sub_query +  "  and log_uri = '%video%' ";	
			}else if(uri.equals("live")){
				sub_query = sub_query +  "  and log_uri = '%live%' ";	
			}
			
		}
		
		if (sessionID != null && sessionID.length() > 0)
		{
			sub_query = sub_query +  "  and log_sessionID = '"+sessionID+"' ";
		}

		String query = "";
		String count_query= "";
		query ="select * from web_log where  log_seq is not null "+sub_query+"   order by log_seq desc";
			  
		count_query ="select count(log_seq) from web_log where log_seq is not null "+sub_query+" ";

		//System.out.println(query);
		return this.selectQuery(query,count_query, page, limit) ;


	}
	/*****************************************************
		지정검색에 의해 미디어전체 리스트 출력.<p>
		<b>작성자</b> : 최희성<br>
		@return 미디어 목록<br>
		@param query 검색 QUERY
	******************************************************/
	public Hashtable selectQuery(String query, String count_query, int page, int limit){
	
		Vector rtn = null;
		Hashtable ht = new Hashtable();
		int totalRecord = 0;
		if(limit < 0){
			limit = 10;
		}
		try {
			Vector v = querymanager.selectEntities(count_query);
			try{
				if(v != null && v.size() > 0){
					totalRecord = Integer.parseInt(String.valueOf(((Vector)(v.elementAt(0))).elementAt(0)));
				}
			}catch(Exception ex){
				totalRecord = 0;
			}
			if(totalRecord <= 0){
				ht.put("LIST", new Vector());
				ht.put("PAGE", new com.yundara.util.PageBean());
				return ht;
			}
			
			PageBean pb = new PageBean(totalRecord, limit, 5, page);
	//		totalrecord,lineperpage,pageperblock,page
			// 해당 페이지의 리스트를 얻는다.
			String rquery ="";
			rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
			Vector result_v = querymanager.selectHashEntities(rquery);

			
			if(result_v != null && result_v.size() > 0){
				ht.put("LIST",result_v);
				ht.put("PAGE",pb);
			}else{
				//ht.put("LIST", new Hashtable());
				ht.put("LIST", new Vector());
				ht.put("PAGE", new com.yundara.util.PageBean());
			}
				
					
		}catch(Exception e) {
			System.err.println("selectMediaListAllExtPage ex : "+e.getMessage());
		}
	
		return ht;
	}
}
