/*
 * Created on 2009. 7. 16.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.sqlbean;


import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
import com.vodcaster.multpart.MultipartRequest;
import com.yundara.util.*;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.*;

import dbcp.SQLBeanExt;

public class UccSQLBean extends SQLBeanExt implements java.io.Serializable{
	/*****************************************************
	�Խ��� �Խù� ������<p>
	<b>�ۼ���</b>       : ������<br>
	******************************************************/
	public UccSQLBean() {
		super();
	}
	
	/*****************************************************
	�Խ��Ǳ��� ����մϴ�.(insert��, ���� ���)<p>
	<b>�ۼ���</b>       : ������<br>
	@return �������� ������ �����̸� row��, ������ ���� -1<br>
	@param req HttpServletRequest����
	@see QueryManager#updateEntities
	******************************************************/
	public int write(HttpServletRequest multi, int iSize) throws Exception 
	{
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_BORADLIST;
		String UPLOAD_PATH_IMG = DirectoryNameManager.UPLOAD_BORADLIST_IMG;
		String UPLOAD_PATH_IMG_MIDDLE	= DirectoryNameManager.UPLOAD_BORADLIST_IMG_MIDDLE;
		if(iSize <=0){
			iSize = 20 * 1024 * 1024;
		}
		try {
			
		
			int board_id	 = 0;
			String list_name = "";
			String list_title = "";
			String list_contents = "";
			String list_email = "";
			String list_data_file = "";
			String list_image_file2 = "";
			String list_link = "";
			String list_passwd = "";
			String list_html_use ="f";
			String list_open = "N";
			
			String image_text = "";
			HttpSession session = multi.getSession(false);
			if(  session.getAttribute("vod_name") == null || ((String) session.getAttribute("vod_name")).length() <=0){
				return -1;
			}
			list_name = (String) session.getAttribute("vod_name") +"("+ (String) session.getAttribute("vod_id")+")";
			list_name = com.vodcaster.utils.TextUtil.getValue(list_name);
			if(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("board_id")).equals("")){
				return -1;
			}
			try{
				if(multi.getParameter("board_id") !=null && com.yundara.util.TextUtil.isNumeric(multi.getParameter("board_id")))  
					board_id = Integer.parseInt(multi.getParameter("board_id"));
			}catch(Exception ex){
				return -1;
			}
			if(multi.getParameter("list_title") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_title")).length()>0){
				list_title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_title")));
			}
			if(multi.getParameter("list_open") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_open")).length()>0){
				list_open = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_open")));
			}
			if(multi.getParameter("list_contents") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_contents")).length()>0){
				list_contents = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_contents")));
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
			
			if(multi.getParameter("image_text") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text")).length()>0){
				image_text = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("image_text")));
			}
			String list_image_file_ = "";
			if(multi.getParameter("list_image_file_") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_file_")).length()>0){
				list_image_file_ = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("list_image_file_"));
			}
			
			list_data_file = CharacterSet.toKorean(multi.getParameter("list_data_file_vod"));
			list_image_file2 = CharacterSet.toKorean(multi.getParameter("list_data_file_vod_mobile"));
			
	
			int list_id = 1;
					
			Vector v = null;
			try{
				v = querymanager.selectEntity("select max(list_id) from board_list");
			}catch(ArrayIndexOutOfBoundsException e){
				System.err.println("boardListSqlBean write1 ex : "+e);
				return -1;
			}
			if(v != null && v.size() > 0){
				try{
					if(Integer.parseInt(String.valueOf(v.elementAt(0))) != 0)
						list_id = Integer.parseInt(String.valueOf(v.elementAt(0))) + 1;
					else list_id = 1;
				}catch(Exception e){
					System.err.println("boardListSqlBean write2 ex : "+e);
					 list_id = 1;
				}
			}else{
				list_id = 1;
			}
	
			
			String query = "insert into board_list "+
			"(list_id, board_id, list_name, list_title, list_contents, list_email, list_image_file, list_data_file, list_image_file2,"+
			" list_link, list_passwd, list_date, list_ref, list_html_use," +
			" image_text,ip) values("
			+list_id+", "+board_id+", '"+list_name+"', '"+list_title+"', '"+list_contents+"', '"+list_email+"', '"+list_image_file_+"', '"+list_data_file
			+"', '"+list_image_file2+"','"+list_link+"' ,password('"+list_passwd+"'), now(), "+list_id+", '"
			+list_html_use+"', '"+image_text+"', '"+multi.getRemoteAddr()+"')";
	
			//System.out.println(query);
			return querymanager.updateEntities(query);
		} catch(Exception e) {
			return -99;
		}
	} 
	
	
	public int write_ccode(HttpServletRequest req ) throws Exception 
	{
 
		 SimpleDateFormat sdf;
		 
		try {
		    sdf = new SimpleDateFormat("yyyyMMddhhmmss");

			String ocode   = sdf.toString();   //    �������ڵ�              
			ocode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("ocode")));
		    
			String ownerid   ="";  // �����
			//ownerid = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("ownerid")));
			String title = ""; //  ����             
			if(req.getParameter("title") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("title")).length()>0){
				title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("title")));
			}
			String playtime   =""; // ����ð�          
			if(req.getParameter("playtime") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("playtime")).length()>0){
				playtime = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("playtime")));
				playtime = playtime.replaceAll("_",":");
			}
			String description   =""; //  ����        
			if(req.getParameter("description") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("description")).length()>0){
				description = CharacterSet.toKorean(req.getParameter("description"));
				description = description
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("��","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
				//description = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("description")));
			}
			String filename       =""; //  ������ ���ϸ�           
			if(req.getParameter("filename") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("filename")).length()>0){
				filename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("filename")));
			}
			int isencoded    =0 ; //  ���ڵ� ����             
			int isended     =0 ; //  ���ڵ� ���� ����        
			String modelimage      =""; //  ��ǥ�̹��� 
			if(req.getParameter("modelimage") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("modelimage")).length()>0){
				modelimage = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("modelimage")));
			}
			int hitcount       =0 ; //  ��û ī��Ʈ             
			int recomcount     =0 ; // ��õ ī��Ʈ             
			int replycount     =0 ; // ��� ī��Ʈ             
			String encodedfilename ="0"; //   ���ڵ� ���� ����
			if(req.getParameter("encodedfilename") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("encodedfilename")).length()>0){
				encodedfilename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("encodedfilename")));
			}
			String subfolder        ="0"; //  ���� ���               
			if(req.getParameter("subfolder") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("subfolder")).length()>0){
				subfolder = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("subfolder")));
			}
			String profilename      ="FFmpeg"; //  ���ڵ� �������ϸ�       
			String ccode            =""; //   ī�װ� �ڵ�           
			if(req.getParameter("ccode") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("ccode")).length()>0){
				ccode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("ccode")));
			}
			int olevel            =0; // ences  ��û ����               
			String del_flag          ="N"; //  ���� ����               
			String openflag          ="N"; // ���� ����               
			String noencode          ="N"; //  ���ڵ� ����             
			String tag_info         =""; //  �ױ�����                
			String linkcopy_flag    ="Y"; // ��ũ �۰��� ���� ����   
			String download_flag    ="N"; //  �ٿ�ε� ��� ����      
			String gcode            ="0"; //  general code (0.1.2.3.4)
			String tag_title        =""; //  �ױ� ����               
			String openflag_mobile  ="N"; //  ����� ���� ����        
			String mobilefilename   =""; //   ����� ���ϸ�
			if(req.getParameter("mobilefilename") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("mobilefilename")).length()>0){
				mobilefilename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("mobilefilename")));
			}
			String mk_date  =""; // �Կ���
			if(req.getParameter("mk_date") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("mk_date")).length()>0){
				mk_date = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("mk_date")));
			}
			String event_seq  =""; // �̺�Ʈ ��ȣ
			if(req.getParameter("event_seq") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("event_seq")).length()>0){
				event_seq = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("event_seq")));
			}
			String user_key  =""; // �Ǹ�Ű
			if(req.getParameter("user_key") != null && req.getParameter("user_key").length()>0){
				user_key = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("user_key")));
			}
			String user_tel  =""; // ����ó
			if(req.getParameter("user_tel") != null && req.getParameter("user_tel").length()>0){
				user_tel = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("user_tel")));
			// ����ó ��ȣȭ
				user_tel = com.security.SEEDUtil.getEncrypt(user_tel);
			}
			String user_email  =""; // �̸���
			if(req.getParameter("user_email") != null && req.getParameter("user_email").length()>0){
				user_email = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("user_email")));
			// �̸��� ��ȣȭ
				user_email = com.security.SEEDUtil.getEncrypt(user_email);
			}
			int event_gread  =0; // �̺�Ʈ ����
			HttpSession session = req.getSession(false);
			if(  session.getAttribute("vod_name") == null || ((String) session.getAttribute("vod_name")).length() <=0){
				return -1;
			}
			ownerid = com.vodcaster.utils.TextUtil.getValue((String) session.getAttribute("vod_name"));
			user_key = com.vodcaster.utils.TextUtil.getValue((String) session.getAttribute("user_key"));
 

			int rtn = 0;
			if (event_seq != null && event_seq.length() > 0) { // event_user ���
				try {
				String sub_query = " insert into event_user ( event_seq, ocode, user_key, user_tel, user_email, etc) values (" +
						" '"+event_seq+"','"+ocode+"','"+user_key+"','"+user_tel+"','"+user_email+"','') ";
//System.out.println(sub_query);				
				 querymanager.updateEntities(sub_query);
				} catch(Exception e) {
					System.out.println("write_ccode sub_query:"+e);
					return -99;
				}
			} else {
				event_seq = "null";
			}
			
			String query = "insert into vod_media "+
			"(ocode, title, playtime, description, filename, modelimage, encodedfilename, subfolder, profilename,ccode, mobilefilename,mk_date, isencoded,isended , olevel, ownerid,openflag,openflag_mobile, download_flag, event_seq) values(" +
			"'"+ocode+"', '"+title+"', '"+playtime+"', '"+description+"', '"+filename+"', '"+modelimage+"', '"+encodedfilename+"', '"+subfolder	+"'," +
			"'"+profilename+"','"+ccode+"' ,'"+mobilefilename+"', '"+mk_date+"','1','1','"+olevel+"','"+ownerid+"','"+openflag+"','"+openflag_mobile+"','"+download_flag+"',"+event_seq+")";
		
			rtn = querymanager.updateEntities(query);
//System.out.println(query);			
			
			////////////////
			// ����� �̹��� //
			////////////////
 
			String[] vod_images = req.getParameterValues("vod_images");
 

			 if (vod_images != null && vod_images.length > 0){  // ����� ��Ͻ�
	 				this.insertVodImages(ocode,  vod_images);  // ����� �̹��� ��� �Է�
			}
			 
			return rtn;
		} catch(Exception e) {
			System.out.println("write_ccode:"+e);
			return -99;
		}
	} 
	
	public int write_admin(HttpServletRequest req , int iSize) throws Exception 
	{
		
		if(iSize <=0){
			iSize = 20 * 1024 * 1024;
		} else {
			iSize = iSize *1024*1024;
		}
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_VOD ;

		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, iSize , new DefaultFileRenamePolicyITNC21());
 
		 SimpleDateFormat sdf;
		 
		try {
		    sdf = new SimpleDateFormat("yyyyMMddhhmmss");

			String ocode   = sdf.toString();   //    �������ڵ�              
			ocode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ocode")));
			if(  ocode == null || ocode.length() <=0){
				return -1;
			}
			String ownerid   ="";  // �����
			//ownerid = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ownerid")));
			
			String title = ""; //  ����             
			if(multi.getParameter("title") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("title")).length()>0){
				title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("title")));
			}
	 
			String playtime   =""; // ����ð�          
			if(multi.getParameter("playtime") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("playtime")).length()>0){
				playtime = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("playtime")));
				playtime = playtime.replaceAll("_",":");
			}
			String description   =""; //  ����        
			if(multi.getParameter("description") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("description")).length()>0){
				description = CharacterSet.toKorean(multi.getParameter("description"));
				description = description
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("��","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
			}
			String content_simple = "";
			if(multi.getParameter("content_simple") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("content_simple")).length()>0){
				content_simple = CharacterSet.toKorean(multi.getParameter("content_simple"));
				content_simple = content_simple
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("��","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
			}
			
			String filename       =""; //  ������ ���ϸ�           
			if(multi.getParameter("filename") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("filename")).length()>0){
				filename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("filename")));
			}
			int isencoded    =0 ; //  ���ڵ� ����             
			int isended     =0 ; //  ���ڵ� ���� ����        
			String modelimage      =""; //  ��ǥ�̹��� 
			if(multi.getParameter("modelimage") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("modelimage")).length()>0){
				modelimage = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("modelimage")));
			}
			int hitcount       =0 ; //  ��û ī��Ʈ             
			int recomcount     =0 ; // ��õ ī��Ʈ             
			int replycount     =0 ; // ��� ī��Ʈ             
			String encodedfilename =""; //   ���ڵ� ���� ����
			if(multi.getParameter("encodedfilename") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("encodedfilename")).length()>0){
				encodedfilename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("encodedfilename")));
			}
			String subfolder        =""; //  ���� ���               
			if(multi.getParameter("subfolder") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("subfolder")).length()>0){
				subfolder = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("subfolder")));
			}
			String profilename      ="FFmpeg"; //  ���ڵ� �������ϸ�       
			String ccode            =""; //   ī�װ� �ڵ�           
			if(multi.getParameter("ccode") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ccode")).length()>0){
				ccode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ccode")));
			}
			
			int olevel            =0; // ences  ��û ����               
			String del_flag          ="N"; //  ���� ����               
			String openflag          ="N"; // ���� ����               
			if(multi.getParameter("openflag") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag")).length()>0){
				openflag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag")));
			}
			String noencode          ="N"; //  ���ڵ� ����             
			String tag_info         =""; //  �ױ�����                
			String linkcopy_flag    ="Y"; // ��ũ �۰��� ���� ����
			if(multi.getParameter("linkcopy_flag") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("linkcopy_flag")).length()>0){
				linkcopy_flag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("linkcopy_flag")));
			}
			String download_flag    ="N"; //  �ٿ�ε� ��� ����
			if(multi.getParameter("download_flag") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("download_flag")).length()>0){
				download_flag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("download_flag")));
			}
			String gcode            ="0"; //  general code (0.1.2.3.4)
			String tag_title        =""; //  �ױ� ����               
			String openflag_mobile  ="N"; //  ����� ���� ����     
			if(multi.getParameter("openflag_mobile") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag_mobile")).length()>0){
				openflag_mobile = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag_mobile")));
			}
			String mobilefilename   =""; //   ����� ���ϸ�
			if(multi.getParameter("mobilefilename") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mobilefilename")).length()>0){
				mobilefilename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mobilefilename")));
			}
			String mk_date  =""; // �Կ���
			if(multi.getParameter("mk_date") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mk_date")).length()>0){
				mk_date = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mk_date")));
			}
			
			String open_date  =""; // ���� ���� ����
			if(multi.getParameter("open_date") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("open_date")).length()>0){
				open_date = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("open_date")));
			}
			
			String close_date  =""; // ���� ���� ����
			if(multi.getParameter("close_date") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("close_date")).length()>0){
				close_date = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("close_date")));
			}
			 
			String[] xcodes = multi.getParameterValues("xcode");
			String xcode ="";
			for (int i = 0 ; xcodes != null && i < xcodes.length ; i++ ) {
				xcode += xcodes[i]+"/";				
			}
			 
			String ycode ="";
			if(multi.getParameter("ycode") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ycode")).length()>0){
				ycode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ycode")));
			}
			
			String encoding_plan   ="";   
			if(multi.getParameter("encoding_plan") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("encoding_plan")).length()>0){
				encoding_plan = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("encoding_plan")));
 
			} 
			 
			HttpSession session = req.getSession(false);
			if(  session.getAttribute("vod_name") == null || ((String) session.getAttribute("vod_name")).length() <=0){
				return -1;
			}
			ownerid = com.vodcaster.utils.TextUtil.getValue((String) session.getAttribute("vod_name"));
			
			String attach_file   =""; //   ÷�� ���ϸ�
			String org_attach_file = "";
			try {
				org_attach_file = CharacterSet.toKorean(multi.getOriginalFileName("attach_file"));
				attach_file = multi.getFilesystemName("attach_file");
				String ext = com.vodcaster.utils.TextUtil.getExtension(attach_file);
				if(!ext.equals("")){
					if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"ATTACH")){
						File del_file_file = new File(UPLOAD_PATH+"/"+attach_file);
						del_file_file.delete(); // ���� ���ϻ���
					}
				}else{
					attach_file="";
					org_attach_file = "";
				}
			} catch(Exception e) {
				attach_file="";
				org_attach_file = "";
			} 
			
			String thumbnail_file   =""; //    ����� �̹������� 
			try {
				thumbnail_file = multi.getFilesystemName("thumbnail_file");
				String ext = com.vodcaster.utils.TextUtil.getExtension(thumbnail_file);
				if(!ext.equals("")){
					if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"IMG")){
						File del_file_file = new File(UPLOAD_PATH+"/"+thumbnail_file);
						del_file_file.delete(); // ���� ���ϻ���
					} 
				}else{
					thumbnail_file=""; 
				}
			} catch(Exception e) {
				thumbnail_file=""; 
			}
			 
			//������ ���� �˻� ���
			String[] gender_types = multi.getParameterValues("gender_type");
			String gender_type ="";
			for (int i = 0 ; gender_types != null && i < gender_types.length ; i++ ) {
				gender_type += gender_types[i]+"/";				
			}
			
			String[] age_types = multi.getParameterValues("age_type");
			String age_type ="";
			for (int i = 0 ; age_types != null && i < age_types.length ; i++ ) {
				age_type += age_types[i]+"/";				
			}
			
			String[] section_types = multi.getParameterValues("section_type");
			String section_type ="";
			for (int i = 0 ; section_types != null && i < section_types.length ; i++ ) {
				section_type += section_types[i]+"/";				
			}
			
			String tag_kwd = "";
			tag_kwd = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("tag_kwd")));
			
			
			int rtn = 0;
			
			String query = "insert into vod_media "+
			"(ocode, title, playtime, description, filename, modelimage, encodedfilename, subfolder, " +
			"profilename,ccode, mobilefilename,mk_date, isencoded,isended , olevel, ownerid,openflag,openflag_mobile, " +
			"download_flag, linkcopy_flag,attach_file, content_simple,org_attach_file, xcode, ycode,encoding_plan, thumbnail_file, open_date, close_date"
			
			+ ",gender_type,age_type,section_type,tag_kwd) values(" +
			"'"+ocode+"', '"+title+"', '"+playtime+"', '"+description+"', '"+filename+"', '"+modelimage+"', '"+encodedfilename+"', '"+subfolder	+"'," +
			"'"+profilename+"','"+ccode+"' ,'"+mobilefilename+"', '"+mk_date+"','0','0','"+olevel+"','"+ownerid+"','"+openflag+"','"+openflag_mobile+"'," +
			"'"+download_flag+"', '"+linkcopy_flag+"','"+attach_file+"','"+content_simple+"','"+org_attach_file+"','"+xcode+"','"+ycode+"','"+encoding_plan+"', '"+thumbnail_file+"','"+open_date+"','"+close_date+"'"
			+",'"+gender_type+"','"+age_types+"','"+section_types+"','"+tag_kwd+"' )";
					
		
//			System.out.println(query);
			rtn = querymanager.updateEntities(query);
 
			////////////////
			// ���ñ��
			////////////////
 			
			String[] news_title = multi.getParameterValues("news_title");
			String[] news_link = multi.getParameterValues("news_link");
			String[] news_date = multi.getParameterValues("news_date");
//	 System.out.println("news_title::"+news_title.length);
//	 System.out.println("news_link::"+news_link);
//	 System.out.println("news_date::"+news_date);
			if (news_title != null && news_title.length > 0){  // ���� ��Ͻ�
				com.hrlee.sqlbean.MediaNewsSqlBean news_sqlbean = null;
				news_sqlbean = new com.hrlee.sqlbean.MediaNewsSqlBean();
				news_sqlbean.delete_ocode(ocode);
				news_sqlbean.insert_array(ocode,  news_title, news_link, news_date);  
			} else {
				com.hrlee.sqlbean.MediaNewsSqlBean news_sqlbean = null;
				news_sqlbean = new com.hrlee.sqlbean.MediaNewsSqlBean();
				news_sqlbean.delete_ocode(ocode);
			}
			
			////////////////
			// ����� �̹��� //
			////////////////

//			String[] vod_images = multi.getParameterValues("vod_images");
// 	 
//			 if (vod_images != null && vod_images.length > 0){  // ����� ��Ͻ�
//	 				this.insertVodImages(ocode,  vod_images);  // ����� �̹��� ��� �Է�
//			}
			 
			return rtn;
		} catch(Exception e) {
			System.out.println("write_admin:"+e);
			return -99;
		}
	} 
	
	
	public int write_admin_new(HttpServletRequest req , int iSize) throws Exception 
	{
		
		if(iSize <=0){
			iSize = 20 * 1024 * 1024;
		} else {
			iSize = iSize *1024*1024;
		}
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_VOD ;

		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, iSize , new DefaultFileRenamePolicyITNC21());
 
		 SimpleDateFormat sdf;
		 
		try {
		    sdf = new SimpleDateFormat("yyyyMMddhhmmss");

			String ocode   = sdf.toString();   //    �������ڵ�              
			ocode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ocode")));
			if(  ocode == null || ocode.length() <=0){
				return -1;
			}
			String ownerid   ="";  // �����
			//ownerid = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ownerid")));
			
			String title = ""; //  ����             
			if(multi.getParameter("title") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("title")).length()>0){
				title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("title")));
			}
	 
			String playtime   =""; // ����ð�          
			if(multi.getParameter("playtime") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("playtime")).length()>0){
				playtime = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("playtime")));
				playtime = playtime.replaceAll("_",":");
			}
			String description   =""; //  ����        
			if(multi.getParameter("description") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("description")).length()>0){
				description = CharacterSet.toKorean(multi.getParameter("description"));
				description = description
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("��","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
			}
			String content_simple = "";
			if(multi.getParameter("content_simple") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("content_simple")).length()>0){
				content_simple = CharacterSet.toKorean(multi.getParameter("content_simple"));
				content_simple = content_simple
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("��","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
			}
			
			String filename       =""; //  ������ ���ϸ�           
			if(multi.getParameter("filename") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("filename")).length()>0){
				filename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("filename")));
			}
			int isencoded    =0 ; //  ���ڵ� ����             
			int isended     =0 ; //  ���ڵ� ���� ����        
			String modelimage      =""; //  ��ǥ�̹��� 
			if(multi.getParameter("modelimage") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("modelimage")).length()>0){
				modelimage = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("modelimage")));
			}
			int hitcount       =0 ; //  ��û ī��Ʈ             
			int recomcount     =0 ; // ��õ ī��Ʈ             
			int replycount     =0 ; // ��� ī��Ʈ             
			String encodedfilename =""; //   ���ڵ� ���� ����
			if(multi.getParameter("encodedfilename") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("encodedfilename")).length()>0){
				encodedfilename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("encodedfilename")));
			}
			String subfolder        =""; //  ���� ���               
			if(multi.getParameter("subfolder") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("subfolder")).length()>0){
				subfolder = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("subfolder")));
			}
			String profilename      ="FFmpeg"; //  ���ڵ� �������ϸ�       
			String ccode            =""; //   ī�װ� �ڵ�           
			if(multi.getParameter("ccode") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ccode")).length()>0){
				ccode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ccode")));
			}
			
			int olevel            =0; // ences  ��û ����               
			String del_flag          ="N"; //  ���� ����               
			String openflag          ="N"; // ���� ����               
			if(multi.getParameter("openflag") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag")).length()>0){
				openflag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag")));
			}
			String noencode          ="N"; //  ���ڵ� ����             
			String tag_info         =""; //  �ױ�����                
			String linkcopy_flag    ="Y"; // ��ũ �۰��� ���� ����
			if(multi.getParameter("linkcopy_flag") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("linkcopy_flag")).length()>0){
				linkcopy_flag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("linkcopy_flag")));
			}
			String download_flag    ="N"; //  �ٿ�ε� ��� ����
			if(multi.getParameter("download_flag") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("download_flag")).length()>0){
				download_flag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("download_flag")));
			}
			String gcode            ="0"; //  general code (0.1.2.3.4)
			String tag_title        =""; //  �ױ� ����               
			String openflag_mobile  ="N"; //  ����� ���� ����     
			if(multi.getParameter("openflag_mobile") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag_mobile")).length()>0){
				openflag_mobile = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag_mobile")));
			}
			String mobilefilename   =""; //   ����� ���ϸ�
			if(multi.getParameter("mobilefilename") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mobilefilename")).length()>0){
				mobilefilename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mobilefilename")));
			}
			String mk_date  =""; // �Կ���
			if(multi.getParameter("mk_date") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mk_date")).length()>0){
				mk_date = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mk_date")));
			}
			String close_date  =""; // ���� ���� ����
			if(multi.getParameter("close_date") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("close_date")).length()>0){
				close_date = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("close_date")));
			}
			 
			String[] xcodes = multi.getParameterValues("xcode");
			String xcode ="";
			for (int i = 0 ; xcodes != null && i < xcodes.length ; i++ ) {
				xcode += xcodes[i]+"/";				
			}
			
			
			 
			String ycode ="";
			if(multi.getParameter("ycode") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ycode")).length()>0){
				ycode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ycode")));
			}
			
			String encoding_plan   ="";   
			if(multi.getParameter("encoding_plan") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("encoding_plan")).length()>0){
				encoding_plan = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("encoding_plan")));
 
			} 
			 
			HttpSession session = req.getSession(false);
			if(  session.getAttribute("vod_name") == null || ((String) session.getAttribute("vod_name")).length() <=0){
				return -1;
			}
			ownerid = com.vodcaster.utils.TextUtil.getValue((String) session.getAttribute("vod_name"));
			
			String attach_file   =""; //   ÷�� ���ϸ�
			String org_attach_file = "";
			try {
				org_attach_file = CharacterSet.toKorean(multi.getOriginalFileName("attach_file"));
				attach_file = multi.getFilesystemName("attach_file");
				String ext = com.vodcaster.utils.TextUtil.getExtension(attach_file);
				if(!ext.equals("")){
					if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"ATTACH")){
						File del_file_file = new File(UPLOAD_PATH+"/"+attach_file);
						del_file_file.delete(); // ���� ���ϻ���
					}
				}else{
					attach_file="";
					org_attach_file = "";
				}
			} catch(Exception e) {
				attach_file="";
				org_attach_file = "";
			} 
			
			String thumbnail_file   =""; //    ����� �̹������� 
			try {
				thumbnail_file = multi.getFilesystemName("thumbnail_file");
				String ext = com.vodcaster.utils.TextUtil.getExtension(thumbnail_file);
				if(!ext.equals("")){
					if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"IMG")){
						File del_file_file = new File(UPLOAD_PATH+"/"+thumbnail_file);
						del_file_file.delete(); // ���� ���ϻ���
					} 
				}else{
					thumbnail_file=""; 
				}
			} catch(Exception e) {
				thumbnail_file=""; 
			}
			
			//������ ���� �˻� ���
			String[] gender_types = multi.getParameterValues("gender_type");
			String gender_type ="";
			for (int i = 0 ; gender_types != null && i < gender_types.length ; i++ ) {
				gender_type += gender_types[i]+"/";				
			}
			
			String[] age_types = multi.getParameterValues("age_type");
			String age_type ="";
			for (int i = 0 ; age_types != null && i < age_types.length ; i++ ) {
				age_type += age_types[i]+"/";				
			}
			
			String[] section_types = multi.getParameterValues("section_type");
			String section_type ="";
			for (int i = 0 ; section_types != null && i < section_types.length ; i++ ) {
				section_type += section_types[i]+"/";				
			}
			
			String tag_kwd = "";
			tag_kwd = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("tag_kwd")));
			
			int rtn = 0;
			
			String query = "insert into vod_media "+
			"(ocode, title, playtime, description, filename, modelimage, encodedfilename, subfolder, " +
			"profilename,ccode, mobilefilename,mk_date, isencoded,isended , olevel, ownerid,openflag,openflag_mobile, " +
			"download_flag, linkcopy_flag,attach_file, content_simple,org_attach_file, xcode, ycode,encoding_plan, thumbnail_file,close_date"
			+ ",gender_type,age_type,section_type,tag_kwd) values(" +
			"'"+ocode+"', '"+title+"', '"+playtime+"', '"+description+"', '"+filename+"', '"+modelimage+"', '"+encodedfilename+"', '"+subfolder	+"'," +
			"'"+profilename+"','"+ccode+"' ,'"+mobilefilename+"', '"+mk_date+"','0','0','"+olevel+"','"+ownerid+"','"+openflag+"','"+openflag_mobile+"'," +
			"'"+download_flag+"', '"+linkcopy_flag+"','"+attach_file+"','"+content_simple+"','"+org_attach_file+"','"+xcode+"','"+ycode+"','"+encoding_plan+"', '"+thumbnail_file+"','"+close_date+"' "
			+",'"+gender_type+"','"+age_types+"','"+section_types+"','"+tag_kwd+"' )"
			;
		
//			System.out.println(query);
			rtn = querymanager.updateEntities(query);
			
			
			////////////////
			// ����� �̹��� //
			////////////////

//			String[] vod_images = multi.getParameterValues("vod_images");
// 	 
//			 if (vod_images != null && vod_images.length > 0){  // ����� ��Ͻ�
//	 				this.insertVodImages(ocode,  vod_images);  // ����� �̹��� ��� �Է�
//			}
			 
			return rtn;
		} catch(Exception e) {
			System.out.println("write_admin_new:"+e);
			return -99;
		}
	} 
	
	public int update_ccode(HttpServletRequest req  ) throws Exception 
	{
		 
 
		 SimpleDateFormat sdf;
		 
		try {
		    sdf = new SimpleDateFormat("yyyyMMddhhmmss");

			String ocode   = sdf.toString();   //    �������ڵ�              
			ocode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("ocode")));
			if(  ocode == null || ocode.length() <=0){
				return -1;
			}
			String ownerid   ="";  // �����
			//ownerid = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("ownerid")));
			String title = ""; //  ����             
			if(req.getParameter("title") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("title")).length()>0){
				title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("title")));
			}
			String playtime   =""; // ����ð�          
			if(req.getParameter("playtime") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("playtime")).length()>0){
				playtime = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("playtime")));
				playtime = playtime.replaceAll("_",":");
			}
			String description   =""; //  ����        
			if(req.getParameter("description") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("description")).length()>0){
				description = CharacterSet.toKorean(req.getParameter("description"));
				description = description
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("��","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
			}
			String content_simple   =""; //  ����        
			if(req.getParameter("content_simple") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("content_simple")).length()>0){
				content_simple = CharacterSet.toKorean(req.getParameter("content_simple"));
				content_simple = content_simple
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("��","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
			}
			
			String filename       =""; //  ������ ���ϸ�           
			if(req.getParameter("filename") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("filename")).length()>0){
				filename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("filename")));
			}
			int isencoded    =0 ; //  ���ڵ� ����             
			int isended     =0 ; //  ���ڵ� ���� ����        
			String modelimage      =""; //  ��ǥ�̹��� 
			if(req.getParameter("modelimage") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("modelimage")).length()>0){
				modelimage = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("modelimage")));
			}
			int hitcount       =0 ; //  ��û ī��Ʈ             
			int recomcount     =0 ; // ��õ ī��Ʈ             
			int replycount     =0 ; // ��� ī��Ʈ             
			String encodedfilename ="0"; //   ���ڵ� ���� ����
			if(req.getParameter("encodedfilename") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("encodedfilename")).length()>0){
				encodedfilename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("encodedfilename")));
			}
			String subfolder        ="0"; //  ���� ���               
			if(req.getParameter("subfolder") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("subfolder")).length()>0){
				subfolder = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("subfolder")));
			}
			String profilename      ="FFmpeg"; //  ���ڵ� �������ϸ�       
			String ccode            =""; //   ī�װ� �ڵ�           
			if(req.getParameter("ccode") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("ccode")).length()>0){
				ccode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("ccode")));
			}
			int olevel            =0; // ences  ��û ����               
			String del_flag          ="N"; //  ���� ����               
			String openflag          ="N"; // ���� ����               
			String noencode          ="N"; //  ���ڵ� ����             
			String tag_info         =""; //  �ױ�����                
			String linkcopy_flag    ="Y"; // ��ũ �۰��� ���� ����   
			String download_flag    ="N"; //  �ٿ�ε� ��� ����      
			String gcode            ="0"; //  general code (0.1.2.3.4)
			String tag_title        =""; //  �ױ� ����               
			String openflag_mobile  ="N"; //  ����� ���� ����        
			String mobilefilename   =""; //   ����� ���ϸ�
			if(req.getParameter("mobilefilename") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("mobilefilename")).length()>0){
				mobilefilename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("mobilefilename")));
				}
			String mk_date  =""; // �Կ���
			if(req.getParameter("mk_date") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("mk_date")).length()>0){
				mk_date = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("mk_date")));
			}
			String event_seq  =""; // �̺�Ʈ ��ȣ
			if(req.getParameter("event_seq") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("event_seq")).length()>0){
				event_seq = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("event_seq")));
			}
			int event_gread  =0; // �̺�Ʈ ����
 
			HttpSession session = req.getSession(false);
			if(  session.getAttribute("vod_name") == null || ((String) session.getAttribute("vod_name")).length() <=0){
				return -1;
			}
			ownerid = com.vodcaster.utils.TextUtil.getValue((String) session.getAttribute("vod_name"));
			
			 
 
			int rtn = 0;
			
			String query = "update vod_media set "+
			" title='"+title+"',  description= '"+description+"', mk_date= '"+mk_date+"' , openflag='"+openflag+"', openflag_mobile='"+openflag_mobile+"', content_simple='"+content_simple+"'  where ocode='"+ocode+"' and ownerid='"+ownerid+"' ";
			 
			//System.out.println(query);
		
			rtn = querymanager.updateEntities(query);
			
 
			return rtn;
		} catch(Exception e) {
			return -99;
		}
	} 
	
	
	public int update_admin(HttpServletRequest req , int iSize ) throws Exception 
	{
		if(iSize <=0){
			iSize = 20 * 1024 * 1024;
		} else {
			iSize = iSize *1024*1024;
		}
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_VOD ;

		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, iSize , new DefaultFileRenamePolicyITNC21());
 
 
		 SimpleDateFormat sdf;
		 
		try {
		    sdf = new SimpleDateFormat("yyyyMMddhhmmss");

			String ocode   = sdf.toString();   //    �������ڵ�              
			ocode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ocode")));
			if(  ocode == null || ocode.length() <=0){
				return -1;
			}
			String ownerid   ="";  // �����
			//ownerid = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ownerid")));
			String title = ""; //  ����             
			if(multi.getParameter("title") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("title")).length()>0){
				title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("title")));
			}
			String playtime   =""; // ����ð�          
			if(multi.getParameter("playtime") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("playtime")).length()>0){
				playtime = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("playtime")));
				playtime = playtime.replaceAll("_",":");
			}
			String description   =""; //  ����        
			if(multi.getParameter("description") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("description")).length()>0){
				description = CharacterSet.toKorean(multi.getParameter("description"));
				description = description
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("��","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
			}
			
			String content_simple   =""; //  ����        
			if(multi.getParameter("content_simple") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("content_simple")).length()>0){
				content_simple = CharacterSet.toKorean(multi.getParameter("content_simple"));
				content_simple = content_simple
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("��","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
			}
			
			String filename       =""; //  ������ ���ϸ�           
			if(multi.getParameter("filename") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("filename")).length()>0){
				filename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("filename")));
			}
			int isencoded    =0 ; //  ���ڵ� ����             
			int isended     =0 ; //  ���ڵ� ���� ����        
			String modelimage      =""; //  ��ǥ�̹��� 
			if(multi.getParameter("modelimage") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("modelimage")).length()>0){
				modelimage = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("modelimage")));
			}
			int hitcount       =0 ; //  ��û ī��Ʈ             
			int recomcount     =0 ; // ��õ ī��Ʈ             
			int replycount     =0 ; // ��� ī��Ʈ             
			String encodedfilename ="0"; //   ���ڵ� ���� ����
			if(multi.getParameter("encodedfilename") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("encodedfilename")).length()>0){
				encodedfilename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("encodedfilename")));
			}
			String subfolder        ="0"; //  ���� ���               
			if(multi.getParameter("subfolder") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("subfolder")).length()>0){
				subfolder = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("subfolder")));
			}
			String profilename      ="FFmpeg"; //  ���ڵ� �������ϸ�       
			String ccode            =""; //   ī�װ� �ڵ�           
			if(multi.getParameter("ccode") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ccode")).length()>0){
				ccode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ccode")));
			}
			
			 
			int olevel            =0; // ences  ��û ����               
			String del_flag          ="N"; //  ���� ����               
			String openflag          ="N"; // ���� ����            
			if(multi.getParameter("openflag") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag")).length()>0){
				openflag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag")));
			}
			String noencode          ="N"; //  ���ڵ� ����             
			String tag_info         =""; //  �ױ�����                
			String linkcopy_flag    ="Y"; // ��ũ �۰��� ���� ���� 
			if(multi.getParameter("linkcopy_flag") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("linkcopy_flag")).length()>0){
				linkcopy_flag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("linkcopy_flag")));
			}
			String download_flag    ="N"; //  �ٿ�ε� ��� ����      
			if(multi.getParameter("download_flag") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("download_flag")).length()>0){
				download_flag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("download_flag")));
			}
			String gcode            ="0"; //  general code (0.1.2.3.4)
			String tag_title        =""; //  �ױ� ����               
			String openflag_mobile  ="N"; //  ����� ���� ����  
			if(multi.getParameter("openflag_mobile") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag_mobile")).length()>0){
				openflag_mobile = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag_mobile")));
			}
			String mobilefilename   =""; //   ����� ���ϸ�
			if(multi.getParameter("mobilefilename") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mobilefilename")).length()>0){
				mobilefilename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mobilefilename")));
			}
			String mk_date  =""; // �Կ���
			if(multi.getParameter("mk_date") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mk_date")).length()>0){
				mk_date = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mk_date")));
			}
			
			String open_date  =""; // ���� ���� ����
			if(multi.getParameter("open_date") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("open_date")).length()>0){
				open_date = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("open_date")));
			}
			
			String close_date  =""; // ���� ���� ����
			if(multi.getParameter("close_date") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("close_date")).length()>0){
				close_date = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("close_date")));
			}

			String old_attach_file  =""; // ���� ���ϸ�
			if(multi.getParameter("old_attach_file") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("old_attach_file")).length()>0){
				old_attach_file = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("old_attach_file")));
			}
			String attach_file_del  =""; // ���� ��������
			if(multi.getParameter("attach_file_del") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("attach_file_del")).length()>0){
				attach_file_del = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("attach_file_del")));
			}
			
			String[] xcodes = multi.getParameterValues("xcode");
			String xcode ="";
			for (int i = 0 ; xcodes != null && i < xcodes.length ; i++ ) {
				xcode += xcodes[i]+"/";				
			}
			 
			String ycode ="";
			if(multi.getParameter("ycode") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ycode")).length()>0){
				ycode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ycode")));
			}
			 
			
			String attach_file   =""; //   ÷�� ���ϸ�
			String org_attach_file = "";
			try {
				org_attach_file = CharacterSet.toKorean(multi.getOriginalFileName("attach_file"));
				attach_file = multi.getFilesystemName("attach_file");
				String ext = com.vodcaster.utils.TextUtil.getExtension(attach_file);
				if(!ext.equals("")){
					if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"ATTACH")){
						File del_file_file = new File(UPLOAD_PATH+"/"+attach_file);
						del_file_file.delete(); // ���� ���ϻ���
					}
				}else{
					attach_file="";
					org_attach_file = "";
				}
			} catch(Exception e) {
				attach_file="";
				org_attach_file = "";
			}
			
			String thumbnail_file_del  =""; // ���� ��������
			if(multi.getParameter("thumbnail_file_del") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("thumbnail_file_del")).length()>0){
				thumbnail_file_del = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("thumbnail_file_del")));
			} 
			String thumbnail_file   =""; //    ����� �̹������� 
			try {
				thumbnail_file = multi.getFilesystemName("thumbnail_file");
				String ext = com.vodcaster.utils.TextUtil.getExtension(thumbnail_file);
				if(!ext.equals("")){
					if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"IMG")){
						File del_file_file = new File(UPLOAD_PATH+"/"+thumbnail_file);
						del_file_file.delete(); // ���� ���ϻ���
					} 
				}else{
					thumbnail_file=""; 
				}
			} catch(Exception e) {
				thumbnail_file=""; 
			}
  
//			if (attach_file_del != null && attach_file_del.equals("Y")) {
//				attach_file="";
//				org_attach_file = "";
//			}
			
			
			//������ ���� �˻� ���
			String[] gender_types = multi.getParameterValues("gender_type");
			String gender_type ="";
			for (int i = 0 ; gender_types != null && i < gender_types.length ; i++ ) {
				gender_type += gender_types[i]+"/";				
			}
			
			String[] age_types = multi.getParameterValues("age_type");
			String age_type ="";
			for (int i = 0 ; age_types != null && i < age_types.length ; i++ ) {
				age_type += age_types[i]+"/";				
			}
			
			String[] section_types = multi.getParameterValues("section_type");
			String section_type ="";
			for (int i = 0 ; section_types != null && i < section_types.length ; i++ ) {
				section_type += section_types[i]+"/";				
			}
			
			String tag_kwd = "";
			tag_kwd = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("tag_kwd")));
			
			
			int rtn = 0;
			
			String query = "update vod_media set "+
			 
			" title='"+title+"',  " +
			" description= '"+description+"', " +
			" ccode='"+ccode+"',  " ;
			
			query +=" olevel='"+olevel+"',  " ;
			query +=" mk_date= '"+mk_date+"' , " ;
			query +=" open_date= '"+open_date+"' , " ;
			query +=" close_date= '"+close_date+"' , " ;
			query +=" openflag='"+openflag+"', " ;
			query +=" openflag_mobile='"+openflag_mobile+"', " ;
			query +=" download_flag='"+download_flag+"',  " ;
			query +=" linkcopy_flag='"+linkcopy_flag+"',  " ;
			
			query +=" gender_type='"+gender_type+"',  " ;
			query +=" age_type='"+age_type+"',  " ;
			query +=" section_type='"+section_type+"',  " ;
			query +=" tag_kwd='"+tag_kwd+"',  " ;
			
			if (attach_file_del != null && attach_file_del.equals("Y") &&  attach_file.length() <= 0 ) {
				query +=" attach_file='', org_attach_file ='', " ;
			} else if (attach_file != null && attach_file.length() > 0) {
				query +=" attach_file='"+attach_file+"', org_attach_file ='"+org_attach_file+"', " ;
			}  
			if (thumbnail_file_del != null && thumbnail_file_del.equals("Y") &&  thumbnail_file.length() <= 0 ) {
				query +=" thumbnail_file='', " ;
			} else if (thumbnail_file != null && thumbnail_file.length() > 0) {
				query +=" thumbnail_file='"+thumbnail_file+"', " ;
			}  
			
			query += " xcode = '"+xcode+"', ";
			query += " ycode = '"+ycode+"', ";
			query += " modelimage = '"+modelimage+"', ";
			query +=" content_simple = '"+content_simple+"'";
		 
			query +=" where ocode='"+ocode+"'";
			 
 //System.out.println(query);
		
			rtn = querymanager.updateEntities(query);
		
			////////////////
			// ���ñ��
			////////////////
			
			String[] news_title = multi.getParameterValues("news_title");
			String[] news_link = multi.getParameterValues("news_link");
			String[] news_date = multi.getParameterValues("news_date");
//	 System.out.println("news_title::"+news_title.length);
//	 System.out.println("news_link::"+news_link);
//	 System.out.println("news_date::"+news_date);
			if (news_title != null && news_title.length > 0){  // ���� ��Ͻ�
				com.hrlee.sqlbean.MediaNewsSqlBean news_sqlbean = null;
				news_sqlbean = new com.hrlee.sqlbean.MediaNewsSqlBean();
				news_sqlbean.delete_ocode(ocode);
				news_sqlbean.insert_array(ocode,  news_title, news_link, news_date);  
			} else {
				com.hrlee.sqlbean.MediaNewsSqlBean news_sqlbean = null;
				news_sqlbean = new com.hrlee.sqlbean.MediaNewsSqlBean();
				news_sqlbean.delete_ocode(ocode);
			}
			
		
			if(rtn > 0){
				if( (  old_attach_file != null && old_attach_file.indexOf('.') != -1  && attach_file_del != null && attach_file_del.equals("Y") ) ||
						(  old_attach_file != null && old_attach_file.indexOf('.') != -1  &&  attach_file != null && attach_file.indexOf('.')  != -1    )){
					File deleteFile1 = new File(UPLOAD_PATH+"/"+old_attach_file);
 					deleteFile1.delete(); // ���� ���ϻ���
				}
			
			}
			return rtn;
		} catch(Exception e) {
			System.out.println(e);
			return -99;
		}
	} 
	
	
	public int update_admin_new(HttpServletRequest req , int iSize ) throws Exception 
	{

		if(iSize <=0){
			iSize = 20 * 1024 * 1024;
		} else {
			iSize = iSize *1024*1024;
		}
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_VOD ;

		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, iSize , new DefaultFileRenamePolicyITNC21());
 
 
		 SimpleDateFormat sdf;
		 
		try {
		    sdf = new SimpleDateFormat("yyyyMMddhhmmss");

			String ocode   = sdf.toString();   //    �������ڵ�              
			ocode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ocode")));
			if(  ocode == null || ocode.length() <=0){
				return -1;
			}
 
			String ownerid   ="";  // �����
			//ownerid = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ownerid")));
			String title = ""; //  ����             
			if(multi.getParameter("title") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("title")).length()>0){
				title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("title")));
			}
			String playtime   =""; // ����ð�          
			if(multi.getParameter("playtime") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("playtime")).length()>0){
				playtime = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("playtime")));
				playtime = playtime.replaceAll("_",":");
			}
			String description   =""; //  ����        
			if(multi.getParameter("description") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("description")).length()>0){
				description = CharacterSet.toKorean(multi.getParameter("description"));
				description = description
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("��","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
			}
			
			String content_simple   =""; //  ����        
			if(multi.getParameter("content_simple") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("content_simple")).length()>0){
				content_simple = CharacterSet.toKorean(multi.getParameter("content_simple"));
				content_simple = content_simple
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("��","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
			}
			
			String filename       =""; //  ������ ���ϸ�           
			if(multi.getParameter("filename") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("filename")).length()>0){
				filename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("filename")));
			}
			int isencoded    =0 ; //  ���ڵ� ����             
			int isended     =0 ; //  ���ڵ� ���� ����        
			String modelimage      =""; //  ��ǥ�̹��� 
			if(multi.getParameter("modelimage") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("modelimage")).length()>0){
				modelimage = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("modelimage")));
			}
			int hitcount       =0 ; //  ��û ī��Ʈ             
			int recomcount     =0 ; // ��õ ī��Ʈ             
			int replycount     =0 ; // ��� ī��Ʈ             
			String encodedfilename =""; //   ���ڵ� ���� ����
			if(multi.getParameter("encodedfilename") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("encodedfilename")).length()>0){
				encodedfilename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("encodedfilename")));
			}
			String subfolder        =""; //  ���� ���               
			if(multi.getParameter("subfolder") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("subfolder")).length()>0){
				subfolder = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("subfolder")));
			}
			String profilename      ="FFmpeg"; //  ���ڵ� �������ϸ�       
			String ccode            =""; //   ī�װ� �ڵ�           
			if(multi.getParameter("ccode") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ccode")).length()>0){
				ccode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ccode")));
			}
			
			int olevel            =0; // ences  ��û ����               
			String del_flag          ="N"; //  ���� ����               
			String openflag          ="N"; // ���� ����            
			if(multi.getParameter("openflag") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag")).length()>0){
				openflag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag")));
			}
			String noencode          ="N"; //  ���ڵ� ����             
			String tag_info         =""; //  �ױ�����                
			String linkcopy_flag    ="Y"; // ��ũ �۰��� ���� ���� 
			if(multi.getParameter("linkcopy_flag") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("linkcopy_flag")).length()>0){
				linkcopy_flag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("linkcopy_flag")));
			}
			String download_flag    ="N"; //  �ٿ�ε� ��� ����      
			if(multi.getParameter("download_flag") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("download_flag")).length()>0){
				download_flag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("download_flag")));
			}
			String gcode            ="0"; //  general code (0.1.2.3.4)
			String tag_title        =""; //  �ױ� ����               
			String openflag_mobile  ="N"; //  ����� ���� ����  
			if(multi.getParameter("openflag_mobile") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag_mobile")).length()>0){
				openflag_mobile = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag_mobile")));
			}
			String mobilefilename   =""; //   ����� ���ϸ�
			if(multi.getParameter("mobilefilename") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mobilefilename")).length()>0){
				mobilefilename = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mobilefilename")));
			}
			String mk_date  =""; // �Կ���
			if(multi.getParameter("mk_date") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mk_date")).length()>0){
				mk_date = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mk_date")));
			}
			
			String open_date  =""; // ���� ���� ����
			if(multi.getParameter("open_date") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("open_date")).length()>0){
				open_date = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("open_date")));
			}
			
			String close_date  =""; // ���� ����� ����
			if(multi.getParameter("close_date") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("close_date")).length()>0){
				close_date = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("close_date")));
			}

			String old_attach_file  =""; // ���� ���ϸ�
			if(multi.getParameter("old_attach_file") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("old_attach_file")).length()>0){
				old_attach_file = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("old_attach_file")));
			}
			String attach_file_del  =""; // ���� ��������
			if(multi.getParameter("attach_file_del") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("attach_file_del")).length()>0){
				attach_file_del = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("attach_file_del")));
			}
			
			String[] xcodes = multi.getParameterValues("xcode");
			String xcode ="";
			for (int i = 0 ; xcodes != null && i < xcodes.length ; i++ ) {
				xcode += xcodes[i]+"/";				
			}
			 
			String ycode ="";
			if(multi.getParameter("ycode") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ycode")).length()>0){
				ycode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ycode")));
			}
			String encoding_plan ="";
			if(multi.getParameter("encoding_plan") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("encoding_plan")).length()>0){
				encoding_plan = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("encoding_plan")));
			}
			
			String attach_file   =""; //   ÷�� ���ϸ�
			String org_attach_file = "";
			try {
				org_attach_file = CharacterSet.toKorean(multi.getOriginalFileName("attach_file"));
				attach_file = multi.getFilesystemName("attach_file");
				String ext = com.vodcaster.utils.TextUtil.getExtension(attach_file);
				if(!ext.equals("")){
					if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"ATTACH")){
						File del_file_file = new File(UPLOAD_PATH+"/"+attach_file);
						del_file_file.delete(); // ���� ���ϻ���
					}
				}else{
					attach_file="";
					org_attach_file = "";
				}
			} catch(Exception e) {
				attach_file="";
				org_attach_file = "";
			}
   
//			if (attach_file_del != null && attach_file_del.equals("Y")) {
//				attach_file="";
//				org_attach_file = "";
//			}
			
			String thumbnail_file_del  =""; // ���� ��������
			if(multi.getParameter("thumbnail_file_del") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("thumbnail_file_del")).length()>0){
				thumbnail_file_del = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("thumbnail_file_del")));
			} 
			String thumbnail_file   =""; //    ����� �̹������� 
			try {
				thumbnail_file = multi.getFilesystemName("thumbnail_file");
				String ext = com.vodcaster.utils.TextUtil.getExtension(thumbnail_file);
				if(!ext.equals("")){
					if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"IMG")){
						File del_file_file = new File(UPLOAD_PATH+"/"+thumbnail_file);
						del_file_file.delete(); // ���� ���ϻ���
					} 
				}else{
					thumbnail_file=""; 
				}
			} catch(Exception e) {
				thumbnail_file=""; 
			}
			 
			//������ ���� �˻� ���
			String[] gender_types = multi.getParameterValues("gender_type");
			String gender_type ="";
			for (int i = 0 ; gender_types != null && i < gender_types.length ; i++ ) {
				gender_type += gender_types[i]+"/";				
			}
			
			String[] age_types = multi.getParameterValues("age_type");
			String age_type ="";
			for (int i = 0 ; age_types != null && i < age_types.length ; i++ ) {
				age_type += age_types[i]+"/";				
			}
			
			String[] section_types = multi.getParameterValues("section_type");
			String section_type ="";
			for (int i = 0 ; section_types != null && i < section_types.length ; i++ ) {
				section_type += section_types[i]+"/";				
			}
			
			String tag_kwd = "";
			tag_kwd = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("tag_kwd")));
			
			
			int rtn = 0;
			
			String query = "update vod_media set "+
			" title='"+title+"',  " +
			" playtime='"+playtime+"',  " +
			" filename='"+filename+"',  " +
			" encodedfilename='"+encodedfilename+"',  " +
			" subfolder='"+subfolder+"',  " +
			" mobilefilename='"+mobilefilename+"',  " +
			" description= '"+description+"', " +
			" ccode='"+ccode+"',  " ;
			
			query +=" gender_type='"+gender_type+"',  " ;
			query +=" age_type='"+age_type+"',  " ;
			query +=" section_type='"+section_type+"',  " ;
			query +=" tag_kwd='"+tag_kwd+"',  " ;
			
			query +=" olevel='"+olevel+"',  " ;
			query +=" mk_date= '"+mk_date+"' , " ;
			query +=" open_date= '"+open_date+"' , " ;
			query +=" close_date= '"+close_date+"' , " ;
			query +=" openflag='"+openflag+"', " ;
			query +=" openflag_mobile='"+openflag_mobile+"', " ;
			query +=" download_flag='"+download_flag+"',  " ;
			query +=" linkcopy_flag='"+linkcopy_flag+"',  " ;
			if (attach_file_del != null && attach_file_del.equals("Y") &&  attach_file.length() <= 0 ) {
				query +=" attach_file='', org_attach_file ='', " ;
			} else if (attach_file != null && attach_file.length() > 0) {
				query +=" attach_file='"+attach_file+"', org_attach_file ='"+org_attach_file+"', " ;
			}  
			if (thumbnail_file_del != null && thumbnail_file_del.equals("Y") &&  thumbnail_file.length() <= 0 ) {
				query +=" thumbnail_file='', " ;
			} else if (thumbnail_file != null && thumbnail_file.length() > 0) {
				query +=" thumbnail_file='"+thumbnail_file+"', " ;
			}  
			 
			query +=" modelimage = '"+modelimage+"', ";
			query +=" xcode = '"+xcode+"', ";
			query +=" ycode = '"+ycode+"', ";
			query +=" encoding_plan = '"+encoding_plan+"', ";
			query +=" isencoded = '0', ";
			query +=" isended = '0', ";
			
			query +=" content_simple = '"+content_simple+"' ";
			query +=" where ocode='"+ocode+"'";
			 
 
			rtn = querymanager.updateEntities(query);
			

			////////////////
			// ���ñ��
			////////////////
 			
			String[] news_title = multi.getParameterValues("news_title");
			String[] news_link = multi.getParameterValues("news_link");
			String[] news_date = multi.getParameterValues("news_date");
//	 System.out.println("news_title::"+news_title.length);
//	 System.out.println("news_link::"+news_link);
//	 System.out.println("news_date::"+news_date);
			if (news_title != null && news_title.length > 0){  // ���� ��Ͻ�
				com.hrlee.sqlbean.MediaNewsSqlBean news_sqlbean = null;
				news_sqlbean = new com.hrlee.sqlbean.MediaNewsSqlBean();
				news_sqlbean.delete_ocode(ocode);
				news_sqlbean.insert_array(ocode,  news_title, news_link, news_date);  
			} else {
				com.hrlee.sqlbean.MediaNewsSqlBean news_sqlbean = null;
				news_sqlbean = new com.hrlee.sqlbean.MediaNewsSqlBean();
				news_sqlbean.delete_ocode(ocode);
			}
			
			
			
			
 		
			////////////////
			// ����� �̹��� //
			////////////////
			
//			String[] vod_images = multi.getParameterValues("vod_images");
// 	 
//			 if (vod_images != null && vod_images.length > 0){  // ����� ��Ͻ�
//				this.delete_thumbnail(ocode);
//	 			this.insertVodImages(ocode,  vod_images);  // ����� �̹��� ��� �Է�
//			}
//			 
//			 
//			 if(rtn > 0){
//					if( (  old_attach_file != null && old_attach_file.indexOf('.') != -1  && attach_file_del != null && attach_file_del.equals("Y") ) ||
//							(  old_attach_file != null && old_attach_file.indexOf('.') != -1  &&  attach_file != null && attach_file.indexOf('.')  != -1    )){
//						File deleteFile1 = new File(UPLOAD_PATH+"/"+old_attach_file);
//	 					deleteFile1.delete(); // ���� ���ϻ���
//					}
//				
//				}
			 
 
			return rtn;
		} catch(Exception e) {
			System.out.println("admin_new:"+e);
			return -99;
		}
	} 
	
	
	public int update_ccode_admin(HttpServletRequest req ) throws Exception 
	{
		 

		 SimpleDateFormat sdf;
		 
		try {
		    sdf = new SimpleDateFormat("yyyyMMddhhmmss");

			String ocode   = sdf.toString();   //    �������ڵ�              
			ocode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("ocode")));
			if(  ocode == null || ocode.length() <=0){
				return -1;
			}
			String ownerid   ="";  // �����
			//ownerid = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("ownerid")));
			
			
			String title = ""; //  ����             
			if(req.getParameter("title") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("title")).length()>0){
				title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("title")));
			}
			 
			String description   =""; //  ����        
			if(req.getParameter("description") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("description")).length()>0){
				description = CharacterSet.toKorean(req.getParameter("description"));
				description = description
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("��","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
			}
			
			String content_simple   =""; //  ����        
			if(req.getParameter("content_simple") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("content_simple")).length()>0){
				content_simple = CharacterSet.toKorean(req.getParameter("content_simple"));
				content_simple = content_simple
				//.replaceAll("&","&amp;")
				//.replaceAll("#","&#35;")
				.replaceAll("��","&#39;")
				.replaceAll("`","&#39;")			
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("��","&#39;")
				.replaceAll("'","&#39;")
				.replaceAll("\"","&quot;");
			}
			
			 
			String ccode            =""; //   ī�װ� �ڵ�           
			if(req.getParameter("ccode") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("ccode")).length()>0){
				ccode = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("ccode")));
			}

			String openflag          ="N"; // ���� ����               
			if(req.getParameter("openflag") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("openflag")).length()>0){
				openflag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("openflag")));
			}
			String linkcopy_flag    ="Y"; // ��ũ �۰��� ���� ����
			if(req.getParameter("linkcopy_flag") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("linkcopy_flag")).length()>0){
				linkcopy_flag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("linkcopy_flag")));
			}
			String download_flag    ="N"; //  �ٿ�ε� ��� ����
			if(req.getParameter("download_flag") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("download_flag")).length()>0){
				download_flag = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("download_flag")));
			}
			String openflag_mobile  ="N"; //  ����� ���� ����
			if(req.getParameter("openflag_mobile") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("openflag_mobile")).length()>0){
				openflag_mobile = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("openflag_mobile")));
			}
			String mk_date  =""; // �Կ���
			if(req.getParameter("mk_date") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("mk_date")).length()>0){
				mk_date = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("mk_date")));
			}
			String event_seq  =""; // �̺�Ʈ ��ȣ
			if(req.getParameter("event_seq") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("event_seq")).length()>0){
				event_seq = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("event_seq")));
			}
			String event_gread  =""; // �̺�Ʈ ����
			if(req.getParameter("event_gread") != null && com.vodcaster.utils.TextUtil.getValue(req.getParameter("event_gread")).length()>0){
				event_gread = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("event_gread")));
			}
 
			int rtn = 0;
			
			String query = "update vod_media set "+
			" gcode = '0' " ;
			if (title != null && title.length() > 0) {
				query += " , title='"+title+"' " ;
			}
			if (description != null && description.length() > 0) {
				query += " , description= '"+description+"' " ;
			}
			if (mk_date != null && mk_date.length() > 0) {
				query += " , mk_date= '"+mk_date+"' " ;
			}
			if (openflag != null && openflag.length() > 0) {
				query += " , openflag='"+openflag+"' " ;
				query += " , openflag_mobile='"+openflag+"' " ;
			}
		 
			if (event_gread != null && event_gread.length() > 0) {
				query += " , event_gread='"+event_gread+"' " ;
			}
			if (content_simple != null && content_simple.length() > 0) {
				query += " , content_simple= '"+content_simple+"' " ;
			}
			
			query += " where ocode='"+ocode+"' and event_seq='"+event_seq+"' ";
			 
 
			rtn = querymanager.updateEntities(query);
 
			return rtn;
		} catch(Exception e) {
			System.out.println("update_ccode_admin_error:"+e);
			return -99;
		}
	} 
	
	public void insertVodImages(String ocode,  String[] vod_images) throws Exception {
		if (ocode == null || ocode.length() <=0  || vod_images == null || vod_images.length == 0 ) return;
		
		///////////////
		//����� ����
		/////////////
		//String ocode       �������ȣ   
		//String filename ="" ; //  �̹��� ���ϸ�
		String description =""; // �̹��� ����  
		//String time  =""; // ��� ��ġ    
		//String title  =""; //  �̹��� ����  
		
		

        try {

            String query = "";
			String query1 = " INSERT INTO thumbnail (ocode,filename, description, time,title) VALUES ";
		
		    for (int i=0; i < vod_images.length ; i++) {
		    	String temp_img = vod_images[i];
		   
		        query = query1 +
		                " ('" +
		                ocode + "'," +
		                " '" + com.vodcaster.utils.TextUtil.getValue(temp_img)  + "', " +
		                " '" + com.vodcaster.utils.TextUtil.getValue(description)  + "', " +
		                " '" + com.vodcaster.utils.TextUtil.getValue(temp_img.substring(0,8).replaceAll("_", ":"))  + "', " +
		                " '" + com.vodcaster.utils.TextUtil.getValue(temp_img.substring(0,8))  + "' " +
		                " )";
//System.out.println(query);		    
		        querymanager.updateEntities(query);
		    }
	  } catch (Exception e) {
          System.err.println("insertMediaSub ex : "+e.getMessage());
      }
	}
	
	public int delete_ucc(HttpServletRequest req ) throws Exception 
	{
		try{
	
			String ocode   = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("ocode")));
			String event_seq   = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("event_seq")));
		if (ocode != null && ocode.length() > 0 && event_seq != null && event_seq.length() > 0) {
			int rtn = 0;
			
			String query = "update vod_media set "+
			" del_flag='Y'  where ocode='"+ocode+"' and event_seq='"+event_seq+"' ";
			 
			//System.out.println(query);
		
			rtn = querymanager.updateEntities(query);
			
	
			return rtn;
		} else {
			return -1;
		}
	} catch(Exception e) {
		return -99;
	}
 
	}
	
	public int delete_admin(String ocode ) throws Exception 
	{
		try{
 
	 	
	 	int rtn = 0;
		
	 	if (ocode != null && ocode.length() > 0) {
		String query = "update vod_media set  del_flag='Y'  where ocode='"+ocode+"' ";
		 
		//System.out.println(query);
	
		rtn = querymanager.updateEntities(query);
	 	} else {
	 		rtn = -1;
	 	}

		return rtn;
	} catch(Exception e) {
		return -99;
	}
 
	}
	
	
	public int open_close(String ocode ) throws Exception 
	{
		try{
 
	 	
	 	int rtn = 0;
		
	 	if (ocode != null && ocode.length() > 0) {
		String query = "update vod_media set  openflag='N'  where ocode='"+ocode+"' ";
		 
		//System.out.println(query);
	
		rtn = querymanager.updateEntities(query);
	 	} else {
	 		rtn = -1;
	 	}

		return rtn;
	} catch(Exception e) {
		return -99;
	}
 
	}
	
	
	public int delete_thumbnail(String ocode ) throws Exception 
	{
		try{
 
		int rtn = 0;
		
		String query = "delete from thumbnail where ocode='"+ocode+"' ";
		 
		//System.out.println(query);
	
		rtn = querymanager.updateEntities(query);
		

		return rtn;
	} catch(Exception e) {
		return -99;
	}
 
	}
	
	
	public int posi_xy(HttpServletRequest req  ) throws Exception 
	{
		try{ 
	 
			String ocode   = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("ocode")));
			String posi_xy   = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("posi_xy")));
			
	 	int rtn = 0;
		
	 	if (posi_xy != null && posi_xy.length() > 0 && ocode != null && ocode.length() > 0) {
		String query = "update vod_media set  posi_xy='"+posi_xy+"'  where ocode='"+ocode+"' ";
		 
		System.out.println(query);
	
		rtn = querymanager.updateEntities(query);
	 	} else {
	 		rtn = -1;
	 	}

		return rtn;
	} catch(Exception e) {
		return -99;
	}
 
	}
	
	
}