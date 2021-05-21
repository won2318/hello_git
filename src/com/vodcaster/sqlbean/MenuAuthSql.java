package com.vodcaster.sqlbean;

import java.util.Vector;
import dbcp.SQLBeanExt;

public class MenuAuthSql extends SQLBeanExt{
	public MenuAuthSql() {
		super();
	}


/*****************************************************
	Query���� ���� DB��� ���<p>
	<b>�ۼ���</b>       : �����<br>
	@return Hash Table������ DB����� ���<br>
	@param sql Query
******************************************************/
    public Vector selectQuery(String query) {
        return querymanager.selectHashEntity(query);
    }


/*****************************************************
	Query���� ���� Ư�� ���ڵ� DB��� ���<p>
	<b>�ۼ���</b>       : �����<br>
	@return Hash Table������ DB����� 1 row ���<br>
	@param sql Query
******************************************************/
    public Vector selectQueryExt(String query) {
        return querymanager.selectEntity(query);
    }


/*****************************************************
	���� ���� ����<p>
	<b>�ۼ���</b>       : �����<br>
	@return ����:1    ����:-1<br>
	@param AuthInfoBean
******************************************************/
	public int updateAhthInfo(MenuAuthInfo bean) throws Exception{

        String query = "update menu_auth set " +
	    		"r_list='"      + bean.getR_list()      + "'," +
                "r_content='"   + bean.getR_content()   + "'," +
                "r_player='"    + bean.getR_player()    + "'," +
                "r_write='"    + bean.getR_write()    	+ "'," +
                "r_del='"    + bean.getR_del()    		+ "'," +

                "v_list='"      + bean.getV_list()      + "'," +
                "v_content='"   + bean.getV_content()   + "'," +
                "v_player='"    + bean.getV_player()    + "'," +
                "v_write='"    + bean.getV_write()    	+ "'," +
                "v_del='"    + bean.getV_del()    		+ "'," +
                
                "m_list='"      + bean.getM_list()      + "'," +
                "m_write='"    + bean.getM_write()    	+ "'," +
                "m_del='"    + bean.getM_del()    		+ "'," +
                
                "cate_list='"      + bean.getCate_list()   + "'," +
                "cate_write='"    + bean.getCate_write()  	+ "'," +
                "cate_del='"    + bean.getCate_del()    	+ "'," +

                "b_list='"      + bean.getB_list()      + "'," +
                "b_content='"   + bean.getB_content()   + "'," +
                "b_write='"     + bean.getB_write()     + "'," +
                "b_del='"       + bean.getB_del()       + "'," +
				
				"be_list='"      + bean.getBe_list()      + "'," +
                "be_write='"   + bean.getBe_write()   + "'," +
                "be_player='"    + bean.getBe_player()    + "'," +

				"p_list='"      + bean.getP_list()      + "'," +
                "p_content='"   + bean.getP_content()   + "'," +
                "p_write='"     + bean.getP_write()     + "'," +
                "p_del='"       + bean.getP_del()       + "'," +
                
                "menu_list='"      + bean.getMenu_list()      + "'," +
                "menu_write='"    + bean.getMenu_write()    	+ "'," +
                "menu_del='"    + bean.getMenu_del()    		+ "'," +

				"s_list='"      + bean.getS_list()      + "'," +
                "s_content='"   + bean.getS_content()   + "'," +
                "s_write='"     + bean.getS_write()     + "'," +
                "s_del='"       + bean.getS_del()       + "'";
				

        return querymanager.updateEntities(query);

	}

}
