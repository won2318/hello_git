package com.vodcaster.sqlbean;

import java.util.*;
import java.text.SimpleDateFormat;
import dbcp.SQLBeanExt;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.RandomUtils;

/**
	접속자수 및 접속통계와 관련된 DB질의문을 처리하는 클래스입니다.
	<b>작성자</b>: 김종진
*/
public class StatManagerBean extends SQLBeanExt implements java.io.Serializable
{
	private int YEAR, MONTH, DAY;
	private Calendar cal;


	public StatManagerBean() 
	{ 
		super();

		this.cal=Calendar.getInstance();
		this.YEAR=cal.get(Calendar.YEAR);
		this.MONTH=cal.get(Calendar.MONTH)+1;
		this.DAY=cal.get(Calendar.DATE);
	}

	/*****************************************************
	오늘의 접속자수를 넘겨줍니다.<p>

	<b>작성자</b>       : 김종진	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntity
	******************************************************/
	public Vector getTodayIPCount()
	{
		String query =
			"select ifnull(count(distinct ip),0) "+
			"  from contact_ip where day='"+getDateStr()+"'";
		//System.err.println(query);
		return querymanager.selectEntity(query);
	}

	/*****************************************************
	이달의 접속자수를 넘겨줍니다.<p>

	<b>작성자</b>       : 김종진	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntity
	******************************************************/
	public Vector getMonthIPCount()
	{
		String query =
			"select ifnull(count(distinct ip),0) "+
			"  from contact_ip where day like '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"%' ";

		return querymanager.selectEntity(query);
	}

	/*****************************************************
	총접속자수를 넘겨줍니다.<p>

	<b>작성자</b>       : 김종진	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntity
	******************************************************/
	public Vector getTotalIPCount()
	{
		String query =
			"select ifnull(count(distinct ip),0) "+
			"  from contact_ip ";

		return querymanager.selectEntity(query);
	}

	/*****************************************************
	오늘의 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>       : 김종진	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntity
	******************************************************/
	public Vector getTodayContactCount()
	{
		try{
			String query =
				"select cnt "+
				"  from contact_stat where day='"+getDateStr()+"'";
	
			return querymanager.selectEntity(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}

	/*****************************************************
	이달의 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>       : 김종진	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntity
	******************************************************/
	public Vector getMonthContactCount()
	{
		try{
			String query =
				"select ifnull(sum(cnt),0) "+
				"  from contact_stat where day like '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"%' ";
	
			return querymanager.selectEntity(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}

	/*****************************************************
	총 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>       : 김종진	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntity
	******************************************************/
	public Vector getTotalContactCount()
	{
		String query = "select ifnull(sum(cnt),0) from contact_stat ";

		return querymanager.selectEntity(query);
	}

	/*****************************************************
	모든 접속관련 통계를 넘겨줍니다.<p>

	<b>작성자</b>       : 김종진	<br>
	<b>관련 JSP</b>	:
	@return 오늘접속자/이달접속자/전체접속자/오늘카운트/이달카운트/전체카운트 가져오기
	@see QueryManager#selectEntities
	******************************************************/
	public Vector getAllCount()
	{
		try{
			String query=
			"select count(distinct ip),'1' as no from contact_ip where day='"+getDateStr()+"' "+
			"union select count(distinct ip),'2' as no from contact_ip where day like '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"%' "+
			"union select count(distinct ip),'3' as no from contact_ip "+
			"union select ifnull(sum(cnt),0),'4' as no from contact_stat where day='"+getDateStr()+"' "+
			"union select ifnull(sum(cnt),0),'5' as no from contact_stat where day like '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"%' "+
			"union select ifnull(sum(cnt),0),'6' as no from contact_stat "+
			"order by no";
	//System.err.println(query);
			return querymanager.selectEntities(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}
	
	
	public Vector getAllCount_stat(String type)
	{
		type = com.vodcaster.utils.TextUtil.getValue(type);
		try{
			String terms = "";
			if(type.equals("") || type.equals("W"))
				terms = " flag='W' ";
			else if(type.equals("M"))
				terms = " flag='M' ";
			
			String query=
			"select ifnull(sum(cnt),0),'1' as no from contact_stat where day='"+getDateStr()+"' and "+terms+
			"union select  ifnull(sum(cnt),0),'2' as no from contact_stat where day like '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"%' and "+terms+
			"union select  ifnull(sum(cnt),0),'3' as no from contact_stat where " +terms+
			"order by no";
			
			//System.err.println(query);
			return querymanager.selectEntities(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}

	/*****************************************************
	최근 한달간 시간별 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>       : 김종진	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntities
	******************************************************/
	public Vector getHourContactCount()
	{
		try{
	        String pre_date = toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH))+toMMDD(cal.get(Calendar.DATE));
	        String now_date = getDateStr();
			String query =
				"select ifnull(sum(cnt),0), '1' as hour from contact_ip where day between '"+pre_date + "' and '" +now_date+ "' and hour in (0,1) "+
				"union select ifnull(sum(cnt),0), '3' as hour from contact_ip where day between '"+pre_date + "' and '" +now_date+ "' and hour in (2,3) "+
				"union select ifnull(sum(cnt),0), '5' as hour from contact_ip where day between '"+pre_date + "' and '" +now_date+ "' and hour in (4,5) "+
				"union select ifnull(sum(cnt),0), '7' as hour from contact_ip where day between '"+pre_date + "' and '" +now_date+ "' and hour in (6,7) "+
				"union select ifnull(sum(cnt),0), '9' as hour from contact_ip where day between '"+pre_date + "' and '" +now_date+ "' and hour in (8,9) "+
				"union select ifnull(sum(cnt),0), '11' as hour from contact_ip where day between '"+pre_date + "' and '" +now_date+ "' and hour in (10,11) "+
				"union select ifnull(sum(cnt),0), '13' as hour from contact_ip where day between '"+pre_date + "' and '" +now_date+ "' and hour in (12,13) "+
				"union select ifnull(sum(cnt),0), '15' as hour from contact_ip where day between '"+pre_date + "' and '" +now_date+ "' and hour in (14,15) "+
				"union select ifnull(sum(cnt),0), '17' as hour from contact_ip where day between '"+pre_date + "' and '" +now_date+ "' and hour in (16,17) "+
				"union select ifnull(sum(cnt),0), '19' as hour from contact_ip where day between '"+pre_date + "' and '" +now_date+ "' and hour in (18,19) "+
				"union select ifnull(sum(cnt),0), '21' as hour from contact_ip where day between '"+pre_date + "' and '" +now_date+ "' and hour in (20,21) "+
				"union select ifnull(sum(cnt),0), '23' as hour from contact_ip where day between '"+pre_date + "' and '" +now_date+ "' and hour in (22,23) "+
				" ";
	
			return querymanager.selectEntities(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}

	/*****************************************************
	지난 1년간 월별 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>       : 김종진	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntities
	******************************************************/
	public Vector getMonthStat(int iData, String type)
	{
		type = com.vodcaster.utils.TextUtil.getValue(type);
		try{


			String terms = "";
			if(type.equals("") || type.equals("W"))
				terms = " and flag='W' ";
			else if(type.equals("M"))
				terms = " and flag='M' ";
			
//					현재 달에서 iDate 만큼 이동한 달
			cal.add ( cal.YEAR, iData );
			int iYear =  cal.get ( cal.YEAR );
			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로

			String query = 
			"select ifnull(sum(cnt),0),'"+toMMDD(12)+"' as mm from contact_stat  where day like '"+toStr(iYear)+toMMDD(12)+"%' "+terms;
			for(int i=10; i>=0; i--)
			{
				query+=
				"union select ifnull(sum(cnt),0) ,'"+toMMDD(i+1)+"' as mm from contact_stat  where day like '"+toStr(iYear)+toMMDD(i+1)+"%'"+terms;
			}
			query+=" order by mm ";
//					System.err.println(query);
			return querymanager.selectEntities(query);
		
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}
	/*****************************************************
	최근 7일간 일일별 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>       : 김종진	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntities
	******************************************************/
	public Vector getDayStat(int iDate, String type)
	{

		type = com.vodcaster.utils.TextUtil.getValue(type);
		try{
 	

			String terms = "";
			if(type.equals("") || type.equals("W"))
				terms = " and flag='W' ";
			else if(type.equals("M"))
				terms = " and flag='M' ";
			
			String query = null;
			cal.add(Calendar.DATE,iDate+1);
			query=
			"select ifnull(sum(cnt),0),  '"+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd , (@a := 1) as aa "+
			" from contact_stat  where  day like '"+toMMDD(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+toMMDD(cal.get(Calendar.DATE))+"' "+terms;

			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
			for(int i=iDate+2; i<=iDate+7; i++)
			{
				cal.add(Calendar.DATE,i);
				query+=
				" union select ifnull(sum(cnt),0), '"+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd , (@a := @a+1) as aa "+
				"  from contact_stat "+
				" where day like '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+toMMDD(cal.get(Calendar.DATE))+"' "+terms;
				cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
			}
			query+=" order by aa ";
			
			//System.err.println(query);
			return querymanager.selectEntities(query);
		
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}

	/*****************************************************
	최근 7일간 일일별 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>       : 김종진	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntities
	******************************************************/
	public Vector getDayStat()
	{
		try{
			String query = null;
			cal.add(Calendar.DATE,-6);
			query=
			"select ifnull(sum(cnt),0), '"+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
			"  from contact_stat "+
			" where day like '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+toMMDD(cal.get(Calendar.DATE))+"'";
			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
			for(int i=-5; i<=0; i++)
			{
				cal.add(Calendar.DATE,i);
				query+=
				" union select ifnull(sum(cnt),0), '"+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
				"  from contact_stat "+
				" where day like '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+toMMDD(cal.get(Calendar.DATE))+"' ";
				cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
			}
			query+=" order by dd ";
	
			return querymanager.selectEntities(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}

	/*****************************************************
	최근 한달간 요일별 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>       : 김종진	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntities
	******************************************************/
	 
	public Vector getDayOfWeekStat(int iDate, String type)
	{
		type = com.vodcaster.utils.TextUtil.getValue(type);
		try{
 
			String terms = "";
			if(type.equals("") || type.equals("W"))
				terms = " and flag='W' ";
			else if(type.equals("M"))
				terms = " and flag='M' ";
			
//					현재 달에서 iDate 만큼 이동한 달
			cal.add ( cal.MONTH, iDate );
			int iMonth = cal.get ( cal.MONTH ) + 1;
			int iYear =  cal.get ( cal.YEAR );
			
			GregorianCalendar today = new GregorianCalendar (iYear,iMonth-1,1 );
			//달의  날짜 수
			int maxday = today.getActualMaximum ( Calendar.DAY_OF_MONTH );
			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
			String query = 
			"select ifnull(sum(cnt),0), '"+toMMDD(maxday)+"' as dd   from contact_stat  where day like '"+toStr(iYear)+toMMDD(iMonth)+toMMDD(maxday)+"'"+terms;
			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로

			for(int i=maxday-1; i>0; i--)
			{
				query+=
				" union select ifnull(sum(cnt),0), '"+toMMDD(i)+"' as dd   from contact_stat  where day like '"+toStr(iYear)+toMMDD(iMonth)+toMMDD(i)+"' "+terms;
			}
			query+=" order by dd ";
			//System.err.println(query);
			return querymanager.selectEntities(query);
		
			}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}


	public String toStr(int num)
	{
		return Integer.toString(num);
	}

	public String toMMDD(int num)
	{
		if(num<10)
			return "0"+num;
		else
			return Integer.toString(num);
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

	/**
	 * 가상 방문 정보 읽기
	 */
	public Vector getStatVisitInfo() {
        String query = " SELECT * FROM stat_visit ORDER BY sv_total DESC LIMIT 0,1 ";
	    return querymanager.selectHashEntity(query);        
    }
    
    /**
	 * 가상 방문 정보 저장
	 */
	public void setStatVisitInfo() {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	    int nowDay = Integer.parseInt(sdf.format(new Date()));

	    Vector vt = this.getStatVisitInfo();

	    StatVisitInfoBean sviBean = new StatVisitInfoBean();

	    try {
    	    String query = "";
    	    if (vt == null || vt.size() < 1 ) {
    	        query = " INSERT INTO stat_visit (sv_total, sv_today, sv_yesterday, sv_day) VALUES ( "
    	                + sviBean.getSv_total()     + ", "
    	                + sviBean.getSv_today()     + ", "
    	                + sviBean.getSv_yesterday() + ", NOW()) ";

    	        querymanager.updateEntities(query);
    	    } else {
	            Enumeration e = vt.elements();
		        com.yundara.beans.BeanUtils.fill(sviBean, (Hashtable)e.nextElement());
		        int sv_day = Integer.parseInt(StringUtils.remove(sviBean.getSv_day(), "-"));
		       // int sv_today = RandomUtils.nextInt(5);
		        int sv_today = 1;
		        

		        if (nowDay > sv_day) {
		            query = " UPDATE stat_visit SET "
		                    + " sv_today = " + sv_today + ", "
		                    + " sv_yesterday = " + sviBean.getSv_today() + ", sv_day = NOW() ";
		        } else {
		            query = " UPDATE stat_visit SET "
		                    + " sv_total = sv_total + " + sv_today + ", "
		                    + " sv_today = sv_today + " + sv_today;
		        }
		        querymanager.updateEntities(query);
    		}
		} catch (Exception e) {
	        System.err.println(e.toString());
	    }
	}
	 /**
	 * 가상 방문 정보 저장
	 */
	public void setStatVisitInfo2() {
		Date date = new Date();

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String strDate = df.format(date);


	    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	    int nowDay = Integer.parseInt(sdf.format(new Date()));
	    //오늘 방문자 정보를 얻어온다.
	    Vector vt = this.getStatVisitInfoToday();

	    StatVisitInfoBean sviBean = new StatVisitInfoBean();

	    try {
    	    String query = "";
    	    //오늘의 정보를 읽어온다.
    	    if (vt == null || (vt != null && vt.size() < 1)) {
    	    	//오늘의 정보가 없어서 최근 정보를 얻어온다.
    	    	Vector vt2 = this.getStatVisitInfoNear();
    	    	if (vt2 == null || (vt2 != null && vt2.size() < 1)) {
    	    		//최근 정보가 존재하지 않으면 기본 값을 이용한다.
    	    		 query = " INSERT INTO stat_visit (sv_total, sv_today, sv_yesterday, sv_day) VALUES ( "
     	                + sviBean.getSv_total()     + ", "
     	                + 0     + ", "
     	                + sviBean.getSv_today() + ", NOW()) ";
    	    	}else{
    	    		//최근의 정보가 존재하면 정보를 바탕으로 값을 입력한다.
    	    		Enumeration e2 = vt2.elements();
    		        com.yundara.beans.BeanUtils.fill(sviBean, (Hashtable)e2.nextElement());
    		        if(strDate.equals(sviBean.getSv_day())){
    		        	//오늘의 정보가 읽어졌다., update를 수행한다
    		        	 int sv_today = 1;
    				        
    			            query = " UPDATE stat_visit SET sv_today =  sv_today + " + sv_today + ", sv_total = sv_total + " + sv_today + " where sv_day = '"+sviBean.getSv_day()+"'" ;
    				        //System.err.println("예외, 최근정보가 오늘 정보로 검색");
    		        }
    		        else{
    		        	//최근의 정보가 읽어졌다.
	    		        query = " INSERT INTO stat_visit (sv_total, sv_today, sv_yesterday, sv_day) VALUES ( "
	     	                + sviBean.getSv_total()     + ", "
	     	                + 0     + ", "
	     	                + sviBean.getSv_today() + ", NOW()) ";
	    		        //System.err.println("정상적으로 새로운 날짜 등록");
    		        }
    		       // System.err.println(query);
    	    	}
    	       

    	        querymanager.updateEntities(query);
    	    } else {
    	    	//오늘 정보를 읽어왔다.
	            Enumeration e = vt.elements();
		        com.yundara.beans.BeanUtils.fill(sviBean, (Hashtable)e.nextElement());
		        int sv_day = Integer.parseInt(StringUtils.remove(sviBean.getSv_day(), "-"));
		        //int sv_today = RandomUtils.nextInt(5);
		        int sv_today = 1;
		        //if(sv_today == 0){
		        //	sv_today= sv_today+1;
		        //}

	            query = " UPDATE stat_visit SET sv_today =  sv_today + " + sv_today + ", sv_total = sv_total + " + sv_today + " where sv_day = now()" ;
		        querymanager.updateEntities(query);
    		}
		} catch (Exception e) {
	        System.err.println("setStatVisitInfo2 ex : "+e.toString());
	    }
	}
	/**
	 * 오늘 가상 방문 정보 읽기
	 */
	public Vector getStatVisitInfoToday() {
        String query = " SELECT * FROM stat_visit where sv_day = NOW() ORDER BY sv_total DESC LIMIT 0,1 ";
	    return querymanager.selectHashEntity(query);        
    }
	
	/**
	 * 어제 가상 방문 정보 읽기
	 */
	public Vector getStatVisitInfoYester() {
        String query = " SELECT * FROM stat_visit where sv_day = DATE_ADD(now(),INTERVAL-1 DAY) ORDER BY sv_total DESC LIMIT 0,1 ";
	    return querymanager.selectHashEntity(query);        
    }

	/**
	 * 최근 가상 방문 정보 읽기
	 */
	public Vector getStatVisitInfoNear() {
		String query = "";
		query = " SELECT * FROM stat_visit  ORDER BY sv_day DESC LIMIT 0,1 ";
	
        
	    return querymanager.selectHashEntity(query);        
    }
	/*****************************************************
	가상의 최근 7일간 일일별 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>       : 이희락	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntities
	******************************************************/
	public Vector getDayStatTemp()
	{
		try{
			String query = null;
			cal.add(Calendar.DATE,-6);
			query=
			"select sum(sv_today), '"+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
			"  from stat_visit "+
			" where sv_day like '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+toMMDD(cal.get(Calendar.DATE))+"'";
			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
			for(int i=-5; i<=0; i++)
			{
				cal.add(Calendar.DATE,i);
				query+=
				" union select sum(sv_today), '"+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
				"  from stat_visit "+
				" where sv_day like '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+toMMDD(cal.get(Calendar.DATE))+"' ";
				cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
			}
			query+=" order by dd ";
			//System.err.println(query);
			return querymanager.selectEntities(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}
	
	/*****************************************************
	가상정보의 최근 7일간 일일별 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>       : 이희락 	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntities
	******************************************************/
	public Vector getDayStatTemp(int iDate)
	{
		try{
			String query = null;
			cal.add(Calendar.DATE,iDate+1);
			query=
			"select sum(sv_today), '"+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
			"  from stat_visit "+
			" where sv_day like '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"-"+toMMDD(cal.get(Calendar.DATE))+"'";
			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
			for(int i=iDate+2; i<=iDate+7; i++)
			{
				cal.add(Calendar.DATE,i);
				query+=
				" union select sum(sv_today), '"+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
				"  from stat_visit "+
				" where sv_day like '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"-"+toMMDD(cal.get(Calendar.DATE))+"' ";
				cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
			}
			query+=" order by dd ";
			//System.err.println(query);
			return querymanager.selectEntities(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}

 

	public Vector getDayStatTemp2(int iDate)
	{
		try{
			String query = null;
			cal.add(Calendar.DATE,iDate+1);
			query=
			"select ifnull(sum(cnt),0),  '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd   from contact_stat  where  day like '"+toMMDD(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+toMMDD(cal.get(Calendar.DATE))+"' " ;
	
			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
			for(int i=iDate+2; i<=iDate+7; i++)
			{
				cal.add(Calendar.DATE,i);
				query+=
				" union select ifnull(sum(cnt),0), '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
				"  from contact_stat "+
				" where day like '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+toMMDD(cal.get(Calendar.DATE))+"' ";
				cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
			}
			query+=" order by dd ";
	//		System.err.println(query);
			return querymanager.selectEntities(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}


	
	public String getDateStrTemp()
	{
		String date_str=toStr(YEAR);
		date_str += "-";
		if(MONTH>9)
			date_str +=toStr(MONTH);
		else
			date_str +="0"+toStr(MONTH);
		date_str += "-";
		if(DAY>9)
			date_str +=toStr(DAY);
		else
			date_str +="0"+toStr(DAY);
		return date_str;
	}
	
	/*****************************************************
	가상의 모든 접속관련 통계를 넘겨줍니다.<p>

	<b>작성자</b>       : 이희락	<br>
	<b>관련 JSP</b>	:
	@return 오늘접속자/이달접속자/전체접속자/오늘카운트/이달카운트/전체카운트 가져오기
	@see QueryManager#selectEntities
	******************************************************/
	public Vector getAllCountTemp()
	{
		try{
			String query=
			 
			"select sv_today,'1' as no from stat_visit where sv_day='"+getDateStrTemp()+"' "+
			"union select sum(sv_today),'2' as no from stat_visit where sv_day like '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"%' "+
			"union select sum(sv_today),'3' as no from stat_visit "+
			"order by no";
	        //System.err.println(query);
			return querymanager.selectEntities(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}
	/*****************************************************
	가상정보 지난 1년간 월별 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>       : 이희락	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntities
	******************************************************/
	public Vector getMonthStatTemp(int iData)
	{
		try{
	//		현재 달에서 iDate 만큼 이동한 달
			cal.add ( cal.YEAR, iData );
			//int iMonth = cal.get ( cal.MONTH ) + 1;
			int iYear =  cal.get ( cal.YEAR );
			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
			String query = null;
			query=
			"select sum(sv_today),'"+toMMDD(12)+"' as mm from stat_visit "+
			" where sv_day like '"+toStr(iYear)+"-"+toMMDD(12)+"%' ";
			for(int i=10; i>=0; i--)
			{
				query+=
				" union select sum(sv_today) ,'"+toMMDD(i+1)+"' as mm from stat_visit "+
				" where sv_day like '"+toStr(iYear)+"-"+toMMDD(i+1)+"%'";
			}
			query+=" order by mm ";
	//		System.err.println(query);
			return querymanager.selectEntities(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}

	///////////////
	// 주현 작업
	// 2008-08-04
	//////////////

	public Vector getMonthStatTemp2(int iData)
	{
		try{
	//		현재 달에서 iDate 만큼 이동한 달
			cal.add ( cal.YEAR, iData );
			//int iMonth = cal.get ( cal.MONTH ) + 1;
			int iYear =  cal.get ( cal.YEAR );
			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
			String query = null;
			query=
			"select ifnull(sum(cnt),0),'"+toMMDD(12)+"' as mm from contact_stat  where day like '"+toStr(iYear)+toMMDD(12)+"%' ";
			for(int i=10; i>=0; i--)
			{
				query+=
				"union select ifnull(sum(cnt),0) ,'"+toMMDD(i+1)+"' as mm from contact_stat  where day like '"+toStr(iYear)+toMMDD(i+1)+"%'";
			}
			query+=" order by mm ";
	//		System.err.println(query);
			return querymanager.selectEntities(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}

	/*****************************************************
	가상정보 월 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>       : 이희락	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntities
	******************************************************/
	public Vector getDateStatTemp(int iDate)
	{
		try{
	//		현재 달에서 iDate 만큼 이동한 달
			cal.add ( cal.MONTH, iDate );
			int iMonth = cal.get ( cal.MONTH ) + 1;
			int iYear =  cal.get ( cal.YEAR );
			
			GregorianCalendar today = new GregorianCalendar (iYear,iMonth-1,1 );
			//달의  날짜 수
			int maxday = today.getActualMaximum ( Calendar.DAY_OF_MONTH );
			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
			String query = null;
			//cal.add(Calendar.DATE,(maxday));
			//cal.add(Calendar.MONTH,iDate);
			query=
			"select sum(sv_today), '"+toMMDD(maxday)+"' as dd "+
			"  from stat_visit "+
			" where sv_day like '"+toStr(iYear)+"-"+toMMDD(iMonth)+"-"+toMMDD(maxday)+"'";
			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
			for(int i=maxday-1; i>0; i--)
			{
				//cal.add(Calendar.DATE,i);
				query+=
				" union select sum(sv_today), '"+toMMDD(i)+"' as dd "+
				"  from stat_visit "+
				" where sv_day like '"+toStr(iYear)+"-"+toMMDD(iMonth)+"-"+toMMDD(i)+"' ";
				//cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
			}
			query+=" order by dd ";
			//System.err.println(query);
			return querymanager.selectEntities(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}

////////////
// 주현 작업
// 2008-08-04
/////////////
	public Vector getDateStatTemp2(int iDate)
	{
		try{
	//		현재 달에서 iDate 만큼 이동한 달
			cal.add ( cal.MONTH, iDate );
			int iMonth = cal.get ( cal.MONTH ) + 1;
			int iYear =  cal.get ( cal.YEAR );
			
			GregorianCalendar today = new GregorianCalendar (iYear,iMonth-1,1 );
			//달의  날짜 수
			int maxday = today.getActualMaximum ( Calendar.DAY_OF_MONTH );
			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
			String query = null;
			query=
			"select ifnull(sum(cnt),0), '"+toMMDD(maxday)+"' as dd   from contact_stat  where day like '"+toStr(iYear)+toMMDD(iMonth)+toMMDD(maxday)+"'";
			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
			for(int i=maxday-1; i>0; i--)
			{
				query+=
				" union select ifnull(sum(cnt),0), '"+toMMDD(i)+"' as dd   from contact_stat  where day like '"+toStr(iYear)+toMMDD(iMonth)+toMMDD(i)+"' ";
			}
			query+=" order by dd ";
	//		System.err.println(query);
			return querymanager.selectEntities(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}


		/*****************************************************
	 일일별 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>   : 주현	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntities
	******************************************************/
	public int getMonthStatDay(String day)
	{
		day = com.vodcaster.utils.TextUtil.getValue(day);
		int count = 0;
		if (day != null && day.length() > 0)
		{
			try{
			Vector v2 = querymanager.selectEntity("select cnt from contact_stat where day ='"+day+"' ");
			//System.err.println("select cnt from contact_stat where day ='"+day+"' ");
			if (v2 != null && v2.size() > 0) {
				count = Integer.parseInt(String.valueOf(v2.elementAt(0)));
			}
			}catch (Exception e){
				System.out.println(e);
				return 0; 
			}
		}

		return count;
	}


	/*****************************************************
	 월 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>   : 주현	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntities
	******************************************************/


	public String getStatMonthS(String day)
	{
		String count ="";

		if (day != null && day.length() > 5)
		{
			 try{
				Vector v2 = querymanager.selectEntity("select ifnull(sum(cnt),0) from contact_stat where day like '"+day.substring(0,6)+"%' ");
	
	//			System.err.println("select sum(cnt) from contact_stat where day like '"+day.substring(0,6)+"%' ");
				if (v2 != null && v2.size() > 0) {
					count = String.valueOf(v2.elementAt(0));
				}
			 }catch (Exception e){
					System.out.println(e);
					return ""; 
			}
		}
		

		return count;
	}
	
	

	public String getStatMonthS(String day, String type)
	{
		String count ="";
		day = com.vodcaster.utils.TextUtil.getValue(day);
		type = com.vodcaster.utils.TextUtil.getValue(type);
		
		String terms = "";
		if(type.equals("") || type.equals("W"))
			terms = " and flag='W' ";
		else if(type.equals("M"))
			terms = " and flag='M' ";
		
		if (day != null && day.length() > 5)
		{
			 try{
				Vector v2 = querymanager.selectEntity("select ifnull(sum(cnt),0) from contact_ip  where day like '"+day.substring(0,6)+"%' "+terms);
				 
	//			System.err.println("select sum(cnt) from contact_stat where day like '"+day.substring(0,6)+"%' ");
				if (v2 != null && v2.size() > 0) {
					count = String.valueOf(v2.elementAt(0));
				}
			 }catch (Exception e){
					System.out.println(e);
					return ""; 
			}
		}
		

		return count;
	}

	/*****************************************************
	 일 접속회수를 넘겨줍니다.<p>

	<b>작성자</b>   : 주현	<br>
	<b>관련 JSP</b>	:
	@see QueryManager#selectEntities
	******************************************************/


	public Vector getStatDayS(String day)
	{
		day = com.vodcaster.utils.TextUtil.getValue(day);
			String query =
			"select ifnull(sum(cnt),0), 'total' as hour from contact_ip where day ='"+day+"' "+
			"union select ifnull(sum(cnt),0), '0' as hour from contact_ip where day ='"+day+"' and hour in (0) "+
			"union select ifnull(sum(cnt),0), '1' as hour from contact_ip where day ='"+day+"' and hour in (1) "+
			"union select ifnull(sum(cnt),0), '2' as hour from contact_ip where day ='"+day+"' and hour in (2) "+
			"union select ifnull(sum(cnt),0), '3' as hour from contact_ip where day ='"+day+"' and hour in (3) "+
			"union select ifnull(sum(cnt),0), '4' as hour from contact_ip where day ='"+day+"' and hour in (4) "+
			"union select ifnull(sum(cnt),0), '5' as hour from contact_ip where day ='"+day+"' and hour in (5) "+
			"union select ifnull(sum(cnt),0), '6' as hour from contact_ip where day ='"+day+"' and hour in (6) "+
			"union select ifnull(sum(cnt),0), '7' as hour from contact_ip where day ='"+day+"' and hour in (7) "+
			"union select ifnull(sum(cnt),0), '8' as hour from contact_ip where day ='"+day+"' and hour in (8) "+
			"union select ifnull(sum(cnt),0), '9' as hour from contact_ip where day ='"+day+"' and hour in (9) "+
			"union select ifnull(sum(cnt),0), '10' as hour from contact_ip where day ='"+day+"' and hour in (10) "+
			"union select ifnull(sum(cnt),0), '11' as hour from contact_ip where day ='"+day+"' and hour in (11) "+
			"union select ifnull(sum(cnt),0), '12' as hour from contact_ip where day ='"+day+"' and hour in (12) "+
			"union select ifnull(sum(cnt),0), '13' as hour from contact_ip where day ='"+day+"' and hour in (13) "+
			"union select ifnull(sum(cnt),0), '14' as hour from contact_ip where day ='"+day+"' and hour in (14) "+
			"union select ifnull(sum(cnt),0), '15' as hour from contact_ip where day ='"+day+"' and hour in (15) "+
			"union select ifnull(sum(cnt),0), '16' as hour from contact_ip where day ='"+day+"' and hour in (16) "+
			"union select ifnull(sum(cnt),0), '17' as hour from contact_ip where day ='"+day+"' and hour in (17) "+
			"union select ifnull(sum(cnt),0), '18' as hour from contact_ip where day ='"+day+"' and hour in (18) "+
			"union select ifnull(sum(cnt),0), '19' as hour from contact_ip where day ='"+day+"' and hour in (19) "+
			"union select ifnull(sum(cnt),0), '20' as hour from contact_ip where day ='"+day+"' and hour in (20) "+
			"union select ifnull(sum(cnt),0), '21' as hour from contact_ip where day ='"+day+"' and hour in (21) "+
			"union select ifnull(sum(cnt),0), '22' as hour from contact_ip where day ='"+day+"' and hour in (22) "+
			"union select ifnull(sum(cnt),0), '23' as hour from contact_ip where day ='"+day+"' and hour in (23) "+
			" ";

//System.err.println(query);
			return querymanager.selectEntities(query);
		
	}
	
	
	public Vector getStatDayS(String day, String type)
	{
		day = com.vodcaster.utils.TextUtil.getValue(day);
type = com.vodcaster.utils.TextUtil.getValue(type);
		
		String terms = "";
		if(type.equals("") || type.equals("W"))
			terms = " and flag='W' ";
		else if(type.equals("M"))
			terms = " and flag='M' ";
		
			String query =
			"select ifnull(sum(cnt),0), 'total' as hour from contact_ip where day ='"+day+"' "+terms+
			"union select ifnull(sum(cnt),0), '0' as hour from contact_ip where day ='"+day+"' and hour in (0) "+terms+
			"union select ifnull(sum(cnt),0), '1' as hour from contact_ip where day ='"+day+"' and hour in (1) "+terms+
			"union select ifnull(sum(cnt),0), '2' as hour from contact_ip where day ='"+day+"' and hour in (2) "+terms+
			"union select ifnull(sum(cnt),0), '3' as hour from contact_ip where day ='"+day+"' and hour in (3) "+terms+
			"union select ifnull(sum(cnt),0), '4' as hour from contact_ip where day ='"+day+"' and hour in (4) "+terms+
			"union select ifnull(sum(cnt),0), '5' as hour from contact_ip where day ='"+day+"' and hour in (5) "+terms+
			"union select ifnull(sum(cnt),0), '6' as hour from contact_ip where day ='"+day+"' and hour in (6) "+terms+
			"union select ifnull(sum(cnt),0), '7' as hour from contact_ip where day ='"+day+"' and hour in (7) "+terms+
			"union select ifnull(sum(cnt),0), '8' as hour from contact_ip where day ='"+day+"' and hour in (8) "+terms+
			"union select ifnull(sum(cnt),0), '9' as hour from contact_ip where day ='"+day+"' and hour in (9) "+terms+
			"union select ifnull(sum(cnt),0), '10' as hour from contact_ip where day ='"+day+"' and hour in (10) "+terms+
			"union select ifnull(sum(cnt),0), '11' as hour from contact_ip where day ='"+day+"' and hour in (11) "+terms+
			"union select ifnull(sum(cnt),0), '12' as hour from contact_ip where day ='"+day+"' and hour in (12) "+terms+
			"union select ifnull(sum(cnt),0), '13' as hour from contact_ip where day ='"+day+"' and hour in (13) "+terms+
			"union select ifnull(sum(cnt),0), '14' as hour from contact_ip where day ='"+day+"' and hour in (14) "+terms+
			"union select ifnull(sum(cnt),0), '15' as hour from contact_ip where day ='"+day+"' and hour in (15) "+terms+
			"union select ifnull(sum(cnt),0), '16' as hour from contact_ip where day ='"+day+"' and hour in (16) "+terms+
			"union select ifnull(sum(cnt),0), '17' as hour from contact_ip where day ='"+day+"' and hour in (17) "+terms+
			"union select ifnull(sum(cnt),0), '18' as hour from contact_ip where day ='"+day+"' and hour in (18) "+terms+
			"union select ifnull(sum(cnt),0), '19' as hour from contact_ip where day ='"+day+"' and hour in (19) "+terms+
			"union select ifnull(sum(cnt),0), '20' as hour from contact_ip where day ='"+day+"' and hour in (20) "+terms+
			"union select ifnull(sum(cnt),0), '21' as hour from contact_ip where day ='"+day+"' and hour in (21) "+terms+
			"union select ifnull(sum(cnt),0), '22' as hour from contact_ip where day ='"+day+"' and hour in (22) "+terms+
			"union select ifnull(sum(cnt),0), '23' as hour from contact_ip where day ='"+day+"' and hour in (23) "+terms+
			" ";

//System.err.println(query);
			return querymanager.selectEntities(query);
		
	}
	
	// 동영상 hit 건수 구하기
	// 주현
	// vod_log 에서 일자별 시청 건수를 구한다.
	//@return 오늘접속자/이달접속자/전체접속자/
	public Vector getAllCount_hit()
	{
		try{
			String query=
			"select ifnull(count(no),0),'1' as no from vod_log where DATE_FORMAT(regDate,'%Y-%m-%d') like '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"-"+toMMDD(cal.get(Calendar.DATE))+"%' "+
			"union select ifnull(count(no),0),'2' as no from vod_log where DATE_FORMAT(regDate,'%Y-%m-%d') like '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"%' "+
			"union select ifnull(count(no),0),'3' as no from vod_log where DATE_FORMAT(regDate,'%Y-%m-%d') like '"+toStr(cal.get(Calendar.YEAR))+"%' "+
			"union select ifnull(count(no),0),'4' as no from vod_log " +
			"order by no"; 
	//System.out.println(query);
			return querymanager.selectEntities(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		}
	}
	
	//주현
	// 일자별 영상 시청 건수, vod_log : count(no)
	public Vector getDayStatTemp_hit(int iDate)
	{
		try{
			String query = null;
			cal.add(Calendar.DATE,iDate+1);
			query=
			"select ifnull(count(no),0), '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
			"  from vod_log "+
			" where DATE_FORMAT(regDate,'%Y-%m-%d') like '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"-"+toMMDD(cal.get(Calendar.DATE))+"%'";
			cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
			for(int i=iDate+2; i<=iDate+7; i++)
			{
				cal.add(Calendar.DATE,i);
				query+=
				" union select count(no), '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
				"  from vod_log "+
				" where DATE_FORMAT(regDate,'%Y-%m-%d') like '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"-"+toMMDD(cal.get(Calendar.DATE))+"%' ";
				cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
			}
			query+=" order by dd ";
	//		System.out.println(query);
			return querymanager.selectEntities(query);
		}catch (Exception e){
			System.out.println(e);
			return null; 
		} 

	}
	
	// 주현 작업	
	// 연간 시청 건수 통계 (vod_log: count(ip)
		
		public Vector getYearStatTemp_hit(int iDate)
		{
			try{
				cal.add ( cal.YEAR, iDate );
				//int iMonth = cal.get ( cal.MONTH ) + 1;
				int iYear =  cal.get ( cal.YEAR );
				
				cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
				
				
				String query = null;
				query=
				" select substring(DATE_FORMAT(regDate,'%Y-%m-%d'),6,2), count(*) from vod_log where LEFT(DATE_FORMAT(regDate,'%Y-%m-%d'),4)='"+toStr(iYear)+"' group by substring(DATE_FORMAT(regDate,'%Y-%m-%d'),6,2) order by regDate ";
	
	//			System.err.println(query);
				return querymanager.selectEntities(query);
			}catch (Exception e){
				System.out.println(e);
				return null; 
			}
		}	 
		

		// 주현 작업
		// 월별 동영상 시청 건수 vod_log : count(no)
				
				public Vector getDateStatTemp_hit(int iDate)
				{
					try{
	//					현재 달에서 iDate 만큼 이동한 달
						cal.add ( cal.MONTH, iDate );
						int iMonth = cal.get ( cal.MONTH ) + 1;
						int iYear =  cal.get ( cal.YEAR );
						
						GregorianCalendar today = new GregorianCalendar (iYear,iMonth-1,1 );
						//달의  날짜 수
						int maxday = today.getActualMaximum ( Calendar.DAY_OF_MONTH );
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	//					
						String query = null;
						//query=" select substring(regDate,9,2) from vod_log where substring(regDate,1,7)='"+toStr(iYear)+"-"+toMMDD(iMonth)+"' order by regDate ";
						query=" select  RIGHT(DATE_FORMAT(regDate,'%Y-%m-%d'),2), count(*)  from vod_log where substring(regDate,1,7)='"+toStr(iYear)+"-"+toMMDD(iMonth)+"' group by RIGHT(DATE_FORMAT(regDate,'%Y-%m-%d'),2) order by regDate ";
	
	//					System.err.println(query); 
						return querymanager.selectEntities(query);
						//return querymanager.selectHashEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				
				
				
				/**
				 * 20110720
				 * 오늘, 이달, 올해, 총합 시청로그 카운트
				 * @param type	V-VOD, L-LIVE, M-MOBILE
				 * @return
				 */
				public Vector getAllCount_hit(String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
						String table = "";
						String terms = "";
						if(type.equals("") || type.equals("V")){
							table = " vod_log ";
							terms = " oflag='V' ";
						}
						else if(type.equals("R")){
							table = " live_log ";
							terms = " oflag='R' ";
						}
						else if(type.equals("H")){
							table = " vod_log ";
							terms = " oflag='H' ";
						}else if(type.equals("L")){
							table = " live_log ";
							terms = " oflag='L' ";
						}
	
						String query=
							" select ifnull(count(no),0),'1' as no from "+table+" where regDate like '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"-"+toMMDD(cal.get(Calendar.DATE))+"%' and "+terms+" "+
							" union select ifnull(count(no),0),'2' as no from "+table+" where regDate like '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"%' and "+terms+" "+
							" union select ifnull(count(no),0),'3' as no from "+table+" where regDate like '"+toStr(cal.get(Calendar.YEAR))+"%' and "+terms+" "+
							" union select ifnull(count(no),0),'4' as no from  "+table+" where "+terms+" "+
							" order by no"; 
						
						//System.out.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				
				public Vector getAllCount_counter(String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
					 
						String terms = "";
						if(type != null && type.length() > 0 ){ 
							terms = " and countFlag='"+type+"' ";
						} 
	
						String query=
							" select ifnull(sum(counter),0),'1' as no from counter where countYField = '"+toStr(cal.get(Calendar.YEAR))+"' and countMField = '"+toMMDD(cal.get(Calendar.MONTH)+1)+"' and countDField='"+toMMDD(cal.get(Calendar.DATE))+"'  and gubunCtn='4' "+terms+" "+
							" union select ifnull(sum(counter),0),'2' as no from counter where countYField = '"+toStr(cal.get(Calendar.YEAR))+"' and countMField='"+toMMDD(cal.get(Calendar.MONTH)+1)+"' and gubunCtn='4' "+terms+" "+
							" union select ifnull(sum(counter),0),'3' as no from counter where countYField = '"+toStr(cal.get(Calendar.YEAR))+"' and gubunCtn='4' "+terms+" "+
							" union select ifnull(sum(counter),0),'4' as no from counter where gubunCtn='4' "+terms+" "+
 
							" order by no"; 
						
						//System.out.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				
				public Vector getPageCount_hit(String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
					 
						String terms = "";
						if(type.equals("") || type.equals("W")){
					 
							terms = "and flag='W' ";
						}
						else if(type.equals("M")){
					 
							terms = "and flag='M' ";
						}
						 
 						String query=
								
							" select ifnull(sum(cnt),0),'1' as no from page_cnn_cnt where day is not null and day like '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"-"+toMMDD(cal.get(Calendar.DATE))+"%' "+terms+" "+
							" union select ifnull(sum(cnt),0),'2' as no from page_cnn_cnt where day is not null and day like '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"%' "+terms+" "+
							" union select ifnull(sum(cnt),0),'3' as no from page_cnn_cnt where day is not null and day like '"+toStr(cal.get(Calendar.YEAR))+"%' "+terms+" "+
							" union select ifnull(sum(cnt),0),'4' as no from  page_cnn_cnt where day is not null "+terms+" "+
							" order by no"; 
						
						//System.out.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				/**
				 * 20110720
				 * 주 시청통계
				 * @param iDate
				 * @param type
				 * @return
				 */
				public Vector getWeekStatTemp_hit(int iDate, String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
						String table = "";
						String terms = "";
						if(type.equals("") || type.equals("V")){
							table = "vod_log";
							terms = " and oflag='V' ";
						}
						else if(type.equals("R")){
							table = "live_log";
							terms = " and oflag='R' ";
						}
						else if(type.equals("H")){
							table = "vod_log";
							terms = " and oflag='H' ";
						}else if(type.equals("L")){
							table = "live_log";
							terms = " and oflag='L' ";
						}
						
						String query = null;
						cal.add(Calendar.DATE,iDate+1);
						query=
						"select ifnull(count(no),0), '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
						"  from  "+table + 
						" where regDate like '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"-"+toMMDD(cal.get(Calendar.DATE))+"%' "+terms;
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
						for(int i=iDate+2; i<=iDate+7; i++)
						{
							cal.add(Calendar.DATE,i);
							query+=
							" union select ifnull(count(no),0), '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
							"  from  "+ table + 
							" where regDate like '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"-"+toMMDD(cal.get(Calendar.DATE))+"%' "+terms;
							cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
						}
						query+=" order by dd ";
						
						//System.out.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				
				public Vector getWeekStatTemp_count(int iDate, String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
					 
						String terms = "";
						if(type.equals("") || type.equals("W")){
						 
							terms = " and flag='W' ";
						}
						else if(type.equals("M")){
							 
							terms = " and flag='M' ";
						}
					  
						String query = null;
						cal.add(Calendar.DATE,iDate+1);
						query=
						"select ifnull(SUM(cnt),0), '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
						"  from page_cnn_cnt "+ 
						" where day = '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"-"+toMMDD(cal.get(Calendar.DATE))+"' "+terms;
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
						for(int i=iDate+2; i<=iDate+7; i++)
						{
							cal.add(Calendar.DATE,i);
							query+=
							" union select ifnull(SUM(cnt),0), '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
									"  from page_cnn_cnt "+ 
							" where day = '"+toStr(cal.get(Calendar.YEAR))+"-"+toMMDD(cal.get(Calendar.MONTH)+1)+"-"+toMMDD(cal.get(Calendar.DATE))+"' "+terms;
							cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
						}
						query+=" order by dd ";
						
					//	System.out.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				
				public Vector getWeekStat_count(int iDate, String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
					 
						String terms = "";
						if(type != null && type.length() > 0){
						 
							terms = " and countFlag='"+type+"' ";
						} 
					  
						String query = null;
						cal.add(Calendar.DATE,iDate+1);
						query=
						"select ifnull(SUM(counter),0), '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
						" from counter "+ 
						" where countYField = '"+toStr(cal.get(Calendar.YEAR))+"' and countMField ='"+toMMDD(cal.get(Calendar.MONTH)+1)+"' and countDField = '"+toMMDD(cal.get(Calendar.DATE))+"' and gubunCtn='4' "+terms;
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
						for(int i=iDate+2; i<=iDate+7; i++)
						{
							cal.add(Calendar.DATE,i);
							query+=
							" union select ifnull(SUM(counter),0), '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd "+
							" from counter "+ 
							" where countYField = '"+toStr(cal.get(Calendar.YEAR))+"' and countMField ='"+toMMDD(cal.get(Calendar.MONTH)+1)+"' and countDField = '"+toMMDD(cal.get(Calendar.DATE))+"' and gubunCtn='4' "+terms;
							cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
						}
						query+=" order by dd ";
						
					//	System.out.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				

				/**
				 * 20110720
				 * 월 시청통계
				 * @param iDate
				 * @param type
				 * @return
				 */
				public Vector getMonthStatTemp_hit(int iDate, String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
						String table = "";
						String terms = "";
						if(type.equals("") || type.equals("V")){
							table = "vod_log";
							terms = " and oflag='V' ";
						}
						else if(type.equals("R")){
							table = "live_log";
							terms = " and oflag='R' ";
						}
						else if(type.equals("H")){
							table = "vod_log";
							terms = " and oflag='H' ";
						}else if(type.equals("L")){
							table = "live_log";
							terms = " and oflag='L' ";
						}
						
	//							현재 달에서 iDate 만큼 이동한 달
						cal.add ( cal.MONTH, iDate );
						int iMonth = cal.get ( cal.MONTH ) + 1;
						int iYear =  cal.get ( cal.YEAR );
						
						GregorianCalendar today = new GregorianCalendar (iYear,iMonth-1,1 );
						//달의  날짜 수
						int maxday = today.getActualMaximum ( Calendar.DAY_OF_MONTH );
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
						String query = null;
						query=	" select regDate,count(*) from "+table+"  where substring(regDate,1,7)='"+toStr(iYear)+"-"+toMMDD(iMonth)+"' "+terms+" group by substring(regDate,9,2) order by regDate ";
	
						//System.err.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				public Vector getMonthStatCount(int iDate, String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
				 
						String terms = "";
						if(type != null && type.length()  >0){
				 
							terms = " and countFlag='"+type+"' ";
						} 
						
	//							현재 달에서 iDate 만큼 이동한 달
						cal.add ( cal.MONTH, iDate );
						int iMonth = cal.get ( cal.MONTH ) + 1;
						int iYear =  cal.get ( cal.YEAR );
						
						GregorianCalendar today = new GregorianCalendar (iYear,iMonth-1,1 );
						//달의  날짜 수
						int maxday = today.getActualMaximum ( Calendar.DAY_OF_MONTH );
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
						
						String query = 
						 
						"select IFNULL(SUM(counter),0), '"+toMMDD(maxday)+"' as dd   from counter  where countYField='"+toStr(iYear)+"' and countMField='"+toMMDD(iMonth)+"' and countDField='"+toMMDD(maxday)+"' and gubunCtn='4' "+terms ;
						
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
						for(int i=maxday-1; i>0; i--)
						{
							query+=
							" union select ifnull(sum(counter),0), '"+toMMDD(i)+"' as dd   from counter  where countYField='"+toStr(iYear)+"' and countMField='"+toMMDD(iMonth)+"' and countDField='"+toMMDD(i)+"' and gubunCtn='4' "+terms;
						}
						query+=" order by dd "; 
					 
						//System.err.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				public Vector getMonthStatTemp_Count(int iDate, String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
					 
						String terms = "";
						if(type.equals("") || type.equals("W")){
						 
							terms = " and flag='W' ";
						}
						else if(type.equals("M")){
							 
							terms = " and flag='M' ";
						}
						 
	//							현재 달에서 iDate 만큼 이동한 달
						cal.add ( cal.MONTH, iDate );
						int iMonth = cal.get ( cal.MONTH ) + 1;
						int iYear =  cal.get ( cal.YEAR );
						
						GregorianCalendar today = new GregorianCalendar (iYear,iMonth-1,1 );
						//달의  날짜 수
						int maxday = today.getActualMaximum ( Calendar.DAY_OF_MONTH );
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
						String query = null;
						query=	" select day,cnt from page_cnn_cnt where substring(day,1,7)='"+toStr(iYear)+"-"+toMMDD(iMonth)+"' "+terms+" group by substring(day,9,2) order by day ";
	
						//System.err.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				/**
				 * 20110720
				 * 년 시청통계
				 * @param iDate
				 * @param type
				 * @return
				 */
				public Vector getYearStatTemp_hit(int iDate, String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
						cal.add ( cal.YEAR, iDate );
						int iYear =  cal.get ( cal.YEAR );
						
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
						
						String table = "";
						String terms = "";
						if(type.equals("") || type.equals("V")){
							table = "vod_log";
							terms = " and oflag='V' ";
						}
						else if(type.equals("R")){
							table = "live_log";
							terms = " and oflag='R' ";
						}
						else if(type.equals("H")){
							table = "vod_log";
							terms = " and oflag='H' ";
						}else if(type.equals("L")){
							table = "live_log";
							terms = " and oflag='L' ";
						}
						
						String query = " select regDate,count(*)   from " +table+ " where substring(regDate,1,4)='"+toStr(iYear)+"' "+terms+" group by substring(regDate,6,2) order by regDate ";
	
						//System.err.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				public Vector getYearStatCount(int iDate, String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					String terms = "";
					if(type != null && type.length() > 0){ 
						terms = " and countFlag='"+type+"' ";
					} 
					
					
					try{
						cal.add ( cal.YEAR, iDate );
						int iYear =  cal.get ( cal.YEAR );
						
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로 
						String query = 
						"select IFNULL(SUM(counter),0) ,'"+toMMDD(12)+"' as mm from counter  where countYField='"+toStr(iYear)+"' and countMField='12' and gubunCtn='4' "+terms;
						for(int i=10; i>=0; i--)
						{
							query+=
							" union select IFNULL(SUM(counter),0)  ,'"+toMMDD(i+1)+"' as mm from counter  where countYField='"+toStr(iYear)+"' and countMField='"+toMMDD(i+1)+"' and gubunCtn='4' "+terms;
						}
						query+=" order by mm ";
		
						//System.err.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				
				public Vector getYearStatTemp_Count(int iDate, String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
						cal.add ( cal.YEAR, iDate );
						int iYear =  cal.get ( cal.YEAR );
						
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
						String terms = "";
						if(type.equals("") || type.equals("W")){
						 
							terms = " and flag='W' ";
						}
						else if(type.equals("M")){
			 
							terms = " and flag='M' ";
						}
					 
						
						String query = " select day,sum(cnt) from page_cnn_cnt where substring(day,1,4)='"+toStr(iYear)+"' "+terms+" group by substring(day,6,2) order by day ";
	
						//System.err.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				
				
				/**
				 * 20110720
				 * 접속자 카운트 종합
				 * @param type
				 * @return
				 */
				public Vector getAllCount(String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
						String terms = "";
						if(type.equals("") || type.equals("W"))
							terms = " flag='W' ";
						else if(type.equals("M"))
							terms = " flag='M' ";
						
						String query=
						"select ifnull(sum(cnt),0),'1' as no from contact_ip where day='"+getDateStr()+"' and "+terms+
						"union select  ifnull(sum(cnt),0),'2' as no from contact_ip where day like '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+"%' and "+terms+
						"union select  ifnull(sum(cnt),0),'3' as no from contact_ip where " +terms+
						"order by no";
						
						//System.err.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				
				/**
				 * 20110720
				 * 주간 접속 현황
				 * @param iDate
				 * @param type
				 * @return
				 */
				public Vector getWeekState(int iDate, String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
						String terms = "";
						if(type.equals("") || type.equals("W"))
							terms = " and flag='W' ";
						else if(type.equals("M"))
							terms = " and flag='M' ";
						
						String query = null;
						cal.add(Calendar.DATE,iDate+1);
						query=
						"select ifnull(sum(cnt),0),  '"+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd , (@a := 1) as aa "+
						" from contact_ip  where  day like '"+toMMDD(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+toMMDD(cal.get(Calendar.DATE))+"' "+terms;
	
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
						for(int i=iDate+2; i<=iDate+7; i++)
						{
							cal.add(Calendar.DATE,i);
							query+=
							" union select ifnull(sum(cnt),0), '"+toMMDD(cal.get(Calendar.MONTH)+1)+"/"+toMMDD(cal.get(Calendar.DATE))+"' as dd , (@a := @a+1) as aa "+
							"  from contact_ip "+
							" where day like '"+toStr(cal.get(Calendar.YEAR))+toMMDD(cal.get(Calendar.MONTH)+1)+toMMDD(cal.get(Calendar.DATE))+"' "+terms;
							cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
						}
						query+=" order by aa ";
						
						//System.err.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				
				/**
				 * 20110720
				 * 월간 접속 현황
				 * @param iDate
				 * @param type
				 * @return
				 */
				public Vector getMonthState(int iDate, String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
						String terms = "";
						if(type.equals("") || type.equals("W"))
							terms = " and flag='W' ";
						else if(type.equals("M"))
							terms = " and flag='M' ";
						
	//					현재 달에서 iDate 만큼 이동한 달
						cal.add ( cal.MONTH, iDate );
						int iMonth = cal.get ( cal.MONTH ) + 1;
						int iYear =  cal.get ( cal.YEAR );
						
						GregorianCalendar today = new GregorianCalendar (iYear,iMonth-1,1 );
						//달의  날짜 수
						int maxday = today.getActualMaximum ( Calendar.DAY_OF_MONTH );
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
						String query = 
						"select ifnull(sum(cnt),0), '"+toMMDD(maxday)+"' as dd   from contact_ip  where day like '"+toStr(iYear)+toMMDD(iMonth)+toMMDD(maxday)+"'"+terms;
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
						for(int i=maxday-1; i>0; i--)
						{
							query+=
							" union select ifnull(sum(cnt),0), '"+toMMDD(i)+"' as dd   from contact_ip  where day like '"+toStr(iYear)+toMMDD(iMonth)+toMMDD(i)+"' "+terms;
						}
						query+=" order by dd ";
						//System.err.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
				public Vector getStatDayS_time(int iDate, String type)
				{
					
					//현재 달에서 iDate 만큼 이동한 달
					cal.add ( cal.MONTH, iDate );
					int iMonth = cal.get ( cal.MONTH ) + 1;
					int iYear =  cal.get ( cal.YEAR );
					
					GregorianCalendar today = new GregorianCalendar (iYear,iMonth-1,1 );
					
					String day = toStr(iYear)+toMMDD(iMonth);
				 
					type = com.vodcaster.utils.TextUtil.getValue(type);
					
					String terms = "";
					if(type.equals("") || type.equals("W"))
						terms = " and flag='W' ";
					else if(type.equals("M"))
						terms = " and flag='M' ";
					
						String query =
						"select ifnull(sum(cnt),0), 'total' as hour from contact_ip where day like'"+day+"%' "+terms+
						"union select ifnull(sum(cnt),0), '0' as hour from contact_ip where day like '"+day+"%' and hour in (0) "+terms+
						"union select ifnull(sum(cnt),0), '1' as hour from contact_ip where day like '"+day+"%' and hour in (1) "+terms+
						"union select ifnull(sum(cnt),0), '2' as hour from contact_ip where day like '"+day+"%' and hour in (2) "+terms+
						"union select ifnull(sum(cnt),0), '3' as hour from contact_ip where day like '"+day+"%' and hour in (3) "+terms+
						"union select ifnull(sum(cnt),0), '4' as hour from contact_ip where day like '"+day+"%' and hour in (4) "+terms+
						"union select ifnull(sum(cnt),0), '5' as hour from contact_ip where day like '"+day+"%' and hour in (5) "+terms+
						"union select ifnull(sum(cnt),0), '6' as hour from contact_ip where day like '"+day+"%' and hour in (6) "+terms+
						"union select ifnull(sum(cnt),0), '7' as hour from contact_ip where day like '"+day+"%' and hour in (7) "+terms+
						"union select ifnull(sum(cnt),0), '8' as hour from contact_ip where day like '"+day+"%' and hour in (8) "+terms+
						"union select ifnull(sum(cnt),0), '9' as hour from contact_ip where day like '"+day+"%' and hour in (9) "+terms+
						"union select ifnull(sum(cnt),0), '10' as hour from contact_ip where day like '"+day+"%' and hour in (10) "+terms+
						"union select ifnull(sum(cnt),0), '11' as hour from contact_ip where day like '"+day+"%' and hour in (11) "+terms+
						"union select ifnull(sum(cnt),0), '12' as hour from contact_ip where day like '"+day+"%' and hour in (12) "+terms+
						"union select ifnull(sum(cnt),0), '13' as hour from contact_ip where day like '"+day+"%' and hour in (13) "+terms+
						"union select ifnull(sum(cnt),0), '14' as hour from contact_ip where day like '"+day+"%' and hour in (14) "+terms+
						"union select ifnull(sum(cnt),0), '15' as hour from contact_ip where day like '"+day+"%' and hour in (15) "+terms+
						"union select ifnull(sum(cnt),0), '16' as hour from contact_ip where day like '"+day+"%' and hour in (16) "+terms+
						"union select ifnull(sum(cnt),0), '17' as hour from contact_ip where day like '"+day+"%' and hour in (17) "+terms+
						"union select ifnull(sum(cnt),0), '18' as hour from contact_ip where day like '"+day+"%' and hour in (18) "+terms+
						"union select ifnull(sum(cnt),0), '19' as hour from contact_ip where day like '"+day+"%' and hour in (19) "+terms+
						"union select ifnull(sum(cnt),0), '20' as hour from contact_ip where day like '"+day+"%' and hour in (20) "+terms+
						"union select ifnull(sum(cnt),0), '21' as hour from contact_ip where day like '"+day+"%' and hour in (21) "+terms+
						"union select ifnull(sum(cnt),0), '22' as hour from contact_ip where day like '"+day+"%' and hour in (22) "+terms+
						"union select ifnull(sum(cnt),0), '23' as hour from contact_ip where day like '"+day+"%' and hour in (23) "+terms+
						" ";

			//System.err.println(query);
						return querymanager.selectEntities(query);
					
				}
				
				/**
				 * 20110720
				 * 년간 접속 통계
				 * @param iData
				 * @return
				 */
				public Vector getYearState(int iData, String type)
				{
					type = com.vodcaster.utils.TextUtil.getValue(type);
					try{
						String terms = "";
						if(type.equals("") || type.equals("W"))
							terms = " and flag='W' ";
						else if(type.equals("M"))
							terms = " and flag='M' ";
						
	//					현재 달에서 iDate 만큼 이동한 달
						cal.add ( cal.YEAR, iData );
						int iYear =  cal.get ( cal.YEAR );
						cal.set(YEAR, MONTH-1, DAY);//다시 원위치로
	
						String query = 
						"select ifnull(sum(cnt),0),'"+toMMDD(12)+"' as mm from contact_ip  where day like '"+toStr(iYear)+toMMDD(12)+"%' "+terms;
						for(int i=10; i>=0; i--)
						{
							query+=
							"union select ifnull(sum(cnt),0) ,'"+toMMDD(i+1)+"' as mm from contact_ip  where day like '"+toStr(iYear)+toMMDD(i+1)+"%'"+terms;
						}
						query+=" order by mm ";
	//					System.err.println(query);
						return querymanager.selectEntities(query);
					}catch (Exception e){
						System.out.println(e);
						return null; 
					}
				}
				
}

