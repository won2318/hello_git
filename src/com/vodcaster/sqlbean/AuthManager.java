package com.vodcaster.sqlbean;

import javax.servlet.http.HttpServletRequest;
import java.util.Vector;

/**
 * @author Choi Hee-Sung
 *
 * ������ ������ ȸ�������� �������� ó��
 * VOD,AOD,�ǽð�����,������,�Խ��Ǻ� ���,����,�÷��̾� ȭ�� ������������ ��ȯ
 * Date: 2005. 2. 21.
 * Time: ���� 3:25:2
 */
public class AuthManager {

	private static AuthManager instance;

	private AuthSqlBean sqlbean = null;

	private AuthManager() {
        sqlbean = new AuthSqlBean();
        //sqlbean.printLog("AuthManager �ν��Ͻ� ����");
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
	�������� �Ѱ���.<p>
	<b>�ۼ���</b>       : ����<br>
	@return �������̺��� �������� ����<br>
	@see
******************************************************/
	public Vector getAuthInfo() {
		return sqlbean.selectQuery("select * from auth_admin");
	}


/*****************************************************
	������ �Էµ� ������ �������̺��� ���� ����.<p>
	<b>�ۼ���</b>       : ����<br>
	@return ���������� �����Ǹ� 1, ������ ��� -1<br>
	@param HttpServletRequest
******************************************************/
	public int editAuthInfo(HttpServletRequest req) throws Exception{

		AuthInfoBean bean = new AuthInfoBean();
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
