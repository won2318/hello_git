package com.vodcaster.sqlbean;

import javax.servlet.http.HttpServletRequest;
import java.util.Vector;

/**
 * @author Choi Hee-Sung
 *
 * 컨텐츠 종류별 회원레벨별 접근제한 처리
 * VOD,AOD,실시간강의,컨텐츠,게시판별 목록,내용,플레이어 화면 접근제한정보 반환
 * Date: 2005. 2. 21.
 * Time: 오후 3:25:2
 */
public class AuthManager {

	private static AuthManager instance;

	private AuthSqlBean sqlbean = null;

	private AuthManager() {
        sqlbean = new AuthSqlBean();
        //sqlbean.printLog("AuthManager 인스턴스 생성");
    }

	public static AuthManager getInstance() {
		if(instance == null) {
			synchronized(AuthManager.class) {
				if(instance == null) {
					instance = new AuthManager();
				}
			}
		}
		return instance;
	}

/*****************************************************
	권한정보 넘겨줌.<p>
	<b>작성자</b>       : 최희성<br>
	@return 권한테이블의 권한정보 리턴<br>
	@see
******************************************************/
	public Vector getAuthInfo() {
		return sqlbean.selectQuery("select * from auth_admin");
	}


/*****************************************************
	폼으로 입력된 정보로 권한테이블의 내용 수정.<p>
	<b>작성자</b>       : 최희성<br>
	@return 정상적으로 수정되면 1, 에러일 경우 -1<br>
	@param HttpServletRequest
******************************************************/
	public int editAuthInfo(HttpServletRequest req) throws Exception{

		AuthInfoBean bean = new AuthInfoBean();
        com.yundara.util.WebUtils.fill(bean, req);

		return sqlbean.updateAhthInfo(bean);
	} 


/*****************************************************
	특정 컨텐츠에 대한 권한정보를 리턴.<p>
	<b>작성자</b>       : 최희성<br>
	@return 특정 필드의 권한정보 Integer형<br>
	@param 필드명
******************************************************/
    public int getAuthLevel(String field) {
    	field = com.vodcaster.utils.TextUtil.getValue(field);
    	if (field != null && field.length()> 0) {
    		try {
	        Vector v = sqlbean.selectQueryExt("select " +field+ " from auth_admin");
	        if(v != null && v.size() > 0) {
	            return Integer.parseInt(String.valueOf(v.elementAt(0)));
	        }else
	            return 0;
    		}catch (Exception e){
    			System.out.println(e);
    			return 0;    			
    		}
    	} else {
    		return 0;
    	}
    }

}
