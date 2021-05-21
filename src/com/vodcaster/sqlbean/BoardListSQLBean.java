/*
 * Created on 2009. 7. 16.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.sqlbean;


import com.yundara.util.*;

import java.io.File;
import java.util.*;

import javax.servlet.http.*;

import dbcp.SQLBeanExt;

import com.security.SEEDUtil;
import com.tistory.antop.Thumbnail;
import com.vodcaster.sqlbean.DirectoryNameManager;
import com.vodcaster.utils.ImageUtil;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;

/**
 * @author Jong-Sung Park
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 * 게시물 관련 정보 클래스
 * 게시물 등록, 수정, 삭제관련
 */
public class BoardListSQLBean extends SQLBeanExt implements java.io.Serializable{
	/*****************************************************
	게시판 게시물 생성자<p>
	<b>작성자</b>       : 박종성<br>
	******************************************************/
	public BoardListSQLBean() {
		super();
	}

/************************************************  SELECT  ************************************************/

	/*****************************************************
	특정 게시판의 특정게시물 내용의 정보들을 넘겨줍니다.<p>
	<b>작성자</b>       : 박종성<br>
	@return 특정 게시판의 게시물 정보 리턴<br>
	@param board_id 게시판 아이디, list_id 게시물 아이디
	@see QueryManager#selectEntity
	******************************************************/
	public Vector getOnlyBoardList(int board_id, int list_id){
		if(board_id < 0) return null;
		if(list_id < 0) return null;
		//String query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' and b.board_id ="+board_id +" and b.list_id = "+list_id;
		String query = "select b.* from board_list b where b.del_flag='N' and b.board_id ="+board_id +" and b.list_id = "+list_id;
		return 	querymanager.selectEntity(query);
	}
	public Vector getOnlyBoardList(int board_id, int list_id, String list_passwd){
		if(board_id < 0) return null;
		if(list_id < 0) return null;
		String query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b " +
				" where b.del_flag='N' and b.board_id ="+board_id +" and b.list_id = "+list_id +" and list_passwd = password('"+list_passwd+"') ";
		return 	querymanager.selectEntity(query);
	}
	public long getFileSize(String file_name) {
		File f = new File(file_name);
		long fileSize = f.length();
		return fileSize;
	}

	/*****************************************************
	검색된 게시판글의 리스트를 넘겨줍니다.<p>
	<b>작성자</b>       : 박종성<br>
	@return 검색에 의한 특정 게시판의 게시물 정보 리턴<br>
	@param board_id 게시판 아이디, field 검색필드정보, searchstring 키워드 정보,  open_space 공지여부
	@see QueryManager#selectEntities
	******************************************************/
	public Vector getAllBoardList(int board_id, String field, String searchstring, String open_space){
		if(board_id < 0) return null;
		String cond = "";
		if(searchstring != null && searchstring.length()> 0 && !com.vodcaster.utils.TextUtil.getValue(searchstring).equals("")){
			cond = '%' + com.vodcaster.utils.TextUtil.getValue(searchstring) + '%';
		}
		open_space = com.vodcaster.utils.TextUtil.getValue(open_space);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		
		String sub_query = "";
		if(open_space != null && open_space.length() > 0) {
			sub_query = " and open_space='"+open_space+"' ";
		}
		
		String query = "";
		
		if(field.equals("1")) { // 글 제목으로 검색할 경우
			query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and lower(b.list_title) like lower('"+cond+"') and b.board_id = "+board_id+
                    " order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
		}else if(field.equals("2")) { // 글 내용으로 검색할 경우
			query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and lower(b.list_contents) like lower('"+cond+"') and b.board_id = "+board_id+
					" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
		}else if(field.equals("3")) { // 글 제목, 내용으로 검색할 경우
			query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and (lower(b.list_title) like lower('"+cond+"') or lower(b.list_contents) " +
                    "like lower('"+cond+"')) and b.board_id = "+board_id+
                    " order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
		}else if(field.equals("4")) { // 작성자의 이름으로 검색할 경우
			query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and lower(b.list_name) like lower('"+cond+"') and b.board_id = "+board_id+
					" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
		}else { // 검색하지 않고 목록 출력할 경우
			query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and b.board_id = "+board_id+" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
		}		
		return 	querymanager.selectEntities(query);
	}
	
	/*****************************************************
	검색된 게시판글의 리스트를 넘겨줍니다.<p>
	<b>작성자</b>       : 박종성<br>
	@return 검색에 의한 특정 게시판의 게시물 정보 리턴<br>
	@param board_id 게시판 아이디, field 검색필드정보, searchstring 키워드 정보,  open_space 공지여부
	@see QueryManager#selectEntities
	******************************************************/
	public Hashtable getAllBoardList(int board_id, String field, String searchstring, String open_space, int page, int limit){
		Hashtable  result_ht = null;
		if(board_id < 0) {
			result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	        return result_ht;
		}
		String sub_query = "";
		
		String cond = "";
		if(searchstring != null && !com.vodcaster.utils.TextUtil.getValue(searchstring).equals("")){
			cond = '%' + com.vodcaster.utils.TextUtil.getValue(searchstring) + '%';
		}
		open_space = com.vodcaster.utils.TextUtil.getValue(open_space);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		if(open_space != null && open_space.length() > 0) {
			sub_query = " and open_space='"+open_space+"' ";
		}
		String count_query = "";
		String query = "";
		if(field == null){
			query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and b.board_id = "+board_id+" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
			count_query = "select count(*) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and b.board_id = "+board_id+" ";
		}else{
			if(field.equals("1")) { // 글 제목으로 검색할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and lower(b.list_title) like lower('"+cond+"') and b.board_id = "+board_id+
	                    " order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
				count_query = "select count(*) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and lower(b.list_title) like lower('"+cond+"') and b.board_id = "+board_id;
			}else if(field.equals("2")) { // 글 내용으로 검색할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and lower(b.list_contents) like lower('"+cond+"') and b.board_id = "+board_id+
						" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
				count_query = "select count(*) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and lower(b.list_contents) like lower('"+cond+"') and b.board_id = "+board_id;
			}else if(field.equals("3")) { // 글 제목, 내용으로 검색할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and (lower(b.list_title) like lower('"+cond+"') or lower(b.list_contents) " +
	                    "like lower('"+cond+"')) and b.board_id = "+board_id+
	                    " order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
				count_query = "select count(*) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and (lower(b.list_title) like lower('"+cond+"') or lower(b.list_contents) " +
					"like lower('"+cond+"')) and b.board_id = "+board_id;
	    			
			}else if(field.equals("4")) { // 작성자의 이름으로 검색할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and lower(b.list_name) like lower('"+cond+"') and b.board_id = "+board_id+
						" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
				count_query = "select count(*) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and lower(b.list_name) like lower('"+cond+"') and b.board_id = "+board_id;
			}else { // 검색하지 않고 목록 출력할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and b.board_id = "+board_id+" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
				count_query = "select count(*) from board_list b where b.del_flag='N' and b.list_open='Y' "+sub_query+" and b.board_id = "+board_id+" ";
			}	
		}
		
		try {
	        result_ht = this.getList(page, query, count_query, limit);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	    
		return result_ht;
	}
	
	/*****************************************************
	검색된 게시판글의 리스트를 넘겨줍니다.(관리자)<p>
	<b>작성자</b>       : 박종성<br>
	@return 검색에 의한 특정 게시판의 게시물 정보 리턴<br>
	@param board_id 게시판 아이디, field 검색필드정보, searchstring 키워드 정보,  open_space 공지여부
	@see QueryManager#selectEntities
	******************************************************/
	public Vector getAllBoardList_admin(int board_id, String field, String searchstring, String open_space){
		if(board_id < 0) return null;
		String cond = "";
		if(searchstring != null && !com.vodcaster.utils.TextUtil.getValue(searchstring).equals("")){
			cond = '%' + com.vodcaster.utils.TextUtil.getValue(searchstring) + '%';
		}
		String sub_query = "";
		
		open_space = com.vodcaster.utils.TextUtil.getValue(open_space);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		
		if(open_space != null && open_space.length() > 0) {
			sub_query = " and open_space='"+open_space+"' ";
		}
		
		String query = "";
		if(field == null || field.equals("")){
			query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' "+sub_query+" and b.board_id = "+board_id+" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
		}else{
			if(field.equals("1")) { // 글 제목으로 검색할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' "+sub_query+" and lower(b.list_title) like lower('"+cond+"') and b.board_id = "+board_id+
	                    " order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
			}else if(field.equals("2")) { // 글 내용으로 검색할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' "+sub_query+" and lower(b.list_contents) like lower('"+cond+"') and b.board_id = "+board_id+
						" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
			}else if(field.equals("3")) { // 글 제목, 내용으로 검색할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' "+sub_query+" and (lower(b.list_title) like lower('"+cond+"') or lower(b.list_contents) " +
	                    "like lower('"+cond+"')) and b.board_id = "+board_id+
	                    " order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
			}else if(field.equals("4")) { // 작성자의 이름으로 검색할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' "+sub_query+" and lower(b.list_name) like lower('"+cond+"') and b.board_id = "+board_id+
						" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
			}else { // 검색하지 않고 목록 출력할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' "+sub_query+" and b.board_id = "+board_id+" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
			}		
		}
		return 	querymanager.selectEntities(query);
	}

	
	/*****************************************************
	검색된 게시판글의 리스트를 넘겨줍니다.(관리자)<p>
	<b>작성자</b>       : 박종성<br>
	@return 검색에 의한 특정 게시판의 게시물 정보 리턴<br>
	@param board_id 게시판 아이디, field 검색필드정보, searchstring 키워드 정보,  open_space 공지여부
	@see QueryManager#selectEntities
	******************************************************/
	public Hashtable getAllBoardList_admin(int board_id, String field, String search_field, String searchstring, String open_space , int page, int limit){
		Hashtable result_ht;
		
		if(board_id < 0){
			result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	        return result_ht;
		}
		String cond = "";
		if(searchstring != null && !com.vodcaster.utils.TextUtil.getValue(searchstring).equals("") && searchstring.length() > 0){
			cond = '%' + com.vodcaster.utils.TextUtil.getValue(searchstring) + '%';
		}
		open_space = com.vodcaster.utils.TextUtil.getValue(open_space);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		search_field = com.vodcaster.utils.TextUtil.getValue(search_field);
		String sub_query = "";
		if(open_space != null && open_space.length() > 0) {
			sub_query = " and open_space='"+open_space+"' ";
		}
		
		if (search_field != null && search_field.length() > 0) {
			sub_query = sub_query+ " and image_text8='"+search_field+"' ";
		}
		
		String query = "";
		String count_query = "";
		if(field == null || field.equals("") || cond.length() <= 0){
			query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' "+sub_query+" and b.board_id = "+board_id+" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
			count_query = "select count(*) from board_list b where b.del_flag='N' "+sub_query+" and b.board_id = "+board_id;
		}else{
			if(field.equals("1")) { // 글 제목으로 검색할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' "+sub_query+" and lower(b.list_title) like lower('"+cond+"') and b.board_id = "+board_id+
	                    " order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
				count_query = " select count(*) from board_list b where b.del_flag='N' "+sub_query+" and lower(b.list_title) like lower('"+cond+"') and b.board_id = "+board_id;
			}else if(field.equals("2")) { // 글 내용으로 검색할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' "+sub_query+" and lower(b.list_contents) like lower('"+cond+"') and b.board_id = "+board_id+
						" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
				count_query = "select count(*)  from board_list b where b.del_flag='N' "+sub_query+" and lower(b.list_contents) like lower('"+cond+"') and b.board_id = "+board_id;
			}else if(field.equals("3")) { // 글 제목, 내용으로 검색할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' "+sub_query+" and (lower(b.list_title) like lower('"+cond+"') or lower(b.list_contents) " +
	                    "like lower('"+cond+"')) and b.board_id = "+board_id+
	                    " order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
				count_query = "select count(*) from board_list b where b.del_flag='N' "+sub_query+" and (lower(b.list_title) like lower('"+cond+"') or lower(b.list_contents) " +
	            "like lower('"+cond+"')) and b.board_id = "+board_id;
			}else if(field.equals("4")) { // 작성자의 이름으로 검색할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' "+sub_query+" and lower(b.list_name) like lower('"+cond+"') and b.board_id = "+board_id+
						" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
				count_query = "select count(*) from board_list b where b.del_flag='N' "+sub_query+" and lower(b.list_name) like lower('"+cond+"') and b.board_id = "+board_id;
				
			}else { // 검색하지 않고 목록 출력할 경우
				query = "select b.*,(select name from member m where m.id=b.list_name) from board_list b where b.del_flag='N' "+sub_query+" and b.board_id = "+board_id+" order by  b.list_ref desc, b.list_step asc, b.list_date desc, b.seq desc";
				count_query = "select count(*) from board_list b where b.del_flag='N' "+sub_query+" and b.board_id = "+board_id;
			}		
		}
		
		System.out.println(query);
		try { 
	        result_ht = this.getList(page, query, count_query, limit);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	    
		return result_ht;
	}
	
	public Hashtable getAllBoardList_admin_event(int board_id, String field, String searchstring, String open_space , int page, int limit, String event_seq, String order, String direction){
		Hashtable result_ht;
		if(board_id < 0){
			result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	        return result_ht;
		}
		
		String cond = "";
		if(searchstring != null && !com.vodcaster.utils.TextUtil.getValue(searchstring).equals("")){
			cond =  com.vodcaster.utils.TextUtil.getValue(searchstring) ;
		}
		
		String sub_query = "";
		event_seq = com.vodcaster.utils.TextUtil.getValue(event_seq);
		open_space = com.vodcaster.utils.TextUtil.getValue(open_space);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		
		if (event_seq != null && event_seq.length() > 0) {
			sub_query = " and b.event_seq = '"+event_seq+"'";
		}
		if(open_space != null && open_space.length() > 0) {
			sub_query = " and b.open_space='"+open_space+"' ";
		}
		String orderby = " order by b."+order+" "+ direction +" , b.seq desc";
		String query = "";
		String count_query = "";
		if(field == null || field.equals("")){
			query = "select b.*, u.user_tel, u.user_email  from board_list b left join event_user u  on b.list_id = u.ocode where b.del_flag='N' "+sub_query+" and b.board_id = "+board_id+orderby;
			count_query = "select count(*) from  board_list b left join event_user u  on b.list_id = u.ocode where b.del_flag='N' "+sub_query+" and b.board_id = "+board_id;
		}else{
			if(field.equals("1")) { // 글 제목으로 검색할 경우
				query = "select b.*, u.user_tel, u.user_email from board_list b left join event_user u  on b.list_id = u.ocode where b.del_flag='N' "+sub_query+" and lower(b.list_title) like lower('%"+cond+"%') and b.board_id = "+board_id
				+orderby;
				count_query = " select count(*) from board_list b left join event_user u  on b.list_id = u.ocode where b.del_flag='N' "+sub_query+" and lower(b.list_title) like lower('%"+cond+"%') and b.board_id = "+board_id;
			}else if(field.equals("2")) { // 글 내용으로 검색할 경우
				query = "select b.*, u.user_tel, u.user_email from board_list b where b.del_flag='N' "+sub_query+" and lower(b.list_contents) like lower('%"+cond+"%') and b.board_id = "+board_id+orderby;
				count_query = "select count(*)  from board_list b left join event_user u  on b.list_id = u.ocode where b.del_flag='N' "+sub_query+" and lower(b.list_contents) like lower('%"+cond+"%') and b.board_id = "+board_id;
			}else if(field.equals("3")) { // 글 제목, 내용으로 검색할 경우
				query = "select b.*, u.user_tel, u.user_email from board_list b left join event_user u  on b.list_id = u.ocode where b.del_flag='N' "+sub_query+" and (lower(b.list_title) like lower('%"+cond+"%') or lower(b.list_contents) " +
	                    " like lower('"+cond+"')) and b.board_id = "+board_id+orderby;
				count_query = "select count(*) from board_list b left join event_user u  on b.list_id = u.ocodewhere b.del_flag='N' "+sub_query+" and (lower(b.list_title) like lower('%"+cond+"%') or lower(b.list_contents) " +
	            " like lower('"+cond+"')) and b.board_id = "+board_id;
			}else if(field.equals("4")) { // 작성자의 이름으로 검색할 경우
				query = "select b.*, u.user_tel, u.user_email  from board_list b left join event_user u  on b.list_id = u.ocode where b.del_flag='N' "+sub_query+" and lower(b.list_name) like lower('"+cond+"%') and b.board_id = "+board_id	+orderby;
				count_query = "select count(*) from board_list b left join event_user u  on b.list_id = u.ocode where b.del_flag='N' "+sub_query+" and lower(b.list_name) like lower('"+cond+"%') and b.board_id = "+board_id;
				
			}else { // 검색하지 않고 목록 출력할 경우
				query = "select b.*, u.user_tel, u.user_email  from board_list b left join event_user u  on b.list_id = u.ocode where b.del_flag='N' "+sub_query+" and b.board_id = "+board_id+orderby;
				count_query = "select count(*) from board_list b left join event_user u  on b.list_id = u.ocode where b.del_flag='N' "+sub_query+" and b.board_id = "+board_id;
			}		
		}
		//System.out.println("getAllBoardList_admin_event:"+query);
		try { 
	        result_ht = this.getList(page, query, count_query, limit);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	    
		return result_ht;
	}
	
	
	public Vector getAllBoardList_admin_eventExcel(int board_id, String field, String searchstring, String open_space ,  String event_seq, String order, String direction){
 
		String cond = "";
		if(searchstring != null && !com.vodcaster.utils.TextUtil.getValue(searchstring).equals("")){
			cond =  com.vodcaster.utils.TextUtil.getValue(searchstring) ;
		}
		
		String sub_query = "";
		event_seq = com.vodcaster.utils.TextUtil.getValue(event_seq);
		open_space = com.vodcaster.utils.TextUtil.getValue(open_space);
		field = com.vodcaster.utils.TextUtil.getValue(field);
		
		if (event_seq != null && event_seq.length() > 0) {
			sub_query = " and b.event_seq = '"+event_seq+"'";
		}
		if(open_space != null && open_space.length() > 0) {
			sub_query = " and b.open_space='"+open_space+"' ";
		}
		String orderby = " order by b."+order+" "+ direction +" , b.seq desc";
		String query = "";
 
		if(field == null || field.equals("")){
			query = "select b.event_gread, b.list_name, u.user_tel, u.user_email, b.list_title, b.event_seq, list_id from board_list b left join event_user u  on b.list_id = u.ocode where  b.event_gread > 0 and  b.del_flag='N' "+sub_query+" and b.board_id = "+board_id+orderby;
			
		}else{
			if(field.equals("1")) { // 글 제목으로 검색할 경우
				query = "select b.event_gread, b.list_name, u.user_tel, u.user_email, b.list_title, b.event_seq, list_id from board_list b left join event_user u  on b.list_id = u.ocode where b.event_gread > 0 and b.del_flag='N' "+sub_query+" and lower(b.list_title) like lower('%"+cond+"%') and b.board_id = "+board_id
				+orderby;
				
			}else if(field.equals("2")) { // 글 내용으로 검색할 경우
				query = "select b.event_gread, b.list_name, u.user_tel, u.user_email, b.list_title, b.event_seq, list_id from board_list b left join event_user u  on b.list_id = u.ocode where b.event_gread > 0 and b.del_flag='N' "+sub_query+" and lower(b.list_contents) like lower('%"+cond+"%') and b.board_id = "+board_id+orderby;
				
			}else if(field.equals("3")) { // 글 제목, 내용으로 검색할 경우
				query = "select b.event_gread, b.list_name, u.user_tel, u.user_email, b.list_title, b.event_seq, list_id  from board_list b left join event_user u  on b.list_id = u.ocode where b.event_gread > 0 and b.del_flag='N' "+sub_query+" and (lower(b.list_title) like lower('%"+cond+"%') or lower(b.list_contents) " +
	                    "like lower('"+cond+"')) and b.board_id = "+board_id+orderby;
				
			}else if(field.equals("4")) { // 작성자의 이름으로 검색할 경우
				query = "select b.event_gread, b.list_name, u.user_tel, u.user_email, b.list_title, b.event_seq, list_id from board_list b left join event_user u  on b.list_id = u.ocode where b.event_gread > 0 and b.del_flag='N' "+sub_query+" and lower(b.list_name) like lower('"+cond+"%') and b.board_id = "+board_id	+orderby;
				
				
			}else { // 검색하지 않고 목록 출력할 경우
				query = "select b.event_gread, b.list_name, u.user_tel, u.user_email,b.list_title, b.event_seq, list_id  from board_list b left join event_user u  on b.list_id = u.ocode where b.event_gread > 0 and b.del_flag='N' "+sub_query+" and b.board_id = "+board_id+orderby;
				
			}		
		}
		//System.out.println("getAllBoardList_admin_eventExcel:"+query);
		return 	querymanager.selectEntities(query);
	}
	
	
	
	public Hashtable getList(int page,String query, String count_query, int limit){

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
//139,4,10,1
        PageBean pb = new PageBean(totalRecord, limit, 10, page);
//totalrecord,lineperpage,pageperblock,page
        
		// 해당 페이지의 리스트를 얻는다.
		String rquery ="";
		rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
		Vector result_v = querymanager.selectHashEntities(rquery);
//System.err.println(rquery);
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
	
	/*****************************************************
	특정 게시판의 최근 글 리스트를 넘겨줍니다.<p>
	<b>작성자</b>       : 박종성<br>
	@return 특정 게시판의 최근 글 리스트 정보 리턴<br>
	@param board_id 게시판 아이디, boardLimit 게시물 수
	@see QueryManager#selectHashEntities
	******************************************************/
	public Vector getRecentBoardList(int board_id, int boardLimit){
		if(board_id < 0 ) return null;
		String query = "select * from board_list where del_flag='N' and board_id=" + board_id + " order by list_date desc limit 0, " + boardLimit;		
		return 	querymanager.selectHashEntities(query);
	}
	
	public Vector getRecentBoardList_open_space(int board_id, int boardLimit){
		if(board_id < 0 ) return null;
		String query = "select * from board_list where del_flag='N' and open_space='Y' and board_id=" + board_id + " order by list_date desc limit 0, " + boardLimit;		
		return 	querymanager.selectHashEntities(query);
	}

	public Vector getRecentBoardList_open(int board_id, int boardLimit){
		if(board_id < 0 ) return null;
		String query = "select * from board_list where del_flag='N' and list_open='Y' and list_security='N' and board_id=" + board_id + " order by list_date desc limit 0, " + boardLimit;		
		return 	querymanager.selectHashEntities(query);
	}
	
	public Vector getRecentBoardList_open_top(int board_id, int boardLimit){
		if(board_id < 0 ) return null;
		String query = "select * from board_list where del_flag='N' and list_open='Y' and list_security='N' and board_id=" + board_id + " order by open_space desc, list_date desc limit 0, " + boardLimit;		
		return 	querymanager.selectHashEntities(query);
	}
	
	public Vector getMain_board_notice(int board_id, int boardLimit){
		if(board_id < 0 ) return null;
		String query = "select * from board_list where del_flag='N' and list_open='Y' and list_security='N' and board_id=" + board_id + " AND (  redate IS NULL OR redate = '' OR redate >= CURRENT_DATE()) order by list_ref DESC, list_date desc limit 0, " + boardLimit;		
		return 	querymanager.selectHashEntities(query);
	}

	/*****************************************************
	파일 업로드시 파일 확장자를 리턴한다.
	<b>작성자</b>       : 이희락<br>
	@return 파일 확장자 체크 후 결과값 리턴<br>
	@param filename 파일이름
	******************************************************/
	public String getExtension(String filename){
		int index = filename.lastIndexOf(".");
		if(index > 0){
			String fileName = filename.substring(0, index);
			String fileExtension = filename.substring(index + 1);
			return fileExtension;
		}else{
			return "";
		}

	}

	/*****************************************************
	암호화된 패스워드 체크<p>
	<b>작성자</b>       : 박종성<br>
	@return 암호화된 패스워드가 맞는지 체크하고 맞으면 true 맞지 않으면 false 를 리턴한다.<br>
	@param board_id 게시판 아이디, list_id 게시물 아이디
	@see QueryManager#selectEntity
	******************************************************/
	
	public String getPassCheckBoardList(int board_id, int list_id, String password){
		if(board_id < 0 ) return "";
		if(list_id < 0 ) return "";		
		String query = 	"select case count(*) when 0 then 'false'  else 'true' end passchk " +
						"from board_list where del_flag='N' and board_id='"+board_id+"' and list_id='"+list_id+"' and list_passwd='"+password+"'";
 
		return 	String.valueOf(querymanager.selectEntity(query)).replace("[", "").replace("]", "");
		
	}

	
	/*****************************************************
	답글 유무 확인<p>
	<b>작성자</b>       : 박종성<br>
	@return 게시물의 답글유무 리턴.<br>
	@param board_id 게시판 아이디, list_id 게시물 아이디
	@see QueryManager#selectEntity
	******************************************************/
	
	public boolean replyCheck(int list_id){
		if(list_id < 0) return false;
		String query = 	"select * from board_list where list_ref = "+list_id+" and del_flag = 'N'";
		try {
			Vector v = querymanager.selectEntities(query);
			if(v != null && v.size() > 1) {
				return true;
			}
			return false;
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
		return 	true;
	}


/************************************************  INSERT  ************************************************/

	/*****************************************************
	게시판글을 등록합니다.(insert문, 파일 등록)<p>
	<b>작성자</b>       : 박종성<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param req HttpServletRequest정보
	@see QueryManager#updateEntities
	******************************************************/
	public int write(HttpServletRequest req, int iSize) throws Exception 
	{
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_BORADLIST;
		String UPLOAD_PATH_IMG = DirectoryNameManager.UPLOAD_BORADLIST_IMG;
		String UPLOAD_PATH_IMG_MIDDLE	= DirectoryNameManager.UPLOAD_BORADLIST_IMG_MIDDLE;
		if(iSize <=0){
			iSize = 20 * 1024 * 1024;
		}
		try {
			MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, iSize, new DefaultFileRenamePolicyITNC21());
		
			int board_id	 = 0;
			String list_name = "";
			String list_title = "";
			String list_contents = "";
			String list_email = "";
			String list_data_file = "";
			String list_image_file = "";
			String list_link = "";
			String list_passwd = "";
			String list_html_use ="f";
			String list_image_file2 = "";
			String list_image_file3 = "";
			String list_image_file4 = "";
			String list_image_file5 = "";
			String list_image_file6 = "";
			String list_image_file7 = "";
			String list_image_file8 = "";
			String list_image_file9 = "";
			String list_image_file10 = "";
			String image_text = "";
			String image_text2 = "";
			String image_text3 = "";
			String image_text4 = "";
			String image_text5 = "";
			String image_text6 = "";
			String image_text7 = "";
			String image_text8 = "";
			String image_text9 = "";
			String image_text10 = "";
			String list_security =  "N";
			String event_seq = "";
			String user_email = "";
			String user_address = "";
			String user_tel = "";
			String user_key = "";
			String list_open="Y";
			
			if(multi.getParameter("board_id") == null || com.vodcaster.utils.TextUtil.getValue(multi.getParameter("board_id")).equals("")){
				return -1;
			}
			try{
				if(multi.getParameter("board_id") !=null && com.yundara.util.TextUtil.isNumeric(multi.getParameter("board_id"))) { 
					board_id = Integer.parseInt(multi.getParameter("board_id"));
				}else{
					return -1;
				}
			}catch(Exception ex){
				return -1;
			}
			
			if(multi.getParameter("event_seq") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("event_seq")).length()>0){
				event_seq = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("event_seq")));
			}
			if(multi.getParameter("user_email") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("user_email")).length()>0){
				user_email = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("user_email")));
				//이메일 암호화
				user_email = com.security.SEEDUtil.getEncrypt(user_email);
			}
			if(multi.getParameter("user_address") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("user_address")).length()>0){
				user_address = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("user_address")));
				//이메일 암호화
				user_address = com.security.SEEDUtil.getEncrypt(user_address);
			}
			
			if(multi.getParameter("user_tel") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("user_tel")).length()>0){
				 user_tel = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("user_tel")));
				 // 연락처 암호화
				 user_tel = com.security.SEEDUtil.getEncrypt(user_tel);
			}
//			if(multi.getParameter("user_key") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("user_key")).length()>0){
//				user_key = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("user_key")));
//			}
							
			if(multi.getParameter("list_name") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_name")).length()>0){
				list_name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_name")));
			}
			
			if(multi.getParameter("list_title") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_title")).length()>0){
				list_title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_title")));
			}
			if(multi.getParameter("list_contents") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_contents")).length()>0){
				list_contents = CharacterSet.toKorean(multi.getParameter("list_contents"));
				list_contents = list_contents
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("‘","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("′","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("’","&#39;")
				.replaceAll("‘","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
				//list_contents = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_contents")));
			}
			if(multi.getParameter("list_email") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_email")).length()>0){
				list_email = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_email")));
			}
			if( multi.getParameter("list_link") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_link")).length()>0){
				list_link = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_link")));
			}
//			if(multi.getParameter("list_passwd") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_passwd")).length()>0){
//			list_passwd = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_passwd"));
//			}
			if(multi.getParameter("list_html_use") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_html_use")).length()>0){
			list_html_use = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_html_use"));
			}
			if(multi.getParameter("list_security") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_security")).length()>0){
				list_security = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_security"));
			}
			if(multi.getParameter("list_open") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_open")).length()>0){
				list_open = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_open"));
			}
			 
			
			if(multi.getParameter("image_text") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text")).length()>0){
				image_text = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text")));
			}
			if(multi.getParameter("image_text2") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text2")).length()>0){
				image_text2 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text2")));
			}
			if(multi.getParameter("image_text3") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text3")).length()>0){
				image_text3 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text3")));
			}
			if(multi.getParameter("image_text4") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text4")).length()>0){
				image_text4 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text4")));
			}
			if(multi.getParameter("image_text5") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text5")).length()>0){
				image_text5 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text5")));
			}
			if(multi.getParameter("image_text6") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text6")).length()>0){
				image_text6 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text6")));
			}
			if(multi.getParameter("image_text7") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text7")).length()>0){
				image_text7 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text7")));
			}
			if(multi.getParameter("image_text8") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text8")).length()>0){
				image_text8 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text8")));
			}
			if(multi.getParameter("image_text9") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text9")).length()>0){
				image_text9 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text9")));
			}
			if(multi.getParameter("image_text10") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text10")).length()>0){
				image_text10 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text10")));
			}
	
				try {
					list_image_file = multi.getFilesystemName("list_image_file");
					 
					list_image_file = createThumbnail(list_image_file);
					
				} catch(Exception e) {
					list_image_file = "";
				}
				try {
					list_image_file2 = multi.getFilesystemName("list_image_file2");
					list_image_file2 = createThumbnail(list_image_file2);
				} catch(Exception e) {
					list_image_file2 = "";
				}
				try {
					list_image_file3 = multi.getFilesystemName("list_image_file3");
					list_image_file3 = createThumbnail(list_image_file3);
				} catch(Exception e) {
					list_image_file3 = "";
				}
				try {
					list_image_file4 = multi.getFilesystemName("list_image_file4");
					list_image_file4 = createThumbnail(list_image_file4);
				} catch(Exception e) {
					list_image_file4 = "";
				}
				try {
					list_image_file5 = multi.getFilesystemName("list_image_file5");
					list_image_file5 = createThumbnail(list_image_file5);
				} catch(Exception e) {
					list_image_file5 = "";
				}
				try {
					list_image_file6 = multi.getFilesystemName("list_image_file6");
					list_image_file6 = createThumbnail(list_image_file6);
				} catch(Exception e) {
					list_image_file6 = "";
				}
				try {
					list_image_file7 = multi.getFilesystemName("list_image_file7");
					list_image_file7 = createThumbnail(list_image_file7);
				} catch(Exception e) {
					list_image_file7 = "";
				}
				try {
					list_image_file8 = multi.getFilesystemName("list_image_file8");
					list_image_file8 = createThumbnail(list_image_file8);
				} catch(Exception e) {
					list_image_file8 = "";
				}
				try {
					list_image_file9 = multi.getFilesystemName("list_image_file9");
					list_image_file9 = createThumbnail(list_image_file9);
				} catch(Exception e) {
					list_image_file9 = "";
				}
				try {
					list_image_file10 = multi.getFilesystemName("list_image_file10");
					list_image_file10 = createThumbnail(list_image_file10);
				} catch(Exception e) {
					list_image_file10 = "";
				}
				
				String org_attach_name = "";
				try {
					org_attach_name = CharacterSet.toKorean(multi.getOriginalFileName("list_data_file"));
					list_data_file = multi.getFilesystemName("list_data_file");
					String ext = com.vodcaster.utils.TextUtil.getExtension(list_data_file);
					if(!ext.equals("")){
						if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"ATTACH")){
							File del_file_file = new File(UPLOAD_PATH+"/"+list_data_file);
							del_file_file.delete(); // 기존 파일삭제
						}
					}else{
						list_data_file="";
						 org_attach_name = "";
					}
				} catch(Exception e) {
					list_data_file="";
					 org_attach_name = "";
				}

			HttpSession session = req.getSession(false);
			
			if(multi.getParameter("list_name") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_name")).length() > 0 && multi.getParameter("list_passwd") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_passwd")).length()>0){
				// 추가 2015-06-22 비인증 사용자 글쓰기 허용
				list_name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_name")));
				list_passwd = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_passwd"));
				list_passwd = SEEDUtil.getEncrypt(list_passwd);
	 
			} else {
				if ( session.getAttribute("vod_name") != null && ((String) session.getAttribute("vod_name")).length() > 0) {  // 관리자, 모니터링단 로그인 아이디로 등록 
					list_name = com.vodcaster.utils.TextUtil.getValue((String) session.getAttribute("vod_id"));  
					list_passwd = com.vodcaster.utils.TextUtil.getValue((String) session.getAttribute("user_key"));
				} else {
					System.err.println("board_write error: 등록자 정보 없음");
					return -1;
				}
			} 
			
			int list_id = 1;
					
			Vector v = null;
			try{
				v = querymanager.selectEntity("select max(list_id) from board_list");
			}catch(ArrayIndexOutOfBoundsException e){
				System.err.println("boardListSqlBean write1 ex : "+e);
			}
			if(v != null && v.size() > 0){
				try{
					if(Integer.parseInt(String.valueOf(v.elementAt(0))) != 0)
						list_id = Integer.parseInt(String.valueOf(v.elementAt(0))) + 1;
					else list_id = 1;
				}catch(Exception e){
					System.err.println("boardListSqlBean write2 ex : "+e);
				}
			}else{
				list_id = 1;
			}
	
//			if (event_seq != null && event_seq.length() > 0) { // event_user 등록
//				try {
//				String sub_query = " insert into event_user ( event_seq, ocode, user_key, user_tel, user_email, etc) values (" +
//						" '"+event_seq+"','"+list_id+"','"+user_key+"','"+user_tel+"','"+user_email+"','') ";
//				 querymanager.updateEntities(sub_query);
//				} catch(Exception e) {
//					return -99;
//				}
//			} else {
//				event_seq = "null"; // event_seq 가 int 형이라 '' 일경우 에러 발생하여 null 값 입력
//			}
			
			String query = "insert into board_list "+
			"(list_id, board_id, list_name, list_title, list_contents, list_email, list_image_file, list_data_file, list_open, "+
			" list_link, list_passwd, list_date, list_ref, list_html_use,list_image_file2,list_image_file3,list_image_file4," +
			" list_image_file5,list_image_file6, list_image_file7, list_image_file8, list_image_file9, list_image_file10," +
			" image_text,image_text2, image_text3, image_text4, image_text5, image_text6, image_text7, image_text8, image_text9, image_text10 ,ip, list_security, event_seq, org_attach_name, address1, tel) values("+
			list_id+", "+board_id+", '"+list_name+"', '"+list_title+"', '"+list_contents+"', '"+list_email+"', '"+
			list_image_file+"', '"+list_data_file+"','"+list_open+"','"+list_link+"' ,'"+list_passwd+"', now(), "+list_id+", '"+list_html_use+"', '"+list_image_file2
			+"', '"+list_image_file3+"', '"+list_image_file4+"', '"+list_image_file5+"', '"+list_image_file6+"', '"+list_image_file7+"', '"+list_image_file8+"', '"+list_image_file9
			+"', '"+list_image_file10+"', '"+image_text+"', '"+image_text2+"', '"+image_text3+"', '"+image_text4+"', '"+image_text5+"', '"+image_text6+"', '"+image_text7
			+"', '"+image_text8+"', '"+image_text9+"', '"+image_text10+"' ,'"+req.getRemoteAddr()+"','"+list_security+"',"+event_seq+",'"+org_attach_name+"','"+user_address+"','"+user_tel+"')";
	
 //System.out.println(query);
			return querymanager.updateEntities(query);
		} catch(Exception e) {
			System.out.println("write_error:"+e);
			return -99;
		}
	} 

	public String createThumbnail(String imgName)
	{
		try{
			String UPLOAD_PATH = DirectoryNameManager.UPLOAD_BORADLIST;
			String UPLOAD_PATH_IMG = DirectoryNameManager.UPLOAD_BORADLIST_IMG;
			String UPLOAD_PATH_IMG_MIDDLE	= DirectoryNameManager.UPLOAD_BORADLIST_IMG_MIDDLE;
			String ext = com.vodcaster.utils.TextUtil.getExtension(imgName);
		 
			if(!ext.equals("")){
				if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"IMG")){
					File del_file_file = new File(UPLOAD_PATH+"/"+imgName);
					del_file_file.delete(); // 기존 파일삭제
					 
				}else{
					 
					Thumbnail.createThumb(UPLOAD_PATH + "/" + imgName, UPLOAD_PATH_IMG+ "/" + imgName, 120, 120);			// 썸네일 생성
					Thumbnail.createThumb(UPLOAD_PATH + "/" + imgName, UPLOAD_PATH_IMG_MIDDLE+ "/" + imgName, 600, 600);			// 썸네일 생성
				}
			}else{
				imgName="";
			}
		}catch(Exception ex){
			System.err.println(" createThumbnail exception : " + ex);
		}
		return imgName;
	}
	/*****************************************************
	관리자 게시판글을 등록합니다.(insert문, 파일 등록)<p>
	<b>작성자</b>       : 박종성<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param req HttpServletRequest정보
	@see QueryManager#updateEntities
	******************************************************/	
	public int write_man(HttpServletRequest req, int iSize) throws Exception 
	{
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_BORADLIST;
		String UPLOAD_PATH_IMG = DirectoryNameManager.UPLOAD_BORADLIST_IMG;
		String UPLOAD_PATH_IMG_MIDDLE	= DirectoryNameManager.UPLOAD_BORADLIST_IMG_MIDDLE;
		if(iSize <=0){
			iSize = 20 * 1024 * 1024;
		} 
		
		 
		try {
			MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, iSize, new DefaultFileRenamePolicyITNC21());
		
			int board_id	 = 0;
			String list_name = "";
			String list_title = "";
			String list_contents = "";
			String list_email = "";
			String list_data_file = "";
			String list_image_file = "";
			String list_link = "";
			String list_passwd = "";
			String list_html_use ="f";
			String list_image_file2 = "";
			String list_image_file3 = "";
			String list_image_file4 = "";
			String list_image_file5 = "";
			String list_image_file6 = "";
			String list_image_file7 = "";
			String list_image_file8 = "";
			String list_image_file9 = "";
			String list_image_file10 = "";
			String image_text = "";
			String image_text2 = "";
			String image_text3 = "";
			String image_text4 = "";
			String image_text5 = "";
			String image_text6 = "";
			String image_text7 = "";
			String image_text8 = "";
			String image_text9 = "";
			String image_text10 = "";
			String list_security = "N";
			String rsdate = "";
			String redate = "";
			
			if(multi.getParameter("board_id") == null || com.vodcaster.utils.TextUtil.getValue(multi.getParameter("board_id")).equals("")
					|| !com.yundara.util.TextUtil.isNumeric(multi.getParameter("board_id"))){
				return -1;
			}
			try{
				if(multi.getParameter("board_id") !=null && com.yundara.util.TextUtil.isNumeric(multi.getParameter("board_id")))  
					board_id = Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("board_id")));
			}catch(Exception ex){
				System.err.println(ex);
				return -1;
			}
			if(multi.getParameter("list_name") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_name")).length()>0){
				list_name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_name")));
			}else{
				return -1;
			}
			if(multi.getParameter("list_title") != null &&com.vodcaster.utils.TextUtil.getValue( multi.getParameter("list_title")).length()>0){
				list_title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_title")));
			}else{
				return -1;
			}
			if(multi.getParameter("list_contents") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_contents")).length()>0){
				list_contents = CharacterSet.toKorean(multi.getParameter("list_contents"));
				list_contents = list_contents
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("‘","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("′","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("’","&#39;")
				.replaceAll("‘","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
			}
			if(multi.getParameter("list_email") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_email")).length()>0){
				list_email = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_email")));
			}
			if(multi.getParameter("list_link") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_link")).length()>0){
				list_link = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_link")));
			}
			if(multi.getParameter("list_passwd") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_passwd")).length()>0){
			list_passwd = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_passwd"));
			}
			if(multi.getParameter("list_html_use") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_html_use")).length()>0){
			list_html_use = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_html_use"));
			}
			if(multi.getParameter("list_security") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_security")).length()>0){
				list_security = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_security"));
			}
			
			if(multi.getParameter("image_text") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text")).length()>0){
				image_text = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text")));
			}
			if(multi.getParameter("image_text2") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text2")).length()>0){
				image_text2 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text2")));
			}
			if(multi.getParameter("image_text3") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text3")).length()>0){
				image_text3 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text3")));
			}
			if(multi.getParameter("image_text4") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text4")).length()>0){
				image_text4 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text4")));
			}
			if(multi.getParameter("image_text5") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text5")).length()>0){
				image_text5 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text5")));
			}
			if(multi.getParameter("image_text6") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text6")).length()>0){
				image_text6 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text6")));
			}
			if(multi.getParameter("image_text7") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text7")).length()>0){
				image_text7 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text7")));
			}
			if(multi.getParameter("image_text8") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text8")).length()>0){
				image_text8 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text8")));
			}
			if(multi.getParameter("image_text9") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text9")).length()>0){
				image_text9 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text9")));
			}
			if(multi.getParameter("image_text10") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text10")).length()>0){
				image_text10 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text10")));
			}
			
			if(multi.getParameter("rsdate") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rsdate")).length()>0){
				rsdate = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rsdate")));
			}
			if(multi.getParameter("redate") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("redate")).length()>0){
				redate = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("redate")));
			}

			
			try {
				list_image_file = multi.getFilesystemName("list_image_file");
				list_image_file = createThumbnail(list_image_file);
			} catch(Exception e) {
				list_image_file = "";
			}
			try {
				list_image_file2 = multi.getFilesystemName("list_image_file2");
				list_image_file2 = createThumbnail(list_image_file2);
			} catch(Exception e) {
				list_image_file2 = "";
			}
			try {
				list_image_file3 = multi.getFilesystemName("list_image_file3");
				list_image_file3 = createThumbnail(list_image_file3);
			} catch(Exception e) {
				list_image_file3 = "";
			}
			try {
				list_image_file4 = multi.getFilesystemName("list_image_file4");
				list_image_file4 = createThumbnail(list_image_file4);
			} catch(Exception e) {
				list_image_file4 = "";
			}
			try {
				list_image_file5 = multi.getFilesystemName("list_image_file5");
				list_image_file5 = createThumbnail(list_image_file5);
			} catch(Exception e) {
				list_image_file5 = "";
			}
			try {
				list_image_file6 = multi.getFilesystemName("list_image_file6");
				list_image_file6 = createThumbnail(list_image_file6);
			} catch(Exception e) {
				list_image_file6 = "";
			}
			try {
				list_image_file7 = multi.getFilesystemName("list_image_file7");
				list_image_file7 = createThumbnail(list_image_file7);
			} catch(Exception e) {
				list_image_file7 = "";
			}
			try {
				list_image_file8 = multi.getFilesystemName("list_image_file8");
				list_image_file8 = createThumbnail(list_image_file8);
			} catch(Exception e) {
				list_image_file8 = "";
			}
			try {
				list_image_file9 = multi.getFilesystemName("list_image_file9");
				list_image_file9 = createThumbnail(list_image_file9);
			} catch(Exception e) {
				list_image_file9 = "";
			}
			try {
				list_image_file10 = multi.getFilesystemName("list_image_file10");
				list_image_file10 = createThumbnail(list_image_file10);
			} catch(Exception e) {
				list_image_file10 = "";
			}
			
			String org_attach_name = "";
			try {
				org_attach_name = CharacterSet.toKorean(multi.getOriginalFileName("list_data_file"));
				list_data_file = multi.getFilesystemName("list_data_file");
				String ext = com.vodcaster.utils.TextUtil.getExtension(list_data_file);
				if(!ext.equals("")){
					if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"ATTACH")){
						File del_file_file = new File(UPLOAD_PATH+"/"+list_data_file);
						del_file_file.delete(); // 기존 파일삭제
					}
				}else{
					list_data_file="";
					org_attach_name = "";
				}
			} catch(Exception e) {
				list_data_file="";
				org_attach_name = "";
			}
	
			int list_id = 1;
					
			Vector v = null;
			try{
				v = querymanager.selectEntity("select max(list_id) from board_list");
			}catch(ArrayIndexOutOfBoundsException e){
				System.err.println("boardListSqlBean write1 ex : "+e);
			}
			if(v != null && v.size() > 0){
				try{
					if(Integer.parseInt(String.valueOf(v.elementAt(0))) != 0)
						list_id = Integer.parseInt(String.valueOf(v.elementAt(0))) + 1;
					else list_id = 1;
				}catch(Exception e){
					System.err.println("boardListSqlBean write2 ex : "+e);
				}
			}else{
				list_id = 1;
			}
	
			String query = "insert into board_list "+
				"(list_id, board_id, list_name, list_title, list_contents, list_email, list_image_file, list_data_file, "+
				" list_link, list_passwd, list_date, list_ref, list_html_use,list_image_file2,list_image_file3,list_image_file4," +
				" list_image_file5,list_image_file6, list_image_file7, list_image_file8, list_image_file9, list_image_file10," +
				" image_text,image_text2, image_text3, image_text4, image_text5, image_text6, image_text7, image_text8, " +
				"image_text9, image_text10,ip , list_open, list_security, org_attach_name, rsdate,redate) values("+
				list_id+", "+board_id+", '"+list_name+"', '"+list_title+"', '"+list_contents+"', '"+list_email+"', '"+
				""+list_image_file+"', '"+list_data_file+"','"+list_link+"' ,password('"+list_passwd+"'), now(), "+list_id+", '"+list_html_use+"', '"+list_image_file2
				+"', '"+list_image_file3+"', '"+list_image_file4+"', '"+list_image_file5+"', '"+list_image_file6+"', '"+list_image_file7+"', '"+list_image_file8+"', '"+list_image_file9
				+"', '"+list_image_file10+"', '"+image_text+"', '"+image_text2+"', '"+image_text3+"', '"+image_text4+"', '"+image_text5+"', '"+image_text6+"', '"+image_text7
				+"', '"+image_text8+"', '"+image_text9+"', '"+image_text10+"','"+req.getRemoteAddr()+"','Y','"+list_security+"','"+org_attach_name+"','"+rsdate+"','"+redate+"')";
	
			//System.out.println(query);
			return querymanager.updateEntities(query);
		} catch(Exception e) {
			return -99;
		}
	}

	/*****************************************************
	게시판의 답변글을 등록합니다.(insert문, 파일 등록)<p>
	<b>작성자</b>       : 박종성<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param req HttpServletRequest정보
	@see QueryManager#updateEntities
	******************************************************/	
	public int reply_man(HttpServletRequest req, int iSize) throws Exception 
	{

		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_BORADLIST;
		String UPLOAD_PATH_IMG = DirectoryNameManager.UPLOAD_BORADLIST_IMG;
		String UPLOAD_PATH_IMG_MIDDLE	= DirectoryNameManager.UPLOAD_BORADLIST_IMG_MIDDLE;
		if(iSize <=0){
			iSize = 20 * 1024 * 1024;
		}
		
		try {
	 		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, iSize, new DefaultFileRenamePolicyITNC21());
				
			int board_id	 = 0;
			int list_id	= 0;
			String list_name = "";
			String list_title = "";
			String list_contents = "";
			String list_email = "";
			String list_data_file = "";
			String list_image_file = "";
			String list_link = "";
			String list_passwd = "";
			String list_html_use ="f";
			String list_image_file2 = "";
			String list_image_file3 = "";
			String list_image_file4 = "";
			String list_image_file5 = "";
			String list_image_file6 = "";
			String list_image_file7 = "";
			String list_image_file8 = "";
			String list_image_file9 = "";
			String list_image_file10 = "";
			String image_text = "";
			String image_text2 = "";
			String image_text3 = "";
			String image_text4 = "";
			String image_text5 = "";
			String image_text6 = "";
			String image_text7 = "";
			String image_text8 = "";
			String image_text9 = "";
			String image_text10 = "";
			String list_security =  "N";
			try{
				if(multi.getParameter("board_id") !=null ) {
					board_id = Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("board_id")));
				}else{
					return -1;
				}
			}catch(Exception ex){
				return -1;
			}
			try{
				if(multi.getParameter("list_id") !=null ) {
					list_id = Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_id")));
				}else{
					return -1;
				}
			}catch(Exception ex){
				return -1;
			}
			if(multi.getParameter("list_name") !=null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_name")).length()>0) 
				list_name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_name")));
			if(multi.getParameter("list_title") !=null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_title")).length()>0) 
				list_title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_title")));
			if(multi.getParameter("list_contents") !=null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_contents")).length()>0) 
				list_contents = CharacterSet.toKorean(multi.getParameter("list_contents"));
			list_contents = list_contents
			//.replaceAll("&","&amp;")
			//.replaceAll("#","&#35;")
			.replaceAll("‘","&#39;")
			.replaceAll("`","&#39;")			
			.replaceAll("′","&#39;")
			.replaceAll("'","&#39;")
			.replaceAll("’","&#39;")
			.replaceAll("‘","&#39;")
			.replaceAll("'","&#39;")
			.replaceAll("\"","&quot;");
			if(multi.getParameter("list_email") !=null ) 
				list_email = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_email"));
			if(multi.getParameter("list_link") !=null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_link")).length()>0) 
				list_link = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_link")));
			if(multi.getParameter("list_passwd") !=null ) 
				list_passwd = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_passwd"));
			if(multi.getParameter("list_html_use") !=null ) 
				list_html_use = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_html_use"));
			if(multi.getParameter("list_security") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_security")).length()>0){
				list_security = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_security"));
			}
			
			if(multi.getParameter("image_text") != null || com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text")).length()>0){
				image_text = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text")));
			}
			if(multi.getParameter("image_text2") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text2")).length()>0){
				image_text2 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text2")));
			}
			if(multi.getParameter("image_text3") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text3")).length()>0){
				image_text3 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text3")));
			}
			if(multi.getParameter("image_text4") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text4")).length()>0){
				image_text4 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text4")));
			}
			if(multi.getParameter("image_text5") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text5")).length()>0){
				image_text5 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text5")));
			}
			if(multi.getParameter("image_text6") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text6")).length()>0){
				image_text6 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text6")));
			}
			if(multi.getParameter("image_text7") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text7")).length()>0){
				image_text7 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text7")));
			}
			if(multi.getParameter("image_text8") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text8")).length()>0){
				image_text8 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text8")));
			}
			if(multi.getParameter("image_text9") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text9")).length()>0){
				image_text9 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text9")));
			}
			if(multi.getParameter("image_text10") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text10")).length()>0){
				image_text10 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text10")));
			}
	
			try {
				list_image_file = multi.getFilesystemName("list_image_file");
				list_image_file = createThumbnail(list_image_file);
			} catch(Exception e) {
				list_image_file = "";
			}
			try {
				list_image_file2 = multi.getFilesystemName("list_image_file2");
				list_image_file2 = createThumbnail(list_image_file2);
			} catch(Exception e) {
				list_image_file2 = "";
			}
			try {
				list_image_file3 = multi.getFilesystemName("list_image_file3");
				list_image_file3 = createThumbnail(list_image_file3);
			} catch(Exception e) {
				list_image_file3 = "";
			}
			try {
				list_image_file4 = multi.getFilesystemName("list_image_file4");
				list_image_file4 = createThumbnail(list_image_file4);
			} catch(Exception e) {
				list_image_file4 = "";
			}
			try {
				list_image_file5 = multi.getFilesystemName("list_image_file5");
				list_image_file5 = createThumbnail(list_image_file5);
			} catch(Exception e) {
				list_image_file5 = "";
			}
			try {
				list_image_file6 = multi.getFilesystemName("list_image_file6");
				list_image_file6 = createThumbnail(list_image_file6);
			} catch(Exception e) {
				list_image_file6 = "";
			}
			try {
				list_image_file7 = multi.getFilesystemName("list_image_file7");
				list_image_file7 = createThumbnail(list_image_file7);
			} catch(Exception e) {
				list_image_file7 = "";
			}
			try {
				list_image_file8 = multi.getFilesystemName("list_image_file8");
				list_image_file8 = createThumbnail(list_image_file8);
			} catch(Exception e) {
				list_image_file8 = "";
			}
			try {
				list_image_file9 = multi.getFilesystemName("list_image_file9");
				list_image_file9 = createThumbnail(list_image_file9);
			} catch(Exception e) {
				list_image_file9 = "";
			}
			try {
				list_image_file10 = multi.getFilesystemName("list_image_file10");
				list_image_file10 = createThumbnail(list_image_file10);
			} catch(Exception e) {
				list_image_file10 = "";
			}
			
			String org_attach_name = "";
			try {
				org_attach_name = CharacterSet.toKorean(multi.getOriginalFileName("list_data_file"));
				list_data_file = multi.getFilesystemName("list_data_file");
				String ext = com.vodcaster.utils.TextUtil.getExtension(list_data_file);
				if(!ext.equals("")){
					if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"ATTACH")){
						File del_file_file = new File(UPLOAD_PATH+"/"+list_data_file);
						del_file_file.delete(); // 기존 파일삭제
					}
				}else{
					list_data_file="";
					org_attach_name = "";
				}
			} catch(Exception e) {
				list_data_file="";
				org_attach_name = "";
			}
	
			int list_ref = list_id;
			int list_step=0;
			int list_re_level =0;
	
			Vector v_re = null;
			try{
				v_re = querymanager.selectEntity("select * from board_list where list_id = "+ list_id);
				if(v_re != null && v_re.size() > 0){
					list_ref = Integer.parseInt(String.valueOf(v_re.elementAt(13)));
					list_step = Integer.parseInt(String.valueOf(v_re.elementAt(14)));
					list_re_level = Integer.parseInt(String.valueOf(v_re.elementAt(11)));
				}
			}catch(ArrayIndexOutOfBoundsException e){
				System.err.println("boardListSqlBean reply ex : "+e);
			}
			
			
			// 답변한 게시물과 관련된 게시물들의 list_step을 1씩 증가
			String query = "update board_list set list_step = list_step + 1 where list_ref = "+list_ref+" and list_step > "+list_step;
	
			int c = querymanager.updateEntities(query);
			
			Vector v = null;
			try{
				v = querymanager.selectEntity("select max(list_id) from board_list");
				if(v != null && v.size() > 0){
					try{
						if(Integer.parseInt(String.valueOf(v.elementAt(0))) != 0)
							list_id = Integer.parseInt(String.valueOf(v.elementAt(0))) + 1;
						else list_id = 1;
					}catch(Exception e){
						System.err.println("boardListSqlBean reply2 ex : "+e);
					}
				}else{
					list_id = 1;
				}
			}catch(ArrayIndexOutOfBoundsException e){
				System.err.println("boardListSqlBean reply1 ex : "+e);
			}
			
	/*
			query = 
			"insert into board_list " + 
			"(list_id, board_id, list_name, list_title, list_contents, list_email, list_passwd, list_date, "+
			" list_ref, list_html_use, list_step, list_re_level) "+
			"values("+list_id+", "+board_id+", '"+list_name+"', '"+list_title+"', '"+list_contents+"', '"+list_email+"',password('"+
			list_passwd+"'),now(), "+list_ref+", '"+list_html_use+"', "+(++list_step)+", "+(++list_re_level)+")";
	*/
			
			query = "insert into board_list "+
			"(list_id, board_id, list_name, list_title, list_contents, list_email, list_image_file, list_data_file, "+
			" list_link, list_passwd, list_date, list_ref,list_step, list_re_level, list_html_use," +
			" list_image_file2, list_image_file3, list_image_file4, list_image_file5,list_image_file6,list_image_file7,list_image_file8,list_image_file9,list_image_file10," +
			" image_text,image_text2,image_text3,image_text4,image_text5,image_text6,image_text7,image_text8,image_text9,image_text10,ip,list_security,org_attach_name) values("+
			list_id+", "+board_id+", '"+list_name+"', '"+list_title+"', '"+list_contents+"', '"+list_email+"', '"+
			""+list_image_file+"', '"+list_data_file+"','"+list_link+"' ,password('"+list_passwd+"'), now(), "
			+list_ref+", "+(++list_step)+", "+(++list_re_level)+", '"+list_html_use
			+"', '"+list_image_file2+"', '"+list_image_file3+"', '"+list_image_file4+"', '"+list_image_file5+"', '"+list_image_file6
			+"', '"+list_image_file7+"', '"+list_image_file8+"', '"+list_image_file9+"', '"+list_image_file10
			+"', '"+image_text+"', '"+image_text2+"', '"+image_text3+"', '"+image_text4+"', '"+image_text5+"', '"
			+image_text6+"', '"+image_text7+"', '"+image_text8+"', '"+image_text9+"', '"+image_text10+"' , '"+req.getRemoteAddr()+"','"+list_security+"','"+org_attach_name+"' )";
	
			return querymanager.updateEntities(query);
		} catch(Exception e) {
			return -99;
		}
	}



/************************************************  UPDATE  ************************************************/

	/*****************************************************
	특정 게시판글의 조회수를 갱신합니다.<p>
	<b>작성자</b>       : 박종성<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param board_id 게시판 아이디, list_id 게시물 아이디
	@see QueryManager#updateEntities
	******************************************************/
	public int updateCount(int board_id, int list_id) throws Exception 
	{
		if(board_id <0) return -1;
		if(list_id < 0) return -1;
        String query = "";

        query ="update board_list set list_read_count = list_read_count+1 where board_id ="+board_id +" and list_id = "+list_id;

		return querymanager.updateEntities(query);

	}

	/*****************************************************
	특정 게시판글의 공개여부를 변경합니다.<p>
	<b>작성자</b>       : 박종성<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param list_id 게시물 아이디, flag 공개여부
	@see QueryManager#updateEntities
	******************************************************/

	public int update_listOpen(String list_id, String flag ) throws Exception{
		if(list_id == null || com.vodcaster.utils.TextUtil.getValue(list_id).equals("") || !com.yundara.util.TextUtil.isNumeric(list_id)) return -1;
		list_id = com.vodcaster.utils.TextUtil.getValue(list_id);
		flag = com.vodcaster.utils.TextUtil.getValue(flag);
		//String query = "update board_list set open_space='"+flag+"', list_date=now() where list_id="+list_id;
		String query = "update board_list set list_open='"+flag+"'  where list_id="+list_id;
	
		return querymanager.updateEntities(query);
	}
	
	/*****************************************************
	특정 게시판글의 공지여부를 변경합니다.<p>
	<b>작성자</b>       : 박종성<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param list_id 게시물 아이디, flag 공지여부
	@see QueryManager#updateEntities
	******************************************************/

	public int update_main(String list_id, String flag ) throws Exception{
		if(list_id == null || com.vodcaster.utils.TextUtil.getValue(list_id).equals("") || !com.yundara.util.TextUtil.isNumeric(list_id)) return -1;
		list_id = com.vodcaster.utils.TextUtil.getValue(list_id);
		flag = com.vodcaster.utils.TextUtil.getValue(flag);
		
		//String query = "update board_list set open_space='"+flag+"', list_date=now() where list_id="+list_id;
		String query = "update board_list set open_space='"+flag+"'  where list_id="+list_id;
	
		return querymanager.updateEntities(query);
	}
	


	/*****************************************************
	게시판글을 수정합니다.(update문, 파일 수정)<p>
	<b>작성자</b>       : 박종성<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param req HttpServletRequest정보
	@see QueryManager#updateEntities
	******************************************************/
	public int update(HttpServletRequest req, int iSize) throws Exception 
	{
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_BORADLIST;
		String UPLOAD_PATH_IMG = DirectoryNameManager.UPLOAD_BORADLIST_IMG;
		String UPLOAD_PATH_IMG_MIDDLE	= DirectoryNameManager.UPLOAD_BORADLIST_IMG_MIDDLE;
		if(iSize <=0){
			iSize = 20 * 1024 * 1024;
		}
		try {
			MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, iSize, new DefaultFileRenamePolicyITNC21());
	
			int board_id	 = 0;
			int list_id      =0;
			String list_name = "";
			String list_title = "";
			String list_contents = "";
			String list_email = "";
			String list_data_file = "";
			String list_image_file = "";
			String list_link = "";
			String list_passwd = "";
			String list_html_use ="f";
			String list_image_file2 = "";
			String list_image_file3 = "";
			String list_image_file4 = "";
			String list_image_file5 = "";
			String list_image_file6 = "";
			String list_image_file7 = "";
			String list_image_file8 = "";
			String list_image_file9 = "";
			String list_image_file10 = "";
			String image_text = "";
			String image_text2 = "";
			String image_text3 = "";
			String image_text4 = "";
			String image_text5 = "";
			String image_text6 = "";
			String image_text7 = "";
			String image_text8 = "";
			String image_text9 = "";
			String image_text10 = "";
			
	
			String list_image_del = "N";
			String list_image_del2 = "N";
			String list_image_del3 = "N";
			String list_image_del4 = "N";
			String list_image_del5 = "N";
			String list_image_del6 = "N";
			String list_image_del7 = "N";
			String list_image_del8 = "N";
			String list_image_del9 = "N";
			String list_image_del10 = "N";
			String list_data_del = "N";
			String open_space = "N";
			String list_security = "N";
 
		 
			try{
				if(multi.getParameter("board_id") !=null && com.yundara.util.TextUtil.isNumeric(multi.getParameter("board_id")))  {
					board_id = Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("board_id")));
				}else{
					return -1;
				}
			}catch(Exception ex){
				System.err.println("board_id:"+ex);
				return -1;
			}
			
			try{
				if(multi.getParameter("list_id") !=null && com.yundara.util.TextUtil.isNumeric(multi.getParameter("list_id")))  {
					list_id = Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_id")));
				}else{
					return -1;
				}
			}catch(Exception ex){
				System.err.println("list_id:"+ex);
				return -1;
			}
			/*
			if(multi.getParameter("list_name") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_name")).length()>0){
				list_name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_name")));
			}else{
				return -1;
			}
			*/
			if(multi.getParameter("list_title") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_title")).length()>0){
				list_title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_title")));
			}
			if(multi.getParameter("list_contents") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_contents")).length()>0){
				list_contents = CharacterSet.toKorean(multi.getParameter("list_contents"));
				list_contents = list_contents
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("‘","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("′","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("’","&#39;")
				.replaceAll("‘","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
				//list_contents = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_contents")));
			}
			if(multi.getParameter("list_email") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_email")).length()>0){
				list_email = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_email")));
			}
			if(multi.getParameter("list_link") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_link")).length()>0){
				list_link = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_link")));
			}
			if(multi.getParameter("list_passwd") != null){
				list_passwd = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_passwd"));
			}
			if(multi.getParameter("list_html_use") != null){
				list_html_use = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_html_use"));
			}
			if(multi.getParameter("list_security") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_security")).length()>0){
				list_security = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_security"));
			}
			if(multi.getParameter("open_space") !=null ) 
				open_space = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("open_space"));
	
			if(multi.getParameter("list_image_del") !=null ) 
				list_image_del = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del"));
			if(multi.getParameter("list_image_del2") !=null ) 
				list_image_del2 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del2"));
			if(multi.getParameter("list_image_del3") !=null ) 
				list_image_del3 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del3"));
			if(multi.getParameter("list_image_del4") !=null ) 
				list_image_del4 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del4"));
			if(multi.getParameter("list_image_del5") !=null ) 
				list_image_del5 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del5"));
			if(multi.getParameter("list_image_del6") !=null ) 
				list_image_del6 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del6"));
			if(multi.getParameter("list_image_del7") !=null ) 
				list_image_del7 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del7"));
			if(multi.getParameter("list_image_del8") !=null ) 
				list_image_del8 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del8"));
			if(multi.getParameter("list_image_del9") !=null ) 
				list_image_del9 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del9"));
			if(multi.getParameter("list_image_del10") !=null ) 
				list_image_del10 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del10"));
			if(multi.getParameter("list_data_del") !=null ) 
				list_data_del = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_data_del"));
	
			if(multi.getParameter("image_text") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text")).length()>0){
				image_text = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text")));
			}
			if(multi.getParameter("image_text2") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text2")).length()>0){
				image_text2 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text2")));
			}
			if(multi.getParameter("image_text3") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text3")).length()>0){
				image_text3 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text3")));
			}
			if(multi.getParameter("image_text4") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text4")).length()>0){
				image_text4 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text4")));
			}
			if(multi.getParameter("image_text5") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text5")).length()>0){
				image_text5 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text5")));
			}
			if(multi.getParameter("image_text6") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text6")).length()>0){
				image_text6 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text6")));
			}
			if(multi.getParameter("image_text7") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text7")).length() > 0){
				image_text7 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text7")));
			}
			if(multi.getParameter("image_text8") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text8")).length()>0){
				image_text8 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text8")));
			}
			if(multi.getParameter("image_text9") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text9")).length()>0){
				image_text9 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text9")));
			}
			if(multi.getParameter("image_text10") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text10")).length()>0){
				image_text10 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text10")));
			}
			
				try {
					list_image_file = multi.getFilesystemName("list_image_file");
					list_image_file = createThumbnail(list_image_file);
				} catch(Exception e) {
					list_image_file = "";
				}
				try {
					list_image_file2 = multi.getFilesystemName("list_image_file2");
					list_image_file2 = createThumbnail(list_image_file2);
				} catch(Exception e) {
					list_image_file2 = "";
				}
				try {
					list_image_file3 = multi.getFilesystemName("list_image_file3");
					list_image_file3 = createThumbnail(list_image_file3);
				} catch(Exception e) {
					list_image_file3 = "";
				}
				try {
					list_image_file4 = multi.getFilesystemName("list_image_file4");
					list_image_file4 = createThumbnail(list_image_file4);
				} catch(Exception e) {
					list_image_file4 = "";
				}
				try {
					list_image_file5 = multi.getFilesystemName("list_image_file5");
					list_image_file5 = createThumbnail(list_image_file5);
				} catch(Exception e) {
					list_image_file5 = "";
				}
				try {
					list_image_file6 = multi.getFilesystemName("list_image_file6");
					list_image_file6 = createThumbnail(list_image_file6);
				} catch(Exception e) {
					list_image_file6 = "";
				}
				try {
					list_image_file7 = multi.getFilesystemName("list_image_file7");
					list_image_file7 = createThumbnail(list_image_file7);
				} catch(Exception e) {
					list_image_file7 = "";
				}
				try {
					list_image_file8 = multi.getFilesystemName("list_image_file8");
					list_image_file8 = createThumbnail(list_image_file8);
				} catch(Exception e) {
					list_image_file8 = "";
				}
				try {
					list_image_file9 = multi.getFilesystemName("list_image_file9");
					list_image_file9 = createThumbnail(list_image_file9);
				} catch(Exception e) {
					list_image_file9 = "";
				}
				try {
					list_image_file10 = multi.getFilesystemName("list_image_file10");
					list_image_file10 = createThumbnail(list_image_file10);
				} catch(Exception e) {
					list_image_file10 = "";
				}
				
				String org_attach_name = "";
				try {
					org_attach_name = CharacterSet.toKorean(multi.getOriginalFileName("list_data_file"));
					list_data_file = multi.getFilesystemName("list_data_file");
					String ext = com.vodcaster.utils.TextUtil.getExtension(list_data_file);
					if(!ext.equals("")){
						if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"ATTACH")){
							File del_file_file = new File(UPLOAD_PATH+"/"+list_data_file);
							del_file_file.delete(); // 기존 파일삭제
						}
					}else{
						list_data_file="";
						org_attach_name = "";
					}
				} catch(Exception e) {
					list_data_file="";
					org_attach_name = "";
				}
	
			//기존의 파일이름
			String _list_image_file = "";
			String _list_image_file2 = "";
			String _list_image_file3 = "";
			String _list_image_file4 = "";
			String _list_image_file5 = "";
			String _list_image_file6 = "";
			String _list_image_file7 = "";
			String _list_image_file8 = "";
			String _list_image_file9 = "";
			String _list_image_file10 = "";
			String _list_data_file = "";
			//기존 파일이 있을경우 값을 선언한다음 지우게 된다.
			String del_file1 = "";
			String del_file2 = "";
			String del_file3 = "";
			String del_file4 = "";
			String del_file5 = "";
			String del_file6 = "";
			String del_file7 = "";
			String del_file8 = "";
			String del_file9 = "";
			String del_file10 = "";
			String del_file_data = "";
	
	
			_list_image_file = multi.getParameter("_list_image_file");
			del_file1 = multi.getParameter("_list_image_file");
			
			_list_image_file2 = multi.getParameter("_list_image_file2");
			del_file2 = multi.getParameter("_list_image_file2");
			
			_list_image_file3 = multi.getParameter("_list_image_file3");
			del_file3 = multi.getParameter("_list_image_file3");
			
			_list_image_file4 = multi.getParameter("_list_image_file4");
			del_file4 = multi.getParameter("_list_image_file4");
			
			_list_image_file5 = multi.getParameter("_list_image_file5");
			del_file5 = multi.getParameter("_list_image_file5");
			
			_list_image_file6 = multi.getParameter("_list_image_file6");
			del_file6 = multi.getParameter("_list_image_file6");
			
			_list_image_file7 = multi.getParameter("_list_image_file7");
			del_file7 = multi.getParameter("_list_image_file7");
			
			_list_image_file8 = multi.getParameter("_list_image_file8");
			del_file8 = multi.getParameter("_list_image_file8");
			
			_list_image_file9 = multi.getParameter("_list_image_file9");
			del_file9 = multi.getParameter("_list_image_file9");
			
			_list_image_file10 = multi.getParameter("_list_image_file10");
			del_file10 = multi.getParameter("_list_image_file10");
			
			_list_data_file =multi.getParameter("_list_data_file");
			del_file_data = multi.getParameter("_list_data_file");
			
			HttpSession session = req.getSession(false);
	 
				// 추가 2015-06-22 비인증 사용자 글쓰기 허용
		if(multi.getParameter("list_name") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_name")).length() > 0 && multi.getParameter("list_passwd") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_passwd")).length()>0){
					
					list_name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_name")));
					list_passwd = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_passwd"));
					list_passwd = SEEDUtil.getEncrypt(list_passwd);
		 
		} else {
			if ( session.getAttribute("vod_name") != null && ((String) session.getAttribute("vod_name")).length() > 0) {
				list_name = com.vodcaster.utils.TextUtil.getValue((String) session.getAttribute("vod_id"));
				list_passwd = com.vodcaster.utils.TextUtil.getValue((String) session.getAttribute("user_key"));
			} else {
				System.err.println("board_update error: 등록자 정보 없음");
				return -1;
			}
		}
			 
			
			String 	query =  "update board_list set ";
			if (list_image_file != null && list_image_file.length() > 0)
			{
						query =  query + " list_image_file ='"+list_image_file+"',";
			} else if(list_image_del.equals("Y")) {
						query =  query + " list_image_file ='',";
			}

			if (list_image_file2 != null && list_image_file2.length() > 0)
			{
						query =  query + " list_image_file2 ='"+list_image_file2+"',";
			}else if(list_image_del2.equals("Y")) {
						query =  query + " list_image_file2 ='',";
			}
			if (list_image_file3 != null && list_image_file3.length() > 0)
			{
						query =  query + " list_image_file3 ='"+list_image_file3+"',";
			}else if(list_image_del3.equals("Y")) {
						query =  query + " list_image_file3 ='',";
			}
			if (list_image_file4 != null && list_image_file4.length() > 0)
			{
						query =  query + " list_image_file4 ='"+list_image_file4+"',";
			}else if(list_image_del4.equals("Y")) {
						query =  query + " list_image_file4 ='',";
			}
			if (list_image_file5 != null && list_image_file5.length() > 0)
			{
						query =  query + " list_image_file5 ='"+list_image_file5+"',";
			}else if(list_image_del5.equals("Y")) {
						query =  query + " list_image_file5 ='',";
			}
			if (list_image_file6 != null && list_image_file6.length() > 0)
			{
						query =  query + " list_image_file6 ='"+list_image_file6+"',";
			}else if(list_image_del6.equals("Y")) {
						query =  query + " list_image_file6 ='',";
			}
			if (list_image_file7 != null && list_image_file7.length() > 0)
			{
						query =  query + " list_image_file7 ='"+list_image_file7+"',";
			}else if(list_image_del7.equals("Y")) {
						query =  query + " list_image_file7 ='',";
			}
			if (list_image_file8 != null && list_image_file8.length() > 0)
			{
						query =  query + " list_image_file8 ='"+list_image_file8+"',";
			}else if(list_image_del8.equals("Y")) {
						query =  query + " list_image_file8 ='',";
			}
			if (list_image_file9 != null && list_image_file9.length() > 0)
			{
						query =  query + " list_image_file9 ='"+list_image_file9+"',";
			}else if(list_image_del9.equals("Y")) {
						query =  query + " list_image_file9 ='',";
			}
			if (list_image_file10 != null && list_image_file10.length() > 0)
			{
						query =  query + " list_image_file10 ='"+list_image_file10+"',";
			}else if(list_image_del10.equals("Y")) {
						query =  query + " list_image_file10 ='',";
			}
	
						query =  query + " image_text ='"+image_text+"',";
						query =  query + " image_text2 ='"+image_text2+"',";
						query =  query + " image_text3 ='"+image_text3+"',";
						query =  query + " image_text4 ='"+image_text4+"',";
						query =  query + " image_text5 ='"+image_text5+"',";
						query =  query + " image_text6 ='"+image_text6+"',";
						query =  query + " image_text7 ='"+image_text7+"',";
						query =  query + " image_text8 ='"+image_text8+"',";
						query =  query + " image_text9 ='"+image_text9+"',";
						query =  query + " image_text10 ='"+image_text10+"',";
				
				if (list_data_file != null && list_data_file.length() > 0)
				{
							query =  query + " list_data_file ='"+list_data_file+"', org_attach_name = '"+org_attach_name+"' , ";
				}else if(list_data_del.equals("Y")) {
							query =  query + " list_data_file ='', org_attach_name = '', ";
				}
	
				query =  query + " list_name='" +list_name+"',";
				query =  query + " list_title='" +list_title+"',";
				query =  query + " list_contents='" +list_contents+"',";
				query =  query + " list_email='" +list_email+"',";
				query =  query + " list_link='" +list_link+"',";
				query =  query + " list_security='" +list_security+"',";
				if (list_passwd != null && list_passwd.length() > 0){
				//query =  query + " list_passwd=password('" +list_passwd+"'),";
				query =  query + " list_passwd='" +list_passwd+"',";
				}
				query =  query + " open_space='" +open_space+"',";
				query =  query + " list_html_use='"+list_html_use+"'";
				query =  query + " where list_id ="+list_id + " and board_id = " + board_id;
			
	
		//System.out.println(query);
			if(querymanager.updateEntities(query) == 1){
	
	/////////////// 기존 파일 삭제
				if( (_list_image_file != null && list_image_file != null && _list_image_file.indexOf('.') != -1 && list_image_file.indexOf('.') != -1 ) || (list_image_del.equals("Y") &&  _list_image_file.indexOf('.') != -1 )){
					File deleteFile1 = new File(UPLOAD_PATH+"/"+del_file1);
					File deleteFile1_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file1);
					File deleteFile1_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file1);
	
	
					deleteFile1.delete(); // 기존 파일삭제
					deleteFile1_IMG.delete(); //  삭제 썸네일
					deleteFile1_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
				if( (_list_image_file2 != null && list_image_file2 != null && _list_image_file2.indexOf('.') != -1 && list_image_file2.indexOf('.') != -1) || (list_image_del2.equals("Y") &&  _list_image_file2.indexOf('.') != -1 )){
					File deleteFile2 = new File(UPLOAD_PATH+"/"+del_file2);
					File deleteFile2_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file2);
					File deleteFile2_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file2);
	
					deleteFile2.delete(); // 기존 파일삭제
					deleteFile2_IMG.delete(); //  삭제 썸네일
					deleteFile2_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
				if( (_list_image_file3 != null && list_image_file3 != null && _list_image_file3.indexOf('.') != -1 && list_image_file3.indexOf('.') != -1 ) || (list_image_del3.equals("Y") &&  _list_image_file3.indexOf('.') != -1 )){
					File deleteFile3 = new File(UPLOAD_PATH+"/"+del_file3);
					File deleteFile3_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file3);
					File deleteFile3_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file3);
	
					deleteFile3.delete(); // 기존 파일삭제
					deleteFile3_IMG.delete(); //  삭제 썸네일
					deleteFile3_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
				if( (_list_image_file4 != null && list_image_file4 != null && _list_image_file4.indexOf('.') != -1 && list_image_file4.indexOf('.') != -1 ) || (list_image_del4.equals("Y") &&  _list_image_file4.indexOf('.') != -1 )){
					File deleteFile4 = new File(UPLOAD_PATH+"/"+del_file4);
					File deleteFile4_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file4);
					File deleteFile4_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file4);
	
					deleteFile4.delete(); // 기존 파일삭제
					deleteFile4_IMG.delete(); //  삭제 썸네일
					deleteFile4_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
	
				if( (_list_image_file5 != null && list_image_file5 != null && _list_image_file5.indexOf('.') != -1 && list_image_file5.indexOf('.') != -1 ) || (list_image_del5.equals("Y") &&  _list_image_file5.indexOf('.') != -1 )){
					File deleteFile5 = new File(UPLOAD_PATH+"/"+del_file5);
					File deleteFile5_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file5);
					File deleteFile5_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file5);
	
					deleteFile5.delete(); // 기존 파일삭제
					deleteFile5_IMG.delete(); //  삭제 썸네일
					deleteFile5_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
	
				if( (_list_image_file6!= null && list_image_file6 != null && _list_image_file6.indexOf('.') != -1 && list_image_file6.indexOf('.') != -1 ) || (list_image_del6.equals("Y") &&  _list_image_file6.indexOf('.') != -1 )){
					File deleteFile6 = new File(UPLOAD_PATH+"/"+del_file6);
					File deleteFile6_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file6);
					File deleteFile6_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file6);
	
					deleteFile6.delete(); // 기존 파일삭제
					deleteFile6_IMG.delete(); //  삭제 썸네일
					deleteFile6_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
	
				if( (_list_image_file7 != null && list_image_file7 != null && _list_image_file7.indexOf('.') != -1 && list_image_file7.indexOf('.') != -1 ) || (list_image_del7.equals("Y") &&  _list_image_file7.indexOf('.') != -1 )){
					File deleteFile7 = new File(UPLOAD_PATH+"/"+del_file7);
					File deleteFile7_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file7);
					File deleteFile7_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file7);
	
					deleteFile7.delete(); // 기존 파일삭제
					deleteFile7_IMG.delete(); //  삭제 썸네일
					deleteFile7_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
	
				if( (_list_image_file8 != null && list_image_file8 != null && _list_image_file8.indexOf('.') != -1 && list_image_file8.indexOf('.') != -1 ) || (list_image_del8.equals("Y") &&  _list_image_file8.indexOf('.') != -1 )){
					File deleteFile8 = new File(UPLOAD_PATH+"/"+del_file8);
					File deleteFile8_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file8);
					File deleteFile8_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file8);
	
					deleteFile8.delete(); // 기존 파일삭제
					deleteFile8_IMG.delete(); //  삭제 썸네일
					deleteFile8_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
	
				if( (_list_image_file9 != null && list_image_file9 != null && _list_image_file9.indexOf('.') != -1 && list_image_file9.indexOf('.') != -1 ) || (list_image_del9.equals("Y") &&  _list_image_file9.indexOf('.') != -1 )){
					File deleteFile9 = new File(UPLOAD_PATH+"/"+del_file9);
					File deleteFile9_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file9);
					File deleteFile9_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file9);
	
					deleteFile9.delete(); // 기존 파일삭제
					deleteFile9_IMG.delete(); //  삭제 썸네일
					deleteFile9_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
	
				if( (_list_image_file10 != null && list_image_file10 != null && _list_image_file10.indexOf('.') != -1 && list_image_file10.indexOf('.') != -1 ) || (list_image_del10.equals("Y") &&  _list_image_file10.indexOf('.') != -1 )){
					File deleteFile10 = new File(UPLOAD_PATH+"/"+del_file10);
					File deleteFile10_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file10);
					File deleteFile10_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file10);
	
					deleteFile10.delete(); // 기존 파일삭제
					deleteFile10_IMG.delete(); //  삭제 썸네일
					deleteFile10_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
	
	
				if( (_list_data_file != null && list_data_file != null && _list_data_file.indexOf('.') != -1 && list_data_file.indexOf('.') != -1 ) || (list_data_del.equals("Y") &&  _list_data_file.indexOf('.') != -1 )){
					File del_file_file = new File(del_file_data);
	
					del_file_file.delete(); // 기존 파일삭제
				}
				////////////////////////////
	
				
				return 1;
	
			}
			return 99;
		} catch(Exception e) {
			System.out.println("board_update:"+e);
			return -99;
		}
	}

	/*****************************************************
	관리자화면의 특정 게시판글을 수정합니다.<p>
	<b>작성자</b>       : 박종성<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param req HttpServletRequest정보, iSize 파일 사이즈
	@see QueryManager#updateEntities
	******************************************************/
	public int update_man(HttpServletRequest req, int iSize) throws Exception 
	{
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_BORADLIST;
		String UPLOAD_PATH_IMG = DirectoryNameManager.UPLOAD_BORADLIST_IMG;
		String UPLOAD_PATH_IMG_MIDDLE	= DirectoryNameManager.UPLOAD_BORADLIST_IMG_MIDDLE;
		if(iSize <=0){
			iSize = 20 * 1024 * 1024;
		}
		try {
			MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, iSize, new DefaultFileRenamePolicyITNC21());
	
			int board_id	 = 0;
			int list_id      =0;
			String list_name = "";
			String list_title = "";
			String list_contents = "";
			String list_email = "";
			String list_data_file = "";
			String list_image_file = "";
			String list_link = "";
			String list_passwd = "";
			String list_html_use ="f";
			String list_image_file2 = "";
			String list_image_file3 = "";
			String list_image_file4 = "";
			String list_image_file5 = "";
			String list_image_file6 = "";
			String list_image_file7 = "";
			String list_image_file8 = "";
			String list_image_file9 = "";
			String list_image_file10 = "";
			String image_text = "";
			String image_text2 = "";
			String image_text3 = "";
			String image_text4 = "";
			String image_text5 = "";
			String image_text6 = "";
			String image_text7 = "";
			String image_text8 = "";
			String image_text9 = "";
			String image_text10 = "";
			String list_open = "";
	
			String list_image_del = "N";
			String list_image_del2 = "N";
			String list_image_del3 = "N";
			String list_image_del4 = "N";
			String list_image_del5 = "N";
			String list_image_del6 = "N";
			String list_image_del7 = "N";
			String list_image_del8 = "N";
			String list_image_del9 = "N";
			String list_image_del10 = "N";
			String list_data_del = "N";
			String open_space = "N";
			String list_security = "N";
			
			String rsdate="";
			String redate="";
			
			if(multi.getParameter("board_id") == null || com.vodcaster.utils.TextUtil.getValue(multi.getParameter("board_id")).equals("")){
				return -1;
			}
			if(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_id")).equals("")){
				return -1;
			}
			try{
				if(multi.getParameter("board_id") !=null && com.yundara.util.TextUtil.isNumeric(multi.getParameter("board_id"))) {
					board_id = Integer.parseInt(multi.getParameter("board_id"));
				}else{
					return -1;
				}
			}catch(Exception ex){
				System.err.println(ex);
				return -1;
			}
			
			try{
				if(multi.getParameter("list_id") !=null && com.yundara.util.TextUtil.isNumeric(multi.getParameter("list_id"))) { 
					list_id = Integer.parseInt(multi.getParameter("list_id"));
				}else{
					return -1;
				}
			}catch(Exception ex){
				System.err.println(ex);
				return -1;
			}
			if(multi.getParameter("list_name") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_name")).length()>0){
				list_name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_name")));
			}else{
				return -1;
			}
			if(multi.getParameter("list_title") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_title")).length()>0){
				list_title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_title")));
			}else{
				return -1;
			}
			if(multi.getParameter("list_contents") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_contents")).length()>0){
				list_contents = CharacterSet.toKorean(multi.getParameter("list_contents"));
				list_contents = list_contents
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("‘","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("′","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("’","&#39;")
				.replaceAll("‘","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
			}
			if(multi.getParameter("list_email") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_email")).length()>0){
				list_email = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_email")));
			}
			if(multi.getParameter("list_link") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_link")).length()>0){
				list_link = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_link")));
			}
			if(multi.getParameter("list_passwd") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_passwd")).length()>0){
				list_passwd = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_passwd"));
			}
			if(multi.getParameter("list_html_use") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_html_use")).length()>0){
				list_html_use = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_html_use"));
			}
			if(multi.getParameter("list_security") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_security")).length()>0){
				list_security = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_security"));
			}
			if(multi.getParameter("open_space") !=null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("open_space")).length()>0 ){ 
				open_space = multi.getParameter("open_space");
			}
	
			if(multi.getParameter("list_image_del") !=null ) 
				list_image_del = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del"));
			if(multi.getParameter("list_image_del2") !=null ) 
				list_image_del2 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del2"));
			if(multi.getParameter("list_image_del3") !=null ) 
				list_image_del3 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del3"));
			if(multi.getParameter("list_image_del4") !=null ) 
				list_image_del4 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del4"));
			if(multi.getParameter("list_image_del5") !=null ) 
				list_image_del5 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del5"));
			if(multi.getParameter("list_image_del6") !=null ) 
				list_image_del6 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del6"));
			if(multi.getParameter("list_image_del7") !=null ) 
				list_image_del7 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del7"));
			if(multi.getParameter("list_image_del8") !=null ) 
				list_image_del8 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del8"));
			if(multi.getParameter("list_image_del9") !=null ) 
				list_image_del9 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del9"));
			if(multi.getParameter("list_image_del10") !=null ) 
				list_image_del10 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_del10"));
			if(multi.getParameter("list_data_del") !=null ) 
				list_data_del = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_data_del"));
			
			if(multi.getParameter("image_text") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text")).length()>0){
				image_text = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text")));
			}
			if(multi.getParameter("image_text2") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text2")).length()>0){
				image_text2 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text2")));
			}
			if(multi.getParameter("image_text3") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text3")).length()>0){
				image_text3 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text3")));
			}
			if(multi.getParameter("image_text4") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text4")).length()>0){
				image_text4 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text4")));
			}
			if(multi.getParameter("image_text5") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text5")).length()>0){
				image_text5 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text5")));
			}
			if(multi.getParameter("image_text6") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text6")).length()>0){
				image_text6 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text6")));
			}
			if(multi.getParameter("image_text7") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text7")).length()>0){
				image_text7 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text7")));
			}
			if(multi.getParameter("image_text8") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text8")).length()>0){
				image_text8 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text8")));
			}
			if(multi.getParameter("image_text9") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text9")).length()>0){
				image_text9 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text9")));
			}
			if(multi.getParameter("image_text10") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text10")).length()>0){
				image_text10 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text10")));
			}
			
			if(multi.getParameter("rsdate") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rsdate")).length()>0){
				rsdate = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rsdate")));
			}
			if(multi.getParameter("redate") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("redate")).length()>0){
				redate = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("redate")));
			}
			if(multi.getParameter("list_open") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_open")).length()>0){
				list_open = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_open")));
			}
			
			
			try {
				list_image_file = multi.getFilesystemName("list_image_file");
				list_image_file = createThumbnail(list_image_file);
			} catch(Exception e) {
				list_image_file = "";
			}
			try {
				list_image_file2 = multi.getFilesystemName("list_image_file2");
				list_image_file2 = createThumbnail(list_image_file2);
			} catch(Exception e) {
				list_image_file2 = "";
			}
			try {
				list_image_file3 = multi.getFilesystemName("list_image_file3");
				list_image_file3 = createThumbnail(list_image_file3);
			} catch(Exception e) {
				list_image_file3 = "";
			}
			try {
				list_image_file4 = multi.getFilesystemName("list_image_file4");
				list_image_file4 = createThumbnail(list_image_file4);
			} catch(Exception e) {
				list_image_file4 = "";
			}
			try {
				list_image_file5 = multi.getFilesystemName("list_image_file5");
				list_image_file5 = createThumbnail(list_image_file5);
			} catch(Exception e) {
				list_image_file5 = "";
			}
			try {
				list_image_file6 = multi.getFilesystemName("list_image_file6");
				list_image_file6 = createThumbnail(list_image_file6);
			} catch(Exception e) {
				list_image_file6 = "";
			}
			try {
				list_image_file7 = multi.getFilesystemName("list_image_file7");
				list_image_file7 = createThumbnail(list_image_file7);
			} catch(Exception e) {
				list_image_file7 = "";
			}
			try {
				list_image_file8 = multi.getFilesystemName("list_image_file8");
				list_image_file8 = createThumbnail(list_image_file8);
			} catch(Exception e) {
				list_image_file8 = "";
			}
			try {
				list_image_file9 = multi.getFilesystemName("list_image_file9");
				list_image_file9 = createThumbnail(list_image_file9);
			} catch(Exception e) {
				list_image_file9 = "";
			}
			try {
				list_image_file10 = multi.getFilesystemName("list_image_file10");
				list_image_file10 = createThumbnail(list_image_file10);
			} catch(Exception e) {
				list_image_file10 = "";
			}
			
			String org_attach_name = "";
			try {
				org_attach_name= CharacterSet.toKorean(multi.getOriginalFileName("list_data_file"));
				list_data_file = multi.getFilesystemName("list_data_file");
				String ext = com.vodcaster.utils.TextUtil.getExtension(list_data_file);
				if(!ext.equals("")){
					if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"ATTACH")){
						File del_file_file = new File(UPLOAD_PATH+"/"+list_data_file);
						del_file_file.delete(); // 기존 파일삭제
					}
				}else{
					list_data_file="";
					org_attach_name = "";
				}
			} catch(Exception e) {
				list_data_file="";
				org_attach_name = "";
			}
	
			//기존의 파일이름
			String _list_image_file = "";
			String _list_image_file2 = "";
			String _list_image_file3 = "";
			String _list_image_file4 = "";
			String _list_image_file5 = "";
			String _list_image_file6 = "";
			String _list_image_file7 = "";
			String _list_image_file8 = "";
			String _list_image_file9 = "";
			String _list_image_file10 = "";
			String _list_data_file = "";
			//기존 파일이 있을경우 값을 선언한다음 지우게 된다.
			String del_file1 = "";
			String del_file2 = "";
			String del_file3 = "";
			String del_file4 = "";
			String del_file5 = "";
			String del_file6 = "";
			String del_file7 = "";
			String del_file8 = "";
			String del_file9 = "";
			String del_file10 = "";
			String del_file_data = "";
	
	
			_list_image_file = multi.getParameter("_list_image_file");
			del_file1 = multi.getParameter("_list_image_file");
			
			_list_image_file2 = multi.getParameter("_list_image_file2");
			del_file2 = multi.getParameter("_list_image_file2");
			
			_list_image_file3 = multi.getParameter("_list_image_file3");
			del_file3 = multi.getParameter("_list_image_file3");
			
			_list_image_file4 = multi.getParameter("_list_image_file4");
			del_file4 = multi.getParameter("_list_image_file4");
			
			_list_image_file5 = multi.getParameter("_list_image_file5");
			del_file5 = multi.getParameter("_list_image_file5");
			
			_list_image_file6 = multi.getParameter("_list_image_file6");
			del_file6 = multi.getParameter("_list_image_file6");
			
			_list_image_file7 = multi.getParameter("_list_image_file7");
			del_file7 = multi.getParameter("_list_image_file7");
			
			_list_image_file8 = multi.getParameter("_list_image_file8");
			del_file8 = multi.getParameter("_list_image_file8");
			
			_list_image_file9 = multi.getParameter("_list_image_file9");
			del_file9 = multi.getParameter("_list_image_file9");
			
			_list_image_file10 = multi.getParameter("_list_image_file10");
			del_file10 = multi.getParameter("_list_image_file10");
			
			_list_data_file =multi.getParameter("_list_data_file");
			del_file_data = multi.getParameter("_list_data_file");
			
	
			String 	query =  "update board_list set ";
			if (list_image_file != null && list_image_file.length() > 0)
			{
						query =  query + " list_image_file ='"+list_image_file+"',";
			} else if(list_image_del.equals("Y")) {
						query =  query + " list_image_file ='',";
			}

			if (list_image_file2 != null && list_image_file2.length() > 0)
			{
						query =  query + " list_image_file2 ='"+list_image_file2+"',";
			}else if(list_image_del2.equals("Y")) {
						query =  query + " list_image_file2 ='',";
			}
			if (list_image_file3 != null && list_image_file3.length() > 0)
			{
						query =  query + " list_image_file3 ='"+list_image_file3+"',";
			}else if(list_image_del3.equals("Y")) {
						query =  query + " list_image_file3 ='',";
			}
			if (list_image_file4 != null && list_image_file4.length() > 0)
			{
						query =  query + " list_image_file4 ='"+list_image_file4+"',";
			}else if(list_image_del4.equals("Y")) {
						query =  query + " list_image_file4 ='',";
			}
			if (list_image_file5 != null && list_image_file5.length() > 0)
			{
						query =  query + " list_image_file5 ='"+list_image_file5+"',";
			}else if(list_image_del5.equals("Y")) {
						query =  query + " list_image_file5 ='',";
			}
			if (list_image_file6 != null && list_image_file6.length() > 0)
			{
						query =  query + " list_image_file6 ='"+list_image_file6+"',";
			}else if(list_image_del6.equals("Y")) {
						query =  query + " list_image_file6 ='',";
			}
			if (list_image_file7 != null && list_image_file7.length() > 0)
			{
						query =  query + " list_image_file7 ='"+list_image_file7+"',";
			}else if(list_image_del7.equals("Y")) {
						query =  query + " list_image_file7 ='',";
			}
			if (list_image_file8 != null && list_image_file8.length() > 0)
			{
						query =  query + " list_image_file8 ='"+list_image_file8+"',";
			}else if(list_image_del8.equals("Y")) {
						query =  query + " list_image_file8 ='',";
			}
			if (list_image_file9 != null && list_image_file9.length() > 0)
			{
						query =  query + " list_image_file9 ='"+list_image_file9+"',";
			}else if(list_image_del9.equals("Y")) {
						query =  query + " list_image_file9 ='',";
			}
			if (list_image_file10 != null && list_image_file10.length() > 0)
			{
						query =  query + " list_image_file10 ='"+list_image_file10+"',";
			}else if(list_image_del10.equals("Y")) {
						query =  query + " list_image_file10 ='',";
			}
	
						query =  query + " image_text ='"+image_text+"',";
						query =  query + " image_text2 ='"+image_text2+"',";
						query =  query + " image_text3 ='"+image_text3+"',";
						query =  query + " image_text4 ='"+image_text4+"',";
						query =  query + " image_text5 ='"+image_text5+"',";
						query =  query + " image_text6 ='"+image_text6+"',";
						query =  query + " image_text7 ='"+image_text7+"',";
						query =  query + " image_text8 ='"+image_text8+"',";
						query =  query + " image_text9 ='"+image_text9+"',";
						query =  query + " image_text10 ='"+image_text10+"',";
				
				if (list_data_file != null && list_data_file.length() > 0)
				{
							query =  query + " list_data_file ='"+list_data_file+"', org_attach_name = '"+org_attach_name+"' , ";
				}else if(list_data_del.equals("Y")) {
							query =  query + " list_data_file ='', org_attach_name = '' , ";
				}
	
				query =  query + " list_name='" +list_name+"',";
				query =  query + " list_title='" +list_title+"',";
				query =  query + " list_contents='" +list_contents+"',";
				query =  query + " list_email='" +list_email+"',";
				query =  query + " list_link='" +list_link+"',";
				if (list_passwd != null && list_passwd.length() > 0) {
					//query =  query + " list_passwd=password('" +list_passwd+"'),";
					query =  query + " list_passwd='" +SEEDUtil.getEncrypt(list_passwd)+"',";	 
					
				}
				query =  query + " rsdate='"+rsdate+"',";
				query =  query + " redate='"+redate+"',";
				query =  query + " open_space='" +open_space+"',";
				query =  query + " list_open='" +list_open+"',";
				query =  query + " list_security='"+list_security+"',";
				query =  query + " list_html_use='"+list_html_use+"'";
				query =  query + " where list_id ="+list_id + " and board_id = " + board_id;
			
	
			//System.out.println(query);
			if(querymanager.updateEntities(query) == 1){
	
	/////////////// 기존 파일 삭제
				if( (_list_image_file != null && list_image_file != null && _list_image_file.indexOf('.') != -1 && list_image_file.indexOf('.') != -1 ) || (list_image_del.equals("Y") &&  _list_image_file.indexOf('.') != -1 )){
					File deleteFile1 = new File(UPLOAD_PATH+"/"+del_file1);
					File deleteFile1_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file1);
					File deleteFile1_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file1);
	
	
					deleteFile1.delete(); // 기존 파일삭제
					deleteFile1_IMG.delete(); //  삭제 썸네일
					deleteFile1_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
				if( (_list_image_file2 != null && list_image_file2 != null && _list_image_file2.indexOf('.') != -1 && list_image_file2.indexOf('.') != -1) || (list_image_del2.equals("Y") &&  _list_image_file2.indexOf('.') != -1 )){
					File deleteFile2 = new File(UPLOAD_PATH+"/"+del_file2);
					File deleteFile2_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file2);
					File deleteFile2_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file2);
	
					deleteFile2.delete(); // 기존 파일삭제
					deleteFile2_IMG.delete(); //  삭제 썸네일
					deleteFile2_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
				if( (_list_image_file3 != null && list_image_file3 != null && _list_image_file3.indexOf('.') != -1 && list_image_file3.indexOf('.') != -1 ) || (list_image_del3.equals("Y") &&  _list_image_file3.indexOf('.') != -1 )){
					File deleteFile3 = new File(UPLOAD_PATH+"/"+del_file3);
					File deleteFile3_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file3);
					File deleteFile3_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file3);
	
					deleteFile3.delete(); // 기존 파일삭제
					deleteFile3_IMG.delete(); //  삭제 썸네일
					deleteFile3_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
				if( (_list_image_file4 != null && list_image_file4 != null && _list_image_file4.indexOf('.') != -1 && list_image_file4.indexOf('.') != -1 ) || (list_image_del4.equals("Y") &&  _list_image_file4.indexOf('.') != -1 )){
					File deleteFile4 = new File(UPLOAD_PATH+"/"+del_file4);
					File deleteFile4_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file4);
					File deleteFile4_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file4);
	
					deleteFile4.delete(); // 기존 파일삭제
					deleteFile4_IMG.delete(); //  삭제 썸네일
					deleteFile4_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
	
				if( (_list_image_file5 != null && list_image_file5 != null && _list_image_file5.indexOf('.') != -1 && list_image_file5.indexOf('.') != -1 ) || (list_image_del5.equals("Y") &&  _list_image_file5.indexOf('.') != -1 )){
					File deleteFile5 = new File(UPLOAD_PATH+"/"+del_file5);
					File deleteFile5_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file5);
					File deleteFile5_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file5);
	
					deleteFile5.delete(); // 기존 파일삭제
					deleteFile5_IMG.delete(); //  삭제 썸네일
					deleteFile5_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
	
				if( (_list_image_file6!= null && list_image_file6 != null && _list_image_file6.indexOf('.') != -1 && list_image_file6.indexOf('.') != -1 ) || (list_image_del6.equals("Y") &&  _list_image_file6.indexOf('.') != -1 )){
					File deleteFile6 = new File(UPLOAD_PATH+"/"+del_file6);
					File deleteFile6_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file6);
					File deleteFile6_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file6);
	
					deleteFile6.delete(); // 기존 파일삭제
					deleteFile6_IMG.delete(); //  삭제 썸네일
					deleteFile6_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
	
				if( (_list_image_file7 != null && list_image_file7 != null && _list_image_file7.indexOf('.') != -1 && list_image_file7.indexOf('.') != -1 ) || (list_image_del7.equals("Y") &&  _list_image_file7.indexOf('.') != -1 )){
					File deleteFile7 = new File(UPLOAD_PATH+"/"+del_file7);
					File deleteFile7_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file7);
					File deleteFile7_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file7);
	
					deleteFile7.delete(); // 기존 파일삭제
					deleteFile7_IMG.delete(); //  삭제 썸네일
					deleteFile7_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
	
				if( (_list_image_file8 != null && list_image_file8 != null && _list_image_file8.indexOf('.') != -1 && list_image_file8.indexOf('.') != -1 ) || (list_image_del8.equals("Y") &&  _list_image_file8.indexOf('.') != -1 )){
					File deleteFile8 = new File(UPLOAD_PATH+"/"+del_file8);
					File deleteFile8_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file8);
					File deleteFile8_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file8);
	
					deleteFile8.delete(); // 기존 파일삭제
					deleteFile8_IMG.delete(); //  삭제 썸네일
					deleteFile8_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
	
				if( (_list_image_file9 != null && list_image_file9 != null && _list_image_file9.indexOf('.') != -1 && list_image_file9.indexOf('.') != -1 ) || (list_image_del9.equals("Y") &&  _list_image_file9.indexOf('.') != -1 )){
					File deleteFile9 = new File(UPLOAD_PATH+"/"+del_file9);
					File deleteFile9_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file9);
					File deleteFile9_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file9);
	
					deleteFile9.delete(); // 기존 파일삭제
					deleteFile9_IMG.delete(); //  삭제 썸네일
					deleteFile9_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
	
				if( (_list_image_file10 != null && list_image_file10 != null && _list_image_file10.indexOf('.') != -1 && list_image_file10.indexOf('.') != -1 ) || (list_image_del10.equals("Y") &&  _list_image_file10.indexOf('.') != -1 )){
					File deleteFile10 = new File(UPLOAD_PATH+"/"+del_file10);
					File deleteFile10_IMG = new File(UPLOAD_PATH_IMG+"/"+del_file10);
					File deleteFile10_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+del_file10);
	
					deleteFile10.delete(); // 기존 파일삭제
					deleteFile10_IMG.delete(); //  삭제 썸네일
					deleteFile10_IMG_MIDDLE.delete(); //  삭제 썸네일
				}
	
	
				if( (_list_data_file != null && list_data_file != null && _list_data_file.indexOf('.') != -1 && list_data_file.indexOf('.') != -1 ) || (list_data_del.equals("Y") &&  _list_data_file.indexOf('.') != -1 )){
					File del_file_file = new File(del_file_data);
	
					del_file_file.delete(); // 기존 파일삭제
				}
				/////////////////
	
				
				return 1;
	
			}
			return 99;
		} catch(Exception e) {
			return -99;
		}
	}



/************************************************  DELETE  ************************************************/

	/*****************************************************
	특정게시판 글의 리스트를 삭제합니다..<p>
	<b>작성자</b>       : 박종성<br>
	@return 쿼리문의 실행이 성공이면 row수<br>
	@param list_id 게시물 아이디
	@see QueryManager#updateEntities
	******************************************************/
	public int delete(int list_id, HttpServletRequest req) throws Exception {
		if(list_id <0) return -1;
		
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_BORADLIST;
		String UPLOAD_PATH_IMG = DirectoryNameManager.UPLOAD_BORADLIST_IMG;
		String UPLOAD_PATH_IMG_MIDDLE	= DirectoryNameManager.UPLOAD_BORADLIST_IMG_MIDDLE;
		 
		HttpSession session = req.getSession(false); 
		
		String list_passwd = ""; 
			
			// 추가 2015-06-22 비인증 사용자 글쓰기 허용
  
				if (session.getAttribute("list_passwd") != null && ((String) session.getAttribute("list_passwd")).length() > 0) {
					 list_passwd = com.vodcaster.utils.TextUtil.getValue((String) session.getAttribute("list_passwd"));
				}else if (session.getAttribute("vod_name") != null && ((String) session.getAttribute("vod_name")).length() > 0) {
					 list_passwd = com.vodcaster.utils.TextUtil.getValue((String) session.getAttribute("user_key"));
				} else{
					System.err.println("delete error: 필수정보 오류");
					return -1;
				}
				
		try {
 
		String select_query = "select * from board_list where list_id="+list_id+" and list_passwd = '"+list_passwd+"'";
		//System.out.println(select_query);
		Vector v = querymanager.selectEntity(select_query);
		if(v != null && v.size() > 0) {
			String img_file1 = String.valueOf(v.elementAt(8));
			String img_file2 = String.valueOf(v.elementAt(17));
			String img_file3 = String.valueOf(v.elementAt(18));
			String img_file4 = String.valueOf(v.elementAt(25));
			String img_file5 = String.valueOf(v.elementAt(26));
			String img_file6 = String.valueOf(v.elementAt(27));
			String img_file7 = String.valueOf(v.elementAt(28));
			String img_file8 = String.valueOf(v.elementAt(29));
			String img_file9 = String.valueOf(v.elementAt(30));
			String img_file10 = String.valueOf(v.elementAt(31));
			String data_file = String.valueOf(v.elementAt(7));
			
			if( data_file != null && data_file.indexOf('.') > -1){
				File deleteFile11 = new File(UPLOAD_PATH+"/"+data_file);
				deleteFile11.delete(); // 첨부파일
 
			}
			
			if( img_file1 != null && img_file1.indexOf('.') > -1){
				File deleteFile1 = new File(UPLOAD_PATH+"/"+img_file1);
				File deleteFile1_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file1);
				File deleteFile1_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file1);


				deleteFile1.delete(); // 기존 파일삭제
				deleteFile1_IMG.delete(); //  삭제 썸네일
				deleteFile1_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file2 != null && img_file2.indexOf('.') > -1){
				File deleteFile2 = new File(UPLOAD_PATH+"/"+img_file2);
				File deleteFile2_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file2);
				File deleteFile2_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file2);


				deleteFile2.delete(); // 기존 파일삭제
				deleteFile2_IMG.delete(); //  삭제 썸네일
				deleteFile2_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file3 != null && img_file3.indexOf('.') > -1){
				File deleteFile3 = new File(UPLOAD_PATH+"/"+img_file3);
				File deleteFile3_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file3);
				File deleteFile3_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file3);


				deleteFile3.delete(); // 기존 파일삭제
				deleteFile3_IMG.delete(); //  삭제 썸네일
				deleteFile3_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file4 != null && img_file4.indexOf('.') > -1){
				File deleteFile4 = new File(UPLOAD_PATH+"/"+img_file4);
				File deleteFile4_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file4);
				File deleteFile4_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file4);


				deleteFile4.delete(); // 기존 파일삭제
				deleteFile4_IMG.delete(); //  삭제 썸네일
				deleteFile4_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file5 != null && img_file5.indexOf('.') > -1){
				File deleteFile5 = new File(UPLOAD_PATH+"/"+img_file5);
				File deleteFile5_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file5);
				File deleteFile5_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file5);


				deleteFile5.delete(); // 기존 파일삭제
				deleteFile5_IMG.delete(); //  삭제 썸네일
				deleteFile5_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file6 != null && img_file6.indexOf('.') > -1){
				File deleteFile6 = new File(UPLOAD_PATH+"/"+img_file6);
				File deleteFile6_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file6);
				File deleteFile6_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file6);


				deleteFile6.delete(); // 기존 파일삭제
				deleteFile6_IMG.delete(); //  삭제 썸네일
				deleteFile6_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file7 != null && img_file7.indexOf('.') > -1){
				File deleteFile7 = new File(UPLOAD_PATH+"/"+img_file7);
				File deleteFile7_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file7);
				File deleteFile7_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file7);


				deleteFile7.delete(); // 기존 파일삭제
				deleteFile7_IMG.delete(); //  삭제 썸네일
				deleteFile7_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file8 != null && img_file8.indexOf('.') > -1){
				File deleteFile8 = new File(UPLOAD_PATH+"/"+img_file8);
				File deleteFile8_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file8);
				File deleteFile8_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file8);


				deleteFile8.delete(); // 기존 파일삭제
				deleteFile8_IMG.delete(); //  삭제 썸네일
				deleteFile8_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file9 != null && img_file9.indexOf('.') > -1){
				File deleteFile9 = new File(UPLOAD_PATH+"/"+img_file9);
				File deleteFile9_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file9);
				File deleteFile9_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file9);


				deleteFile9.delete(); // 기존 파일삭제
				deleteFile9_IMG.delete(); //  삭제 썸네일
				deleteFile9_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file10 != null && img_file10.indexOf('.') > -1){
				File deleteFile10 = new File(UPLOAD_PATH+"/"+img_file10);
				File deleteFile10_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file10);
				File deleteFile10_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file10);


				deleteFile10.delete(); // 기존 파일삭제
				deleteFile10_IMG.delete(); //  삭제 썸네일
				deleteFile10_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			String query = "update board_list set del_flag = 'Y' where list_id=" + list_id +" and list_passwd = '"+list_passwd+"'";
			//String query = "delete from board_list where list_id=" + list_id +" and list_passwd = '"+list_passwd+"'";
			//System.out.println(query);
			return querymanager.updateEntities(query);
		} else {
			return -99;
		}
		
		} catch(Exception e) {
			System.out.println("error:"+ e);
			 return - 99;
		}

	}
	
	
	public int delete_man(int list_id) throws Exception {
		if(list_id <0) return -1;
		
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_BORADLIST;
		String UPLOAD_PATH_IMG = DirectoryNameManager.UPLOAD_BORADLIST_IMG;
		String UPLOAD_PATH_IMG_MIDDLE	= DirectoryNameManager.UPLOAD_BORADLIST_IMG_MIDDLE;
		
		String select_query = "select * from board_list where list_id="+list_id;
		Vector v = querymanager.selectEntity(select_query);
		if(v != null && v.size() > 0) {
			String img_file1 = String.valueOf(v.elementAt(8));
			String img_file2 = String.valueOf(v.elementAt(17));
			String img_file3 = String.valueOf(v.elementAt(18));
			String img_file4 = String.valueOf(v.elementAt(25));
			String img_file5 = String.valueOf(v.elementAt(26));
			String img_file6 = String.valueOf(v.elementAt(27));
			String img_file7 = String.valueOf(v.elementAt(28));
			String img_file8 = String.valueOf(v.elementAt(29));
			String img_file9 = String.valueOf(v.elementAt(30));
			String img_file10 = String.valueOf(v.elementAt(31));
			String data_file = String.valueOf(v.elementAt(7));
			
			if( data_file != null && data_file.indexOf('.') > -1){
				File deleteFile11 = new File(UPLOAD_PATH+"/"+data_file);
				deleteFile11.delete(); // 첨부파일
 
			}
			
			if( img_file1 != null && img_file1.indexOf('.') > -1){
				File deleteFile1 = new File(UPLOAD_PATH+"/"+img_file1);
				File deleteFile1_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file1);
				File deleteFile1_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file1);


				deleteFile1.delete(); // 기존 파일삭제
				deleteFile1_IMG.delete(); //  삭제 썸네일
				deleteFile1_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file2 != null && img_file2.indexOf('.') > -1){
				File deleteFile2 = new File(UPLOAD_PATH+"/"+img_file2);
				File deleteFile2_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file2);
				File deleteFile2_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file2);


				deleteFile2.delete(); // 기존 파일삭제
				deleteFile2_IMG.delete(); //  삭제 썸네일
				deleteFile2_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file3 != null && img_file3.indexOf('.') > -1){
				File deleteFile3 = new File(UPLOAD_PATH+"/"+img_file3);
				File deleteFile3_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file3);
				File deleteFile3_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file3);


				deleteFile3.delete(); // 기존 파일삭제
				deleteFile3_IMG.delete(); //  삭제 썸네일
				deleteFile3_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file4 != null && img_file4.indexOf('.') > -1){
				File deleteFile4 = new File(UPLOAD_PATH+"/"+img_file4);
				File deleteFile4_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file4);
				File deleteFile4_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file4);


				deleteFile4.delete(); // 기존 파일삭제
				deleteFile4_IMG.delete(); //  삭제 썸네일
				deleteFile4_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file5 != null && img_file5.indexOf('.') > -1){
				File deleteFile5 = new File(UPLOAD_PATH+"/"+img_file5);
				File deleteFile5_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file5);
				File deleteFile5_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file5);


				deleteFile5.delete(); // 기존 파일삭제
				deleteFile5_IMG.delete(); //  삭제 썸네일
				deleteFile5_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file6 != null && img_file6.indexOf('.') > -1){
				File deleteFile6 = new File(UPLOAD_PATH+"/"+img_file6);
				File deleteFile6_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file6);
				File deleteFile6_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file6);


				deleteFile6.delete(); // 기존 파일삭제
				deleteFile6_IMG.delete(); //  삭제 썸네일
				deleteFile6_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file7 != null && img_file7.indexOf('.') > -1){
				File deleteFile7 = new File(UPLOAD_PATH+"/"+img_file7);
				File deleteFile7_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file7);
				File deleteFile7_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file7);


				deleteFile7.delete(); // 기존 파일삭제
				deleteFile7_IMG.delete(); //  삭제 썸네일
				deleteFile7_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file8 != null && img_file8.indexOf('.') > -1){
				File deleteFile8 = new File(UPLOAD_PATH+"/"+img_file8);
				File deleteFile8_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file8);
				File deleteFile8_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file8);


				deleteFile8.delete(); // 기존 파일삭제
				deleteFile8_IMG.delete(); //  삭제 썸네일
				deleteFile8_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file9 != null && img_file9.indexOf('.') > -1){
				File deleteFile9 = new File(UPLOAD_PATH+"/"+img_file9);
				File deleteFile9_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file9);
				File deleteFile9_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file9);


				deleteFile9.delete(); // 기존 파일삭제
				deleteFile9_IMG.delete(); //  삭제 썸네일
				deleteFile9_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			if( img_file10 != null && img_file10.indexOf('.') > -1){
				File deleteFile10 = new File(UPLOAD_PATH+"/"+img_file10);
				File deleteFile10_IMG = new File(UPLOAD_PATH_IMG+"/"+img_file10);
				File deleteFile10_IMG_MIDDLE = new File(UPLOAD_PATH_IMG_MIDDLE+"/"+img_file10);


				deleteFile10.delete(); // 기존 파일삭제
				deleteFile10_IMG.delete(); //  삭제 썸네일
				deleteFile10_IMG_MIDDLE.delete(); //  삭제 썸네일
			}
			
		}
		String query = "update board_list set del_flag = 'Y' where list_id=" + list_id;
		//String query = "delete from board_list where list_id=" + list_id;
		return querymanager.updateEntities(query);
	}

///////////
//이전글
//주현
///////////

	 public Vector getList_id_pre(int board_id, int list_id ) throws Exception{
		 if(board_id < 0) return null;
		 if(list_id < 0) return null;
		 
		Vector v = null;
		String query = "";
		
		query = "select * from board_list where board_id="+board_id+" and list_id < "+list_id+" order by seq desc  ";
		
		return 	querymanager.selectEntity(query);

	}
//////////
//다음글
//주현
/////////
	 public Vector getList_id_next(int board_id, int list_id ) throws Exception{
		 if(board_id < 0) return null;
		 if(list_id < 0) return null;
	 
		Vector v = null;
	    String query = "";
			
		query = "select * from board_list where board_id="+board_id+" and list_id > "+list_id+" order by seq asc  ";

		return 	querymanager.selectEntity(query);

	}
 

	/**
	 * 보드 리스트를 얻어온다
	 * @param board_id
	 * @param pg
	 * @param limit
	 * @return
	 */
public Hashtable getBoardList(int board_id, String searchField, String searchString, int pg, int limit)
{
	Hashtable result_ht;
 
	searchField = com.vodcaster.utils.TextUtil.getValue(searchField);
	searchString = com.vodcaster.utils.TextUtil.getValue(searchString);
	
//	String query = "select list_id, list_title, list_contents, list_name, list_image_file, list_read_count," +
//			" list_date, list_link, list_security from board_list where " +
//			" board_id="+board_id+" and del_flag='N' and list_open='Y'";
	
	String query = " SELECT a.*, (SELECT COUNT(muid) FROM content_memo WHERE ocode=a.list_id) AS memo_cnt  FROM board_list a  " +
			" where a.board_id="+board_id+" and a.del_flag='N' and a.list_open='Y'";

	String count_query = "select count(*) from board_list where " +
		" board_id="+board_id+" and del_flag='N' and list_open='Y'";
	
	if(searchField != null && !searchField.equals("") && searchString != null && !searchString.equals("")){
		if(searchField.equals("1")){
			query = query + " and list_title like '%" + searchString + "%' ";
			count_query = count_query + " and list_title like '%" + searchString + "%' ";
		}else if(searchField.equals("2")){
			query = query + " and list_contents like '%" + searchString + "%' ";
			count_query = count_query + " and list_contents like '%" + searchString + "%' ";
		}else if(searchField.equals("3")){
			query = query + " and (list_title like '%" + searchString + "%' or list_contents like '%" + searchString + "%')";
			count_query = count_query + " and (list_title like '%" + searchString + "%' or list_contents like '%" + searchString + "%')";
		}else if(searchField.equals("4")){
			query = query + " and list_name like '%" + searchString + "%' ";
			count_query = count_query + " and list_name like '%" + searchString + "%' ";
		}
	}
	
	//query = query + "order by list_id desc";
	query = query + " order by a.list_ref desc,  a.list_step asc, a.list_date desc, a.seq desc";
	
	//System.err.println(query);
	
	try {
     result_ht = getMediaList(pg, query, count_query, limit);

 }catch (Exception e) {
     result_ht = new Hashtable();
     result_ht.put("LIST", new Vector());
     result_ht.put("PAGE", new com.yundara.util.PageBean());
 }
 
	return result_ht;
}

public Hashtable getMediaList(int page, String query, int limit){
		// page정보를 얻는다.
     Vector v = querymanager.selectEntities(query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			totalRecord = v.size();
		}
		if(totalRecord <= 0){
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}

     PageBean pb = new PageBean(totalRecord, limit, 10, page);
		String rquery ="";
		rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
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

public Hashtable getMediaList(int page, String query, String count_query, int limit){
	// page정보를 얻는다.
    Vector v = querymanager.selectEntities(count_query);
	int totalRecord = 0;
	if(v != null && v.size() > 0){
		try{
			totalRecord = Integer.parseInt(String.valueOf(((Vector)(v.elementAt(0))).elementAt(0)));
		}catch(Exception ex){
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}
	}

	PageBean pb = new PageBean(totalRecord, limit, 10, page);
	String rquery ="";
	rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
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


public Vector getBoardList_admin(String list_id)
{
	if (list_id != null && list_id.length() > 0) {
		String query = "select * from board_list where del_flag='N' and list_id="+list_id;
	 
		Vector result = null;
		 try {
			result = querymanager.selectHashEntities(query);
	
		 }catch (Exception e) {
		 	result = null;
		 }
	 
		 return result;
	} else {
		return null;
	}
}


/**
* 모바일 게시판 보기 페이지
* @param list_id
* @return
*/
public Vector getBoardList_view(String list_id)
{
	if (list_id != null && list_id.length() > 0) {
		String query = "select * from board_list where list_open='Y' and del_flag='N' and list_id="+list_id;
	 
		Vector result = null;
		 try {
			result = querymanager.selectHashEntities(query);
	
		 }catch (Exception e) {
		 	result = null;
		 }
	 
		 return result;
	} else {
		return null;
	}
}


/**
* 모바일 게시판 리스트 페이지
* @param board_id
* @param pg
* @param limit
* @return
*/
	public Hashtable getBoardList(String board_id, int pg, int limit)
	{
		String query = "select a.list_id, a.list_title, a.list_contents, a.list_image_file from board_list a left join board_info b on a.board_id = b.board_id where b.flag = 'P' " ;
		String count_query = "select count(*) from board_list a left join board_info b on a.board_id = b.board_id where b.flag = 'P' " ;
		if (board_id != null && board_id.length() > 0) {	
			query =	query + " and a.board_id="+board_id+" " ;
			count_query = count_query + " and a.board_id="+board_id+" " ;
		}
		query =	query +" and a.del_flag='N' and a.list_open='Y' ";
		count_query = count_query +" and a.del_flag='N' and a.list_open='Y' ";
		
		query = query + " order by a.list_id desc";
		
		//System.out.println(query);
		Hashtable result_ht;
		try {
	     result_ht = getMediaList(pg, query,count_query, limit);
		
		 }catch (Exception e) {
		     result_ht = new Hashtable();
		     result_ht.put("LIST", new Vector());
		     result_ht.put("PAGE", new com.yundara.util.PageBean());
		 }
		 
			return result_ht;
		}



public int update_photo(HttpServletRequest req) throws Exception 
{
 
	try {
		 
		int board_id	 = 0;
		int list_id      =0;
		String event_seq = "";
		String event_gread = "";
		String list_open = "";
 
		if(req.getParameter("board_id") == null || com.vodcaster.utils.TextUtil.getValue(req.getParameter("board_id")).equals("")){
			return -1;
		}
		if(req.getParameter("list_id") == null || com.vodcaster.utils.TextUtil.getValue(req.getParameter("list_id")).equals("")){
			return -1;
		}
		try{
			if(req.getParameter("board_id") !=null && com.yundara.util.TextUtil.isNumeric(req.getParameter("board_id")))  
				board_id = Integer.parseInt(req.getParameter("board_id"));
		}catch(Exception ex){
			System.err.println(ex);
			return -1;
		}
		
		try{
			if(req.getParameter("list_id") !=null && com.yundara.util.TextUtil.isNumeric(req.getParameter("list_id")))  
				list_id = Integer.parseInt(req.getParameter("list_id"));
		}catch(Exception ex){
			System.err.println(ex);
			return -1;
		}
		 
		event_seq = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("event_seq")));
		event_gread = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("event_gread")));
		list_open = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("list_open")));
 
		String 	query =  "update board_list set board_id='"+board_id+"' ";
		 
		if (event_gread != null && event_gread.length() > 0)
		{
					query =  query + " ,event_gread ='"+event_gread+"' ";
		}
		if (list_open != null && list_open.length() > 0){
					query =  query + " ,list_open ='"+list_open+"' ";
		}

			query =  query + " where list_id ="+list_id + " and event_seq = " + event_seq;

//System.out.println(query);
 
		return querymanager.updateEntities(query);
	} catch(Exception e) {
		return -99;
	}
}


}
