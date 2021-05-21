/*
 * Created on 2005. 1. 13
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.sqlbean;

import com.yundara.util.*;

import java.io.File;
import java.util.*;

import org.apache.commons.lang.StringUtils;
import javax.servlet.http.*;
import dbcp.*;
import com.vodcaster.sqlbean.DirectoryNameManager;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
 
/**
 * @author Choi Hee-Sung
 *
 * 미디어 DB QUERY 클래스
 */

public class SubjectSqlBean  extends SQLBeanExt {

    public SubjectSqlBean() {
		super();
	}

    
	////////////////
	// 해쉬 테이블 
	// 페이징 처리 
	/////////////
	public Hashtable getSubjectList(int page, String query, String count_query, int limit) {

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
		PageBean pb = new PageBean(totalRecord, limit, 10, page);

		// 해당 페이지의 리스트를 얻는다.
		String rquery = "";
		rquery = query + " limit " + (pb.getStartRecord() - 1) + "," + limit;
		Vector result_v = querymanager.selectHashEntities(rquery);

		Hashtable ht = new Hashtable();
		if (result_v != null && result_v.size() > 0) {
			ht.put("LIST", result_v);
			ht.put("PAGE", pb);
		} else {
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		}

		return ht;
	}
	 

	public Hashtable getSubjectList(int page, String query, String count_query, int limit, int limit2) {

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
		
		PageBean pb = new PageBean(totalRecord, limit, limit2, page);

		// 해당 페이지의 리스트를 얻는다.
		String rquery = "";
		rquery = query + " limit " + (pb.getStartRecord() - 1) + "," + limit;
		Vector result_v = querymanager.selectHashEntities(rquery);

		Hashtable ht = new Hashtable();
		if (result_v != null && result_v.size() > 0) {
			ht.put("LIST", result_v);
			ht.put("PAGE", pb);
		} else {
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		}

		return ht;
	}
	  

	public Vector selectQuery(String query) {
	    return querymanager.selectEntity(query);

	}

	public Vector selectSubjectListAll(String query){

		Vector rtn = null;

		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {
			System.err.println("selectSubjectListAll ex " + e.getMessage());
		}

		return rtn;
	}


/*
	public Vector getSubject_QuestionListAll(String idx) {

      String query = " select * from subject_question where sub_idx="+idx+" order by question_num asc, question_idx desc ";

	  return querymanager.selectHashEntities(query);
	}
*/

/////////////////////
// 설문 정보 등록 (설문제목)
////////////////////////

public int insert_subject (HttpServletRequest req) throws Exception{

	String sub_idx = "";
	String sub_title = "";
	String sub_start = "";
	String sub_end = "";
	String sub_person = "";
	String sub_name = "N";
	String sub_mf = "N";
	String sub_tel = "N";
	String sub_email = "N";
	String sub_etc = "";
	String sub_flag = "";
	String sub_user_on = "";

	 if(req.getParameter("sub_idx") !=null )
            sub_idx = req.getParameter("sub_idx");
	 if(req.getParameter("sub_title") !=null )
            sub_title = req.getParameter("sub_title");
	 if(req.getParameter("sub_start") !=null )
            sub_start = req.getParameter("sub_start");
	 if(req.getParameter("sub_end") !=null )
            sub_end = req.getParameter("sub_end");
	 if(req.getParameter("sub_person") !=null )
            sub_person = req.getParameter("sub_person");
	 if(req.getParameter("sub_name") !=null )
            sub_name = req.getParameter("sub_name");
	 if(req.getParameter("sub_mf") !=null )
            sub_mf = req.getParameter("sub_mf");
	 if(req.getParameter("sub_tel") !=null )
            sub_tel = req.getParameter("sub_tel");
	 if(req.getParameter("sub_email") !=null )
            sub_email = req.getParameter("sub_email");
	 if(req.getParameter("sub_etc") !=null )
            sub_etc = req.getParameter("sub_etc");
	 if(req.getParameter("sub_flag") !=null )
            sub_flag = req.getParameter("sub_flag");
	 if(req.getParameter("sub_user_on") !=null )
		 sub_user_on = req.getParameter("sub_user_on");
	   
	String query = "insert into subject(sub_title, sub_start,sub_end,sub_person,sub_name,sub_mf,sub_tel,sub_email,sub_etc,sub_flag,sub_user_on) values( '"+sub_title+"', '"+sub_start+"' ,'"+sub_end+"','"+sub_person+"','"+sub_name+"','"+sub_mf+"','"+sub_tel+"','"+sub_email+"','"+sub_etc+"','"+sub_flag+"','"+sub_user_on+"' )";

//System.out.println(query);
	return querymanager.updateEntities(query);
}

public int update_subject (HttpServletRequest req) throws Exception{

	String sub_idx = "";
	String sub_title = "";
	String sub_start = "";
	String sub_end = "";
	String sub_person = "0";
	String sub_name = "N";
	String sub_mf = "N";
	String sub_tel = "N";
	String sub_email = "N";
	String sub_etc = "";
	String sub_flag = "";
	String sub_user_on = "";
	

	 if(req.getParameter("sub_idx") !=null )
            sub_idx = req.getParameter("sub_idx");
	 if(req.getParameter("sub_title") !=null )
            sub_title = req.getParameter("sub_title");
	 if(req.getParameter("sub_start") !=null )
            sub_start = req.getParameter("sub_start");
	 if(req.getParameter("sub_end") !=null )
            sub_end = req.getParameter("sub_end");
	 if(req.getParameter("sub_person") !=null )
            sub_person = req.getParameter("sub_person");
	 if(req.getParameter("sub_name") !=null )
            sub_name = req.getParameter("sub_name");
	 if(req.getParameter("sub_mf") !=null )
            sub_mf = req.getParameter("sub_mf");
	 if(req.getParameter("sub_tel") !=null )
            sub_tel = req.getParameter("sub_tel");
	 if(req.getParameter("sub_email") !=null )
            sub_email = req.getParameter("sub_email");
	 if(req.getParameter("sub_etc") !=null )
            sub_etc = req.getParameter("sub_etc");
	 if(req.getParameter("sub_flag") !=null )
            sub_flag = req.getParameter("sub_flag");
	 if(req.getParameter("sub_user_on") !=null )
		 sub_user_on = req.getParameter("sub_user_on");
	 
	String query = "update subject set sub_title='"+sub_title+"', sub_start =  '"+sub_start+"', sub_end = '"+sub_end+"' ,sub_person ='"+sub_person+"',sub_name='"+sub_name+"',sub_mf='"+sub_mf+"', sub_tel = '"+sub_tel+"', sub_email='"+sub_email+"', sub_etc='"+sub_etc+"', sub_flag='"+sub_flag+"', sub_user_on='"+sub_user_on+"' where sub_idx = "+sub_idx ;
	 //String query = "update subject set sub_title='"+sub_title+"', sub_start =  '"+sub_start+"', sub_end = '"+sub_end+"'  ,sub_name='"+sub_name+"',sub_mf='"+sub_mf+"', sub_tel = '"+sub_tel+"', sub_email='"+sub_email+"', sub_etc='"+sub_etc+"', sub_flag='"+sub_flag+"' where sub_idx = "+sub_idx ;
//System.out.println(query);
     return querymanager.updateEntities(query);
}

public int delete_subject (String idx) throws Exception{
	String query = "delete from subject where sub_idx="+idx;
	return querymanager.updateEntities(query);

}

///////////////
// 문항 정보입력
///////////////


public int insert_question (HttpServletRequest req) throws Exception{
	String UPLOAD_PATH = DirectoryNameManager.UPLOAD + "/subject";
	MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, 20 * 1024 * 1024, new DefaultFileRenamePolicyITNC21());

	String question_idx = "";
	String sub_idx = "";
	String question_content = "";
	String question_option = "";
	String question_info = "";
	String question_etc = "";
	String question_num = "0";
	String question_image = "";

	 if(multi.getParameter("sub_idx") !=null && multi.getParameter("sub_idx").length()>0)  
          sub_idx = multi.getParameter("sub_idx");
	 if(multi.getParameter("question_content") !=null && multi.getParameter("question_content").length()>0)  {
		 question_content = CharacterSet.toKorean(multi.getParameter("question_content")).replace("'","''");
		 question_content = question_content.replace("#","&#35;").replace("&","&#38;").replace("<","&lt;").replace(">","&gt;").replace("(","&#40;").replace(")","&#41;");
	 }
	 if(multi.getParameter("question_option") !=null && multi.getParameter("question_option").length()>0)  
            question_option = multi.getParameter("question_option");
	 if(multi.getParameter("question_info") !=null && multi.getParameter("question_info").length()>0)  
            question_info = CharacterSet.toKorean(multi.getParameter("question_info")).replace("'","''");
	 if(multi.getParameter("question_etc") !=null && multi.getParameter("question_etc").length()>0)  
            question_etc = multi.getParameter("question_etc");
	 if(multi.getParameter("question_num") !=null && multi.getParameter("question_num").length()>0)  
            question_num = multi.getParameter("question_num");

	 try {
		 if (multi.getFilesystemName("question_image") != null )
		 {
			 question_image = multi.getFilesystemName("question_image");
		 }
			
		} catch(Exception e) {
			question_image = "";
		}
		int result = -1;
	 
		try {
			Vector v = null;
			v = querymanager.selectEntity(" SELECT ifnull(max(question_idx)+1,1)  FROM subject_question ");

			if(v != null && v.size() > 0){
				result = Integer.parseInt(String.valueOf(v.elementAt(0)));
			}
		} catch(Exception e) {
			System.out.println(e);
		}


	String query = "insert into subject_question(question_idx,sub_idx, question_content,question_option,question_info,question_etc,question_num, question_image) values("+result+",'"+sub_idx+"' ,'"+question_content+"','"+question_option+"', '"+question_info+"','"+question_etc+"','"+question_num+"','"+question_image+"')";

//     return querymanager.updateEntities(query);
// 등록 성공인경우 question_idx 값을 리턴
 
	if (querymanager.updateEntities(query) > 0)	{
		 

	} else {
		result = -1;
	}
	return result;
}

public int update_question (HttpServletRequest req) throws Exception{
	String UPLOAD_PATH = DirectoryNameManager.UPLOAD + "/subject";

	MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, 20 * 1024 * 1024, new DefaultFileRenamePolicyITNC21());

	String question_idx = "";
	String sub_idx = "";
	String question_content = "";
	String question_option = "";
	String question_info = "";
	String question_etc = "";
	String question_num = "0";
	String question_image = "";


	 if(multi.getParameter("question_idx") !=null && multi.getParameter("question_idx").length()>0)  
          question_idx = multi.getParameter("question_idx");
	 if(multi.getParameter("sub_idx") !=null && multi.getParameter("sub_idx").length()>0)  
          sub_idx = multi.getParameter("sub_idx");
	 if(multi.getParameter("question_content") !=null && multi.getParameter("question_content").length()>0)  {
		 question_content = CharacterSet.toKorean(multi.getParameter("question_content")).replace("'","''");
		 question_content = question_content.replace("#","&#35;").replace("&","&#38;").replace("<","&lt;").replace(">","&gt;").replace("(","&#40;").replace(")","&#41;");
	 }
	 if(multi.getParameter("question_option") !=null && multi.getParameter("question_option").length()>0)  
            question_option = multi.getParameter("question_option");
	 if(multi.getParameter("question_info") !=null && multi.getParameter("question_info").length()>0)  
            question_info = CharacterSet.toKorean(multi.getParameter("question_info")).replace("'","''");
	 if(multi.getParameter("question_etc") !=null && multi.getParameter("question_etc").length()>0)  
            question_etc = multi.getParameter("question_etc");
	 if(multi.getParameter("question_num") !=null && multi.getParameter("question_num").length()>0)  
		 question_num = multi.getParameter("question_num");

	 try {
			 if (multi.getFilesystemName("question_image") != null )
			 {
				 question_image = multi.getFilesystemName("question_image");
			 }
	} catch(Exception e) {
		question_image = "";
	}

	if (multi.getParameter("question_image_del") !=null && multi.getParameter("question_image_del").length()>0 && multi.getParameter("question_image_del").equals("delete"))
	{
		int del = delete_question_image(question_idx);
	}

	String qry = " select question_image from subject_question where question_idx="+question_idx;
	String old_file="";
	Vector v = querymanager.selectEntity(qry);
	if(v != null && v.size() > 0) {
		old_file = String.valueOf(v.elementAt(0));
	}

	String query = "update subject_question set question_content='"+question_content+"',question_option='"+question_option+"',question_info='"+question_info+"',question_etc='"+question_etc+"', question_num='"+question_num+"' ";
	if (question_image != null && question_image.length() > 0)
	{
		query = query + " , question_image = '"+question_image+"' " ;
	}
	
	query = query + " where question_idx="+question_idx;

		if(querymanager.updateEntities(query) == 1){
			if (!question_image.equals("") && !old_file.equals(""))// 기존 이미지 삭제
			{
				String file_dir1=UPLOAD_PATH+"/"+old_file;
		
				File deleteFile1 = new File(file_dir1);
				
				try{  
					deleteFile1.delete(); // 기존 이미지 파일 삭제
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

public int delete_question (String question_idx) throws Exception{
	int del = delete_question_image(question_idx);
	String query = "delete from subject_question where question_idx="+question_idx;
	return querymanager.updateEntities(query);

}

public int delete_question_image (String question_idx) throws Exception{
	String UPLOAD_PATH = DirectoryNameManager.UPLOAD + "/subject";
	String qry = " select question_image from subject_question where question_idx="+question_idx;
	String old_file="";
	Vector v = querymanager.selectEntity(qry);
	if(v != null && v.size() > 0) {
		old_file = String.valueOf(v.elementAt(0));
	}
	if ( !old_file.equals(""))// 기존 이미지 삭제
	{
		String file_dir1=UPLOAD_PATH+"/"+old_file;

		File deleteFile1 = new File(file_dir1);
		
		try{  
			deleteFile1.delete(); // 기존 이미지 파일 삭제
		}
		catch(Exception e){ // 
			System.err.println(" 기존 이미지 파일 삭제 Ex : " + e);	
		}
	}
	String query = "update subject_question set question_image='' where question_idx="+question_idx;
	return querymanager.updateEntities(query);

}

//////////////
// 문항번호 업데이트
/////////////

	public int getQuestion_inxUp(String num, String idx){
		String query = "update subject_question set question_num ='"+num+"' where question_idx="+idx;
		return querymanager.updateEntities(query);
	}

/////////////
// 예시 항목 저장
////////////
	public int insert_ans(HttpServletRequest req) throws Exception 
	{
		int iReturn = 1;

		String question_idx = "";
		String step_flag = "";
//		String ans_etc = "";
		String ans_order = "";

		if(req.getParameter("question_idx") !=null )
			question_idx = req.getParameter("question_idx");
		
		if(req.getParameter("step_flag") !=null )
			step_flag = req.getParameter("step_flag");
		
//		if(req.getParameter("ans_etc") !=null )
//			ans_etc = req.getParameter("ans_etc");
//		
		if(req.getParameter("ans_order") !=null )
			ans_order = req.getParameter("ans_order");

		String[] ans_inxArr2 = req.getParameterValues("ans_num");
		String[] ans_inxArr3 = req.getParameterValues("ans_content");
		
		String[] ans_inxArr4 = req.getParameterValues("ans_etc");		 	// 간략설명
		String[] ans_inxArr5 = req.getParameterValues("ans_img");  			// 대표이미지
		String[] ans_inxArr6 = req.getParameterValues("ans_hot7_ocode");	// 영상코드
		
		ArrayList aList = new ArrayList();

		if (ans_inxArr2 != null && ans_inxArr2.length > 0 && ans_inxArr3 != null && ans_inxArr3.length > 0) {

/////////////////////////////////////////////////////////////////
//        기존 예문들 삭제후 예문 등록
//
			String query2 = " DELETE FROM subject_ans WHERE question_idx = " + question_idx;
			querymanager.updateEntities(query2);
//
//
/////////////////////////////////////////////////////////////////
			String query = "";
			String query1 = " INSERT INTO subject_ans(  question_idx, step_flag, ans_num, ans_content, ans_order, ans_etc, ans_img , ans_hot7_ocode) VALUES ";

			for (int i=0; i < ans_inxArr3.length; i++) {


				if (StringUtils.isNotBlank(ans_inxArr2[i]) && StringUtils.isNotBlank(ans_inxArr3[i])) {
					query = query1 +
					" ( "+question_idx+" , '"+step_flag+"', '"+ans_inxArr2[i]+"','" + com.vodcaster.utils.TextUtil.getValue(ans_inxArr3[i])+"','"+ans_order+"','"+com.vodcaster.utils.TextUtil.getValue(ans_inxArr4[i])+"' ,'"+ans_inxArr5[i]+"' ,'"+ans_inxArr6[i]+"' ) ";
					
					 int request = querymanager.updateEntities(query);
//System.out.println(query);
					 if ( request <= 0 )
					 { 
						 iReturn = -1 ;
					 }
				}
			}
		}

		return iReturn;
	}
	

	public int update_ans(HttpServletRequest req) throws Exception 
	{
		
		int iReturn = 1;
		String ans_idx = "";
		String question_idx = "";
		String step_flag = "";
		String ans_etc = "";
		String ans_order = "";

		if(req.getParameter("ans_idx") !=null )
			ans_idx = req.getParameter("ans_idx");
		if(req.getParameter("question_idx") !=null )
			question_idx = req.getParameter("question_idx");
		
		if(req.getParameter("step_flag") !=null )
			step_flag = req.getParameter("step_flag");
		
//		if(req.getParameter("ans_etc") !=null )
//			ans_etc = req.getParameter("ans_etc");
//		
		if(req.getParameter("ans_order") !=null )
			ans_order = req.getParameter("ans_order");

		String[] ans_inxArr2 = req.getParameterValues("ans_num");
		String[] ans_inxArr3 = req.getParameterValues("ans_content");
		String[] ans_inxArr4 = req.getParameterValues("ans_etc");		 	// 간략설명
		String[] ans_inxArr5 = req.getParameterValues("ans_img");  			// 대표이미지
		String[] ans_inxArr6 = req.getParameterValues("ans_hot7_ocode");	// 영상코드

		ArrayList aList = new ArrayList();

		if (ans_inxArr2 != null && ans_inxArr2.length > 0 && ans_inxArr3 != null && ans_inxArr3.length > 0) {

			String query = "";

			for (int i=0; i < ans_inxArr3.length; i++) {
				if (StringUtils.isNotBlank(ans_inxArr2[i]) && StringUtils.isNotBlank(ans_inxArr3[i])) {
					 query =  " update subject_ans set step_flag = '"+step_flag+"', ans_num = '"+ans_inxArr2[i]+"', ans_content = '"+com.vodcaster.utils.TextUtil.getValue(ans_inxArr3[i])+"', ans_order = '"+ans_order+"'ans_etc = '"+com.vodcaster.utils.TextUtil.getValue(ans_inxArr4[i])+"', ans_img = '"+ans_inxArr5[i]+"', ans_hot7_ocode = '"+ans_inxArr6[i]+"'  where ans_idx = " +ans_idx;
					 int request = querymanager.updateEntities(query);
					 if ( request <= 0 )
					 { 
						 iReturn = -1 ;
					 }
				}
			}
		}

		return iReturn ;
	}
	

	public int delete_ans (String question_idx) throws Exception{  // 해당 예문 전체 삭제
		String query = "delete from subject_ans where question_idx="+question_idx;
		return querymanager.updateEntities(query);
	}

	public int delete_ans_idx (String ans_idx) throws Exception{  // 선택예문 삭제
		String query = "delete from subject_ans where ans_idx="+ans_idx;
		return querymanager.updateEntities(query);
	}

	public Vector getSubject_AnsList(String idx) {
        String query = "select * from subject_ans where question_idx="+idx+" order by ans_num asc ";
		return querymanager.selectEntities(query);

    }

	public Vector getSubject_QuiestionList(String idx) {
        String query = "select * from subject_question where sub_idx="+idx+" order by CAST(question_num  AS DECIMAL) ASC, question_idx asc ";
		return querymanager.selectEntities(query);

    }

	public String getSubject_AnsInx(String idx) {

	    Vector v = null;
        String query = "select max(ans_num) from subject_ans where question_idx="+idx;
        v = querymanager.selectEntity(query);

        if(v != null && v.size() > 0)
            return String.valueOf(v.elementAt(0));
        else
            return "0";
	}


	
//////////////
// 예문번호 업데이트
/////////////

	public int getAns_inxUp(String num, String idx){
		String query = "update subject_ans set ans_num ='"+num+"' where ans_idx="+idx;
		return querymanager.updateEntities(query);
	}


///////////////////
//  사용자 정보 입력
///////////////////


public int insert_user (HttpServletRequest req) throws Exception{

	String user_idx = "";
	String user_name = "";
	String user_mf = "";
	String user_tel = "";
	String user_email = "";
	String user_etc = "";
	String user_ip = "";
	
	String user_id = "";
	String lecture_idx = "0";

	 if(req.getParameter("user_idx") !=null )
            user_idx = req.getParameter("user_idx");
	 if(req.getParameter("user_name") !=null )
            user_name = req.getParameter("user_name");
	 if(req.getParameter("user_mf") !=null )
            user_mf = req.getParameter("user_mf");
	 if(req.getParameter("user_tel") !=null )
            user_tel = req.getParameter("user_tel");
	 if(req.getParameter("user_email") !=null )
            user_email = req.getParameter("user_email");
	 if(req.getParameter("user_etc") !=null )
            user_etc = req.getParameter("user_etc");
	 if(req.getParameter("lecture_idx") !=null )
		 lecture_idx = req.getParameter("lecture_idx");
	 if(req.getParameter("user_id") !=null )
		 user_id = req.getParameter("user_id");
//	 if(req.getParameter("user_ip") !=null )
            user_ip = req.getRemoteAddr();

            int result = 0;
            try {
    			Vector v = null;
    			v = querymanager.selectEntity(" SELECT ifnull(max(user_idx)+1,1) FROM subject_user ");

    			if(v != null && v.size() > 0){
    				result = Integer.parseInt(String.valueOf(v.elementAt(0)));
 			
    			}
    		} catch(Exception e) {
    			System.out.println(e);
    		}
 
	String query = "insert into subject_user(user_idx,user_name, user_mf,user_tel,user_email,user_etc,user_ip, user_date, user_id, lecture_idx) values("+result+",'"+user_name+"','"+user_mf+"', '"+user_tel+"','"+user_email+"','"+user_etc+"','"+user_ip+"', now(),'"+user_id+"','"+lecture_idx+"')";
//	return querymanager.updateEntities(query);
//System.out.println(query);

		if (querymanager.updateEntities(query) > 0)	{ 
			
		} else {
			result = -1;
		}
		return result;

	}

// 정보 수정
public int update_user (HttpServletRequest req) throws Exception{

	String user_idx = "";
	String user_name = "";
	String user_mf = "";
	String user_tel = "";
	String user_email = "";
	String user_etc = "";
	String user_ip = "";

	 if(req.getParameter("user_idx") !=null )
            user_idx = req.getParameter("user_idx");
	 if(req.getParameter("user_name") !=null )
            user_name = req.getParameter("user_name");
	 if(req.getParameter("user_mf") !=null )
            user_mf = req.getParameter("user_mf");
	 if(req.getParameter("user_tel") !=null )
            user_tel = req.getParameter("user_tel");
	 if(req.getParameter("user_email") !=null )
            user_email = req.getParameter("user_email");
	 if(req.getParameter("user_etc") !=null )
            user_etc = req.getParameter("user_etc");
//	 if(req.getParameter("user_ip") !=null )
            user_ip = req.getRemoteAddr();

	String query = " update subject_user set ";
		   query = query + " user_name='"+user_name+"'";
		   query = query + " ,user_mf='"+user_mf+"'";
		   query = query + " ,user_tel='"+user_tel+"'";
		   query = query + " ,user_email='"+user_email+"'";
		   query = query + " ,user_etc='"+user_etc+"'";
		   query = query + " where user_idx = "+ user_idx;
//System.out.println(query);

	return querymanager.updateEntities(query);

	}

////////////////////
// 점수 저장
///////////////

	public int insert_point ( String user_idx, int point )  throws Exception{

			String query = "update subject_user set event_point ="+point+" where user_idx = "+user_idx ;
	//System.out.println(query);
		 return querymanager.updateEntities(query);
	}
	
 

///////////////////
//  답변 내용 저장
///////////////////


public int insert_info (HttpServletRequest req) throws Exception{

	String info_idx = "";
	String sub_idx = "";
	String question_idx = "";
	String info_ip = "";
	String info_date = "";
	String info_order = "";
	String info_etc = "";
	String user_idx = "";
	String ans = "";
	String ans_order = "";

	 if(req.getParameter("info_idx") !=null )
            info_idx = req.getParameter("info_idx");
	 if(req.getParameter("sub_idx") !=null )
            sub_idx = req.getParameter("sub_idx");
	 if(req.getParameter("question_idx") !=null )
            question_idx = req.getParameter("question_idx");
	 if(req.getParameter("info_ip") !=null )
            info_ip = req.getParameter("info_ip");
	 if(req.getParameter("info_date") !=null )
            info_date = req.getParameter("info_date");
	 if(req.getParameter("info_order") !=null )
            info_order = req.getParameter("info_order");
	 if(req.getParameter("info_etc") !=null )
            info_etc = req.getParameter("info_etc");
	 if(req.getParameter("user_idx") !=null )
            user_idx = req.getParameter("user_idx");
	 if(req.getParameter("ans") !=null )
            ans = req.getParameter("ans");
	 if(req.getParameter("ans_order") !=null )
            ans_order = req.getParameter("ans_order");

	String query = "insert into subject_info(sub_idx, question_idx,info_ip,info_date,info_order,info_etc,user_idx,ans,ans_order)	values	( '"+sub_idx+"','"+question_idx+"', '"+info_ip+"','"+info_date+"','"+info_order+"','"+info_etc+"','"+user_idx+"','"+ans+"','"+ans_order+"')";
	return querymanager.updateEntities(query);
	}

	
   public int insert_info2 ( String sub_idx , String question_idx  , String info_order , String info_etc ,String user_idx ,String ans ,String ans_order) throws Exception{

	String query = "insert into subject_info(sub_idx, question_idx, info_order,info_etc,user_idx,ans,ans_order)	values	( '"+sub_idx+"','"+question_idx+"', '"+info_order+"','"+info_etc+"','"+user_idx+"','"+ans+"','"+ans_order+"')";
	//System.out.println(query);
	return querymanager.updateEntities(query);
	}

	// 선택 사용자 답변 지우기

	public int delete_info_user (String user_idx) throws Exception{
		String query = "delete from subject_info where user_idx="+user_idx;
		return querymanager.updateEntities(query);

	}


	public int delete_info (String idx) throws Exception{
		String query = "delete from subject_info where info_idx="+idx;
		return querymanager.updateEntities(query);

	}

	/* 설문 인원수 */
	public int user_count(String sub_idx) {
	    Vector v = null;
		String query = "select count( distinct (e.user_idx)) from subject a, subject_question b ,  subject_info d, subject_user e "
				+ " where d.sub_idx = a.sub_idx and d.question_idx = b.question_idx  and d.user_idx=e.user_idx"
				+ " and a.sub_idx= " + sub_idx;
        v = querymanager.selectEntity(query);
        //System.out.println(query);
        if(v != null && v.size() > 0)
            return Integer.parseInt(String.valueOf(v.elementAt(0)));
        else
            return 0;
	}

/* 설문 인원수(성별) */
	public int user_count(String sub_idx, String MF) {
	    Vector v = null;
		String query = "select count( distinct (e.user_idx)) from subject a, subject_question b ,  subject_info d, subject_user e "
				+ " where d.sub_idx = a.sub_idx and d.question_idx = b.question_idx  and d.user_idx=e.user_idx"
				+ " and a.sub_idx= " + sub_idx ;
				if (MF != null && MF.length() > 0)
				{
				query = query+ " and e.user_mf = '" + MF + "'" ;
				}
				
        v = querymanager.selectEntity(query);
        if(v != null && v.size() > 0)
            return Integer.parseInt(String.valueOf(v.elementAt(0)));
        else
            return 0;
	}


/* 문항 답한 명수 */
	public int user_count_question(String sub_idx, String question_idx) {
	    Vector v = null;
		String query = " select count(distinct (e.user_idx)) from subject a, subject_question b ,  subject_info d, subject_user e "
		+ " where  d.question_idx = b.question_idx and d.user_idx=e.user_idx "
		+ " and a.sub_idx="+sub_idx+" and b.question_idx= "+question_idx;

        v = querymanager.selectEntity(query);
        if(v != null && v.size() > 0)
            return Integer.parseInt(String.valueOf(v.elementAt(0)));
        else
            return 0;
	}
	/* 문항 답한 명수 , 성별*/
	public int user_count_question(String sub_idx, String question_idx, String MF, String question_flag) {
	    Vector v = null;
		String query = " select count(distinct (e.user_idx)) from subject a, subject_question b ,  subject_info d, subject_user e "
		+ " where  d.question_idx = b.question_idx and d.user_idx=e.user_idx "
		+ " and a.sub_idx="+sub_idx+" and b.question_idx= "+question_idx ;
		if (MF != null && MF.length() > 0)
		{
			 query = query+ " and e.user_mf = '" + MF + "'" ;
		}
		if (question_flag != null && question_flag.equals("5")) // textarea 일경우 ans(값이 값음)
		{
			 query = query+ " and d.ans_order is not null";
		}
		
        v = querymanager.selectEntity(query);
        if(v != null && v.size() > 0)
            return Integer.parseInt(String.valueOf(v.elementAt(0)));
        else
            return 0;
	}
	
	public int user_count_question(String sub_idx, String question_idx, String MF, String question_flag, String teacher_code, String delivery_idx) {
	    Vector v = null;
		String query = " select count(distinct (e.user_idx)) from subject a, subject_question b ,  subject_info d, subject_user e , delivery_request f "
		+ " where  d.question_idx = b.question_idx and d.user_idx=e.user_idx and e.lecture_idx = f.delivery_request_idx "
		+ " and a.sub_idx="+sub_idx+" and b.question_idx= "+question_idx ;
		if (MF != null && MF.length() > 0)
		{
			 query = query+ " and e.user_mf = '" + MF + "'" ;
		}
		if (question_flag != null && question_flag.equals("5")) // textarea 일경우 ans(값이 값음)
		{
			 query = query+ " and d.ans_order is not null";
		}
		if (teacher_code != null && teacher_code.length() > 0) {
			query = query+ " and f.teacher_member_code = '"+teacher_code+"'";
		}
		if (delivery_idx != null && delivery_idx.length() > 0) {
			query = query+ " and e.lecture_idx='"+delivery_idx+"'";
		}
        v = querymanager.selectEntity(query);
        if(v != null && v.size() > 0)
            return Integer.parseInt(String.valueOf(v.elementAt(0)));
        else
            return 0;
	}

/* 예문 각각 답변 갯수 */
	public int user_count_ans(String sub_idx, String question_idx, String ans_idx) {

	    Vector v = null;
		String query = " select count(info_idx) from  subject_info where " 
			+ " sub_idx="+sub_idx+" and question_idx="+question_idx+" and ans="+ ans_idx;

        v = querymanager.selectEntity(query);
        if(v != null && v.size() > 0)
            return Integer.parseInt(String.valueOf(v.elementAt(0)));
        else
            return 0;
	}
	/* 예문 각각 답변 갯수, 성별 */
	public int user_count_ans(String sub_idx, String question_idx, String ans_idx, String MF) {

	    Vector v = null;
		String query = " select count(d.info_idx) from  subject_info d, subject_user e where d.user_idx=e.user_idx and " 
			+ " d.sub_idx="+sub_idx+" and d.question_idx="+question_idx+" and d.ans="+ ans_idx  ;
			if (MF != null && MF.length() > 0)
			{
				query = query+ " and e.user_mf = '" + MF + "'" ;
			}
			
        v = querymanager.selectEntity(query);
        if(v != null && v.size() > 0)
            return Integer.parseInt(String.valueOf(v.elementAt(0)));
        else
            return 0;
	}
	
	public int user_count_ans(String sub_idx, String question_idx, String ans_idx, String MF, String teacher_code, String delivery_idx) {

	    Vector v = null;
		String query = " select count(d.info_idx) from  subject_info d, subject_user e where d.user_idx=e.user_idx and " 
			+ " d.sub_idx="+sub_idx+" and d.question_idx="+question_idx+" and d.ans="+ ans_idx  ;
			if (MF != null && MF.length() > 0)
			{
				query = query+ " and e.user_mf = '" + MF + "'" ;
			}
			if (teacher_code != null && teacher_code.length() > 0) {
				query = query+ " and f.teacher_member_code = '"+teacher_code+"'";
			}
			if (delivery_idx != null && delivery_idx.length() > 0) {
				query = query+ " and e.lecture_idx='"+delivery_idx+"'";
			}
			
        v = querymanager.selectEntity(query);
        if(v != null && v.size() > 0)
            return Integer.parseInt(String.valueOf(v.elementAt(0)));
        else
            return 0;
	}


	/* 예문 답변 반복 (라디오버튼) */
	public int user_count_ans2(String sub_idx, String question_idx, String ans_idx, String ans_num) {

	    Vector v = null;

		String query = " select count(info_idx) from  subject_info where " 
			+ " sub_idx="+sub_idx+" and question_idx="+question_idx+" and ans="+ ans_idx +" and info_etc = "+ans_num;

//System.out.println(query);
        v = querymanager.selectEntity(query);
        if(v != null && v.size() > 0)
            return Integer.parseInt(String.valueOf(v.elementAt(0)));
        else
            return 0;
	}

/* 예문 답변 반복 (라디오버튼) , 성별 */
	public int user_count_ans2(String sub_idx, String question_idx, String ans_idx, String ans_num, String MF) {

	    Vector v = null;
		String query = " select count(d.info_idx) from  subject_info d,subject_user e where d.user_idx=e.user_idx and " 
			+ " d.sub_idx="+sub_idx+" and d.question_idx="+question_idx+" and d.ans="+ ans_idx +" and d.info_etc = "+ans_num ;
			if (MF != null && MF.length() > 0)
			{
				query = query+ " and e.user_mf = '" + MF + "'" ;
			}
			
//System.out.println(query);
        v = querymanager.selectEntity(query);
        if(v != null && v.size() > 0)
            return Integer.parseInt(String.valueOf(v.elementAt(0)));
        else
            return 0;
	}
	
	public int user_count_ans2(String sub_idx, String question_idx, String ans_idx, String ans_num, String MF, String teacher_code, String delivery_idx) {

	    Vector v = null;
		String query = " select count(d.info_idx) from  subject_info d,subject_user e, delivery_request f where d.user_idx=e.user_idx and  d.user_idx=e.user_idx and e.lecture_idx = f.delivery_request_idx and " 
			+ " d.sub_idx="+sub_idx+" and d.question_idx="+question_idx+" and d.ans="+ ans_idx +" and d.info_etc = "+ans_num ;
			if (MF != null && MF.length() > 0)
			{
				query = query+ " and e.user_mf = '" + MF + "'" ;
			}
			if (teacher_code != null && teacher_code.length() > 0) {
				query = query+ " and f.teacher_member_code = '"+teacher_code+"'";
			}
			if (delivery_idx != null && delivery_idx.length() > 0) {
				query = query+ " and e.lecture_idx='"+delivery_idx+"'";
			}
			
//System.out.println(query);
        v = querymanager.selectEntity(query);
        if(v != null && v.size() > 0)
            return Integer.parseInt(String.valueOf(v.elementAt(0)));
        else
            return 0;
	}

	



//////////////
//  정답 가져 오기 (객관식)
////////////
public String getAns_num(String idx) {

	    Vector v = null;
        String query = " select ans_order from subject_ans where question_idx ="+idx;
        v = querymanager.selectEntity(query);

        if(v != null && v.size() > 0)
            return String.valueOf(v.elementAt(0));
        else
            return "0";
	}
	

	
//////////////
//  정답 가져 오기 (주관식)
////////////
public String getAns_order(String idx) {

	    Vector v = null;
        String query = " select ans_content from subject_ans where question_idx ="+idx;
        v = querymanager.selectEntity(query);

        if(v != null && v.size() > 0)
            return String.valueOf(v.elementAt(0));
        else
            return "";
	}
      //////////////
      //  사용자 답 가져 오기
      ////////////
      public String getAns_user_num(String user_idx, String question_idx) {

        Vector v = null;
        String query = " select ans from subject_info where user_idx="+user_idx+" and question_idx = "+question_idx ;
        v = querymanager.selectEntity(query);
        if(v != null && v.size() > 0)
         return String.valueOf(v.elementAt(0));
        else
         return "";
      }

      public String getAns_user_order(String user_idx, String question_idx) {

        Vector v = null;
        String query = " select ans_order from subject_info where ans_order is not null and user_idx="+user_idx+" and question_idx = "+question_idx ;
        v = querymanager.selectEntity(query);
        if(v != null && v.size() > 0)
         return String.valueOf(v.elementAt(0));
        else
         return "";
      }
      
      public Vector getAns_user_num_V(String user_idx, String question_idx) {
          String query = "select ans from subject_info where user_idx="+user_idx+" and question_idx = "+question_idx ;
          return querymanager.selectEntities(query);
      }
      
	///////////////
	//    기타 답변 (text)
	//////////// //
	  public String getAns_user_order2(String user_idx, String question_idx) {
	
	    Vector v = null;
	    String query = " select info_order from subject_info where info_order is not null and user_idx="+user_idx+" and question_idx = "+question_idx ;
	    v = querymanager.selectEntity(query);
	
	    if(v != null && v.size() > 0)
	     return String.valueOf(v.elementAt(0));
	    else
	     return "";
	  }

	  /* 이벤트 정답자 인원수 */
		public int user_count_T(String sub_idx) {
			
			String qry = " select count(distinct (b.question_idx)) from subject a, subject_question b "
				+ " where b.sub_idx = a.sub_idx  and a.sub_idx= "+sub_idx ;

			Vector vt = querymanager.selectEntity(qry);
			int Pcount = 0;

			if(vt != null && vt.size() > 0){
	             Pcount = Integer.parseInt(String.valueOf(vt.elementAt(0)));
			}
			
		    Vector v = null;
			String query = "select count( distinct (e.user_idx)) from subject a, subject_question b ,  subject_info d, subject_user e "
					+ " where d.sub_idx = a.sub_idx and d.question_idx = b.question_idx  and d.user_idx=e.user_idx"
					+ " and a.sub_idx= " + sub_idx+"and e.event_point >= " + Pcount;
	        v = querymanager.selectEntity(query);
	        if(v != null && v.size() > 0)
	            return Integer.parseInt(String.valueOf(v.elementAt(0)));
	        else
	            return 0;
		}

//////////////////////////
// 이벤트 추첨 인원 목록
//////////////////////////
int total_people_count = 0;  // 재추첨
int event_people = 0 ;  // 추첨 인원 전역변수

	public int getEvent_userList(String sub_idx, int people){
	int people_count = 0;  

		int right_people = user_count_T(sub_idx);  // 만점자 인원수(정답자)
//	int people = 0; // 당첨 인원수

		Random ran = new Random();
		int num[] = new int[people]; // 당첨자
		for (int i = 0; i < people; i++) {
			num[i] = ran.nextInt(right_people) + 1; // user 수만큼 난수 발생 
			for (int j = 0; j < i; j++) { // 생성된 수와 이전에 저장된 수를 비교 
				if (num[i] == num[j]) { // 중복체크
					num[i] = ran.nextInt(right_people) + 1; // 다시 수를 생성
					i = i - 1; // 다시 첨부터 같은 숫자가 있는 비교 
					break;
				}
			}
		}

		Vector v= null;
		String query =" select * from ( "
			
		//+"    select f.*,  rownum rnum from( "
		+" select  @rnum:=@rnum+1 as rownum, f.*"
		+"        select distinct (e.user_idx), e.user_name, e.user_mf, e.user_tel,e.user_email, e.user_etc, e.user_ip, e.user_date, e.event_point from subject a, subject_question b ,  subject_info d, subject_user e "
		+"        where d.sub_idx = a.sub_idx and d.question_idx = b.question_idx  and d.user_idx=e.user_idx and a.sub_idx= "+sub_idx 
		+"        and e.event_point= ( select count(question_idx) from subject_question where sub_idx="+sub_idx +" ) "
		+"    ) f "
		+" )  " ;
		query = query + "   where rownum in( ";
		for (int i = 0; i < num.length  ; i++) {
			if ( i > 0)
			{
				query = query +"," ;
			}
			
			query = query +  num[i] ;
		}
		query = query +" ) " ;


		try {
			v = querymanager.selectEntities(query);


////////////////
// 중복 당첨 제거
/////////////////

		 if (v != null && v.size() > 0) {
				for (int i = 0; i < v.size() ; i ++ ) {  
						Vector v2= getEvent_user(sub_idx);
						boolean check = true;
						if ( v2 != null && v2.size() > 0 )	{
							for (int j = 0; j < v2.size() ; j ++ )	{
								if ( String.valueOf(((Vector)(v.elementAt(i))).elementAt(3)) != null && String.valueOf(((Vector)(v2.elementAt(j))).elementAt(3)) != null && String.valueOf(((Vector)(v.elementAt(i))).elementAt(3)).equals( String.valueOf(((Vector)(v2.elementAt(j))).elementAt(3)) ) )  //전화 번호 비교
								{
									check = false;
									//중복 당첨 입니다.
									
								} else if (String.valueOf(((Vector)(v.elementAt(i))).elementAt(4)) != null && String.valueOf(((Vector)(v2.elementAt(j))).elementAt(4)) != null && String.valueOf(((Vector)(v.elementAt(i))).elementAt(4)).equals( String.valueOf(((Vector)(v2.elementAt(j))).elementAt(4)) )) {  // email 비교
									check = false;

								} 
							}
						}

						if (check)
						{
							insert_event_user2( sub_idx, String.valueOf(((Vector)(v.elementAt(i))).elementAt(0)) );
							people_count ++ ;  // 추첨된 인원
							event_people ++ ; // 전체 추첨된 인원수

						}

				}
		 }

//System.out.println(people +"::"+ people_count);


		 if (people > people_count)
		 {
			 total_people_count ++ ;  // 재추첨 몇번 했는지..

			 if (total_people_count < right_people )
			 {
				 getEvent_userList( sub_idx,  people-people_count );
			 }

			 
		 }

		}catch(Exception e) {
			System.err.println("getEvent_userList ex : " + e.getMessage());
		}

		return event_people;  // 추첨인원 리턴

	}

//	이벤트 당첨자 입력
	public int insert_event_user (HttpServletRequest req) throws Exception{
		
		
//		String event_idx = "";
		String sub_idx = "";
//		String event_date = "";
		String people = "";
		String user_idx = "";

//		 if(req.getParameter("event_idx") !=null )
//			event_idx = req.getParameter("event_idx");
		 if(req.getParameter("sub_idx") !=null )
			sub_idx = req.getParameter("sub_idx");
//		 if(req.getParameter("event_date") !=null )
//			 event_date = req.getParameter("event_date");
		 if(req.getParameter("people") !=null )
			 people = req.getParameter("people");
		 if(req.getParameter("user_idx") !=null )
			 user_idx = req.getParameter("user_idx");

		String query = "insert into subject_event(sub_idx,event_date,event_people,user_idx) values( "+sub_idx+", now() , "+people+","+user_idx+" )";

//	System.out.println(query);
		return querymanager.updateEntities(query);
	}


	public int insert_event_user2 (String sub_idx, String user_idx) throws Exception{

		String query = " insert into subject_event(sub_idx,event_date,event_people,user_idx) values( "+sub_idx+", now() , '',"+user_idx+" )";

		return querymanager.updateEntities(query);
	}

//////////////////////////
// 이벤트 추첨 결과 목록
//////////////////////////

	public Vector getEvent_user(String sub_idx){

		String query = " select b.* from subject_event a , subject_user b where a.user_idx = b.user_idx and sub_idx = " + sub_idx;

		return querymanager.selectEntities(query);

	}
	

	public String getSubjectUser_check(String idx, String dupInfo) {

	    Vector v = null;
        String query = " select a.user_etc from subject_user a , subject_info b where a.user_idx = b.user_idx and b.sub_idx="+idx+ " and a.user_etc='" + dupInfo+"' " ;
        v = querymanager.selectEntity(query);
//System.out.println(query);
        if(v != null && v.size() > 0)
            return String.valueOf(v.elementAt(0));
        else
            return null;
	}




}