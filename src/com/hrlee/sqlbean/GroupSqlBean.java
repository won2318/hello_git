package com.hrlee.sqlbean;
import dbcp.SQLBeanExt;
import com.yundara.util.TextUtil;

import java.util.*;
import com.vodcaster.sqlbean.DirectoryNameManager;

import javax.servlet.http.*;

public class GroupSqlBean extends SQLBeanExt {
	
	 public GroupSqlBean() {
			super();
	}
	 


	 /*****************************************************
	 	사용자 그룹  Group 정보 리턴.<p>
	 	<b>작성자</b> : 이희락 <br>
	 	@return 검색된 그룹  정보<br>
	 	@param 검색 코드ㅣQuery문
	 ******************************************************/
	 	public Vector selectGroup(int group_seq){
	 		if (group_seq >= 0) {
		 		String query = "select * from user_group where group_seq =" +group_seq;
		 		return 	querymanager.selectHashEntity(query);
	 		} else {
	 			return null;
	 		}
	 	}		
	 	
	 	/*****************************************************
		 	사용자 Group 정보 등록 .<p>
		 	<b>작성자</b> : 이희락 <br>
		 	@return  그룹  정보 등록 <br>
		 	@param 검색 코드ㅣInsert 문
		 ******************************************************/
	 	public int insertGroup(GroupInfoBean bean) throws Exception {
	 		
			
	 		 String query = "insert into user_group (group_code,group_name,group_comment) values ('" +
	    		bean.getGroup_code()				+ "','" +
				bean.getGroup_name()				+ "','" +
	    		bean.getGroup_comment()						+ "')";
	 		return querymanager.updateEntities(query);
	 	}	
	 	
	 	

	 	/*****************************************************
	 		사용자 그룹 정보 수정<p>
	 		<b>작성자</b> : 이희락 <br>
	 		@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	 		@param GroupInfoBean 빈즈
	 		@see
	 	******************************************************/
	 		public int updateGroup(GroupInfoBean bean) throws Exception{
	 		    
	 			String query = "";
	 			query = "update user_group set " 
	 			    + " group_name ='" + bean.getGroup_name() +"', "
	 		   		+ " group_code ='" + bean.getGroup_code() +"', "
					+ " group_comment ='" + bean.getGroup_comment() +"' "
	 		   		+ " where group_seq =" + bean.getGroup_seq();
	 			return querymanager.updateEntities(query);
	 		}
	 		
	 		
	 		/*****************************************************
		 		사용자 그룹 정보 삭제 <p>
		 		<b>작성자</b> : 이희락 <br>
		 		@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
		 		@param GroupInfoBean 빈즈
		 		@see
		 	******************************************************/
	 		public int deleteGroup(int groupSeq) throws Exception{
	 		    
	 			String query = "";
	 			int iResult = -1;
	 			try{
	 				query = "delete from user_group where group_seq =" + groupSeq;
	 				iResult = querymanager.executeQuery(query);
	 			}catch(Exception e){
	 				 System.err.println("deleteGroup ex : " + e);
	 			}
	 			return iResult;
	 		}
	 		
	 		/*****************************************************
	 		특정 검색에 의해 사용자 그룹  전체 리스트 리턴.<p>
	 		<b>작성자</b> : 이희락 <br>
	 		@return 검색된 사용자 그룹  리스트<br>
	 		@param 검색 Query문
	 	******************************************************/
	 		public Vector selectGroupListAll(){
	 			
	 			Vector rtn = null;
	 			String query = "";
	 			query = "select * from user_group";
	 			
	 			try {
	 				rtn = querymanager.selectHashEntities(query);
	 			}catch(Exception e) {}

	 			return rtn;
	 		}

 		 public Vector selectQuery(String query) {
 	        return querymanager.selectEntity(query);
 	    }
	 	 
	 	public Vector selectQueryList(String query) {
	         return querymanager.selectHashEntities(query);
	     }
	 	
}
