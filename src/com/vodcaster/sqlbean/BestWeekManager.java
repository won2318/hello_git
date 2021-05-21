package com.vodcaster.sqlbean;

import javax.servlet.http.HttpServletRequest;
import java.util.Vector;

/**
 * @author Choi Hee-Sung
 *
 * ������ ���� ���� ���� Ŭ����
 * ������ ���� ���, ����, ��������
 * Date: 2005. 1. 31.
 * Time: ���� 9:29:10
 */

public class BestWeekManager {

	private static BestWeekManager instance;

	private BestWeekSqlBean sqlbean = null;

	private BestWeekManager() {
        sqlbean = new BestWeekSqlBean();
        //sqlbean.printLog("BestWeekManager �ν��Ͻ� ����");
    }

	public static BestWeekManager getInstance() {
		if(instance == null) {
			synchronized(BestWeekManager.class) {
				if(instance == null) {
					instance = new BestWeekManager();
				}
			}
		}
		return instance;
	}



/*****************************************************
	������ ���� ���� �Է�.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:row��, ����:-1, ���ؼǿ���:-99<br>
	@param HttpServletRequest
******************************************************/
    public int insertBestWeek(HttpServletRequest req) throws Exception {

		BestWeekInfoBean bean = new BestWeekInfoBean();
        com.yundara.util.WebUtils.fill(bean, req);
		return sqlbean.insertBestWeek(bean);
    }


/*****************************************************
	������ ���� ���� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:������ �������� ����, ����:null<br>
	@param
******************************************************/
    public Vector getBestWeekInfo(String flag) {
    	flag = com.vodcaster.utils.TextUtil.getValue(flag);
    	if (flag != null && flag.length()>0) {
	        String query = "select * from weekbest a , vod_media b where a.ocode=b.ocode and a.isview='Y' and a.flag='" + flag + "'";
	        
	        return sqlbean.selectBestWeek(query);
    	} else {
    		return null;
    	}
    }

    /*****************************************************
	ȫ�� ���� ���� �Է�.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:row��, ����:-1, ���ؼǿ���:-99<br>
	@param HttpServletRequest
******************************************************/
    public int insertPR_vod(HttpServletRequest req) throws Exception {

		BestWeekInfoBean bean = new BestWeekInfoBean();
        com.yundara.util.WebUtils.fill(bean, req);
		return sqlbean.insertPR_vod(bean);
    }


/*****************************************************
	ȫ�� ���� ���� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:ȫ�� �������� ����, ����:null<br>
	@param
******************************************************/
    public Vector getPR_Info() {
        String query = "select * from prvod where isview='Y'";
        return sqlbean.selectBestWeek(query);
    }
}
