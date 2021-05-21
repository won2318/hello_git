package com.vodcaster.sqlbean;

import dbcp.SQLBeanExt;
import java.util.*;
import javax.servlet.http.*;
import com.yundara.util.CharacterSet;

/**
 * @author Choi Hee-Sung
 *
 * ����Ʈ������ ���� DB QUERY �۾� Ŭ����
 * Date: 2005. 1. 26.
 * Time: ���� 3:9:24
 */
public class BestMediaSqlBean extends SQLBeanExt  {

    public BestMediaSqlBean() {
		super();
	}


/*****************************************************
	����Ʈ������ �Է��۾�.<p>
	<b>�ۼ���</b>       : ����<br>
	@return ����:row��, ����:-1, ���ؼǿ���:-99<br>
	@param BestMediaInfoBean
******************************************************/
	public int insertBest(BestMediaInfoBean bean) throws Exception {

		Vector row = null;
		int iRtn = -1;
        try {
            String query = "insert into best_list"+
                            " (title1,title2,title3,title4,ocode1,ocode2,ocode3,ocode4,isview,oflag,mtype,border)" +
                            "values('" 		+
                            //CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getTitle1()) )    + "','" +
                            //CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getTitle2()) )    + "','" +
                            //CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getTitle3()) )    + "','" +
                            //CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getTitle4()) )    + "'," +
                            com.vodcaster.utils.TextUtil.getValue(bean.getTitle1() )    + "','" +
                            com.vodcaster.utils.TextUtil.getValue(bean.getTitle2() )    + "','" +
                            com.vodcaster.utils.TextUtil.getValue(bean.getTitle3() )    + "','" +
                            com.vodcaster.utils.TextUtil.getValue(bean.getTitle4() )    + "','" +
                            com.vodcaster.utils.TextUtil.getValue(bean.getOcode1() )    + "','" +
                            com.vodcaster.utils.TextUtil.getValue(bean.getOcode2() )    + "','" +
                            com.vodcaster.utils.TextUtil.getValue(bean.getOcode3() )   + "','" +
                            com.vodcaster.utils.TextUtil.getValue(bean.getOcode4() )   + "','" +
                            com.vodcaster.utils.TextUtil.getValue(bean.getIsview() )   + "','" +
                            com.vodcaster.utils.TextUtil.getValue(bean.getOflag()  )   + "','" +
                            com.vodcaster.utils.TextUtil.getValue(bean.getMtype()  )   + "'," +
                            bean.getBorder()    + ")";

            iRtn = querymanager.executeQuery(query);

        } catch(Exception e) {
        	System.err.println("insertBest ex : " + e.getMessage());
        }

        return iRtn;
	}


/*****************************************************
	����Ʈ������ �����۾�.<p>
	<b>�ۼ���</b>       : ����<br>
	@return ����:row��, ����:-1, ���ؼǿ���:-99<br>
	@param BestMediaInfoBean
******************************************************/
	public int updateBest(BestMediaInfoBean bean) throws Exception {

		Vector row = null;
		int num_update = 0;
		int iRtn = -1;
        try {
            String query = "update best_list set "+
//                            "title1='"      + CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getTitle1()) ) + "'," +
//                            "title2='"      + CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getTitle2()) ) + "'," +
                            //"title3='"      + CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getTitle3()) ) + "'," +
                            //"title4='"      + CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getTitle4()) ) + "'," +
                            "title1='"      + com.vodcaster.utils.TextUtil.getValue(bean.getTitle1() ) + "'," +
                            "title2='"      + com.vodcaster.utils.TextUtil.getValue(bean.getTitle2() ) + "'," +
                            "title3='"      + com.vodcaster.utils.TextUtil.getValue(bean.getTitle3() ) + "'," +
                            "title4='"      + com.vodcaster.utils.TextUtil.getValue(bean.getTitle4() ) + "'," +

                            "ocode1='"       +com.vodcaster.utils.TextUtil.getValue(bean.getOcode1() )    + "','" +
                            "ocode2='"       +com.vodcaster.utils.TextUtil.getValue(bean.getOcode2() )    + "','" +
                            "ocode3='"       +com.vodcaster.utils.TextUtil.getValue(bean.getOcode3() )   + "','" +
                            "ocode4='"       +com.vodcaster.utils.TextUtil.getValue(bean.getOcode4() )   + "','" +
                            "isview='"      + com.vodcaster.utils.TextUtil.getValue(bean.getIsview() )   + "'," +
                            "border="       + bean.getBorder()    + " where uid=" + bean.getUid();


            //System.err.println("query == " + query);
            iRtn = querymanager.executeQuery(query);
            
            num_update = iRtn;
            
        } catch(Exception e) {
        	System.err.println("updateBest ex : " + e.getMessage());
        }

        return num_update;
	}



/*****************************************************
	����Ʈ������ ��� ����.<p>
	<b>�ۼ���</b>       : ����<br>
	@return ����:����Ʈ������ �ؽ����̺�����, ����:null<br>
	@param �˻� Query
******************************************************/
    public Vector getBestList(String query) {
        return querymanager.selectHashEntities(query);
    }


/*****************************************************
	����Ʈ������ ����.<p>
	<b>�ۼ���</b>       : ����<br>
	@return ����:������ ��������, ����:-1, ���ؼǿ���:-99<br>
	@param �˻� Query
******************************************************/
    public int deleteBest(String query) {
        Vector rtn = null;
        int iRtn = -1;

        iRtn = querymanager.executeQuery(query);
        return iRtn;
    }



/*****************************************************
	����Ʈ������ ��� ����.<p>
	<b>�ۼ���</b>       : ����<br>
	@return ����:�ؽ����̺� ����, ����:null<br>
	@param �˻� Query
******************************************************/
    public Vector selectBest(String query) {
        return querymanager.selectHashEntity(query);
        
    }
 
    public Vector list_link (String query) {
    	return querymanager.selectEntity(query);
        
    }
    
    

    /**
     * ����Ʈ 10 ���� ����/����
     * @param btiBean
     * @param btsList
     * @return
     * @throws Exception
     */
    public int saveBestTopInfo (BestTopInfoBean btiBean, ArrayList btsList) throws Exception {
        int rtn = -1;
        int bti_id = btiBean.getBti_id();
        String query = "";
        try {
            if (bti_id == 0) {
                query = " INSERT INTO best_top_info ( "+
                    " bti_isview,bti_hit_num,bti_mng_num," +
                    " bti_uip,bti_uid,bti_udate,bti_rdate " +
                    " ) VALUES (" +
                    " '" + btiBean.getBti_isview() + "', " +
                    " '" + btiBean.getBti_hit_num() + "' ," +
                    " '" + btiBean.getBti_mng_num() + "' ," +
                    " '" + btiBean.getBti_uip() + "', " +
                    " '" + com.vodcaster.utils.TextUtil.getValue(btiBean.getBti_uid() ) + "', " +
                    " now(), now() )";

                rtn = querymanager.updateEntities(query);
                // ����� bti_id �б�
                query = " SELECT LAST_INSERT_ID() ";

                Vector vector = querymanager.selectEntity(query);
                if (vector != null && vector.size() > 0) {
                    bti_id = Integer.parseInt(String.valueOf(vector.elementAt(0)));
                }
            } else {
                query = " UPDATE best_top_info SET " +
                    " bti_isview = '" + btiBean.getBti_isview() + "', " +
                    " bti_hit_num = " + btiBean.getBti_hit_num() + ", " +
                    " bti_mng_num = " + btiBean.getBti_mng_num() + ", " +
                    " bti_uip = '" + btiBean.getBti_uip() + "', " +
                    " bti_uid = '" + com.vodcaster.utils.TextUtil.getValue(btiBean.getBti_uid()) + "', " +
                    " bti_udate = now() " +
                    " WHERE bti_id = " + bti_id;

                rtn = querymanager.updateEntities(query);

                // ���� ������ ��ü DELETE �� �ٽ� INSERT
                query = " DELETE FROM best_top_sub WHERE bti_id = " + bti_id;
                querymanager.updateEntities(query);
            }

            rtn = this.insertBestTopSub(bti_id, btsList);

        } catch(Exception e) {
        	System.err.println("saveBestTopInfo Ex : " + e.getMessage());
        }
        return rtn;
	}

    /**
     * ����Ʈ 10 ����
     * @param bti_id
     * @return int
     */
    public int deleteBestTop(int bti_id) {
    	if (bti_id >= 0) {
        String query1 = " DELETE FROM best_top_sub WHERE bti_id=" + bti_id;
        String query2 = " DELETE FROM best_top_info WHERE bti_id=" + bti_id;

        querymanager.updateEntities(query2);
        int rtn = querymanager.updateEntities(query1);

        return rtn;
    	} else {
    		return -1;
    	}
    }

    /**
     * BEST 10 ���� ����
     * @param bti_id
     * @param btsList
     * @throws Exception
     */
    public int insertBestTopSub(int bti_id, ArrayList btsList) throws Exception {
        if (bti_id == 0 || btsList == null || btsList.size() == 0) {
        	System.out.println("insertBestTopSub return -1 224 line");
            return -1;
        }
        int rtn = -1;
        try {
            String query = "";
            String query1 = " INSERT INTO best_top_sub ( bti_id, bts_order, bts_title, bts_ocode, bts_uip, bts_uid, bts_udate, bts_rdate, bts_type ) VALUES ( ";
            for (int i=0; i < btsList.size(); i++) {
                BestTopSubBean btsBean = (BestTopSubBean) btsList.get(i);
                query = query1 +
                        " '" + bti_id + "', " +
                        btsBean.getBts_order() + ", " +
                       // " '" + CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(btsBean.getBts_title()) ) + "' ," +
                        " '" + com.vodcaster.utils.TextUtil.getValue(btsBean.getBts_title() ) + "' ,'" +
                        btsBean.getBts_ocode() + "', " +
                        " '" + btsBean.getBts_uip() + "', " +
                        " '" + com.vodcaster.utils.TextUtil.getValue(btsBean.getBts_uid() ) + "', " +
                        " now(), now(), " +
                        " '" + btsBean.getBts_type() + "' )";
                //System.out.println(query);
                rtn = querymanager.updateEntities(query);
            }
        } catch (Exception e) {
        	System.err.println("insertBestTopSub ex : " + e.getMessage());
        }
        return rtn;
    }

    /**
     * ����� ��ȸ�� ���
     * @param query
     * @return Vector
     */
    public Vector getBestHitList(String query) {
        return querymanager.selectHashEntities(query);
    }
}
