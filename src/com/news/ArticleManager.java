package com.news;

import java.util.*;

/*
 *  @author Kyu - Soung Lee
 *  뉴스 기사 관련 정보 클래스
 *  Date : 2010. 12. 15
 */

public class ArticleManager {

	private static ArticleManager instance;
	
	private ArticleSqlBean sqlbean = null;
	
	private ArticleManager(){
		sqlbean = new ArticleSqlBean();
	}
	
	public static ArticleManager getInstance(){
		if(instance == null){
			synchronized(ArticleManager.class){
				if(instance == null){
					instance = new ArticleManager();
				}
			}
		}
		return instance;
	}
	
	//기사 리스트
	
	public Vector getArticleList_main(String menu, int i, int j){
		String query = "";
		String where = "";
		
		if(menu.equals("0101")){
			where = " and section_idx = 61 and section_sub_idx = 14";
		}else if(menu.equals("0102")){
			where = " and section_idx != 71 and section_idx != 72 and section_idx != 68 " +
					" and section_sub_idx != 0 and section_sub_idx != 14 and section_sub_idx != 58  and section_sub_idx != 66 and section_sub_idx != 70 ";
		}else if(menu.equals("0301")){
			where = " and section_idx = 68 and (section_sub_idx = 32 or section_sub_idx = 81) ";
		}else if(menu.equals("0302")){ //64 -->68 변경 20150331
			where = " and section_idx = 68 and (section_sub_idx = 58 or section_sub_idx = 70 or section_sub_idx = 66) ";
		}else if(menu.equals("0303")){
			where = " and section_idx = 68 and section_sub_idx = 61";
		}
		
		query = " select idx, title, img_file1 " + 
				"   from t_article2 " +
				"  where is_select='1' " +
				"    and (is_reserve='N'  or (is_reserve='Y' and rsrv_date < now())) " +
				where +	" order by date desc limit " + i + ", " + j;
//System.out.println(query);		
		return sqlbean.selechHashQuery2(query);
	}
	
	
	public Vector getArticleList(String menu, int i, int j){
		String query = "";
		String where = "";
		
		if(menu.equals("0101")){
			where = " and section_idx = 61 and section_sub_idx = 14";
		}else if(menu.equals("0102")){
			where = " and section_idx != 71 and section_idx != 72 and section_idx != 68 " +
					" and section_sub_idx != 0 and section_sub_idx != 14 and section_sub_idx != 58  and section_sub_idx != 66 and section_sub_idx != 70 ";
		}else if(menu.equals("0301")){
			where = " and section_idx = 68 and (section_sub_idx = 32 or section_sub_idx = 81) ";
		}else if(menu.equals("0302")){//64 -->68 변경 20150331
			where = " and section_idx = 68 and (section_sub_idx = 58 or section_sub_idx = 70 or section_sub_idx = 66) ";
		}else if(menu.equals("0303")){
			where = " and section_idx = 68 and section_sub_idx = 61";
		}
		
		query = " select * " + 
				"   from t_article2 " +
				"  where is_select='1' " +
				"    and (is_reserve='N'  or (is_reserve='Y' and rsrv_date < now())) " +
				where +	" order by date desc limit " + i + ", " + j;
//System.out.println(query);		
		return sqlbean.selechHashQuery2(query);
	}
	
	//기사 리스트 Count
	public Vector getArticleListCount(String menu){
		String query = "";
		String where = "";
		
		if(menu.equals("0101")){ // 주요뉴스
			where = " and section_idx = 61 and section_sub_idx = 14";
		}else if(menu.equals("0102")){ // 최신뉴스
			where = " and section_idx != 71 and section_idx != 72 and section_idx != 68" +
					" and section_sub_idx != 0 and section_sub_idx != 14 and section_sub_idx != 58  and section_sub_idx != 66 and section_sub_idx != 70 ";
		}else if(menu.equals("0301")){  //시민기자
			where = " and section_idx = 68 and (section_sub_idx = 32 or section_sub_idx=81)";
		}else if(menu.equals("0302")){  // 만화 //64 -->68 변경 20150331
			where = " and section_idx = 68 and (section_sub_idx = 58 or section_sub_idx = 70 or section_sub_idx = 66)";
		}else if(menu.equals("0303")){  // 칼럼
			where = " and section_idx = 68 and section_sub_idx = 61";
		}
		
		query = " select count(idx) " + 
				"   from t_article2 " +
				"  where is_select='1' " +
				"    and (is_reserve='N'  or (is_reserve='Y' and rsrv_date < now())) " +
				where +	" ";
		
		return sqlbean.selectQuery(query);
	}
	
	 public Hashtable getArticleList(String menu_id, int page, int limit, int pagePerBlock)
		{
		 menu_id = com.vodcaster.utils.TextUtil.getValue(menu_id);
			if(page < 1 ) page = 1;
			if(limit < 1 || limit > 30) limit = 10;
			if(pagePerBlock < 1 || pagePerBlock > 10) pagePerBlock = 10;
			
			
			Hashtable result_ht;
		 
			String where = "";
			if(menu_id.equals("0101")){ // 주요뉴스
				where = " and a.section_idx = 61 and a.section_sub_idx = 14";
			}else if(menu_id.equals("0102")){ // 최신뉴스
				where = " and a.section_idx != 71 and a.section_idx != 72 and a.section_idx != 68" +
						" and a.section_sub_idx != 0 and a.section_sub_idx != 14 and a.section_sub_idx != 58  and a.section_sub_idx != 66 and a.section_sub_idx != 70 ";
			}else if(menu_id.equals("0301")){  //시민기자
				where = " and a.section_idx = 68 and (a.section_sub_idx = 32 or a.section_sub_idx=81)";
			}else if(menu_id.equals("0302")){  // 만화 칼럼 64 -->68 변경 20150331
				where = " and a.section_idx = 68 and (a.section_sub_idx = 58 or a.section_sub_idx = 70 or a.section_sub_idx = 66)";
			}else if(menu_id.equals("0303")){  // 칼럼
				where = " and a.section_idx = 68 and a.section_sub_idx = 61";
			}
			 

			String query  = " select a.idx, a.title, a.sub_title, a.date, a.img_file1, b.name " + 
					"   from t_article2 a LEFT JOIN  t_cp2 b ON  a.cp_idx =  b.idx  " +
					"  where  a.is_select='1' " +
					"    and (a.is_reserve='N'  or (a.is_reserve='Y' and a.rsrv_date < now())) " +
					where +	" order by a.date desc ";
			String count_query = " select count(a.idx) " + 
					"   from t_article2 a " +
					"  where a.is_select='1' " +
					"    and (a.is_reserve='N'  or (a.is_reserve='Y' and a.rsrv_date < now())) " +
					where +	" ";
 //System.out.println(query);			
				try {
			        result_ht = sqlbean.getListCnt(page, query, count_query, limit, pagePerBlock);
			
			    }catch (Exception e) {
			        result_ht = new Hashtable();
			        result_ht.put("LIST", new Vector());
			        result_ht.put("PAGE", new com.yundara.util.PageBean());
			    }
		 
			return result_ht;
		} 
	
	 
	 
	 public Hashtable getArticleList_search(String searchField, String searchString, String date,  int page, int limit, int pagePerBlock)
		{
 
			if(page < 1 ) page = 1;
			if(limit < 1 || limit > 30) limit = 10;
			if(pagePerBlock < 1 || pagePerBlock > 10) pagePerBlock = 10;
			
			
			Hashtable result_ht;
		 
			String where = "";
			where = " and a.section_sub_idx != 34 and a.section_sub_idx != 0 ";
			 
			if(searchField != null && searchString != null && searchField.length() > 0 && searchString.length() > 0 && !searchField.equals("null") && !searchString.equals("")){
				if(searchField.equals("all")){
					where += " and (a.title like '%" + searchString + "%' or a.content like '%" + searchString +  "%') ";
				}else if(searchField.equals("title")){
					where += " and a.title like '%" + searchString + "%' ";
				}else if(searchField.equals("content")){
					where += " and a.content like '%" + searchString + "%' ";
				}
			}
			
			if(date.equals("week")){
				where += " and to_days(now()) - to_days(a.date) <= 7 ";
			}else if(date.equals("month")){
				where += " and to_days(now()) - to_days(a.date) <= 30 ";
			}else if(date.equals("year")){
				where += " and to_days(now()) - to_days(a.date) <= 365 ";
			}
			

			String query  = " select a.idx, a.title, a.sub_title, a.date, a.img_file1, b.name " + 
					"   from t_article2 a LEFT JOIN  t_cp2 b ON  a.cp_idx =  b.idx  " +
					"  where  a.is_select='1' and a.cp_idx!='11507' " +where+
					"    and (a.is_reserve='N'  or (a.is_reserve='Y' and a.rsrv_date < now())) " +
					where +	" order by a.date desc ";
			String count_query = " select count(a.idx) " + 
					"   from t_article2 a " +
					"  where a.is_select='1' and a.cp_idx!='11507' " +where+
					"    and (a.is_reserve='N'  or (a.is_reserve='Y' and a.rsrv_date < now())) " +
					where +	" ";
//System.out.println(query);			
				try {
			        result_ht = sqlbean.getListCnt(page, query, count_query, limit, pagePerBlock);
			
			    }catch (Exception e) {
			        result_ht = new Hashtable();
			        result_ht.put("LIST", new Vector());
			        result_ht.put("PAGE", new com.yundara.util.PageBean());
			    }
		 
			return result_ht;
		} 
	
	 
	//기사 상세 검색하기
	public Vector searchArticle(String menu, String searchField, String searchString, String date, int i, int j){
		String query = "";
		String where = "";
		
		if(menu.equals("0101")){
			where = " and a.section_idx = 61 and a.section_sub_idx = 14";
		}else if(menu.equals("0102")){
			where = " and a.section_idx != 68 and a.section_sub_idx != 0 and a.section_sub_idx != 14 and a.section_sub_idx != 58  and a.section_sub_idx != 66 and a.section_sub_idx != 70 ";
		}else{
			where = " and a.section_sub_idx != 34 and a.section_sub_idx != 0";
		}
		
		if(searchField != null && searchString != null && searchField.length() > 0 && searchString.length() > 0 && !searchField.equals("null") && !searchString.equals("")){
			if(searchField.equals("all")){
				where += " and (a.title like '%" + searchString + "%' or a.content like '%" + searchString +  "%')";
			}else if(searchField.equals("title")){
				where += " and a.title like '%" + searchString + "%'";
			}else if(searchField.equals("content")){
				where += " and a.content like '%" + searchString + "%'";
			}
		}
		
		if(date.equals("week")){
			where += " and to_days(now()) - to_days(a.date) <= 7";
		}else if(date.equals("month")){
			where += " and to_days(now()) - to_days(a.date) <= 30";
		}else if(date.equals("year")){
			where += " and to_days(now()) - to_days(a.date) <= 365";
		}
 
		query = " select a.title, a.date, a.content, a.img_file1,  b.name , a.idx " +
				"   from t_article2 a  LEFT JOIN  t_cp2 b ON  a.cp_idx =  b.idx " +
				"  where a.is_select='1' " +
				"    and (a.is_reserve='N'  or (a.is_reserve='Y' and a.rsrv_date < now())) " +
				"    and a.cp_idx!='11507'" + where + " order by a.date desc limit " + i + "," + j;
		
		//System.out.println(query);
		return sqlbean.selechHashQuery2(query);
	}
	
	//기사 상세 검색하기 Count
	public Vector searchArticleCount(String menu, String searchField, String searchString, String date){
		String query = "";
		String where = "";
		
		if(menu.equals("0101")){
			where = " and section_idx = 61 and section_sub_idx = 14";
		}else if(menu.equals("0102")){
			where = " and section_idx != 68 and section_sub_idx != 0 and section_sub_idx != 14 and section_sub_idx != 58  and section_sub_idx != 66 and section_sub_idx != 70 ";
		}else{
			where = " and section_sub_idx != 34 and section_sub_idx != 0";
		}
		
		if(searchField != null && searchString != null && searchField.length() > 0 && searchString.length() > 0 && !searchField.equals("null") && !searchString.equals("null")){
			if(searchField.equals("all")){
				where += " and (title like '%" + searchString + "%' or content like '%" + searchString +  "%')";
			}else if(searchField.equals("title")){
				where += " and title like '%" + searchString + "%'";
			}else if(searchField.equals("content")){
				where += " and content like '%" + searchString + "%'";
			}
		}
		
		if(date.equals("week")){
			where += " and to_days(now()) - to_days(date) <= 7";
		}else if(date.equals("month")){
			where += " and to_days(now()) - to_days(date) <= 30";
		}else if(date.equals("year")){
			where += " and to_days(now()) - to_days(date) <= 365";
		}
		
		query = " select count(idx) as cnt " +
				"   from t_article2 " +
				"  where is_select='1' " +
				"    and (is_reserve='N'  or (is_reserve='Y' and rsrv_date < now())) " +
				"    and cp_idx!='11507'" + where + " ";
				
		
		return sqlbean.selectQuery(query);
	}
	
	public int searchArticle_Count(String menu, String searchField, String searchString, String date){
		String query = "";
		String where = "";
		
		if(menu.equals("0101")){
			where = " and section_idx = 61 and section_sub_idx = 14";
		}else if(menu.equals("0102")){
			where = " and section_idx != 68 and section_sub_idx != 0 and section_sub_idx != 14 and section_sub_idx != 58  and section_sub_idx != 66 and section_sub_idx != 70 ";
		}else{
			where = " and section_sub_idx != 34 and section_sub_idx != 0";
		}
		
		if(searchField != null && searchString != null && searchField.length() > 0 && searchString.length() > 0 && !searchField.equals("null") && !searchString.equals("null")){
			if(searchField.equals("all")){
				where += " and (title like '%" + searchString + "%' or content like '%" + searchString +  "%')";
			}else if(searchField.equals("title")){
				where += " and title like '%" + searchString + "%'";
			}else if(searchField.equals("content")){
				where += " and content like '%" + searchString + "%'";
			}
		}
		
		if(date.equals("week")){
			where += " and to_days(now()) - to_days(date) <= 7";
		}else if(date.equals("month")){
			where += " and to_days(now()) - to_days(date) <= 30";
		}else if(date.equals("year")){
			where += " and to_days(now()) - to_days(date) <= 365";
		}
		
		query = " select count(idx) as cnt " +
				"   from t_article2 " +
				"  where is_select='1' " +
				"    and (is_reserve='N'  or (is_reserve='Y' and rsrv_date < now())) " +
				//"    and cp_idx!='11507'" + where + " order by date desc";
				"    and cp_idx!='11507'" + where + " ";
		
	 
		Vector v = sqlbean.selectQuery(query);
	   if(v != null && v.size() > 0){
	   	return Integer.parseInt(String.valueOf(v.elementAt(0)));
	   }  else{
	   	return 0;
	   }
	}
	


   
	//기사 내용보기
	public Vector getArticle(String idx){
		String query = "";
		
		if (idx != null && idx.length() > 0 && com.vodcaster.utils.TextUtil.isNumber(idx)) {
			try{
				//기사 조회수 증가
				 sqlbean.updateArticleCount(idx);	
			 
			}catch (Exception e) {
				return null;
			}
			
			query = " select * from t_article2 where idx = " + idx;
			
			return sqlbean.selechHashQuery(query);
		} else {
			return null;
		}
	}
	
	
	public Vector getArticle_user(String idx){
 		
		if (idx != null && idx.length() > 0 && com.vodcaster.utils.TextUtil.isNumber(idx)) {
		String query = "";
		
		try{
			//기사 조회수 증가
			  sqlbean.updateArticleCount(idx);	
			 
		}catch (Exception e) {
			return null;
		}
		
		query = " select a.title, a.date, a.content, a.img_file1, a.img_file2, a.img_file3, a.img_file4, b.name " +
				" from t_article2 a LEFT JOIN  t_cp2 b ON  a.cp_idx =  b.idx  where   a.idx = " + idx;
 	
			return sqlbean.selechHashQuery(query);
		} else {
			return null;
		}
	}
	
	
	//메뉴 명
	public Vector getMenuName(String idx, String sub_idx){
		String query = "";
		String where = "";
		
		if (idx != null && idx.length() > 0 && com.vodcaster.utils.TextUtil.isNumber(idx)) {
			
			if(sub_idx != null && sub_idx.length() > 0){
				where = " and sub_idx = " + sub_idx;
			}else{
				where = " and sub_idx = 0 ";
			}
			
			query = " select idx, sub_idx, name " +
					"   from t_section2 " +
					"  where idx = " + idx +
					"    and state = 1 " + where;
			
			return sqlbean.selechHashQuery2(query);
		} else {
			return null;
		}
		
	}
	
	//메일 보내기
	public int sendEmailAction(String date, String title, String content, String senderName, String senderMail, String receiverName, String receiverMail) {
    	String query = "";
    	int result = 0;
    	String mailidx = "";
    	String table = "mail_" + date;
    	
    	try{
    		query = " select max(mailidx)+1 from cysendbase ";
    		
    		Vector vt = sqlbean.selechHashQuery(query);
    		
    		if(vt != null && vt.size() > 0){
    			mailidx = String.valueOf(vt.elementAt(0));
    		
    			result = sqlbean.insertSender(mailidx, title, content, senderName, senderMail);
    			
    			if(result < 0){
        			return -10;
        		}
        	}else{
    			return -20;
    		}
    	}catch(Exception e){
    		return -30;
    	}
    	
    	try{
    		query = " desc " + table;
    		
    		Vector vt2 = sqlbean.selechHashQuery(query);
    		
    		if(vt2 != null && vt2.size() > 0){
    			
    			result = sqlbean.insertReceiver(table, mailidx, receiverName, receiverMail);
    			
    			if(result < 0){
            		return -40;
            	}
            }else{
    			result = sqlbean.createMailTable(table);
    			
    			if(result >= 0){
    				result = sqlbean.insertReceiver(table, mailidx, receiverName, receiverMail);
                		
                	if(result < 0){
                		return -50;
                	}
    			}else{
    				return -60;
    			}
    		}
    	}catch (Exception e) {
    		return -70;	
		}
    	
    	return 99;
    	
	}
	
	//작성자 검색
	public Vector getWriter(String cp_idx){
		String query = "";
		if (cp_idx != null && cp_idx.length() > 0 && com.vodcaster.utils.TextUtil.isNumber(cp_idx)) {
		query = "select * from t_cp2 where idx = " + cp_idx;
		
		return sqlbean.selechHashQuery(query);
		} else {
			return null;
		}
	}
}
