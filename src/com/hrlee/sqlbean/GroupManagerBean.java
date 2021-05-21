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
		����� �׷�  ��ü����Ʈ ����.<p>
		<b>�ۼ���</b> : ����� <br>
		@return �˻��� ����� �׷�  ����Ʈ(order by group_seq)<br>
		@param 
	******************************************************/
		public Vector getGroupListALL() {
		    
			return sqlbean.selectGroupListAll();

		}

		
		/*****************************************************
			����� �׷�  ����<p>
			<b>�ۼ���</b> : ����� <br>
			@return ����:0���� ũ�ų� ���� �� , ����:-1, Ŀ�ؼǿ���:-99<br>
			@param HttpServletRequest
			@see /vodman/user_group/proc_groupAdd.jsp
		******************************************************/
			public int createCategory(HttpServletRequest req) throws Exception {
			    
				try{
				    GroupInfoBean bean = new GroupInfoBean();
				    com.yundara.util.WebUtils.fill(bean, req);
				    
				    //������ ������ �ڵ尪�� ����ִ��� ���θ� Ȯ���Ѵ�.
				    String query = "select group_code from user_group where group_code ='" + bean.getGroup_code() + "' or group_name='"+bean.getGroup_name()+"'" ;
					Vector v = sqlbean.selectQuery(query);
					if(v != null && v.size()>0){
							//������ �ڵ尪�� ����ִٸ� ������� �ʴ´�.
							return -1;
					}
								
			    	return sqlbean.insertGroup(bean);
				}catch(Exception ex){
					System.err.println(ex);
					return -1;
				}
			}

		/*****************************************************
			����� �׷�  ���� ���� <p>
			<b>�ۼ���</b> : ����� <br>
			@return ����:0���� ũ�ų� ���� �� , ����:-1, Ŀ�ؼǿ���:-99<br>
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
			����� �׷�  ���� ���� <p>
			<b>�ۼ���</b> : ����� <br>
			@return ����:0���� ũ�ų� ���� �� , ����:-1, Ŀ�ؼǿ���:-99<br>
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
