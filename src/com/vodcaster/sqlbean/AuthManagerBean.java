package com.vodcaster.sqlbean;

import javax.servlet.http.HttpServletRequest;
import java.util.Vector;

public class AuthManagerBean {
	private static AuthManagerBean instance;

	private MenuAuthSql sqlbean = null;

	private AuthManagerBean() {
        sqlbean = new MenuAuthSql();
        //sqlbean.printLog("MenuAuthSql 인스턴스 생성");
    }

	public static AuthManagerBean getInstance() {
		if(instance == null) {
			synchronized(AuthManagerBean.class) {
				if(instance == null) {
					instance = new AuthManagerBean();
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
		return sqlbean.selectQuery("select * from menu_auth");
	}


/*****************************************************
	폼으로 입력된 정보로 권한테이블의 내용 수정.<p>
	<b>작성자</b>       : 최희성<br>
	@return 정상적으로 수정되면 1, 에러일 경우 -1<br>
	@param HttpServletRequest
******************************************************/
	public int editAuthInfo(HttpServletRequest req) throws Exception{

		MenuAuthInfo bean = new MenuAuthInfo();
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
    	if (field != null && field.length()> 0) {
    		try {
 
	        Vector v = sqlbean.selectQueryExt("select " +field+ " from menu_auth");
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
