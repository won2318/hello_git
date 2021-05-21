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
 * 그룹 DB Query 클래스
 * Date: 2005. 2. 22.
 * Time: 오후 7:41:38
 */
public class GroupSqlBean extends SQLBeanExt {

    public GroupSqlBean() {
		super();
	}



/*****************************************************
	그룹입력.<p>
	<b>작성자</b> : 주현<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
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
	그룹수정.<p>
	<b>작성자</b> : 주현<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
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
	그룹삭제.<p>
	<b>작성자</b> : 주현<br>
	@return <br>
	@param 아이디,암호,미디어코드
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
	그룹리스트 리턴.<p>
	<b>작성자</b> : 주현<br>
	@return 그룹리스트<br>
	@param 검색 Query
******************************************************/
    public Vector selectGroupList(String query){
        Vector rtn = null;
        try {
            rtn = querymanager.selectHashEntities(query);
        }catch(Exception e) {}
        return rtn;
    }
    
    public Hashtable getGroupListLimit(int page, String query, int limit ) {
        // page정보를 얻는다.
    	int totalRecord = 0;
        Vector v = querymanager.selectEntities(query);
		if(v.size() >= 1){
			totalRecord = v.size();
		}

        PageBean pb = new PageBean(totalRecord, limit, 10, page);

		// 해당 페이지의 리스트를 얻는다.
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
	회원전체 리스트 출력.<p>
	<b>작성자</b> : 최희성<br>
	@return 검색된 회원리스트<br>
	@param 검색 Query
 ******************************************************/
	public Hashtable selectGroupListAll(int page,String query){

		// page정보를 얻는다.
        Vector v = querymanager.selectEntities(query);
		int totalRecord = v.size();

        PageBean pb = new PageBean(totalRecord, 20, 10, page);

		// 해당 페이지의 리스트를 얻는다.
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
