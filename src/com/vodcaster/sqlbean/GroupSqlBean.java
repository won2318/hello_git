package com.vodcaster.sqlbean;


import java.util.*;
import org.apache.commons.lang.StringEscapeUtils;
import javax.servlet.http.*;
import dbcp.SQLBeanExt;
import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.yundara.util.FileUtil;
import com.yundara.util.PageBean;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;

/**
 * @author Choi Hee-Sung
 * �׷� DB Query Ŭ����
 * Date: 2005. 2. 22.
 * Time: ���� 7:41:38
 */
public class GroupSqlBean extends SQLBeanExt {

    public GroupSqlBean() {
		super();
	}



/*****************************************************
	�׷��Է�.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
	@param GroupInfoBean
******************************************************/
	public int insertGroup(GroupInfoBean bean) throws Exception {
	    int rtn = -1;
	    try {
            String query = "insert into vod_group (vodgroup,comment) values(" 	+
                    "'" + bean.getVodgroup()      + "'," +
                    "'" + bean.getComment()    + "'"+
                    ")";

//			System.err.println("Group query == " + query);
            rtn = querymanager.updateEntities(query);
	    } catch(Exception e) {
	    	System.out.println(e);
	    	return -1;
	    }
	    return rtn;
	}

/*****************************************************
	�׷����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
	@param GroupInfoBean
******************************************************/
	public int updateGroup(GroupInfoBean bean) throws Exception {
	    int rtn = -1;
	    try {
            String query = "update vod_group set " 	+
                    " vodgroup = '" + bean.getVodgroup()      + "'," +
                    " comment = '" + bean.getComment()    + "'"+
                    " where seq = "+bean.getSeq();

			//System.err.println("Groupupdate query == " + query);

            rtn = querymanager.updateEntities(query);

	    } catch(Exception e) {
	    	System.out.println(e);
	    	return -1;
	    }
	    return rtn;
	}
/*****************************************************
	�׷����.<p>
	<b>�ۼ���</b> : ����<br>
	@return <br>
	@param ���̵�,��ȣ,�̵���ڵ�
******************************************************/
	public Vector deleteGroup(int seq) {

        Vector v = null;
		if (seq >= 0) {
	        try {
	            String query = "delete from vod_group where seq=" +seq;
	            v = querymanager.executeQuery(query, "");
	        }catch(Exception e) {
	            System.err.println(e.getMessage());
	            return null;
	        }
		}

        return v;
	}



/*****************************************************
	�׷츮��Ʈ ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return �׷츮��Ʈ<br>
	@param �˻� Query
******************************************************/
    public Vector selectGroupList(String query){
        Vector rtn = null;
        try {
            rtn = querymanager.selectHashEntities(query);
        }catch(Exception e) {}
        return rtn;
    }
    
    public Hashtable getGroupListLimit(int page, String query, int limit ) {
        // page������ ��´�.
    	int totalRecord = 0;
        Vector v = querymanager.selectEntities(query);
		if(v.size() >= 1){
			totalRecord = v.size();
		}

        PageBean pb = new PageBean(totalRecord, limit, 10, page);

		// �ش� �������� ����Ʈ�� ��´�.
		String rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
        
		Vector result_v = querymanager.selectHashEntities(rquery);
		Hashtable ht = new Hashtable();
		//if(result_v.size() < 1){
		//	ht = new Hashtable();
		//	ht.put("LIST", new Hashtable());
		//	ht.put("PAGE", new com.yundara.util.PageBean());
		//}
		//else{
			ht.put("LIST",result_v);
			ht.put("PAGE",pb);
		//}

		return ht;
    }

	/*****************************************************
	ȸ����ü ����Ʈ ���.<p>
	<b>�ۼ���</b> : ����<br>
	@return �˻��� ȸ������Ʈ<br>
	@param �˻� Query
 ******************************************************/
	public Hashtable selectGroupListAll(int page,String query){

		// page������ ��´�.
        Vector v = querymanager.selectEntities(query);
		int totalRecord = v.size();

        PageBean pb = new PageBean(totalRecord, 20, 10, page);

		// �ش� �������� ����Ʈ�� ��´�.
		String rquery = query + " limit "+ (pb.getStartRecord()-1) + ",20";
        //log.printlog("MovieBoardSQLBean getBoardList method query"+query);
		Vector result_v = querymanager.selectHashEntities(rquery);

		Hashtable ht = new Hashtable();
		ht.put("LIST",result_v);
		ht.put("PAGE",pb);

		return ht;
	}


	public Vector selectQuery(String query) {
	    //System.err.println(">>>>>>>>>>>>>>>>>>>>>>>>>>query " + query);
	    return querymanager.selectEntity(query);

	}


    
    public void saveGroup(String query) {
        try {
            querymanager.updateEntities(query);
	    } catch(Exception e) {
	        System.err.println(e.toString());
	    }
    }
}
