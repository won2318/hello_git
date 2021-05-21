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
import java.io.*;
import java.awt.Image;
import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiException;
import com.sun.jimi.core.JimiUtils;


/**
 * @author Choi Hee-Sung
 *
 * 미디어 DB QUERY 클래스
 */
public class PhotoSqlBean  extends SQLBeanExt {

    public PhotoSqlBean() {
		super();
	}


	public Hashtable getPhotoList(int page,String query, int limit){

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



public Hashtable getPhotoList(int page,String query, int limit, int limit2){

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

	public Vector selectQuery(String query) {
	    return querymanager.selectEntity(query);

	}
	
	public Vector selectQueries(String query) {
	    return querymanager.selectEntities(query);

	}

	public Vector selectPhotoListAll(String query){

		Vector rtn = null;

		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {
			System.err.println("selectPhotoListAll ex " + e.getMessage());
		}

		return rtn;
	}

	
	/*****************************************************
	사진을 등록합니다.(insert문, 파일 등록)<p>
	<b>작성자</b>       : 호종현<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param req HttpServletRequest정보
	@see QueryManager#updateEntities
	******************************************************/
	public int write(HttpServletRequest req, String c_code) throws Exception 
	{
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_MEDIA + MediaManager.getInstance().getUploadFolder(c_code, "P" );
		
		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, 20 * 1024 * 1024, new DefaultFileRenamePolicyITNC21());
	
		String ccode	 = "";
		int ocode	 = 0;
		String title = "";
		String text1 = "";
		String text2 = "";
		String text3 = "";
		String text4 = "";
		String text5 = "";
		String text6 = "";
		String filename = "";
		String mview_flag = "Y";
		String pflag = "P";
		String path = "";
		int plevel = 0;
		
		if(multi.getParameter("ccode") !=null && multi.getParameter("ccode").length()>0) 
			ccode = (multi.getParameter("ccode"));
		if(multi.getParameter("ocode") !=null && multi.getParameter("ocode").length()>0) {
			ocode = Integer.parseInt(multi.getParameter("ocode"));
		} else {
			String qry = "select max(ocode) from photo";
			Vector v = querymanager.selectEntity(qry);
			if(v != null && v.size() > 0) {
				ocode = Integer.parseInt(String.valueOf(v.elementAt(0)));
			}
			ocode++;
		}

		if(multi.getParameter("title") !=null && multi.getParameter("title").length()>0) {
			title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("title")) );
 		}
		if(multi.getParameter("text1") !=null && multi.getParameter("text1").length()>0) {
			text1 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text1")) );
 		}
		if(multi.getParameter("text2") !=null && multi.getParameter("text2").length()>0) {
			text2 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text2")) );
 		}
		if(multi.getParameter("text3") !=null && multi.getParameter("text3").length()>0) {
			text3 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text3")) );
 		}
		if(multi.getParameter("text4") !=null && multi.getParameter("text4").length()>0) {
			text4 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text4")));
 		}
		if(multi.getParameter("text5") !=null && multi.getParameter("text5").length()>0) {
			text5 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text5")));
 		}
		if(multi.getParameter("text6") !=null && multi.getParameter("text6").length()>0) {
			text6 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text6"))) ;
	 	}
		if(multi.getParameter("plevel") !=null && multi.getParameter("plevel").length()>0) 
			plevel = Integer.parseInt(multi.getParameter("plevel"));

		if(multi.getParameter("mview_flag") !=null && multi.getParameter("mview_flag").length() > 0 ) 
			mview_flag = multi.getParameter("mview_flag");
		if(multi.getParameter("pflag") !=null && multi.getParameter("pflag").length() > 0 ) 
			pflag = multi.getParameter("pflag");


		try {
			filename = multi.getFilesystemName("oimagefile1");

				//Image thumb1 = JimiUtils.getThumbnail(UPLOAD_PATH+"/"+list_image_file,150,150,Jimi.IN_MEMORY);  // 원본이미지
				//Jimi.putImage(thumb1,UPLOAD_PATH_IMG+"/"+list_image_file);	                // 썸네일 이미지
			ImageUtil.createThumbnail(UPLOAD_PATH+"/"+filename, UPLOAD_PATH+"/small/"+filename, 100, 100);
			ImageUtil.createThumbnail(UPLOAD_PATH+"/"+filename, UPLOAD_PATH+"/middle/"+filename, 450, 450);
			path = "/mediaROOT" + MediaManager.getInstance().getUploadFolder(c_code, "P" );

		} catch(Exception e) {
			filename = "";
		}

		String query = "insert into photo (ccode, ocode, title, text1, text2, text3, text4, text5, text6, filename, mview_flag, pflag, path, plevel, owdate) values('"+ccode+"', "+ocode+", '"+title+"', password('"+text1+"'),'"+text2+"','"+text3+"','"+text4+"', '"+text5+"','"+text6+"' ,'"+filename+"', '"+mview_flag+"', '"+pflag+"','"+path+"',"+plevel+",now())";
//		System.out.println(query);
		int iReturn = querymanager.updateEntities(query);
		return iReturn;
		//return querymanager.updateEntities(query);
	}
	
	public int write_sub(String ccode, String code, String pflag, String mview_flag, String filename ,String vod_id, String vod_name) throws Exception 
	{
		String title = "";
		String text1 = "";
		String text2 = "";
		String text3 = "";
		String text4 = "";
		String text5 = "";
		String text6 = "";
		String path = "";
		int plevel = 0;
		int ocode = -1;
		
		if(ccode ==null || ccode.length()<=0) 
			ccode = "";
		
		if(vod_id != null && vod_id.length() > 0) {
			text3 = vod_id;
		}
		
		if(vod_name != null && vod_name.length() > 0) {
			text4 = vod_name;
		}
		
		if(code != null && code.length() > 0) {
			ocode = Integer.parseInt(code);
		}
		
		if(pflag ==null || pflag.length()<=0) 
			pflag = "P";
		
		if(mview_flag ==null || mview_flag.length()<=0) 
			mview_flag = "Y";
		
		if(filename ==null || filename.length()<=0) {
			filename = "";
		} else {
			title = filename;
		}
		
		path = "/mediaROOT" + MediaManager.getInstance().getUploadFolder(ccode, "P" );
		
		String query = "insert into photo (ccode, ocode, title, text1, text2, text3, text4, text5, text6, filename, mview_flag, pflag, path, plevel, owdate) values('"+ccode+"', "+ocode+", '"+title+"', '"+text1+"','"+text2+"','"+text3+"','"+text4+"', '"+text5+"','"+text6+"' ,'"+filename+"', '"+mview_flag+"', '"+pflag+"','"+path+"',"+plevel+",now())";
//		System.out.println(query);
		int iReturn = querymanager.updateEntities(query);
			
		return iReturn;
		//return querymanager.updateEntities(query);
	}
	
	
	/*****************************************************
	사진을 등록합니다.(insert문, 파일 등록)<p>
	<b>작성자</b>       : 호종현<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param req HttpServletRequest정보
	@see QueryManager#updateEntities
	******************************************************/
	public int write_user(HttpServletRequest req, String c_code) throws Exception 

	{
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_MEDIA + MediaManager.getInstance().getUploadFolder(c_code, "P" );

		
		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, 20 * 1024 * 1024, new DefaultFileRenamePolicyITNC21());
	
		String ccode	 = "";
		int ocode	 = 0;
		String title = "";
		String text1 = "";
		String text2 = "";
		String text3 = "";
		String text4 = "";
		String text5 = "";
		String text6 = "";
		String filename = "";
		String mview_flag = "Y";
		String pflag = "P";
		String path = "";
		int plevel = 0;
		
		if(multi.getParameter("ccode") !=null && multi.getParameter("ccode").length()>0) 
			ccode = (multi.getParameter("ccode"));
		if(multi.getParameter("ocode") !=null && multi.getParameter("ocode").length()>0) {
			ocode = Integer.parseInt(multi.getParameter("ocode"));
		} else {
			String qry = "select max(ocode) from photo";
			Vector v = querymanager.selectEntity(qry);
			if(v != null && v.size() > 0) {
				ocode = Integer.parseInt(String.valueOf(v.elementAt(0)));
			}
			ocode++;
		}
		String PassWord = "";
		

		if(multi.getParameter("title") !=null && multi.getParameter("title").length()>0) {
			title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("title")) );
 		}
		if(multi.getParameter("text1") !=null && multi.getParameter("text1").length()>0) {
			text1 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text1")) );
 		}
		if(multi.getParameter("text2") !=null && multi.getParameter("text2").length()>0) {
			text2 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text2")) );
 		}
		if(multi.getParameter("text3") !=null && multi.getParameter("text3").length()>0) {
			text3 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text3")) );
 		}
		if(multi.getParameter("text4") !=null && multi.getParameter("text4").length()>0) {
			text4 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text4")));
 		}
		if(multi.getParameter("text5") !=null && multi.getParameter("text5").length()>0) {
			text5 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text5")));
 		}
		if(multi.getParameter("text6") !=null && multi.getParameter("text6").length()>0) {
			text6 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text6"))) ;
	 	}

		if(multi.getParameter("plevel") !=null && multi.getParameter("plevel").length()>0) 
			plevel = Integer.parseInt(multi.getParameter("plevel"));

		if(multi.getParameter("mview_flag") !=null && multi.getParameter("mview_flag").length() > 0  ) 
			mview_flag = multi.getParameter("mview_flag");
		if(multi.getParameter("pflag") !=null && multi.getParameter("pflag").length() > 0 ) 
			pflag = multi.getParameter("pflag");
		if(pflag != null && pflag.length()>0){
			if(pflag.equals("P")){
				//pflag가 M인 그룹의 비밀번호를 얻어와서 저장한다.
				PassWord = this.getPass(String.valueOf(ocode),"M");
				//text4 = PassWord;
			}
		}
		try {
			filename = multi.getFilesystemName("oimagefile1");

				//Image thumb1 = JimiUtils.getThumbnail(UPLOAD_PATH+"/"+list_image_file,150,150,Jimi.IN_MEMORY);  // 원본이미지
				//Jimi.putImage(thumb1,UPLOAD_PATH_IMG+"/"+list_image_file);	                // 썸네일 이미지
			ImageUtil.createThumbnail(UPLOAD_PATH+"/"+filename, UPLOAD_PATH+"/small/"+filename, 100, 100);
			ImageUtil.createThumbnail(UPLOAD_PATH+"/"+filename, UPLOAD_PATH+"/middle/"+filename, 450, 450);
			path = "/mediaROOT" + MediaManager.getInstance().getUploadFolder(c_code, "P" );

		} catch(Exception e) {
			filename = "";
		}

		String query = "insert into photo (ccode, ocode, title, text1, text2, text3, text4, text5, text6, filename, mview_flag, pflag, path, plevel, owdate) values('"+ccode+"', "+ocode+", '"+title+"', '"+text1+"','"+text2+"','"+text3+"','"+text4+"', '"+text5+"','"+text6+"' ,'"+filename+"', '"+mview_flag+"', '"+pflag+"','"+path+"',"+plevel+",now())";

		int iReturn = querymanager.updateEntities(query);
		
		String qry2 = "select seq from photo where ocode="+ocode + " and pflag='M'";
		Vector v2 = querymanager.selectEntity(qry2);
		int iSeq = 0;
		if(v2 != null && v2.size() > 0) {
			iSeq = Integer.parseInt(String.valueOf(v2.elementAt(0)));
		}
		return iSeq;
		//return querymanager.updateEntities(query);
	}

	
	/*****************************************************
	사진수정.(update, 파일 등록)<p>
	<b>작성자</b>       : 김주현<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param req HttpServletRequest정보
	@see QueryManager#updateEntities
	******************************************************/
	public int update(HttpServletRequest req, String c_code, String seq) throws Exception 
	{
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_MEDIA + MediaManager.getInstance().getUploadFolder(c_code, "P" );
		
		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, 20 * 1024 * 1024, new DefaultFileRenamePolicyITNC21());
	
		String ccode	 = "";
		int ocode	 = 0;
		String title = "";
		String text1 = "";
		String text2 = "";
		String text3 = "";
		String text4 = "";
		String text5 = "";
		String text6 = "";
		String filename = "";
		String mview_flag = "";
		String pflag = "";
		String path = "";
		int plevel = 0;
		

		String qry = "select * from photo where seq="+seq;
		String old_file="";
		String old_path="";
		Vector v = querymanager.selectEntity(qry);
		if(v != null && v.size() > 0) {
			old_file = String.valueOf(v.elementAt(10));
			old_path = String.valueOf(v.elementAt(14));
			ocode = Integer.parseInt(String.valueOf(v.elementAt(2)));
		}

		if(multi.getParameter("ccode") !=null && multi.getParameter("ccode").length()>0) 
			ccode = (multi.getParameter("ccode"));

		if(multi.getParameter("title") !=null && multi.getParameter("title").length()>0) {
			title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("title")) );
 		}
		if(multi.getParameter("text1") !=null && multi.getParameter("text1").length()>0) {
			text1 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text1")) );
 		}
		if(multi.getParameter("text2") !=null && multi.getParameter("text2").length()>0) {
			text2 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text2")) );
 		}
		if(multi.getParameter("text3") !=null && multi.getParameter("text3").length()>0) {
			text3 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text3")) );
 		}
		if(multi.getParameter("text4") !=null && multi.getParameter("text4").length()>0) {
			text4 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text4")));
 		}
		if(multi.getParameter("text5") !=null && multi.getParameter("text5").length()>0) {
			text5 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text5")));
 		}
		if(multi.getParameter("text6") !=null && multi.getParameter("text6").length()>0) {
			text6 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("text6"))) ;
	 	}

		if(multi.getParameter("mview_flag") !=null && multi.getParameter("mview_flag").length() > 0) 
			mview_flag = multi.getParameter("mview_flag");
		if(multi.getParameter("pflag") !=null && multi.getParameter("pflag").length() > 0) 
			pflag = multi.getParameter("pflag");

		if(multi.getParameter("plevel") !=null && multi.getParameter("plevel").length()>0) 
			plevel = Integer.parseInt(multi.getParameter("plevel"));

		try {
			filename = multi.getFilesystemName("oimagefile1");

				//Image thumb1 = JimiUtils.getThumbnail(UPLOAD_PATH+"/"+list_image_file,150,150,Jimi.IN_MEMORY);  // 원본이미지
				//Jimi.putImage(thumb1,UPLOAD_PATH_IMG+"/"+list_image_file);	                // 썸네일 이미지
			ImageUtil.createThumbnail(UPLOAD_PATH+"/"+filename, UPLOAD_PATH+"/small/"+filename, 100, 100);
			ImageUtil.createThumbnail(UPLOAD_PATH+"/"+filename, UPLOAD_PATH+"/middle/"+filename, 450, 450);
			path = "/mediaROOT" + MediaManager.getInstance().getUploadFolder(c_code, "P" );

		} catch(Exception e) {
			filename = "";
		}


		String query = 
			"update photo set "+
			" title ='"+title+"'";
			if (!ccode.equals(""))
			{
				query=query+", ccode= '"+ccode+"'";
			}

			if (!text1.equals(""))
			{
				query=query+", text1= password('"+text1+"')";
			}
			if (!text2.equals(""))
			{
				query=query+", text2='" +text2+"'";
			}
			if (!text3.equals(""))
			{
				query=query+", text3='" +text3+"'";
			}
			if (!text4.equals(""))
			{
				query=query+", text4 ='"+text4+"'";
			}
			if (!text5.equals(""))
			{
				query=query+", text5 ='"+text5+"'";
			}
			if (!text6.equals(""))
			{
				query=query+", text6 ='"+text6+"'";
			}
			if (!filename.equals(""))
			{
				query=query+", filename ='"+filename+"'"+
				", path ='"+path+"'";
			}

			if (plevel>= 0 )
			{
				query=query+", plevel ="+plevel;
			}

			if (!mview_flag.equals(""))
			{
				query=query+", mview_flag ='"+mview_flag+"'";
			}
			
			query=query+" where seq ="+seq;
		

		if(querymanager.updateEntities(query) == 1){
			try {
				String sub_update_query = "update photo set ccode='"+ccode+"' where ocode="+ocode+" and pflag = 'P'";
				querymanager.updateEntities(sub_update_query);
			}catch(Exception e) {}
			
			if (!filename.equals("") && !old_file.equals(""))// 기존 이미지 삭제
			{
				String file_dir1=DirectoryNameManager.VODROOT +old_path+"/"+old_file;
				String file_dir1_middle=DirectoryNameManager.VODROOT +old_path+"/middle/"+old_file;
				String file_dir1_small=DirectoryNameManager.VODROOT +old_path+"/small/"+old_file;
			
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
			return 1;
		} else {
			return -1;
		}
		
	}
	public String getPass(String seq) throws Exception{
		String qry = "select text4 from photo where seq="+seq;
		String pass="";
		
		Vector v = querymanager.selectEntity(qry);
		if(v != null && v.size() > 0) {
			pass = String.valueOf(v.elementAt(0));
		}
		return pass;
	}
	
	public String getPass(String ocode, String pflag) throws Exception{
		if (ocode != null && ocode.length() > 0 && pflag != null && pflag.length() >0 ) {
			String qry = "select text4 from photo where ocode="+ocode + " and pflag='"+pflag+"'";
			String pass="";
			
			Vector v = querymanager.selectEntity(qry);
			if(v != null && v.size() > 0) {
				pass = String.valueOf(v.elementAt(0));
			}
			return pass;
		} else {
			return "";
		}
	}
	
	public int getSeq(String ocode, String pflag) throws Exception{
		if (ocode != null && ocode.length() > 0 && pflag != null && pflag.length() >0 ) {
			String qry = "select seq from photo where ocode="+ocode + " and pflag='"+pflag+"'";
			String pass="0";
			int iNum = 0;
			
			Vector v = querymanager.selectEntity(qry);
			if(v != null && v.size() > 0) {
				pass = String.valueOf(v.elementAt(0));
				iNum = Integer.parseInt(pass);
			}
			return iNum;
		} else {
			return -1;
		}
	}
	
	
	/*****************************************************
	사진삭제.(update, 파일 삭제)<p>
	<b>작성자</b>       : 김주현<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param req HttpServletRequest정보
	@see QueryManager#updateEntities
	******************************************************/

public int deletePhoto(String seq) throws Exception 
	{

		String qry = "select filename,path from photo where seq="+seq;
		String old_file="";
		String old_path="";
		Vector v = querymanager.selectEntity(qry);
		if(v != null && v.size() > 0) {
			old_file = String.valueOf(v.elementAt(0));
			old_path = String.valueOf(v.elementAt(1));
//	System.out.println("old_path:"+old_path);

		}
//	System.out.println("old_file:"+old_file);

		String query = "delete from photo where seq = " + seq;

		if(querymanager.updateEntities(query) == 1){
				if (!old_file.equals(""))// 기존 이미지 삭제
			{
					String file_dir1=DirectoryNameManager.VODROOT +old_path+"/"+old_file;
					String file_dir1_middle=DirectoryNameManager.VODROOT +old_path+"/middle/"+old_file;
					String file_dir1_small=DirectoryNameManager.VODROOT +old_path+"/small/"+old_file;
//	System.out.println(file_dir1_small);
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

	}

    public void updatePhotoHit(String seq) {
    	if(seq != null && seq.length() > 0 ){
	        String query = " UPDATE photo SET mhit = mhit + 1 WHERE seq = " + seq + " ";
	        querymanager.updateEntities(query);
    	}
    }
    
    public int updatePhotoImg(String seq)  {
    	if(seq != null && seq.length() > 0 ){
	        String query = " UPDATE photo SET filename = '', path='' WHERE seq = '" + seq + "' ";
	        if(querymanager.updateEntities(query) == 1) {
	        	return 1;
	        } else {
	        	return -1;
	        }
    	} else {
    		return -99;
    	}
    	
    }
}