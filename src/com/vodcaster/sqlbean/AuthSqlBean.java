package com.vodcaster.sqlbean;

import dbcp.SQLBeanExt;
import java.util.Vector;

/**
 * @author Choi Hee-Sung
 *
 * �������� ���Ѽ��� Query �۾� Ŭ����
 * �������� �������� ���,����
*/
public class AuthSqlBean  extends SQLBeanExt {

    public AuthSqlBean() {
		super();
	}


/*****************************************************
	Query���� ���� DB��� ���<p>
	<b>�ۼ���</b>       : ����<br>
	@return Hash Table������ DB����� ���<br>
	@param sql Query
******************************************************/
    public Vector selectQuery(String query) {
        return querymanager.selectHashEntity(query);
    }


/*****************************************************
	Query���� ���� Ư�� ���ڵ� DB��� ���<p>
	<b>�ۼ���</b>       : ����<br>
	@return Hash Table������ DB����� 1 row ���<br>
	@param sql Query
******************************************************/
    public Vector selectQueryExt(String query) {
        return querymanager.selectEntity(query);
    }


/*****************************************************
	���� ���� ����<p>
	<b>�ۼ���</b>       : ����<br>
	@return ����:1    ����:-1<br>
	@param AuthInfoBean
******************************************************/
	public int updateAhthInfo(AuthInfoBean bean) throws Exception{

        String query = "update auth_admin set " +
	    		"r_list='"      + bean.getR_list()      + "'," +
                "r_content='"   + bean.getR_content()   + "'," +
                "r_player='"    + bean.getR_player()    + "'," +

                "v_list='"      + bean.getV_list()      + "'," +
                "v_content='"   + bean.getV_content()   + "'," +
                "v_player='"    + bean.getV_player()    + "'," +

                "b_list='"      + bean.getB_list()      + "'," +
                "b_content='"   + bean.getB_content()   + "'," +
                "b_write='"     + bean.getB_write()     + "'," +
                "b_del='"       + bean.getB_del()       + "'," +
				
				"p_list='"      + bean.getP_list()      + "'," +
                "p_content='"   + bean.getP_content()   + "'," +
                "p_write='"     + bean.getP_write()     + "'," +
                "p_del='"       + bean.getP_del()       + "'";

        return querymanager.updateEntities(query);

	}

}
