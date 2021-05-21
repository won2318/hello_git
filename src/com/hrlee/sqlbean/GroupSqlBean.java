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
	 	����� �׷�  Group ���� ����.<p>
	 	<b>�ۼ���</b> : ����� <br>
	 	@return �˻��� �׷�  ����<br>
	 	@param �˻� �ڵ��Query��
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
		 	����� Group ���� ��� .<p>
		 	<b>�ۼ���</b> : ����� <br>
		 	@return  �׷�  ���� ��� <br>
		 	@param �˻� �ڵ��Insert ��
		 ******************************************************/
	 	public int insertGroup(GroupInfoBean bean) throws Exception {
	 		
			
	 		 String query = "insert into user_group (group_code,group_name,group_comment) values ('" +
	    		bean.getGroup_code()				+ "','" +
				bean.getGroup_name()				+ "','" +
	    		bean.getGroup_comment()						+ "')";
	 		return querymanager.updateEntities(query);
	 	}	
	 	
	 	

	 	/*****************************************************
	 		����� �׷� ���� ����<p>
	 		<b>�ۼ���</b> : ����� <br>
	 		@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
	 		@param GroupInfoBean ����
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
		 		����� �׷� ���� ���� <p>
		 		<b>�ۼ���</b> : ����� <br>
		 		@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
		 		@param GroupInfoBean ����
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
	 		Ư�� �˻��� ���� ����� �׷�  ��ü ����Ʈ ����.<p>
	 		<b>�ۼ���</b> : ����� <br>
	 		@return �˻��� ����� �׷�  ����Ʈ<br>
	 		@param �˻� Query��
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
