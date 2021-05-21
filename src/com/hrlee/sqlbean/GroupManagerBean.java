package com.hrlee.sqlbean;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

public class GroupManagerBean {

	private static GroupManagerBean instance;
	
	private GroupSqlBean sqlbean = null;
    
	private GroupManagerBean() {
        sqlbean = new GroupSqlBean();
    }
    
	public static GroupManagerBean getInstance() {
		if(instance == null) {
			synchronized(GroupManagerBean.class) {
				if(instance == null) {
					instance = new GroupManagerBean();
				}
			}
		}
		return instance;
	}
	
	/*****************************************************
		사용자 그룹  전체리스트 리턴.<p>
		<b>작성자</b> : 이희락 <br>
		@return 검색된 사용자 그룹  리스트(order by group_seq)<br>
		@param 
	******************************************************/
		public Vector getGroupListALL() {
		    
			return sqlbean.selectGroupListAll();

		}

		
		/*****************************************************
			사용자 그룹  생성<p>
			<b>작성자</b> : 이희락 <br>
			@return 성공:0보다 크거나 같은 수 , 실패:-1, 커넥션에러:-99<br>
			@param HttpServletRequest
			@see /vodman/user_group/proc_groupAdd.jsp
		******************************************************/
			public int createCategory(HttpServletRequest req) throws Exception {
			    
				try{
				    GroupInfoBean bean = new GroupInfoBean();
				    com.yundara.util.WebUtils.fill(bean, req);
				    
				    //기존에 동일한 코드값이 들어있는지 여부를 확인한다.
				    String query = "select group_code from user_group where group_code ='" + bean.getGroup_code() + "' or group_name='"+bean.getGroup_name()+"'" ;
					Vector v = sqlbean.selectQuery(query);
					if(v != null && v.size()>0){
							//동일한 코드값이 들어있다면 등록하지 않는다.
							return -1;
					}
								
			    	return sqlbean.insertGroup(bean);
				}catch(Exception ex){
					System.err.println(ex);
					return -1;
				}
			}

		/*****************************************************
			사용자 그룹  정보 수정 <p>
			<b>작성자</b> : 이희락 <br>
			@return 성공:0보다 크거나 같은 수 , 실패:-1, 커넥션에러:-99<br>
			@param HttpServletRequest
			@see /vodman/user_group/proc_groupUpdate.jsp
		******************************************************/
			public int updateCategory(HttpServletRequest req) throws Exception {
			    
				try{
				    GroupInfoBean bean = new GroupInfoBean();
				    com.yundara.util.WebUtils.fill(bean, req);
				    
			    	return sqlbean.updateGroup(bean);
				}catch(Exception ex){
					System.err.println(ex);
					return -1;
				}
			}
			
			/*****************************************************
			사용자 그룹  정보 삭제 <p>
			<b>작성자</b> : 이희락 <br>
			@return 성공:0보다 크거나 같은 수 , 실패:-1, 커넥션에러:-99<br>
			@param HttpServletRequest
			@see /vodman/user_group/proc_groupDelete.jsp
		******************************************************/
			public int deleteCategory(int groupSeq) throws Exception {
			    
				try{
			    	return sqlbean.deleteGroup(groupSeq);
				}catch(Exception ex){
					System.err.println(ex);
					return -1;
				}
			}
			
			public Vector selectGroup(int groupSeq){
				return sqlbean.selectGroup(groupSeq);
			}
}
