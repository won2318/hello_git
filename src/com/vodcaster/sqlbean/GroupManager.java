package com.vodcaster.sqlbean;

import com.yundara.util.CharacterSet;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.StringEscapeUtils;

/**
 * @author Choi Hee-Sung
 *
 * ������ �̵���� �׷��� ���� Ŭ����
 * Date: 2005. 2. 22.
 * Time: ���� 7:41:21
 */
public class GroupManager {

	private static GroupManager instance;

	private GroupSqlBean sqlbean = null;

	private GroupManager() {
        sqlbean = new GroupSqlBean();
//        sqlbean.printLog("GroupManager �ν��Ͻ� ����");
    }

	public static GroupManager getInstance() {
		if(instance == null) {
			synchronized(GroupManager.class) {
				if(instance == null) {
					instance = new GroupManager();
				}
			}
		}
		return instance;
	}



/*****************************************************
	Ư�� �̵���������� �׷쳻�� �߰�.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
	@param HttpServletRequest, �Խù����̵�, �Խù���ȣ
******************************************************/
    public int createGroup(HttpServletRequest req) throws Exception {

        GroupInfoBean bean = new GroupInfoBean();
		bean.initGroup(req);

        return sqlbean.insertGroup(bean);
    }


/*****************************************************
	�׷����� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
	@param HttpServletRequest
******************************************************/
	public int updateGroup(HttpServletRequest req) throws Exception{
		
		GroupInfoBean bean = new GroupInfoBean();
		bean.initGroup(req);
		
		return sqlbean.updateGroup(bean);
	}



/*****************************************************
	Ư�� �̵���������� �׷쳻�� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return <br>
	@param ���̵�,��ȣ, �̵���ڵ�
******************************************************/
    public Vector deleteGroup(int seq) throws Exception {
        return sqlbean.deleteGroup(seq);
    }



/*****************************************************
	Ư�� �̵���������� �׷츮��Ʈ ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return �׷츮��Ʈ<br>
	@param �̵���ڵ�
******************************************************/
	public Vector getGroupList(int seq){
		String query = "";

		if (seq >= 0) {
	        query = "select * from vod_group where seq=" +seq ;
			return sqlbean.selectGroupList(query);
		} else {
			return null;
		}
	}

	public Vector getGroupList(){
		String query = "";

        query = "select * from vod_group order by vodgroup"  ;
		return sqlbean.selectGroupList(query);
	}
	

	public Hashtable getGroupListAll(int page) {
        Hashtable result_ht;

        String query = " SELECT * FROM vod_group ORDER BY seq DESC ";
        
		 try {
            result_ht = sqlbean.selectGroupListAll(page,query);
        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Hashtable());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }

//		System.err.println("Query ====> " + query);
		return result_ht;
    }

	public Hashtable getGroupListLimit(int page, int limit) {
        Hashtable result_ht;

        String query = " SELECT * FROM vod_group ORDER BY seq DESC ";
        
        try {
            result_ht = sqlbean.getGroupListLimit(page, query, limit);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Hashtable());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
            
        }
//		System.err.println("Query ====> " + query);
		return result_ht;
    }
    
}
