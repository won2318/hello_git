/*
 * Created on 2005. 1. 4
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.sqlbean;

/**
 * @author Choi Hee-Sung
 * 홈페이지 스킨관련 관리 클래스
 */


import com.vodcaster.utils.TextUtil;
import com.vodcaster.utils.WebutilsExt;
import com.yundara.util.CharacterSet;
import com.yundara.util.TimeUtil;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.sqlbean.DirectoryNameManager;
import javax.servlet.http.HttpServletRequest;

import javazoom.upload.MultipartFormDataRequest;

import java.awt.Image;
import java.util.*;


public class PopupManager {
	private String skin_name = "";
    private static PopupManager instance;
    private PopupSqlBean sqlbean = null;

	/*****************************************************
	생성자  (생성될때 DB에서 스킨명을 읽어서 멤버변수인  <b>skin_name</b>에 넣는다. <p>
	<b>작성자</b>       : 최희성<br>
	<b>해당 파일</b>    : <br>
	@return
	@see this.getSkinName()
	******************************************************/		
	public PopupManager() {
        sqlbean = new PopupSqlBean();
	}

 

	public static PopupManager getInstance() {
		if(instance == null) {
			synchronized(PopupManager.class) {
				if(instance == null) {
					instance = new PopupManager();
				}
			}
		}
		return instance;
	}

	/**
	 * <b>작성자</b> : 유만호<br>
	 * 팝업 정보 저장
	 * date : 2007-12-13
	 */
	public int insertPOP(HttpServletRequest req) throws Exception {
		
		String UPLOAD_POPUP = DirectoryNameManager.UPLOAD_POPUP;

		MultipartRequest multi = new MultipartRequest(req, UPLOAD_POPUP, 20 * 1024 * 1024, new DefaultFileRenamePolicyITNC21());
		
		String title = "";
		String content = "";
		String width = "";
		String height = "";
		String is_visible = "";
		String pop_level = "";
		String pop_link = "";
		String img_name = "";
		String img_name_mobile = "";
		String pos_x = "";
		String pos_y = "";
		String rstime = "";
		String retime = "";
		String pop_flag = "";
		
		if(multi.getParameter("title") !=null   && multi.getParameter("title").length() > 0 ) 
			title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("title")));
		if(multi.getParameter("content") !=null  && multi.getParameter("content").length() > 0) 
			content = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("content")));
		if(multi.getParameter("width") !=null  && multi.getParameter("width").length() > 0 && com.yundara.util.TextUtil.isNumeric(multi.getParameter("width"))) 
			width = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("width"));
		if(multi.getParameter("height") !=null  && multi.getParameter("height").length() > 0 &&  com.yundara.util.TextUtil.isNumeric(multi.getParameter("height"))) 
			height = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("height"));
		if(multi.getParameter("is_visible") !=null  && multi.getParameter("is_visible").length() > 0  && multi.getParameter("is_visible").length()==1) 
			is_visible = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("is_visible"));
		if(multi.getParameter("pop_level") !=null  && multi.getParameter("pop_level").length() > 0 && com.yundara.util.TextUtil.isNumeric(multi.getParameter("pop_level"))) 
			pop_level = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("pop_level"));
		if(multi.getParameter("pop_link") !=null  && multi.getParameter("pop_link").length() > 0) 
			pop_link = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("pop_link")));
		if(multi.getParameter("pos_x") !=null  && multi.getParameter("pos_x").length() > 0 && com.yundara.util.TextUtil.isNumeric(multi.getParameter("pos_x"))) 
			pos_x = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("pos_x"));
		if(multi.getParameter("pos_y") !=null  && multi.getParameter("pos_y").length() > 0 && com.yundara.util.TextUtil.isNumeric(multi.getParameter("pos_y"))) 
			pos_y =com.vodcaster.utils.TextUtil.getValue(multi.getParameter("pos_y"));
		
		if(multi.getParameter("pop_flag") !=null  && multi.getParameter("pop_flag").length() > 0 && multi.getParameter("pop_flag").length()==1) 
			pop_flag = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("pop_flag"));
		
		if(multi.getParameter("rstime") !=null && !multi.getParameter("rstime").equals("") && multi.getParameter("rstime").length() <= 10) 
			rstime = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rstime"));
 
		if(multi.getParameter("retime") !=null &&  !multi.getParameter("retime").equals("") && multi.getParameter("retime").length() <= 10) 
			retime = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("retime"));
		
		try {
			if (multi.getFilesystemName("img_name") != null && multi.getFilesystemName("img_name").length() > 0) {
			img_name = multi.getFilesystemName("img_name");
			}
		} catch(Exception e) {
			img_name = "";
		}
		
		try {
			if (multi.getFilesystemName("img_name_mobile") != null && multi.getFilesystemName("img_name_mobile").length() > 0) {
				img_name_mobile = multi.getFilesystemName("img_name_mobile");
			}
		} catch(Exception e) {
			img_name_mobile = "";
		}
		
		 
		String query ="insert into popupman(title,content, width, height, is_visible, pop_level, pop_link, img_name,img_name_mobile, pos_x, pos_y, pop_flag, rstime,  retime) values " +
			"('" + title + "'," + 
			"'" + content + "'," + 
			"'" + width + "'," + 
			"'" + height + "'," + 
			"'" + is_visible + "'," + 
			"'" + pop_level + "'," + 
			"'" + pop_link + "'," + 
			"'" + img_name + "'," +
			"'" + img_name_mobile + "'," +
			"'" + pos_x + "'," +
			"'" + pos_y + "',"+
			"'" + pop_flag + "'," +
			"'" + rstime + "'," +
			"'" + retime + "')";
		
		//System.out.println("query ::: " +query );
		return sqlbean.updatePOP(query);
    }
	
	/**
	 * <b>작성자</b> : 유만호<br>
	 * 팝업 정보 수정
	 * date : 2007-12-18
	 */
	public int updatePOP(HttpServletRequest req) throws Exception {
		
		String seq = ""; 
		String title = "";
		String content = "";
		String width = "";
		String height = "";
		String is_visible = "";
		String pop_level = "";
		String pop_link = "";
		String pos_x = "";
		String pos_y = "";
		String query = "";
		String rstime = "";
		String retime = "";
		String pop_flag = "";
		
		if(req.getParameter("seq") !=null &&  !req.getParameter("seq").equals("")) 
			seq = com.vodcaster.utils.TextUtil.getValue(req.getParameter("seq"));
		if (seq != null && !seq.equals("") && com.yundara.util.TextUtil.isNumeric(seq))
		{
			query = " update popupman set " ;
			
			if(req.getParameter("title") !=null &&  !req.getParameter("title").equals("")) {
				title = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("title")));
				query= query + " title = '" + title +"', ";
			}
			if(req.getParameter("content") !=null &&  !req.getParameter("content").equals("")) {
				content = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(req.getParameter("content")));
				query= query + " content = '" + content +"', ";
			}
			if(req.getParameter("width") !=null &&  !req.getParameter("width").equals("") && com.yundara.util.TextUtil.isNumeric(req.getParameter("width"))) {
				width = com.vodcaster.utils.TextUtil.getValue(req.getParameter("width"));
				query= query + " width = '" + width +"', ";
			}
			if(req.getParameter("height") !=null &&  !req.getParameter("height").equals("") && com.yundara.util.TextUtil.isNumeric(req.getParameter("width"))) {
				height = com.vodcaster.utils.TextUtil.getValue(req.getParameter("height"));
				query= query + " height = '" + height +"', ";
			}
			if(req.getParameter("is_visible") !=null &&  !req.getParameter("is_visible").equals("") && req.getParameter("is_visible").length()==1 ){ 
				is_visible = com.vodcaster.utils.TextUtil.getValue(req.getParameter("is_visible"));
				query= query + " is_visible = '" + is_visible +"', ";
			}
			if(req.getParameter("pop_level") !=null &&  !req.getParameter("pop_level").equals("") && com.yundara.util.TextUtil.isNumeric(req.getParameter("pop_level"))) {
				pop_level = com.vodcaster.utils.TextUtil.getValue(req.getParameter("pop_level"));
				query= query + " pop_level = '" + pop_level +"', ";
			}
			if(req.getParameter("pos_x") !=null &&  !req.getParameter("pos_x").equals("") && com.yundara.util.TextUtil.isNumeric(req.getParameter("pos_x"))) {
				pos_x = com.vodcaster.utils.TextUtil.getValue(req.getParameter("pos_x"));
				query= query + " pos_x = '" + pos_x +"', ";
			}
			if(req.getParameter("pos_y") !=null &&  !req.getParameter("pos_y").equals("") && com.yundara.util.TextUtil.isNumeric(req.getParameter("pos_y"))) {
				pos_y = com.vodcaster.utils.TextUtil.getValue(req.getParameter("pos_y"));
				query= query + " pos_y = '" + pos_y +"', ";
			}
			
			if(req.getParameter("pop_flag") !=null &&  !req.getParameter("pop_flag").equals("") && req.getParameter("pop_flag").length()==1) {
				pop_flag = com.vodcaster.utils.TextUtil.getValue(req.getParameter("pop_flag"));
				query= query + " pop_flag = '" + pop_flag +"', ";
			}
			
			if(req.getParameter("rstime") !=null &&  !req.getParameter("rstime").equals("") && req.getParameter("rstime").length()<=10) {
				rstime = com.vodcaster.utils.TextUtil.getValue(req.getParameter("rstime"));
				query= query + " rstime = '" + rstime +"', ";
			}
			
			if(req.getParameter("retime") !=null &&  !req.getParameter("retime").equals("")  && req.getParameter("retime").length()<=10) {
				retime = com.vodcaster.utils.TextUtil.getValue(req.getParameter("retime"));
				query= query + " retime = '" + retime +"', ";
			}
			
			// pop_link가 null값이든 null값이 아니든 들어와도 pop_link를 update를 해준다.
			
			if(req.getParameter("pop_link") !=null &&  !req.getParameter("pop_link").equals("")) {
				pop_link = CharacterSet.toKorean(req.getParameter("pop_link"));
			}
	
//			pop_link = com.vodcaster.utils.TextUtil.getValue(req.getParameter("pop_link"));
//			pop_link = pop_link.length()>100?"":pop_link;
			query= query + " pop_link = '" + pop_link +"' ";
				
			query= query + " where seq = " + seq ;
			return sqlbean.updatePOP(query);
	//System.out.println("pop update query ::: " + query);		
		}else{
			return -1;
		}
	
		
    }
	
public int updatePOP2(HttpServletRequest req) throws Exception {
		
		String seq = ""; 
		String title = "";
		String content = "";
		String width = "";
		String height = "";
		String is_visible = "";
		String pop_level = "";
		String pop_link = "";
		String pos_x = "";
		String pos_y = "";
		String query = "";
		String rstime = "";
		String retime = "";
		String pop_flag = "";
		
		if(req.getParameter("seq") !=null &&  !req.getParameter("seq").equals("")) 
			seq = com.vodcaster.utils.TextUtil.getValue(req.getParameter("seq"));
		if (seq != null && !seq.equals("") && com.yundara.util.TextUtil.isNumeric(seq))
		{
			query = " update popupman set " ;
			
			if(req.getParameter("title") !=null &&  !req.getParameter("title").equals("")  ) {
				title = com.vodcaster.utils.TextUtil.getValue(req.getParameter("title"));
				query= query + " title = '" + title +"', ";
			}
			if(req.getParameter("content") !=null &&  !req.getParameter("content").equals("")) {
				content = com.vodcaster.utils.TextUtil.getValue(req.getParameter("content"));
				query= query + " content = '" + content +"', ";
			}
			if(req.getParameter("width") !=null &&  !req.getParameter("width").equals("") && com.yundara.util.TextUtil.isNumeric(req.getParameter("width"))) {
				width = com.vodcaster.utils.TextUtil.getValue(req.getParameter("width"));
				query= query + " width = '" + width +"', ";
			}
			if(req.getParameter("height") !=null &&  !req.getParameter("height").equals("") && com.yundara.util.TextUtil.isNumeric(req.getParameter("width"))) {
				height = com.vodcaster.utils.TextUtil.getValue(req.getParameter("height"));
				query= query + " height = '" + height +"', ";
			}
			if(req.getParameter("is_visible") !=null &&  !req.getParameter("is_visible").equals("") && req.getParameter("is_visible").length()==1){ 
				is_visible = com.vodcaster.utils.TextUtil.getValue(req.getParameter("is_visible"));
				query= query + " is_visible = '" + is_visible +"', ";
			}
			if(req.getParameter("pop_level") !=null &&  !req.getParameter("pop_level").equals("") && com.yundara.util.TextUtil.isNumeric(req.getParameter("pop_level"))) {
				pop_level = com.vodcaster.utils.TextUtil.getValue(req.getParameter("pop_level"));
				query= query + " pop_level = '" + pop_level +"', ";
			}
			if(req.getParameter("pos_x") !=null &&  !req.getParameter("pos_x").equals("") && com.yundara.util.TextUtil.isNumeric(req.getParameter("pos_x"))) {
				pos_x = com.vodcaster.utils.TextUtil.getValue(req.getParameter("pos_x"));
				query= query + " pos_x = '" + pos_x +"', ";
			}
			if(req.getParameter("pos_y") !=null &&  !req.getParameter("pos_y").equals("") && com.yundara.util.TextUtil.isNumeric(req.getParameter("pos_y"))) {
				pos_y = com.vodcaster.utils.TextUtil.getValue(req.getParameter("pos_y"));
				query= query + " pos_y = '" + pos_y +"', ";
			}
			if(req.getParameter("pop_flag") !=null &&  !req.getParameter("pop_flag").equals("") && req.getParameter("pop_flag").length()==1) {
				pop_flag = com.vodcaster.utils.TextUtil.getValue(req.getParameter("pop_flag"));
				query= query + " pop_flag = '" + pop_flag +"', ";
			}
			if(req.getParameter("rstime") !=null &&  !req.getParameter("rstime").equals("") && req.getParameter("rstime").length()<=10) {
				rstime = com.vodcaster.utils.TextUtil.getValue(req.getParameter("rstime"));
				query= query + " rstime = '" + rstime +"', ";
			}
			if(req.getParameter("retime") !=null &&  !req.getParameter("retime").equals("")  && req.getParameter("retime").length()<=10) {
				retime = com.vodcaster.utils.TextUtil.getValue(req.getParameter("retime"));
				query= query + " retime = '" + retime +"', ";
			}
			
			// pop_link가 null값이든 null값이 아니든 들어와도 pop_link를 update를 해준다.
			pop_link = com.vodcaster.utils.TextUtil.getValue(req.getParameter("pop_link"));
			pop_link = pop_link.length()>100?"":pop_link;
			query= query + " pop_link = '" + pop_link +"' ";
				
			query= query + " where seq = " + seq ;
			return sqlbean.updatePOP(query);
	//System.out.println("pop update2 query ::: " + query);		
		}else{
			return -1;
		}
	
		
    }
	/**
	 * <b>작성자</b> : 유만호<br>
	 * 팝업 이미지 정보 수정
	 * date : 2007-12-18
	 */
	public int imageUpdatePOP(HttpServletRequest req) throws Exception {
		String UPLOAD_POPUP = DirectoryNameManager.UPLOAD_POPUP;
		MultipartRequest multi = new MultipartRequest(req, UPLOAD_POPUP, 20 * 1024 * 1024, new DefaultFileRenamePolicyITNC21());
		
		String seq = ""; 
		String img_name = "";
		String query = "";
		String gubun = "1";
		
		if(multi.getParameter("seq") !=null &&  multi.getParameter("seq").length() > 0) 
			seq = multi.getParameter("seq");
		if (seq != null && !seq.equals("") && com.yundara.util.TextUtil.isNumeric(seq))
		{
			if(multi.getParameter("gubun") != null && !gubun.equals("") && com.yundara.util.TextUtil.isNumeric(gubun)){
				gubun = multi.getParameter("gubun");
			}
			query = " update popupman set " ;
			
			try {
				img_name = multi.getFilesystemName("img_name");
			} catch(Exception e) {
				img_name = "";
			}
			if(gubun != null && gubun.equals("1")){
				query= query + " img_name = '" + img_name +"' ";
			}else{
				query= query + " img_name_mobile = '" + img_name +"' ";
			}
			query= query + " where seq = " + seq ;

			
		}
	
		return sqlbean.updatePOP(query);
    }
	
	/**
	 * <b>작성자</b> : 유만호<br>
	 * 팝업 정보 읽기
	 * date : 2007-12-13
	 */

	public Vector getPopup() {
        String query = "select * from popupman where seq = (select max(seq) from popupman) ";
        return sqlbean.selectQuery(query);
    }
	
	public Vector getVisible_flag(String s)
    {
        PopupInfoBean popupinfobean = new PopupInfoBean();
        String s1 = "";
        s1 = (new StringBuilder()).append("select * from popupman where is_visible = 'Y' and pop_flag='").append(s).append("' order by seq desc").toString();
        return sqlbean.selectQueryListExt(s1);
    }
	
	public Vector getVisible_dateflag(String s) { 
		PopupInfoBean bean = new PopupInfoBean();
		String query = "";
		 
			query = "select * from popupman where is_visible = 'Y' and pop_flag ='"+s+"'" +
					" and (rstime  <= date_format(now(),'%Y-%m-%d') and (retime is null or retime ='' or  retime >= date_format(now(),'%Y-%m-%d' ) ) ) " +
					" order by seq desc" ;
		// System.out.println(query);
        return sqlbean.selectQueryListExt(query);
    }
	
	public Vector getVisible() {//index.jsp에서 popup창띄우기 사용
		PopupInfoBean bean = new PopupInfoBean();
		String query = "";
		//for(int seq=0;seq< ;seq++){
			query = "select * from popupman where is_visible = 'Y' order by seq desc" ;
		//}
        return sqlbean.selectQueryListExt(query);
    }
	
	public Vector getVisible_date() {//index.jsp에서 popup창띄우기 사용
		PopupInfoBean bean = new PopupInfoBean();
		String query = "";
		 
			query = "select * from popupman where is_visible = 'Y' " +
					" and (rstime  <= date_format(now(),'%Y-%m-%d') and (retime is null or retime ='' or  retime >= date_format(now(),'%Y-%m-%d' ) ) ) " +
					" order by seq desc" ;
		 
        return sqlbean.selectQueryListExt(query);
    }
	
	public Vector getPop(int i) {
		if(i < 1) return null;
        String query = "select * from popupman where seq = " + i;
       // System.out.println("select popup query ::: " + query);
        return sqlbean.selectQuery(query);
    }
	public Vector getPopupFromMobile() {
		
        String query = "select seq, title, pop_link, img_name_mobile from popupman where is_visible = 'Y' and " +
        		" (rstime  <= date_format(now(),'%Y-%m-%d') and (retime is null or retime ='' or  retime >= date_format(now(),'%Y-%m-%d' ) ) )" +
        		" and img_name_mobile is not null " +
        		" order by seq desc " +
        		" limit 0,1 ";
       // System.out.println("select popup query ::: " + query);
        return sqlbean.selectQuery(query);
    }

	public Vector getAllRecord() {
        String query = "select * from popupman order by seq desc;";
       // System.out.println(query);
        return sqlbean.selectQuery(query);
    }
	
	/*****************************************************
    팝업 이미지를 입력.<p>
	<b>작성자</b> : 유만호<br>
	@date : 2007-12-18
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	 ******************************************************/
	public int createPopupImage(MultipartFormDataRequest req, String filename) throws Exception {
		
		PopupInfoBean bean = new PopupInfoBean();
		WebutilsExt.fill(bean, req);
	
	
	    //int n = bean.getNo();
	    String org_imgfile = bean.getImg_name();
	   // System.err.println("원본 화일명 ===============> " + org_imgfile);
	    String ext = TextUtil.last_substr(org_imgfile, ".");
	    String file = filename + "." + ext;
	    //System.err.println("수정된 화일명 ===============> " + file);
	
	    bean.setImg_name(file);
	    return sqlbean.insertPopImage(bean);
	}
	
	/*****************************************************
    팝업 이미지를 삭제<p>
	<b>작성자</b> : 유만호<br>
	@date : 2007-12-18
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	******************************************************/
	public int deletePopupImage(String seq, String gubun) throws Exception {
		seq = com.vodcaster.utils.TextUtil.getValue(seq);
		gubun = com.vodcaster.utils.TextUtil.getValue(gubun);
		 if(seq != null 
		    		&& seq.length()> 0
		    		&&  com.yundara.util.TextUtil.isNumeric(seq)
		    		&& gubun != null 
		    		&& gubun.length()>0
		    		&& com.yundara.util.TextUtil.isNumeric(gubun)) { 
			 return sqlbean.dropPopupImage(seq, gubun); 
		 }else{
			 return -1;
		 }
	}
	
	
	
	 /*****************************************************
    업로드된 이미지 첨부화일명 리턴.<p>
	<b>작성자</b> : 유만호<br>
	@return 이미지 첨부화일명<br>
	@param popupMan
	******************************************************/
	public String getUploadFile(String seq, String gubun) {

    String strtmp = "";

    if(seq == null || seq.equals("") ||  !com.yundara.util.TextUtil.isNumeric(seq)) {
        return null;
    } else {
    	seq = com.vodcaster.utils.TextUtil.getValue(seq);
        try {
	        // 화일명 얻어옴.
	        String query = "select img_name from popupman where seq=" +seq;
	        if(gubun.equals("2")){
	        	query = "select img_name_mobile from popupman where seq=" +seq;
	        }
	        Vector v = sqlbean.selectQuery(query);
	        if(v != null && v.size() > 0){
	        	strtmp = String.valueOf(v.elementAt(0));
	        }

        } catch (Exception e) {
            System.err.println("getUploadFile ex : "+e.getMessage());

        }

        return strtmp;
    }

}

}
