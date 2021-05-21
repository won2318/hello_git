package com.vodcaster.sqlbean;

import dbcp.SQLBeanExt;
import com.yundara.util.CharacterSet;

import java.util.Vector;

/**
 * @author Choi Hee-Sung
 *
 * 금주의 영상 관련 DB컨트롤 클래스
 * 금주의 영상 등록, 수정, 삭제관련
 * Date: 2005. 1. 31.
 * Time: 오후 9:29:55
 */
public class BestWeekSqlBean extends SQLBeanExt {

    public BestWeekSqlBean() {
		super();
	}


/*****************************************************
	금주의 영상정보 입력.<p>
	<b>작성자</b> : 최희성<br>
	@return 성공:row수. 실패:-1, 커넥션에러:-99<br>
	@param BestWeekInfoBean 빈즈
******************************************************/
	public int insertBestWeek(BestWeekInfoBean bean) throws Exception {

		Vector row = null;
        String query = "";
        int result = -1;
        try {

            Vector v = querymanager.selectEntities("select * from weekbest where flag='"+bean.getFlag()+"'");
            if(v == null || (v != null && v.size() <= 0)) {

                query = "insert into weekbest (title,ocode,isview, flag)" +
                            "values('" 		+
                            //CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getTitle()) )    + "'," +
                            com.vodcaster.utils.TextUtil.getValue(bean.getTitle() )    + "','" +
                            com.vodcaster.utils.TextUtil.getValue(bean.getOcode() )     + "','" +
                            com.vodcaster.utils.TextUtil.getValue(bean.getIsview() )    + "','" +
                            com.vodcaster.utils.TextUtil.getValue(bean.getFlag() )	+ "')";

            } else {

                query = "update weekbest set " +
                        //"title='"   + CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getTitle()) )    + "'," +
                		"title='"   + com.vodcaster.utils.TextUtil.getValue(bean.getTitle() )    + "'," +
                        "ocode='"    + com.vodcaster.utils.TextUtil.getValue(bean.getOcode() )     + "'," +
                        "isview='"  + com.vodcaster.utils.TextUtil.getValue(bean.getIsview() )    + "'" +
                        " where flag='" + com.vodcaster.utils.TextUtil.getValue(bean.getFlag())  + "'";

            }

            int iRtn = querymanager.executeQuery(query);
           
            result = iRtn;
            

        } catch(Exception e) {
        	System.err.println("insertBestWeek Ex : " + e.getMessage());
        }

        return result;
	}


/*****************************************************
	금주의 영상정보 출력.<p>
	<b>작성자</b> : 최희성<br>
	@return 성공:row수. 실패:-1, 커넥션에러:-99<br>
	@param BestWeekInfoBean 빈즈
******************************************************/
    public Vector selectBestWeek(String query) {
        return querymanager.selectHashEntity(query);
    }

    /*****************************************************
    	홍보 영상정보 입력.<p>
    	<b>작성자</b> : 주현<br>
    	@return 성공:row수. 실패:-1, 커넥션에러:-99<br>
    	@param BestWeekInfoBean 빈즈
    ******************************************************/
    	public int insertPR_vod(BestWeekInfoBean bean) throws Exception {

    		Vector row = null;
            String query = "";
            int result = 0;
            try {

                Vector v = querymanager.selectEntities("select * from prvod");
                if(v == null || (v != null && v.size() <= 0)) {

                    query = "insert into prvod (title,ocode,auto,isview)" +
                                "values('" 		+
                                com.vodcaster.utils.TextUtil.getValue(bean.getTitle() )    + "'," +
                                com.vodcaster.utils.TextUtil.getValue(bean.getOcode() )    + ",'" +
                                com.vodcaster.utils.TextUtil.getValue(bean.getAuto())		+ "','" +
                                com.vodcaster.utils.TextUtil.getValue(bean.getIsview())    + "')";

                } else {

                    query = "update prvod set " +
                            " title='"   + com.vodcaster.utils.TextUtil.getValue(bean.getTitle() )    + "'," +
                            " ocode="    + com.vodcaster.utils.TextUtil.getValue(bean.getOcode() )    + "," +
                            " auto='"    + com.vodcaster.utils.TextUtil.getValue(bean.getAuto() )      + "'," + 
                            " isview='"  + com.vodcaster.utils.TextUtil.getValue(bean.getIsview())    + "'";

                }

                result = querymanager.executeQuery(query);
                

            } catch(Exception e) {

            	System.err.println("prvod Ex : " + e.getMessage());
            }

            return result;
    	}

}
