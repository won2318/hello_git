package com.vodcaster.sqlbean;

import dbcp.SQLBeanExt;

import java.util.Calendar;
import java.util.Hashtable;
import java.util.Vector;

import com.hrlee.sqlbean.MediaManager;
import com.yundara.util.PageBean;

/** 
	이 클래스는 쇼핑몰의 index.jsp, login process page에서 접속회수와 접속자(ip)를 입력처리 합니다.
*/
public class ContactBean extends SQLBeanExt implements java.io.Serializable{

	public ContactBean() {
		super();
	}

	
	private static ContactBean instance;
	 
	public static ContactBean getInstance() {
		if(instance == null) {
			synchronized(MediaManager.class) {
				if(instance == null) {
					instance = new ContactBean();
				}
			}
		}
		return instance;
	}
	
	private Calendar cal;
	private int YEAR, MONTH, DAY, DAYOFWEEK, HOUROFDAY;
	private String IP_ADDRESS, CUSTOMER_ID;

	public void setPage_cnn_cnt(String flag){
  
	        String sql = "";
	        try {
	        	if (flag != null && flag.length() > 0) {
		            //insert
//		            if(!isConn_DAY(flag)) {
//		                //System.err.println("입력");
//		                sql = "insert into page_cnn_cnt (cnt,day,flag) values(1,curdate(),'"+flag+"')";
//		               //System.err.println(sql);
//		                querymanager.executeQuery(sql); 
//		
//		            } //update
//		            else {
//		            	 
//		                sql = "update page_cnn_cnt set cnt=cnt+1 where day=curdate() and flag='"+flag+"'";
//		                querymanager.executeQuery(sql);
//		 
//		            }
	        		
	        		sql = "INSERT INTO page_cnn_cnt (cnt,DAY,flag) VALUES(1,CURDATE(),'"+flag+"') ON DUPLICATE KEY UPDATE cnt = cnt +1;";
 	                querymanager.executeQuery(sql);
	        		
	        	}

	        }catch(Exception e) {
	            System.err.println(e.getMessage());
	        }
		 
		
	}

	
	public boolean isConn_DAY(String flag)
	{
		boolean day_exist = false;

		try {
			Vector v = getTodayConnCount(flag);
			//System.err.println("vector size : "+v.size());
			if(v != null && v.size()>0) {
	            day_exist = true;
	        }
		}catch (Exception e){
			System.out.println(e);
			return day_exist;
		}

		return day_exist;
	}

	
	public Vector getTodayConnCount(String flag)
	{
		if (flag != null && flag.length() > 0) {
			String query = "select cnt from page_cnn_cnt where day=curdate() and flag='"+flag+"'";
			//System.err.println(query);
			return querymanager.selectEntity(query);
		} else {
		 return null;
		}
	}
	
	/*****************************************************
	쇼핑몰 인덱스 화면 접속시에 접속자에 대한 접속 정보를 저장합니다.<p>

	<b>작성자</b>       : 김종진<br>
	<b>관련 JSP</b>     : ROOT/index.jsp						 
	******************************************************/
	public void setValue(String ip, String customer_id, String flag)
	{
		flag = com.vodcaster.utils.TextUtil.getValue(flag);
		customer_id = com.vodcaster.utils.TextUtil.getValue(customer_id);
		
		this.cal=Calendar.getInstance();
		this.YEAR=cal.get(Calendar.YEAR);
		this.MONTH=cal.get(Calendar.MONTH)+1;
		this.DAY=cal.get(Calendar.DATE);
		this.DAYOFWEEK=cal.get(Calendar.DAY_OF_WEEK);
		this.HOUROFDAY=cal.get(Calendar.HOUR_OF_DAY);
		this.IP_ADDRESS=ip;
		this.CUSTOMER_ID=customer_id;
		//System.err.println("customer_id="+CUSTOMER_ID);
		setCount(flag);
	}

	/*****************************************************
	오늘날짜가 등록되어 있는지를 확인합니다.<p>

	<b>작성자</b>       : 김종진<br>
	<b>관련 JSP</b>     : 
	******************************************************/
	public boolean isExistance_DAY(String flag)
	{
		boolean day_exist = false;

		try {
			Vector v = getTodayContactCount(flag);
			//System.err.println("vector size : "+v.size());
			if(v != null && v.size()>0) {
	            day_exist = true;
	        }
		}catch (Exception e){
			System.out.println(e);
			return day_exist;
		}

		return day_exist;
	}

	/*****************************************************
	메뉴 접속 카운트가 오늘날짜에 등록되어 있는지를 확인합니다.<p>

	<b>작성자</b>       : hrlee<br>
	<b>관련 JSP</b>     : 
	******************************************************/
	public boolean isExistanceMenu_DAY(int menu_id, String flag)
	{
		boolean day_exist = false;
		if(menu_id >= 0 && flag != null && flag.length() > 0) {
			try {
				String query = "select cnt from contact_stat_menu where day='"+getDateStr()+"' and muid="+menu_id + " and flag='"+flag+"'";
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
	
	/*****************************************************
	오늘의 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>       : 김종진<br>
	<b>관련 JSP</b>     : 
	@see QueryManager#selectEntity
	******************************************************/
	public Vector getTodayContactCount(String flag)
	{
		if (flag != null && flag.length() > 0) {
			String query = "select cnt from contact_stat where day='"+getDateStr()+"' and flag='"+flag+"'";
			//System.err.println(query);
			return querymanager.selectEntity(query);
		} else {
		 return null;
		}
	}

	/*****************************************************
	사이트 인덱스페이지 접속시에 해당 아이피가 존재하는지 확인합니다.<p>

	<b>작성자</b>       : 김종진<br>
	<b>관련 JSP</b>     : 
	@see QueryManager#selectEntity
	******************************************************/
	public boolean isExistance_IP(String flag)
	{
		boolean ip_exist=false;
		
		if (flag != null && flag.length() > 0) {
			try{
			String query = 
				"select ip "+
				"  from contact_ip where day='"+getDateStr()+"' "+
				"   and hour="+HOUROFDAY+
				"   and ip='"+IP_ADDRESS+"'"+
				"   and customer_id='"+CUSTOMER_ID+"'"+
				"	and flag='"+flag+"'";
			//System.err.println(query);
			Vector v=querymanager.selectEntity(query);
			//System.err.println("vector size : "+v.size());
			if(v != null && v.size() > 0){
				ip_exist=true;
			}
	
			} catch (Exception e){
				System.out.println(e);
				return ip_exist;
			}
		}
		return ip_exist;
	}

	/*****************************************************
	사이트 인덱스페이지 접속시에 접속카운트를 처리합니다.<p>

	<b>작성자</b>       : 김종진<br>
	<b>관련 JSP</b>     : 
	@see QueryManager#selectEntity
	******************************************************/
	public void setCount(String flag)
	{
        String sql = "";
        try {
        	if (flag != null && flag.length() > 0) {
	            //insert
	            if(!isExistance_DAY(flag)) {

	            	sql = "insert into contact_stat (day,dayofweek,cnt, flag) values('"+getDateStr()+"',"+DAYOFWEEK+",1, '"+flag+"')";
	                querymanager.executeQuery(sql);
	
	                sql = "insert into contact_ip (day,hour,ip,customer_id,cnt, flag) "+ " values('"+getDateStr()+"',"+HOUROFDAY+",'"+IP_ADDRESS+"','"+CUSTOMER_ID+"',1, '"+flag+"')";
	                querymanager.executeQuery(sql);

	            } //update
	            else {
	            	 
	                sql = "update contact_stat set cnt=cnt+1 where day='"+getDateStr()+"' and flag='"+flag+"'";
	                querymanager.executeQuery(sql);
	
	                if(!isExistance_IP(flag)){
	                    sql = "insert into contact_ip (day,hour,ip,customer_id,cnt, flag) "+
	                                "values('"+getDateStr()+"',"+HOUROFDAY+",'"+IP_ADDRESS+"','"+CUSTOMER_ID+"',1, '"+flag+"')";
	                }else{
	                    sql = "update contact_ip set cnt=cnt+1 "+
	                            " where day='"+getDateStr()+"' and hour="+HOUROFDAY+" and ip='"+IP_ADDRESS+"' and customer_id='"+CUSTOMER_ID+"'"+
	                            " and flag='"+flag+"'";
	                }
 	                querymanager.executeQuery(sql);
 	                 
	            }
 	              
//        		sql = "INSERT INTO contact_stat (DAY,DAYOFWEEK,cnt, flag) VALUES('"+getDateStr()+"',"+DAYOFWEEK+",1,'"+flag+"') ON DUPLICATE KEY UPDATE cnt = cnt +1;"; 
//        		querymanager.executeQuery(sql);
//        		sql = "INSERT INTO contact_ip (day,hour,ip,customer_id,cnt, flag) VALUES('"+getDateStr()+"',"+HOUROFDAY+",'"+IP_ADDRESS+"','"+CUSTOMER_ID+"',1,'"+flag+"') ON DUPLICATE KEY UPDATE cnt = cnt +1;"; 
//        		querymanager.executeQuery(sql);
        	        		            
        	}

        }catch(Exception e) {
            System.err.println(e.getMessage());
        }
	}
	
	/*****************************************************
	사이트 메뉴 접속시에 접속카운트를 처리합니다.<p>

	<b>작성자</b>       : hrlee<br>
	<b>관련 JSP</b>     : 
	@see QueryManager#selectEntity
	******************************************************/
	public void setCountMenu(int menu_id, String flag)
	{
		if(menu_id < 0) return;
		flag = com.vodcaster.utils.TextUtil.getValue(flag);
        String sql = "";
        if (flag != null && flag.length() > 0) {
	        try {
	            //insert
	            if(!isExistanceMenu_DAY(menu_id, flag)) {
	                sql = "insert into contact_stat_menu (muid, day,dayofweek,cnt, flag) values("+menu_id+"'"+getDateStr()+"',"+DAYOFWEEK+",1, '"+flag+"')";
	                querymanager.executeQuery(sql);
	
	            } //update
	            else {
	                sql = "update contact_stat_menu set cnt=cnt+1 where muid="+menu_id +" and day='"+getDateStr()+"' and flag='"+flag+"'";
	                querymanager.executeQuery(sql);
	            }
	
	        }catch(Exception e) {
	            System.err.println(e.getMessage());
	        }
        }
	}

	public String toStr(int num)
	{
		try{
			return Integer.toString(num);
		} catch (Exception e){
			System.out.println(e);
			return "";
		}
	}

	public String getDateStr()
	{
		String date_str=toStr(YEAR);
		if(MONTH>9)
			date_str +=toStr(MONTH);
		else
			date_str +="0"+toStr(MONTH);
		if(DAY>9)
			date_str +=toStr(DAY);
		else
			date_str +="0"+toStr(DAY);
		return date_str;
	}
	
	
	
	public Vector getPageCnnCnt(String rstime, String retime, String flag ){

		rstime = com.vodcaster.utils.TextUtil.getValue(rstime);
		retime = com.vodcaster.utils.TextUtil.getValue(retime);
		flag = com.vodcaster.utils.TextUtil.getValue(flag);
	 
		String sub_query = "";
	    	
 
	 
		if (rstime != null && rstime.length() > 0 && retime != null && retime.length() > 0 )
		{
			sub_query = sub_query + " and day between '" +rstime+ "' and '"+retime +" 23:59' ";
		} else if (rstime != null && rstime.length() > 0 && (retime == null || retime.equals("")) )
		{
			sub_query = sub_query + " and day >= '" +rstime +"' ";
		}else if (retime != null && retime.length() > 0 && (rstime == null || rstime.equals("")) )
		{
			sub_query = sub_query + " and day <= '" +retime +"' ";
		}

		
		if (flag != null && flag.length() > 0)
		{
			sub_query = sub_query +  "  and flag ='"+flag+"' ";
		}
 

		String query = "";
		String count_query= "";
		query ="select * from page_cnn_cnt where  day is not null "+sub_query+"   order by day desc";
	 
		//System.out.println(query);
 
		return querymanager.selectHashEntities(query);
 
	}
	
	
	public Hashtable getPageCnnCnt(String rstime, String retime, String flag, int page, int limit ){

		rstime = com.vodcaster.utils.TextUtil.getValue(rstime);
		retime = com.vodcaster.utils.TextUtil.getValue(retime);
		flag = com.vodcaster.utils.TextUtil.getValue(flag);
	 
		String sub_query = "";
	    	
 
	 
		if (rstime != null && rstime.length() > 0 && retime != null && retime.length() > 0 )
		{
			sub_query = sub_query + " and day between '" +rstime+ "' and '"+retime +" 23:59' ";
		} else if (rstime != null && rstime.length() > 0 && (retime == null || retime.equals("")) )
		{
			sub_query = sub_query + " and day >= '" +rstime +"' ";
		}else if (retime != null && retime.length() > 0 && (rstime == null || rstime.equals("")) )
		{
			sub_query = sub_query + " and day <= '" +retime +"' ";
		}

		
		if (flag != null && flag.length() > 0)
		{
			sub_query = sub_query +  "  and flag ='"+flag+"' ";
		}
 

		String query = "";
		String count_query= "";
		query ="select * from page_cnn_cnt where  day is not null "+sub_query+"   order by day desc";
			  
		count_query ="select count(day) from page_cnn_cnt where day is not null "+sub_query+" ";

		//System.out.println(query);
		return this.selectQuery(query,count_query, page, limit) ;
 
	}
	
	
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