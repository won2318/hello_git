package com.vodcaster.sqlbean;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
import com.yundara.util.CharacterSet;

import dbcp.SQLBeanExt;

public class YoutubeeManager extends SQLBeanExt{
	private static YoutubeeManager instance;

	private YoutubeeSqlBean sqlbean = null;
	
	private YoutubeeManager(){
		sqlbean = new YoutubeeSqlBean();
	}
	
	
	public static YoutubeeManager getInstance(){
		if(instance == null){
			synchronized (YoutubeeManager.class) {
				if(instance == null){
					instance = new YoutubeeManager();
				}
				
			}
		}
		return instance;
	}
	
	
	
	public Vector getYoutubeeLink() {
	    return sqlbean.selectYoutubeeLink();
	}
	

	
/*	public int update_youtube(HttpServletRequest req, int iSize) throws Exception{
	String UPLOAD_PATH = DirectoryNameManager.UPLOAD_YOUTUBEE;
	String UPLOAD_PATH_IMG = DirectoryNameManager.UPLOAD_YOUTUBEE_IMG;
	String upload_PATH_MIDDLE = DirectoryNameManager.UPLOAD_YOUTUBEE_IMG_MIDDLE;
	
	if(iSize <=0){
		iSize = 20 * 1024 * 1024;
	}
	
	MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, iSize, new DefaultFileRenamePolicyITNC21());
		
	String title = "";
	String link = "";
	String img = "";
	
	
		
		
		
			String title = "";
		String link = "";
		String img = "";
		
		title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("title")));
		link = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("link")));
		img = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("img")));
		
		title = req.getParameter("title");
		
		return sqlbean.update_youtubee(title, link, img);
		
	}
*/
	

	
	
}
