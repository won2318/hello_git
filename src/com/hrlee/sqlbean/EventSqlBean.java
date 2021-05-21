/*
 * Created on 2005. 1. 13
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;

import com.yundara.util.*;

import java.io.File;
import java.util.*;

import javax.servlet.http.*;
import dbcp.SQLBeanExt;

import com.vodcaster.sqlbean.DirectoryNameManager;
import com.vodcaster.utils.ImageUtil;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
 


/**
 * @author Choi Hee-Sung
 *
 * 미디어 DB QUERY 클래스
 */
public class EventSqlBean  extends SQLBeanExt {

    public EventSqlBean() {
		super();
	}


	public Hashtable getEventList(int page,String query, int limit){

		// page정보를 얻는다.
        Vector v = querymanager.selectEntities(query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			totalRecord  = v.size();
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
	
	public Hashtable getEventListCnt(int page,String query, int limit, String cnt){

		// page정보를 얻는다.
		if (cnt != null && cnt.length() > 0) {
		 
	        Vector v = querymanager.selectEntities(cnt);
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
		} else {
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}
	}




public Hashtable getEventList(int page,String query, int limit, int limit2){

		// page정보를 얻는다.
        Vector v = querymanager.selectEntities(query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			totalRecord  = v.size();
		}
		if(totalRecord <= 0){
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}

        PageBean pb = new PageBean(totalRecord, limit, limit2, page);
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

public Hashtable getEventListCnt(int page,String query, int limit, int limit2, String cnt){

	// page정보를 얻는다.
	if (cnt != null && cnt.length() > 0){
		String cnt_query = "select count(cnt."+cnt+") from ( "+ query +" ) as cnt";
        Vector v = querymanager.selectEntities(cnt_query);
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
	
	    PageBean pb = new PageBean(totalRecord, limit, limit2, page);
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
	} else {
		Hashtable ht = new Hashtable();
		ht.put("LIST", new Vector());
		ht.put("PAGE", new com.yundara.util.PageBean());
		return ht;
	}
}

	public Vector selectQuery(String query) {
	    return querymanager.selectEntity(query);

	}
	
	public Vector selectQueries(String query) {
	    return querymanager.selectEntities(query);

	}
	
	public Vector selectQueryHash(String query) {
	    return querymanager.selectHashEntity(query);

	}

	public Vector selectEventListAll(String query){

		Vector rtn = null;

		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {
			System.err.println("selectPhotoListAll ex " + e.getMessage());
		}

		return rtn;
	}

	

	public int deleteEvent(String seq) throws Exception 
		{

		if (seq  != null && seq.length() > 0) {
			String qry = "select event_img  from event where seq="+seq;
			String old_file="";
		 
			Vector v = querymanager.selectEntity(qry);
			if(v != null && v.size() > 0) {
				old_file = String.valueOf(v.elementAt(0));
		 
//		System.out.println("old_path:"+old_path);

			}
//		System.out.println("old_file:"+old_file);

			String query = "update event set del_flag='Y' where seq = " + seq;

			if(querymanager.updateEntities(query) == 1){
					if (!old_file.equals(""))// 기존 이미지 삭제
				{
						String file_dir1=DirectoryNameManager.UPLOAD +"event/"+old_file;
						String file_dir1_middle=DirectoryNameManager.UPLOAD +"event/middle/"+old_file;
						String file_dir1_small=DirectoryNameManager.UPLOAD +"event/small/"+old_file;
 
						File deleteFile1 = new File(file_dir1);
						File deleteFile1_middle = new File(file_dir1_middle);
						File deleteFile1_small = new File(file_dir1_small);
						
						try{  
							deleteFile1.delete(); // 기존 이미지 파일 삭제
							deleteFile1_middle.delete(); // 기존 이미지 파일 삭제 썸네일
							deleteFile1_small.delete(); // 기존 이미지 파일 삭제 썸네일
						}
						catch(Exception e){ // 
							System.err.println(" 기존 이미지 파일 삭제 Ex : " +e);	
						}
					}
				return 1;
				
			} else {
				return -1;
			}
		} else {
			return -1;
		}

		}
	
	  public void updateEventHit(String seq) {
	    	if(seq != null && !seq.equals("")){
		        String query = " UPDATE event SET hit = hit + 1 WHERE seq = " + seq + " ";
		        querymanager.updateEntities(query);
	    	}
	   }
	    
	  
	/*****************************************************
	사진을 등록합니다.(insert문, 파일 등록)<p>
	<b>작성자</b>       : 호종현<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param req HttpServletRequest정보
	@see QueryManager#updateEntities
	******************************************************/
	public int write(HttpServletRequest req) throws Exception 
	{
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD+"/event/";
		
		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, 20 * 1024 * 1024, new DefaultFileRenamePolicyITNC21());
	
	    int seq 			= 0;		// 순차 코드
	    String title		= "";		// 이미지 제목
		String sdate	= "";		// 시작일자
		String edate	= "";		// 종료일자
		String pubdate	= "";		// 종료일자
		String content	= "";		// 종료일자
		int people_cnt = 0;		//인원수
		String insert_dt		= "";		// 등록일 
		String open_flag		= "";		// 공개구분
		String event_type		= "";		// 이벤트구분
		String del_flag		= "";		// 삭제 구분
		String event_img		= "";		// 이미지 파일
		String list_data_file		= "";		// 첨부 파일
		int hit = 0 ; // 카운트
	    
 

		if(multi.getParameter("title") !=null && multi.getParameter("title").length()>0) {
			title = CharacterSet.toKorean(multi.getParameter("title")) ;
			title = com.vodcaster.utils.TextUtil.getValue(title);
		}
		 
		if(multi.getParameter("sdate") !=null && multi.getParameter("sdate").length()>0) {
			sdate = CharacterSet.toKorean(multi.getParameter("sdate"));
 		}
		if(multi.getParameter("edate") !=null && multi.getParameter("edate").length()>0) {
			edate = CharacterSet.toKorean(multi.getParameter("edate"));
 		}
		if(multi.getParameter("pubdate") !=null && multi.getParameter("pubdate").length()>0) {
			pubdate = CharacterSet.toKorean(multi.getParameter("pubdate"));
 		}
		if(multi.getParameter("content") !=null && multi.getParameter("content").length()>0) {
			content = CharacterSet.toKorean(multi.getParameter("content"));
			content = com.vodcaster.utils.TextUtil.getValue(content);
		}
		 
		if(multi.getParameter("people_cnt") !=null && multi.getParameter("people_cnt").length()>0 ) 
			people_cnt = Integer.parseInt(multi.getParameter("people_cnt"));
		 
		if(multi.getParameter("open_flag") !=null && multi.getParameter("open_flag").length()>0) 
			open_flag = multi.getParameter("open_flag");
		
		if(multi.getParameter("event_type") !=null && multi.getParameter("event_type").length()>0) 
			event_type = multi.getParameter("event_type");


		try {
			event_img = multi.getFilesystemName("event_img");
			String ext = com.vodcaster.utils.TextUtil.getExtension(event_img);
			if (!ext.equals("")) {
				if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"IMG")){
					File del_file_file = new File(UPLOAD_PATH+event_img);
					del_file_file.delete(); // 기존 파일삭제
					 
				}else {
					ImageUtil.createThumbnail(UPLOAD_PATH+event_img, UPLOAD_PATH+"small/"+event_img, 200, 200);
					ImageUtil.createThumbnail(UPLOAD_PATH+event_img, UPLOAD_PATH+"middle/"+event_img, 600, 600);
					
				}
			} else {
				event_img="";
			}
		} catch(Exception e) {
			event_img = "";
		}

		String org_data_file = "";
		try {
			org_data_file = CharacterSet.toKorean(multi.getOriginalFileName("list_data_file"));
			list_data_file = multi.getFilesystemName("list_data_file");
			String ext = com.vodcaster.utils.TextUtil.getExtension(list_data_file);
			if (!ext.equals("")) {
				if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"ATTACH")){
					File del_file_file = new File(UPLOAD_PATH+list_data_file);
					del_file_file.delete(); // 기존 파일삭제
				} 
			} else {
				list_data_file="";
			}
		} catch(Exception e) {
			list_data_file = "";
		}

		
		String query = "insert into event ( title, sdate, edate, content, people_cnt, insert_dt, open_flag, event_type, del_flag, hit, event_img, pubdate, list_data_file, org_data_file) values" +
				"('"+title+"','"+sdate+"' , '"+edate+"', '"+content+"', '"+people_cnt+"', now(), '"+open_flag+"', '"+event_type+"', 'N', 0,'"+event_img+"','"+pubdate+"','"+list_data_file+"','"+org_data_file+"')";
		//System.out.println(query);
		int iReturn = querymanager.updateEntities(query);
		return iReturn;
		//return querymanager.updateEntities(query);
	}
	 
	 
	/*****************************************************
	사진수정.(update, 파일 등록)<p>
	<b>작성자</b>       : 김주현<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param req HttpServletRequest정보
	@see QueryManager#updateEntities
	******************************************************/
	public int update(HttpServletRequest req, String seq) throws Exception 
	{
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD+"/event/";
		
		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, 20 * 1024 * 1024, new DefaultFileRenamePolicyITNC21());
	
	 
		    String title		= "";		// 이미지 제목
			String sdate	= "";		// 시작일자
			String edate	= "";		// 종료일자
			String content	= "";		// 종료일자
			int people_cnt = 0;		//인원수
			String insert_dt		= "";		// 등록일 
			String open_flag		= "";		// 공개구분
			String event_type		= "";		// 이벤트구분
			String del_flag		= "";		// 삭제 구분
			String event_img		= "";		// 이미지 파일
			int hit = 0 ; // 카운트
			String img_del =""; //이미지 삭제
			String old_img = "";
		    String pubdate ="";
		    String list_data_file ="";  // 첨부파일
		    String attach_del = "";  // 첨부파일삭제
		    String old_attach = ""; // 기존 첨부파일명
	 

			if(multi.getParameter("title") !=null && multi.getParameter("title").length()>0) {
				title = CharacterSet.toKorean(multi.getParameter("title")) ;
				title = com.vodcaster.utils.TextUtil.getValue(title);
			}
			 
			if(multi.getParameter("sdate") !=null && multi.getParameter("sdate").length()>0) {
				sdate = CharacterSet.toKorean(multi.getParameter("sdate"));
	 		}
			if(multi.getParameter("edate") !=null && multi.getParameter("edate").length()>0) {
				edate = CharacterSet.toKorean(multi.getParameter("edate"));
	 		}
			if(multi.getParameter("pubdate") !=null && multi.getParameter("pubdate").length()>0) {
				pubdate = CharacterSet.toKorean(multi.getParameter("pubdate"));
	 		}
			if(multi.getParameter("content") !=null && multi.getParameter("content").length()>0) {
				content = CharacterSet.toKorean(multi.getParameter("content"));
				content = com.vodcaster.utils.TextUtil.getValue(content);
			}
			 
			if(multi.getParameter("people_cnt") !=null && multi.getParameter("people_cnt").length()>0 ) 
				people_cnt = Integer.parseInt(multi.getParameter("people_cnt"));
			 
			if(multi.getParameter("open_flag") !=null && multi.getParameter("open_flag").length()>0) 
				open_flag = multi.getParameter("open_flag");
			
			if(multi.getParameter("event_type") !=null && multi.getParameter("event_type").length()>0) 
				event_type = multi.getParameter("event_type");
			
			if(multi.getParameter("img_del") !=null && multi.getParameter("img_del").length()>0) 
				img_del = multi.getParameter("img_del");
			if(multi.getParameter("old_img") !=null && multi.getParameter("old_img").length()>0) 
				old_img = multi.getParameter("old_img");

			if(multi.getParameter("attach_del") !=null && multi.getParameter("attach_del").length()>0) 
				attach_del = multi.getParameter("attach_del");
			if(multi.getParameter("old_attach") !=null && multi.getParameter("old_attach").length()>0) 
				old_attach = multi.getParameter("old_attach");
			

			try {
				event_img = multi.getFilesystemName("event_img");
				String ext = com.vodcaster.utils.TextUtil.getExtension(event_img);
				if (!ext.equals("")) {
					if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"IMG")){
						File del_file_file = new File(UPLOAD_PATH+event_img);
						del_file_file.delete(); // 기존 파일삭제
						 
					}else {
						ImageUtil.createThumbnail(UPLOAD_PATH+event_img, UPLOAD_PATH+"small/"+event_img, 200, 200);
						ImageUtil.createThumbnail(UPLOAD_PATH+event_img, UPLOAD_PATH+"middle/"+event_img, 600, 600);
						
					}
				} else {
					event_img="";
				}

			} catch(Exception e) {
				event_img = "";
			} 
 
			String org_data_file = "";
			try {
				org_data_file = CharacterSet.toKorean(multi.getOriginalFileName("list_data_file"));
				list_data_file = multi.getFilesystemName("list_data_file");
				String ext = com.vodcaster.utils.TextUtil.getExtension(list_data_file);
				if (!ext.equals("")) {
					if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"ATTACH")){
						File del_file_file = new File(UPLOAD_PATH+list_data_file);
						del_file_file.delete(); // 기존 파일삭제
					}
				} else {
					list_data_file="";
				}

			} catch(Exception e) {
				list_data_file = "";
			} 

		String query = 
			"update event set "+
			" title ='"+title+"'";
			if (!sdate.equals(""))
			{
				query=query+", sdate= '"+sdate+"'";
			}

			if (!edate.equals(""))
			{
				query=query+", edate= '"+edate+"'";
			}
			if (!pubdate.equals(""))
			{
				query=query+", pubdate= '"+pubdate+"'";
			}
			if (!content.equals(""))
			{
				query=query+", content='" +content+"'";
			}
			if (people_cnt >= 0)
			{
				query=query+", people_cnt='" +people_cnt+"'";
			}
			if (!open_flag.equals(""))
			{
				query=query+", open_flag ='"+open_flag+"'";
			}
			if (!event_type.equals(""))
			{
				query=query+", event_type ='"+event_type+"'";
			}
			if (!event_img.equals(""))
			{
				query=query+", event_img ='"+event_img+"'";
			} else if (!img_del.equals("") && img_del.equals("Y")) {
				query=query+", event_img =''";
			}
			
			if (!list_data_file.equals(""))
			{
				query=query+", list_data_file ='"+list_data_file+"', org_data_file = '"+org_data_file+"' ";
			} else if (!attach_del.equals("") && attach_del.equals("Y")) {
				query=query+", list_data_file ='', org_data_file = '' ";
			}
			
			query=query+" where seq ="+seq;
		
 
		if(querymanager.updateEntities(query) == 1){
		 
			if (!event_img.equals("") && !old_img.equals(""))// 기존 이미지 삭제
			{
				String file_dir1=UPLOAD_PATH+old_img;
				String file_dir1_middle=UPLOAD_PATH+"middle/"+old_img;
				String file_dir1_small=UPLOAD_PATH+"small/"+old_img;
			
				File deleteFile1 = new File(file_dir1);
				File deleteFile1_middle = new File(file_dir1_middle);
				File deleteFile1_small = new File(file_dir1_small);
				
				try{  
					deleteFile1.delete(); // 기존 이미지 파일 삭제
					deleteFile1_middle.delete(); // 기존 이미지 파일 삭제 썸네일
					deleteFile1_small.delete(); // 기존 이미지 파일 삭제 썸네일
				}
				catch(Exception e){ // 
					System.err.println(" 기존 이미지 파일 삭제 Ex : " + e);	
				}
			}
			
			if (!list_data_file.equals("") && !old_attach.equals(""))// 기존 이미지 삭제
			{
				String file_dir1=UPLOAD_PATH+old_attach;
			 
				File deleteFile1 = new File(file_dir1);
			 
				
				try{  
					deleteFile1.delete(); // 기존 첨부 파일 삭제
				 
				}
				catch(Exception e){ // 
					System.err.println(" 기존 이미지 파일 삭제 Ex : " + e);	
				}
			}
			
			return 1;
		} else {
			return -1;
		}
		
	}
	  
	 
}