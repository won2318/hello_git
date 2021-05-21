package com.vodcaster.sqlbean;

import javax.servlet.http.HttpServletRequest;
import java.util.Vector;

/**
 * @author Choi Hee-Sung
 *
 * 금주의 영상 관련 정보 클래스
 * 금주의 영상 등록, 수정, 삭제관련
 * Date: 2005. 1. 31.
 * Time: 오후 9:29:10
 */

public class BestWeekManager {

	private static BestWeekManager instance;

	private BestWeekSqlBean sqlbean = null;

	private BestWeekManager() {
        sqlbean = new BestWeekSqlBean();
        //sqlbean.printLog("BestWeekManager 인스턴스 생성");
    }

	public static BestWeekManager getInstance() {
		if(instance == null) {
			synchronized(BestWeekManager.class) {
				if(instance == null) {
					instance = new BestWeekManager();
				}
			}
		}
		return instance;
	}



/*****************************************************
	금주의 영상 정보 입력.<p>
	<b>작성자</b> : 최희성<br>
	@return 성공:row수, 실패:-1, 컨넥션에러:-99<br>
	@param HttpServletRequest
******************************************************/
    public int insertBestWeek(HttpServletRequest req) throws Exception {

		BestWeekInfoBean bean = new BestWeekInfoBean();
        com.yundara.util.WebUtils.fill(bean, req);
		return sqlbean.insertBestWeek(bean);
    }


/*****************************************************
	금주의 영상 정보 리턴.<p>
	<b>작성자</b> : 최희성<br>
	@return 성공:금주의 영상정보 리턴, 실패:null<br>
	@param
******************************************************/
    public Vector getBestWeekInfo(String flag) {
    	flag = com.vodcaster.utils.TextUtil.getValue(flag);
    	if (flag != null && flag.length()>0) {
	        String query = "select * from weekbest a , vod_media b where a.ocode=b.ocode and a.isview='Y' and a.flag='" + flag + "'";
	        
	        return sqlbean.selectBestWeek(query);
    	} else {
    		return null;
    	}
    }

    /*****************************************************
	홍보 영상 정보 입력.<p>
	<b>작성자</b> : 주현<br>
	@return 성공:row수, 실패:-1, 컨넥션에러:-99<br>
	@param HttpServletRequest
******************************************************/
    public int insertPR_vod(HttpServletRequest req) throws Exception {

		BestWeekInfoBean bean = new BestWeekInfoBean();
        com.yundara.util.WebUtils.fill(bean, req);
		return sqlbean.insertPR_vod(bean);
    }


/*****************************************************
	홍보 영상 정보 리턴.<p>
	<b>작성자</b> : 주현<br>
	@return 성공:홍보 영상정보 리턴, 실패:null<br>
	@param
******************************************************/
    public Vector getPR_Info() {
        String query = "select * from prvod where isview='Y'";
        return sqlbean.selectBestWeek(query);
    }
}
