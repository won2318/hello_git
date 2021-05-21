/*
 * Created on 2005. 1. 4
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.sqlbean;

/**
 * @author Choi Hee-Sung
 * Ȩ������ ��Ų���� ���� Ŭ����
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
	������  (�����ɶ� DB���� ��Ų���� �о ���������  <b>skin_name</b>�� �ִ´�. <p>
	<b>�ۼ���</b>       : ����<br>
	<b>�ش� ����</b>    : <br>
	@return
	@see this.getSkinName()
	******************************************************/		
	public SkinManager() {
        sqlbean = new SkinSqlBean();
        //sqlbean.printLog("SkinManager �ν��Ͻ� ����");
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

        // ���� �󿵵Ǵ� ����̵�� ���
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
	 * �˾� ���� ���� ����
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
	 * �˾� ���� �б�
	 */
    public Vector getPopup() {
        String query = "select * from popup";
        return sqlbean.selectQuery(query);
    }
}
