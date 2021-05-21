package com.vodcaster.sqlbean;

import java.io.File;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.tistory.antop.Thumbnail;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
import com.yundara.util.CharacterSet;

import dbcp.SQLBeanExt;

public class YoutubeeSqlBean extends SQLBeanExt implements java.io.Serializable{
	 public YoutubeeSqlBean() {
			super();
		}

	
	public Vector selectYoutubeeLink(){
		
		return querymanager.selectEntity("select * from youtube_link where 1=1");

		
	}
	
	
 
	public int update_youtubee(HttpServletRequest req, int iSize) throws Exception{
		String UPLOAD_PATH = DirectoryNameManager.UPLOAD_BORADLIST;
 		
		if(iSize <=0){
			iSize = 20 * 1024 * 1024;
		}
		
		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, iSize, new DefaultFileRenamePolicyITNC21());
		String title = "";
		String link = "";
		String img = "";
		 
		if(multi.getParameter("title") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("title")).length()>0){
			title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("title")));
		}else{
			return -1;
		}
		if(multi.getParameter("link") != null && com.vodcaster.utils.TextUtil.getValue(multi.getParameter("link")).length()>0){
			link = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("link")));
		}else{
			return -1;
		}
//		if(multi.getParameter("img") !=null ) 
//			img = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("img"));
//		
//		try {
//			img = multi.getFilesystemName("img");
//			img = createThumbnail(img);
//		} catch(Exception e) {
//			img = "";
//		}
 
		String image_del = "";
		String old_imgName = "";
		old_imgName = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("real_imgName"));
	 
		image_del = multi.getParameter("image_del"); //Y or NULL
		if(multi.getParameter("image_del") !=null && multi.getParameter("image_del").trim().equals("Y") && old_imgName != null &old_imgName.length() > 0 ) {
			
		 	File del_file_file = new File(UPLOAD_PATH+"/"+old_imgName);
			del_file_file.delete(); // 기존 파일삭제
			
		} 
		
		String org_attach_name = "";
		try {
			//org_attach_name = CharacterSet.toKorean(multi.getOriginalFileName("img"));
			org_attach_name = multi.getFilesystemName("img");
		} catch(Exception e) {
		 
			 org_attach_name = "";
		}
		
	 
		
		String query = "update youtube_link set " ;
				query = query + "title='" + title  +"'," ;
				 
				if (image_del != null && image_del.trim().equals("Y")) {
					query = query +  "img =''," ;
				} else if (org_attach_name != null && org_attach_name.length() > 0) {
					 
					query = query +  "img ='" + org_attach_name  + "'," ;
				}
				
				
				query = query + "link='" +link + "' ";
		
//		System.out.println("update_youtubee::: = "+query);
		return querymanager.updateEntities(query);
	}
	
	
	/*public int update_youtubee(String title, String link, String img) throws Exception{
		String query = "update youtube_link set " +
						"title='" + title  +"'," +
						"img ='" + link  + "'," +
						"link='" +img + "',";
		System.out.println("update_youtubee="+query);
		return querymanager.updateEntities(query);
	}*/ 
	
	
}
