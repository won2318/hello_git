package com.vodcaster.sqlbean;

import javax.servlet.http.HttpServletRequest;
import java.util.Vector;

public class AuthManagerBean {
	private static AuthManagerBean instance;

	private MenuAuthSql sqlbean = null;

	private AuthManagerBean() {
        sqlbean = new MenuAuthSql();
        //sqlbean.printLog("MenuAuthSql �ν��Ͻ� ����");
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
	�������� �Ѱ���.<p>
	<b>�ۼ���</b>       : ����<br>
	@return �������̺��� �������� ����<br>
	@see
******************************************************/
	public Vector getAuthInfo() {
		return sqlbean.selectQuery("select * from menu_auth");
	}


/*****************************************************
	������ �Էµ� ������ �������̺��� ���� ����.<p>
	<b>�ۼ���</b>       : ����<br>
	@return ���������� �����Ǹ� 1, ������ ��� -1<br>
	@param HttpServletRequest
******************************************************/
	public int editAuthInfo(HttpServletRequest req) throws Exception{

		MenuAuthInfo bean = new MenuAuthInfo();
        com.yundara.util.WebUtils.fill(bean, req);

		return sqlbean.updateAhthInfo(bean); 
	}


/*****************************************************
	Ư�� �������� ���� ���������� ����.<p>
	<b>�ۼ���</b>       : ����<br>
	@return Ư�� �ʵ��� �������� Integer��<br>
	@param �ʵ��
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
