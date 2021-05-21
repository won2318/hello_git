package com.vodcaster.sqlbean;

import dbcp.SQLBeanExt;
import com.yundara.util.CharacterSet;

import java.util.Vector;

/**
 * @author Choi Hee-Sung
 *
 * ������ ���� ���� DB��Ʈ�� Ŭ����
 * ������ ���� ���, ����, ��������
 * Date: 2005. 1. 31.
 * Time: ���� 9:29:55
 */
public class BestWeekSqlBean extends SQLBeanExt {

    public BestWeekSqlBean() {
		super();
	}


/*****************************************************
	������ �������� �Է�.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:row��. ����:-1, Ŀ�ؼǿ���:-99<br>
	@param BestWeekInfoBean ����
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
	������ �������� ���.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:row��. ����:-1, Ŀ�ؼǿ���:-99<br>
	@param BestWeekInfoBean ����
******************************************************/
    public Vector selectBestWeek(String query) {
        return querymanager.selectHashEntity(query);
    }

    /*****************************************************
    	ȫ�� �������� �Է�.<p>
    	<b>�ۼ���</b> : ����<br>
    	@return ����:row��. ����:-1, Ŀ�ؼǿ���:-99<br>
    	@param BestWeekInfoBean ����
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
