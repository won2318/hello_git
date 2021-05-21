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
import com.yundara.util.CharacterSet;
import com.yundara.util.TimeUtil;
import com.vodcaster.sqlbean.DirectoryNameManager;

import com.hrlee.sqlbean.MediaManager;
import com.hrlee.sqlbean.MediaInfoBean;
import com.hrlee.sqlbean.OrderMediaInfoBean;
import com.hrlee.sqlbean.CategoryInfoBean;


import javax.servlet.http.HttpServletRequest;
import java.util.*;


public class SkinManager {
	private String skin_name = "";
    private static SkinManager instance;
    private SkinSqlBean sqlbean = null;

	/*****************************************************
	생성자  (생성될때 DB에서 스킨명을 읽어서 멤버변수인  <b>skin_name</b>에 넣는다. <p>
	<b>작성자</b>       : 최희성<br>
	<b>해당 파일</b>    : <br>
	@return
	@see this.getSkinName()
	******************************************************/		
	public SkinManager() {
        sqlbean = new SkinSqlBean();
        //sqlbean.printLog("SkinManager 인스턴스 생성");
//		getSkinName();
	}



	public static SkinManager getInstance() {
		if(instance == null) {
			synchronized(SkinManager.class) {
				if(instance == null) {
					instance = new SkinManager();
				}
			}
		}
		return instance;
	}


public Vector getBestContentDefault(String oflag, int line){
	if (oflag != null && oflag.length() > 0 && line >0) {
		String query="select * from best_list where isview='Y' and oflag='"+oflag+"' order by border limit 0,"+line;
		Vector v =sqlbean.selectQueryList(query);
		return v;
	} else {
		return null;
	}
}




public Vector getNowLive(){
	String play_skin = "";
	Vector v = null;
	try {

        // 현재 상영되는 예약미디어 출력
        String cur_date = TimeUtil.getDetailTime();
        cur_date = cur_date.substring(0,19);

        String query = "select a.mtitle,b.rcode,b.ralias from media as a, real_media as b where (a.mcode=b.mcode) and ((b.rstart_time <= '" +
                        cur_date+ "') and " + "(b.rend_time >= '" +cur_date+ "'))";
        //System.err.println(query);
         v = sqlbean.selectQuery(query);
 	}catch(Exception e) {
		System.err.println("getNowLive ex : "+e.getMessage());
		v = null;
	}

	return v;
}


    public int executeQuery(String query) {
        return sqlbean.executeQuery(query);
    }



	public Vector selectQuery(String query) throws Exception {
	    return sqlbean.selectQuery(query);

	}
	
	/**
	 * 팝업 정보 수정 저장
	 */
	public int updatePOP(HttpServletRequest req) throws Exception {
	    String query = "update popup set " +
                        "title='"   + req.getParameter("title").replace("'","''")    + "'," +
                        "use_html='"    + req.getParameter("use_html")  + "'," +
                        "content='" + req.getParameter("content").replace("'","''")    + "'," +
                        "width='"    + req.getParameter("width")    + "'," +
                        "height='"  + req.getParameter("height")    + "'," +
                        "is_visible='"  + req.getParameter("is_view")    + "'";

        return sqlbean.updatePOP(query);
    }

    /**
	 * 팝업 정보 읽기
	 */
    public Vector getPopup() {
        String query = "select * from popup";
        return sqlbean.selectQuery(query);
    }
}
