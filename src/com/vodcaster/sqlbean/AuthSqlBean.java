package com.vodcaster.sqlbean;

import dbcp.SQLBeanExt;
import java.util.Vector;

/**
 * @author Choi Hee-Sung
 *
 * 컨텐츠별 권한설정 Query 작업 클래스
 * 컨텐츠별 권한정보 출력,수정
*/
public class AuthSqlBean  extends SQLBeanExt {

    public AuthSqlBean() {
		super();
	}


/*****************************************************
	Query문에 대한 DB결과 출력<p>
	<b>작성자</b>       : 최희성<br>
	@return Hash Table형태의 DB결과물 출력<br>
	@param sql Query
******************************************************/
    public Vector selectQuery(String query) {
        return querymanager.selectHashEntity(query);
    }


/*****************************************************
	Query문에 대한 특정 레코드 DB결과 출력<p>
	<b>작성자</b>       : 최희성<br>
	@return Hash Table형태의 DB결과물 1 row 출력<br>
	@param sql Query
******************************************************/
    public Vector selectQueryExt(String query) {
        return querymanager.selectEntity(query);
    }


/*****************************************************
	권한 설정 변경<p>
	<b>작성자</b>       : 최희성<br>
	@return 성공:1    에러:-1<br>
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
