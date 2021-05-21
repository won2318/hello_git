package com.vodcaster.sqlbean;

import com.yundara.util.CharacterSet;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.StringEscapeUtils;

/**
 * @author Choi Hee-Sung
 *
 * 예약형 미디어의 그룹기능 관리 클래스
 * Date: 2005. 2. 22.
 * Time: 오후 7:41:21
 */
public class GroupManager {

	private static GroupManager instance;

	private GroupSqlBean sqlbean = null;

	private GroupManager() {
        sqlbean = new GroupSqlBean();
//        sqlbean.printLog("GroupManager 인스턴스 생성");
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
	특정 미디어컨텐츠에 그룹내용 추가.<p>
	<b>작성자</b> : 최희성<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param HttpServletRequest, 게시물아이디, 게시물암호
******************************************************/
    public int createGroup(HttpServletRequest req) throws Exception {

        GroupInfoBean bean = new GroupInfoBean();
		bean.initGroup(req);

        return sqlbean.insertGroup(bean);
    }


/*****************************************************
	그룹정보 수정.<p>
	<b>작성자</b> : 주현<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param HttpServletRequest
******************************************************/
	public int updateGroup(HttpServletRequest req) throws Exception{
		
		GroupInfoBean bean = new GroupInfoBean();
		bean.initGroup(req);
		
		return sqlbean.updateGroup(bean);
	}



/*****************************************************
	특정 미디어컨텐츠의 그룹내용 삭제.<p>
	<b>작성자</b> : 최희성<br>
	@return <br>
	@param 아이디,암호, 미디어코드
******************************************************/
    public Vector deleteGroup(int seq) throws Exception {
        return sqlbean.deleteGroup(seq);
    }



/*****************************************************
	특정 미디어컨텐츠의 그룹리스트 리턴.<p>
	<b>작성자</b> : 최희성<br>
	@return 그룹리스트<br>
	@param 미디어코드
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
