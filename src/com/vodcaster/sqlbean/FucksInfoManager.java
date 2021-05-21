package com.vodcaster.sqlbean;

import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.yundara.util.CharacterSet;

public class FucksInfoManager {
	private static FucksInfoManager instance;
	private FucksInfoSql sqlbean = null;
    
	private FucksInfoManager() {
        sqlbean = new FucksInfoSql();
    }
    
	public static FucksInfoManager getInstance() {
		if(instance == null) {
			synchronized(FucksInfoManager.class) {
				if(instance == null) {
					instance = new FucksInfoManager();
				}
			}
		}
		return instance;
	}
	
	/*****************************************************
		아이디 입력받아 시청 대상자 정보 삭제.<p>
		<b>작성자</b> : 이희락<br>
		@return <br> 결과값 faile=-1, success= >0
		@param 아이디 
	******************************************************/
	public int deleteFuck( String fuck_id) {
		fuck_id = com.vodcaster.utils.TextUtil.getValue(fuck_id);
		return sqlbean.deleteFuckInfo(fuck_id);
	}
	
	/*****************************************************
	욕설정보를 저장합니다.(insert문 실행)<p>
	<b>작성자</b>       : 이희락<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1, 커넥션 에러일 경우 99
	@see QueryManager#updateEntities
	******************************************************/
	public int insertFuckInfo(HttpServletRequest req) throws Exception 
	{
		// 기본변수들을 초기화 한다.
		String fucks    			=  "";
				//파라메타 값이 들어오는지 체크한다.
		if(req.getParameter("fucks") !=null && req.getParameter("fucks").length()>0 && !req.getParameter("fucks").equals("null")){
			fucks = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("fucks")));
			//fucks = com.vodcaster.utils.TextUtil.getValue(req.getParameter("fucks"));
		}else{
			return -1;
		}
		return sqlbean.insertFucks(fucks);
	}
	
	/*****************************************************
	욕설정보를 수정 저장합니다.(update문 실행)<p>
	<b>작성자</b>       : 이희락<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1, 커넥션 에러일 경우 99
	@see QueryManager#updateEntities
	******************************************************/
	public int updateFuckInfo(HttpServletRequest req) throws Exception 
	{
		// 기본변수들을 초기화 한다.
		String fucks    			=  "";
		int fuck_id = 0;
		
		//파라메타 값이 들어오는지 체크한다.
		if(req.getParameter("fuck_id") !=null && req.getParameter("fuck_id").length()>0 && !req.getParameter("fuck_id").equals("null") 
				&& com.yundara.util.TextUtil.isNumeric(com.vodcaster.utils.TextUtil.getValue(req.getParameter("fuck_id"))))  {
			fuck_id = Integer.parseInt(req.getParameter("fuck_id"));
		}else{
			return -1;
		}
		
		//파라메타 값이 들어오는지 체크한다.
		if(req.getParameter("fucks") !=null && req.getParameter("fucks").length()>0 && !req.getParameter("fucks").equals("null")){
			fucks = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("fucks")));
			//fucks =  com.vodcaster.utils.TextUtil.getValue(req.getParameter("fucks"));
		}else{
			return -1;
		}
		return sqlbean.modifyFuckInfo(fuck_id, fucks);
	}
	
	/*****************************************************
		검색된 욕설 게시판글의 리스트를 넘겨줍니다.(관리자)<p>
		<b>작성자</b>       : 이희락<br>
		@return 검색에 의한 특정 욕설 게시판의 게시물 정보 리턴<br>
		@param  searchstring 키워드 정보
		@see QueryManager#selectEntities
	******************************************************/
	public Hashtable getAllFucks_admin(  String searchstring,  int page, int limit, String orderby, String order){
		
		String sub_query = "";
		orderby = com.vodcaster.utils.TextUtil.getValue(orderby);
		order = com.vodcaster.utils.TextUtil.getValue(order);
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		Hashtable result_ht;
		String query = "";
		String count_query = "";
		if(order == null || order.length()<=0){
			order = " fuck_id ";
		}
		if(searchstring != null && searchstring.length()>0) { // 글 제목으로 검색할 경우
			query = "select * from  fuck_info where fucks like '%"+searchstring+"%'  order by  "+order+" desc";
			count_query = " select count(*) from  fuck_info where fucks like '%"+searchstring+"%'  ";
		}else{
			query = "select * from  fuck_info   order by  "+order+" desc";
			count_query = " select count(*) from  fuck_info    ";
		}
		try { 
	        result_ht = sqlbean.selectFucksListAll(page, query, count_query, limit);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	    
		return result_ht;
	}
	
	/*****************************************************
		검색된 욕설 게시판글의 리스트를 넘겨줍니다.(관리자)<p>
		<b>작성자</b>       : 이희락<br>
		@return 검색에 의한 특정 욕설 게시판의 게시물 정보 리턴<br>
		@param  searchstring 키워드 정보
		@see QueryManager#selectEntities
	******************************************************/
	public Hashtable getAllFucks_admin(  String searchstring ){
		
		String sub_query = "";
		searchstring = com.vodcaster.utils.TextUtil.getValue(searchstring);
		Hashtable result_ht;
		String query = "";
		String count_query = "";
		
		if(searchstring != null && searchstring.length()>0){
			query = "select * from  fuck_info  where fucks like '%"+searchstring+"%' order by  fucks desc";
			count_query = "select count(fucks) from  fuck_info where fucks like '%"+searchstring+"%'  ";
		}else{
			query = "select * from  fuck_info   order by  fucks desc";
			count_query = "select count(fucks) from  fuck_info   ";
		}
	
		
		try { 
	        result_ht = sqlbean.selectFucksListAll(  query, count_query );
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	    
		return result_ht;
	}
	
	public Vector getFuck(String seq) {

		seq = com.vodcaster.utils.TextUtil.getValue(seq);
		if (seq != null && seq.length() > 0) {
	      String query = "select * from fuck_info where fuck_id="+seq ;

			return sqlbean.selectHashEntities(query);
		} else {
			return null;
		}

	    }

}
