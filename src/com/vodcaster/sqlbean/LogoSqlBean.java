package com.vodcaster.sqlbean;

import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.utils.ImageUtil;
import com.yundara.util.*;

import java.io.File;
import java.util.*;

import javax.servlet.http.*;

import javazoom.upload.MultipartFormDataRequest;

import dbcp.SQLBeanExt;


/**
 * @author park-jong-sung
 * 로고관련 클래스
 */

public class LogoSqlBean extends SQLBeanExt implements java.io.Serializable {
	/*----------------------------------------------
	 * discription : 로고
	 * 작성자       : 박종성
	 * 해당 파일    : /vodman/site/frm_mainLogo.jsp
	 * 작성일       : 2009/07/01
	 *----------------------------------------------*/
	public LogoSqlBean() {
		super();
	}


	/*----------------------------------------------
	 * discription : 로고 검색
	 * 작성자       : 박종성
	 * 해당 파일    : /vodman/site/frm_mainLogo.jsp
	 * 작성일       : 2009/07/01
	 *----------------------------------------------*/
	public Vector getLogo() {
        String query = "select * from logo";
        return querymanager.selectEntity(query);
	}


	/*----------------------------------------------
	 * discription : 로고 저장
	 * 작성자       : 박종성
	 * 해당 파일    : /vodman/site/frm_mainLogo.jsp
	 * 작성일       : 2009/07/01
	 *----------------------------------------------*/
	
	public int updateLogoImg(HttpServletRequest req, int iSize) throws Exception 
	{
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD +"/logo";

		if(iSize <=0){
			iSize = 20 * 1024 * 1024;
		}

		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, iSize, new DefaultFileRenamePolicyITNC21());

		String top_logo = "";
		String footer_logo = "";
		String media_logo = "";
		String play_logo = "";
		String play_pos = "";
		String opacity = "";

		String top_logo_del = "N";
		String footer_logo_del = "N";
		String media_logo_del = "N";
		String play_logo_del = "N";
		String top_logo_url = "/";
		String top_logo_text = "인터넷방송";
		String top_logo_use = "1";
		

		if(multi.getParameter("top_logo_del") !=null ) 
			top_logo_del = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("top_logo_del"));
		if(multi.getParameter("footer_logo_del") !=null ) 
			footer_logo_del = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("footer_logo_del"));
		if(multi.getParameter("media_logo_del") !=null ) 
			media_logo_del = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("media_logo_del"));
		if(multi.getParameter("play_logo_del") !=null ) 
			play_logo_del = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("play_logo_del"));
		if(multi.getParameter("top_logo_url") !=null ) 
			top_logo_url = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("top_logo_url"));
		if(multi.getParameter("top_logo_text") !=null ) 
			top_logo_text = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("top_logo_text"));
		if(multi.getParameter("top_logo_use") !=null && multi.getParameter("top_logo_use").length() == 1 
				&& (multi.getParameter("top_logo_use").equals("0") || multi.getParameter("top_logo_use").equals("1"))
				) 
			top_logo_use = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("top_logo_use"));
		
		top_logo_text = CharacterSet.toKorean(top_logo_text);
		try {
			top_logo = multi.getFilesystemName("top_logo");
		} catch(Exception e) {
			top_logo = "";
		}
		try {
			footer_logo = multi.getFilesystemName("footer_logo");
		} catch(Exception e) {
			footer_logo = "";
		}
		try {
			media_logo = multi.getFilesystemName("media_logo");
		} catch(Exception e) {
			media_logo = "";
		}
		try {
			play_logo = multi.getFilesystemName("play_logo");
		} catch(Exception e) {
			play_logo = "";
		}
		
		try {
			play_pos = multi.getParameter("play_pos");
		} catch(Exception e) {
			play_pos = "";
		}
		
		try {
			opacity = multi.getParameter("opacity");
			if(!com.yundara.util.TextUtil.isNumeric(opacity) ){
				opacity = "";
			}
		} catch(Exception e) {
			opacity = "";
		}
		

		//기존의 파일이름
		String _top_logo = "";
		String _footer_logo = "";
		String _media_logo = "";
		String _play_logo = "";

		//기존 파일이 있을경우 값을 선언한다음 지우게 된다.
		String del_file1 = "";
		String del_file2 = "";
		String del_file3 = "";
		String del_file4 = "";



			_top_logo = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("_top_logo"));
			del_file1 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("_top_logo"));
			_footer_logo = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("_footer_logo"));
			del_file2 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("_footer_logo"));
			_media_logo = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("_media_logo"));
			del_file3 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("_media_logo"));
			_play_logo = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("_play_logo"));
			del_file4 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("_play_logo"));
			
		String query =  "update logo set play_pos='"+play_pos+"' ";
			if (top_logo != null && top_logo.length() > 0){
				query =  query + ", top_logo ='"+top_logo+"'";
			} else if(top_logo_del.equals("Y")) {
				query =  query + ", top_logo =''";
			}

			query = query + ", top_logo_url='"+top_logo_url+"' ";
			query = query + ", top_logo_text='"+top_logo_text+"' ";
			query = query + ", top_logo_use='"+top_logo_use+"' ";
			
			if (footer_logo != null && footer_logo.length() > 0) {
				query =  query + ", footer_logo ='"+footer_logo+"'";
			}else if(footer_logo_del.equals("Y")) {
				query =  query + ", footer_logo =''";
			}
			
			
			if (media_logo != null && media_logo.length() > 0) {
				query =  query + ", media_logo ='"+media_logo+"'";
			}else if(media_logo_del.equals("Y")) {
				query =  query + ", media_logo =''";
				
			}
			
			if (opacity != null && opacity.length() > 0) {
				query =  query + ", opacity ="+opacity+"";
			}
			
			if (play_logo != null && play_logo.length() > 0) {
				query =  query + ", play_logo ='"+play_logo+"'";
			}else if(play_logo_del.equals("Y")) {
				query =  query + ", play_logo =''";
								
			}

//		System.out.println(query);
		if(querymanager.updateEntities(query) == 1){

			/////////////// 기존 파일 삭제
			if( (_top_logo != null && top_logo != null && _top_logo.indexOf('.') != -1 && top_logo.indexOf('.') != -1 ) || (top_logo_del.equals("Y") &&  _top_logo.indexOf('.') != -1 )){
				File deleteFile1 = new File(UPLOAD_PATH+"/"+del_file1);
				deleteFile1.delete(); // 기존 파일삭제
			}
			if( (_footer_logo != null && footer_logo != null && _footer_logo.indexOf('.') != -1 && footer_logo.indexOf('.') != -1) || (footer_logo_del.equals("Y") &&  _footer_logo.indexOf('.') != -1 )){
				File deleteFile2 = new File(UPLOAD_PATH+"/"+del_file2);
				deleteFile2.delete(); // 기존 파일삭제
			}
			if( (_media_logo != null && media_logo != null && _media_logo.indexOf('.') != -1 && media_logo.indexOf('.') != -1) || (media_logo_del.equals("Y") &&  _media_logo.indexOf('.') != -1 )){
				File deleteFile3 = new File(UPLOAD_PATH+"/"+del_file3);
				deleteFile3.delete(); // 기존 파일삭제
			}
			if( (_play_logo != null && play_logo != null && _play_logo.indexOf('.') != -1 && play_logo.indexOf('.') != -1) || (play_logo_del.equals("Y") &&  _play_logo.indexOf('.') != -1 )){
				File deleteFile4 = new File(UPLOAD_PATH+"/"+del_file4);
				deleteFile4.delete(); // 기존 파일삭제
			}

			
			return 1;

		}
		return 99;
	}
	
}



