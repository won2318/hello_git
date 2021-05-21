/*
 * Created on 2005. 1. 3
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.sqlbean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.*;

import com.security.SEEDUtil;
import com.yundara.util.CharacterSet;
import javax.servlet.http.HttpServletRequest;
/**
 * @author Choi Hee-Sung
 *
 * ȸ������ ���� Ŭ����
 */
public class MemberManager {
	private static MemberManager instance;
	
	private MemberSqlBean sqlbean = null;
    
	private MemberManager() {
        sqlbean = new MemberSqlBean();
        //System.err.println("MemberManager �ν��Ͻ� ����");
    }
    
	public static MemberManager getInstance() {
		if(instance == null) {
			synchronized(MemberManager.class) {
				if(instance == null) {
					instance = new MemberManager();
				}
			}
		}
		return instance;
	}

/*****************************************************
	���̵� ã��.<p>
	<b>�ۼ���</b> : ����<br>
	@return �˻����<br>
	@param ȸ���̸�, ȸ�� �̸���
******************************************************/

	public String searchID(String name, String ssn) {
		try {
			name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(name));
			ssn = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(ssn));
			Vector rtn = sqlbean.selectSearchID(name, ssn);
			return String.valueOf(rtn.elementAt(0));
		} catch (Exception e) {
			System.out.println(e);
			return "";
		}
	}
	
/*****************************************************
	�˻����̵��� �ߺ�üũ.<p>
	<b>�ۼ���</b> : ����<br>
	@return �ߺ�:true, ����::false<br>
	@param ȸ�����̵�
******************************************************/
	public boolean checkID(String id) {
		if(id != null && id.length() > 0) {
			id = com.vodcaster.utils.TextUtil.getValue(id);
			try{
				Vector rtn = sqlbean.selectID(id);
				if(rtn.size() > 0) {
					return true;
				}else {
					return false;
				}
			} catch (Exception e){
				System.out.println(e);
				return false;
			}
		} else
			return false;
	}
	
	/*****************************************************
	�α��ν� ���̵� ����üũ.<p>
	<b>�ۼ���</b> : ����<br>
	@return �ߺ�:true, ����::false<br>
	@param ȸ�����̵�
******************************************************/
	public boolean checkID_login(String id) {
		if(id != null && id.length() > 0) {
			id = com.vodcaster.utils.TextUtil.getValue(id);
			try{
			Vector rtn = sqlbean.selectID_login(id);
			
			if(rtn.size() > 0) {
				return true;
			}else {
				return false;
			}
			} catch (Exception e){
				System.out.println(e);
				return false;
			}
		} else
			return false;
	}



/*****************************************************
	Ư�� ȸ�����̵�, ��ȣ üũ.<p>
	<b>�ۼ���</b> : ����<br>
	@return �ߺ�:true, ����::false<br>
	@param ȸ�����̵�, ȸ����ȣ
******************************************************/
	public boolean checkID(String id, String pwd){
		
		if(id != null && id.length() > 0 && pwd != null && pwd.length() > 0) {
			id = com.vodcaster.utils.TextUtil.getValue(id);
			pwd = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(pwd));
			try{
				Vector rtn = sqlbean.selectIDPwdName(id, pwd);
				
				if(rtn.size() > 0) {
					return true;
				}else {
					return false;
				}
				} catch (Exception e){
					System.out.println(e);
					return false;
				}
		} else
			return false;
	}


	public boolean checkID2(String id, String pwd){
		
		if(id != null && id.length() > 0 && pwd != null && pwd.length() > 0) {
			id = com.vodcaster.utils.TextUtil.getValue(id);
			pwd = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(pwd));
			try{
				Vector rtn = sqlbean.selectIDPwdName2(id, pwd);
				//System.out.println(rtn);
				if(rtn.size() > 0) {
	
	//				System.err.println(String.valueOf(rtn.elementAt(0))+"::"+String.valueOf(rtn.elementAt(1)));
	
					if(String.valueOf(rtn.elementAt(0)).equals(id) ){
						
						return true;
					} else {
						return false;
					}
				}else {
					return false;
				}
			 
			} catch (Exception e){
				System.out.println(e);
				return false;
			}
		} else
			return false;
	}
	
public int checkID3(String id, String pwd){
	
	if(id != null && id.length() > 0 && pwd != null && pwd.length() > 0) {
			id = com.vodcaster.utils.TextUtil.getValue(id);
			pwd = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(pwd));
			try{
				Vector rtn = sqlbean.selectIDPwdName3(id, pwd);
				if(rtn.size() > 0) {
	
	//				System.err.println(String.valueOf(rtn.elementAt(0))+"::"+String.valueOf(rtn.elementAt(1)));
					if(String.valueOf(rtn.elementAt(0)).equals(id) ){
						if(String.valueOf(rtn.elementAt(3)).equals("N")) {
							return 2;
						} else {
							return 1;
						}
					} else {
						return -1;
					}
				}else {
					return -1;
				}
			} catch (Exception e){
				System.out.println(e);
				return -1;
			}
		} else
			return -1;
	}

/*****************************************************
	Ư�� ȸ���� �ֹε�Ϲ�ȣ üũ.<p>
	<b>�ۼ���</b> : ����<br>
	@return �ߺ�:true, ����::false<br>
	@param ȸ���ֹε�Ϲ�ȣ
******************************************************/
	public boolean checkSSN(String ssn){
		if(ssn != null && ssn.length() > 0){
			try{
				ssn = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(ssn));
				Vector rtn = sqlbean.selectIDName(ssn);
				
				if(rtn.size() > 0) {
					return true;
				}else {
					return false;
				}
			} catch (Exception e){
				System.out.println(e);
				return false;
			}
		}else
			return false;
	}



/*****************************************************
	Ư�� ȸ�����̵��� ȸ�������� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ȸ�� ����<br>
	@param ȸ�����̵�
******************************************************/
	public int getLevel(String id){
		
		int rtn = 0;
		
		if(id != null && id.length() > 0){
			id = com.vodcaster.utils.TextUtil.getValue(id);
			if(this.checkID(id)) {
				try{
					Vector vl = sqlbean.selectLevel(id);
	
					if(vl.size() > 0) {
					    
					    rtn = Integer.parseInt(String.valueOf(vl.elementAt(0)));
					    //System.err.println(info.getLevel());
						return rtn;
						
					} else
						return -99;
				} catch (Exception e){
					System.out.println(e);
					return -99;
				}
			
			}else
				return -99;
		}else
			return -99;
	}



/*****************************************************
	ȸ���ƾƵ�,��ȣ �нǽ� �Է������� ���� �нǵ� ���� ã����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ȸ�����̵�, ȸ����ȣ<br>
	@param ȸ���̸�, ȸ���ֹι�ȣ, ȸ���̸���
******************************************************/
	public Vector findIDPwdEmail(String name, String ssn, String email){
		name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(name));
		ssn = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(ssn));
		email = com.vodcaster.utils.TextUtil.getValue(email);
		return sqlbean.selectIDPwdEmail(name, ssn, email);
	}



/*****************************************************
	ȸ���ƾƵ�,��ȣ �нǽ� �Է������� ���� �нǵ� ���� ã����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ȸ�����̵�<br>
	@param ȸ���̸�, ȸ���ֹι�ȣ
******************************************************/
	public Vector findID(String name, String ssn1, String ssn2){
        String ssn = ssn1 + ssn2;
        
        name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(name));
		ssn = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(ssn));
		return sqlbean.selectID(name, ssn);
	}



/*****************************************************
	ȸ����ȣ �нǽ� �Է������� ���� �нǵ� ������ ���Ϸ� �˷���.<p>
	<b>�ۼ���</b> : ����<br>
	@return ȸ����ȣ, ȸ���̸���<br>
	@param ȸ���̸�, ȸ�����̵�, ȸ���ֹι�ȣ
******************************************************/
	public Vector findPwd(String name, String id, String ssn){
		name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(name));
		id =  com.vodcaster.utils.TextUtil.getValue(id);
		ssn = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(ssn));
        return sqlbean.selectIDPwdEmail(name,id,ssn);
	}


	/*****************************************************
		ȸ����ȣ �нǽ� �Է������� ���� �нǵ� ������ ���Ϸ� �˷���.<p>
		<b>�ۼ���</b> : ����<br>
		@return ȸ����ȣ, ȸ���̸���<br>
		@param ȸ�����̵�, ���� ��ȣ, �亯
	******************************************************/
		public Vector findPwd_chk(String id, String pwd_ask_num, String pwd_answer){
			id = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(id));
			pwd_ask_num =  com.vodcaster.utils.TextUtil.getValue(pwd_ask_num);
			pwd_answer = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(pwd_answer));
	        return sqlbean.selectPwdChk(id,pwd_ask_num,pwd_answer);
		}

		/*****************************************************
		ȸ�� Ż��.<p>
		<b>�ۼ���</b> : hrlee<br>
		@return  Ż�� ���<br>
		@param ȸ�����̵�, ���� ��ȣ, �亯
	******************************************************/
		public int leave_chk(String id, String pwd_ask_num, String pwd_answer, String pwd, String remote_ip, String work_id, String user_name){
			if(id == null || id.length()<=0 || id.equals("null")){
				return -1;
			}
			id = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(id));
			pwd_ask_num =  com.vodcaster.utils.TextUtil.getValue(pwd_ask_num);
			
			pwd_answer = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(pwd_answer));
			pwd  = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(pwd));
			
			user_name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(user_name));
			
			
			if(pwd_ask_num.equals("") && pwd_answer.equals("") && pwd.equals("")) return -1;
			return sqlbean.leaveMember(id,pwd_ask_num,pwd_answer,pwd, remote_ip, work_id, user_name);
		}
		
		/*****************************************************
		ȸ����ȣ �нǽ� �Է������� ���� �нǵ� ������ ���Ϸ� �˷���.<p>
		<b>�ۼ���</b> : ����<br>
		@return ȸ����ȣ, ȸ���̸���<br>
		@param ȸ���̸�, ȸ�����̵�, ȸ���ֹι�ȣ
	******************************************************/
		public Vector findId_chk(String name, String pwd_ask_num, String pwd_answer){
			name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(name));
			pwd_ask_num =  com.vodcaster.utils.TextUtil.getValue(pwd_ask_num);
			pwd_answer = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(pwd_answer));
	        return sqlbean.selectIdChk(name,pwd_ask_num,pwd_answer);
		}
/*****************************************************
	ȸ�����̵� �Է����� ȸ���� �̸������� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ȸ���̸���<br>
	@param ȸ�����̵�
******************************************************/
	public Vector getEmail(String id){
		id =  com.vodcaster.utils.TextUtil.getValue(id);
		return sqlbean.selectEmail(id);
	}



/*****************************************************
	ȸ�����̵� �Է����� ȸ���� ��ü���� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ȸ������<br>
	@param ȸ�����̵�
******************************************************/
	public Vector getMemberInfo(String id) {
		if(id == null || id.length()<=0) return null;
		id =  com.vodcaster.utils.TextUtil.getValue(id);
		return sqlbean.selectMemberAll(id);
	}




/*****************************************************
	ȸ����ü ����Ʈ�� �̸������� ���.<p>
	<b>�ۼ���</b> : ����<br>
	@return ȸ������Ʈ<br>
	@param
******************************************************/
	public Vector getMemberListALL() {
	    return sqlbean.selectMemberListAll();
	}
	
	/*****************************************************
	ȸ����ü ����Ʈ�� �̸������� ���.<p>
	<b>�ۼ���</b> : ����<br>
	@return ȸ������Ʈ<br>
	@param
******************************************************/
	public Vector getMemberListALL_Email() {
	    return sqlbean.selectMemberListAll_Email();
	}



/*****************************************************
	ȸ����ü ����Ʈ�� �˻������� ���� ����¡ ����Ʈ ���.<p>
	<b>�ۼ���</b> : ����<br>
	@return ȸ������Ʈ<br>
	@param ����,����,���ϸ����,������,�˻��ʵ�,�˻���,��������ȣ
******************************************************/
	public Hashtable getMemberListAll(String sex, String level, String useMailling, String joinDate1, String joinDate2, String searchField, String searchString, int page, String approval){

        Hashtable result_ht;
		String query = "";
		String cond = "";
		sex =  com.vodcaster.utils.TextUtil.getValue(sex);
		level =  com.vodcaster.utils.TextUtil.getValue(level);
		useMailling =  com.vodcaster.utils.TextUtil.getValue(useMailling);
		joinDate1 =  com.vodcaster.utils.TextUtil.getValue(joinDate1);
		joinDate2 =  com.vodcaster.utils.TextUtil.getValue(joinDate2);
		searchField =  com.vodcaster.utils.TextUtil.getValue(searchField);
		//searchString =  CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(searchString));
		approval =  com.vodcaster.utils.TextUtil.getValue(approval);
		if(!searchString.equals("")) {
		    cond = '%' + searchString + '%';
		}
		String sub_query = "";
		
		
		if(!sex.equals("")){
			sub_query = " and sex='" +sex+ "' ";
		}
		
		if(!approval.equals("") && !approval.equals("all")){
			sub_query += " and approval='" +approval+ "' ";
		}
		
		if(!level.equals("") && !level.equals("all")){
			sub_query += " and level=" +level+ " ";
		}
		
		if(!useMailling.equals("")) {
		    sub_query += " and use_mailling='" + useMailling + "' ";
		}
		
		if(!joinDate1.equals("")) {
			sub_query += " and join_date >= '"+ joinDate1 + "' ";
		}
		if(!joinDate2.equals("")) {
			sub_query += " and join_date <= '"+ joinDate2 + "' ";
		}
		
		String cnt_query="";
		if(searchString.equals("")){//��ü
			query = "select * from member "+
					" where del_flag='N' and (id!='' or id!=null) " + sub_query + " order by code desc";
			cnt_query = "select  count(id) from member "+
			" where del_flag='N' and (id!='' or id!=null) " + sub_query ;
		}else if(searchField != null && (searchField.equals("name") ||  searchField.equals("email") )) {
			query = "select * from member "+
			" where del_flag='N' and name ='"+SEEDUtil.getEncrypt(searchString)+"' and (id!='' or id!=null) " +sub_query+ " order by code desc";
			cnt_query = "select  count(id) from member "+
			" where del_flag='N' and name ='"+SEEDUtil.getEncrypt(searchString)+"' and (id!='' or id!=null) " +sub_query;
		}else{
			query = "select * from member "+
					" where del_flag='N' and lower(" +searchField+ ") like lower('"+cond+"') and (id!='' or id!=null) " +sub_query+ " order by code desc";
			cnt_query = "select count(id) from member "+
			" where del_flag='N' and lower(" +searchField+ ") like lower('"+cond+"') and (id!='' or id!=null) " +sub_query;
		}
		
        try {
            result_ht = sqlbean.selectMemberListCnt(page,query,cnt_query);
        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Hashtable());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }

		//System.err.println("Query ====> " + query);
		//System.err.println("Sub Query ====> " + sub_query);
		return result_ht;
	}



/*****************************************************
	ȸ����ü ����Ʈ�� �˻������� ���� ����Ʈ ���.<p>
	<b>�ۼ���</b> : ����<br>
	@return ȸ������Ʈ<br>
	@param ����,����,���ϸ����,������,�˻��ʵ�,�˻���
******************************************************/
	public Vector getMemberListAll(String sex, String level, String useMailling, String joinDate1, String joinDate2, String searchField, String searchString){

		String query = "";
		String cond = "";
		sex =  com.vodcaster.utils.TextUtil.getValue(sex);
		level =  com.vodcaster.utils.TextUtil.getValue(level);
		useMailling =  com.vodcaster.utils.TextUtil.getValue(useMailling);
		joinDate1 =  com.vodcaster.utils.TextUtil.getValue(joinDate1);
		joinDate2 =  com.vodcaster.utils.TextUtil.getValue(joinDate2);
		searchField =  com.vodcaster.utils.TextUtil.getValue(searchField);
		searchString =  CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(searchString));
		
		if(!searchString.equals("")) {
		    cond = '%' + searchString + '%';
		}
		String sub_query = "";

		if(!sex.equals("")){
			sub_query = " and sex='" +sex+ "' ";
		}

		if(!level.equals("") && !level.equals("all")){
			sub_query += " and level=" +level+ " ";
		}

		if(!useMailling.equals("")) {
		    sub_query += " and use_mailling='" + useMailling + "' ";
		}

		if(!joinDate1.equals("") && !joinDate2.equals(""))
		    sub_query += " and join_date between '" +joinDate1+ "' and '" +joinDate2+ "' ";


		if(searchString.equals("")){//��ü
			query = "select * from member "+
					" where del_flag='N' and (id!='' or id!=null) " + sub_query + " order by code desc";
		}else {
			query = "select * from member "+
					" where del_flag='N' and lower(" +searchField+ ") like lower('"+cond+"') and (id!='' or id!=null) " +sub_query+ " order by code desc";
		}

		return sqlbean.selectQueryList(query);
	}




/*****************************************************
	ȸ����ü ����Ʈ�� �˻������� ���� ����Ʈ ���.<p>
	<b>�ۼ���</b> : ����<br>
	@return ȸ������Ʈ<br>
	@param ����,����,�˻��ʵ�,�˻���
******************************************************/
	public Vector getMemberListAll(String sex, String level, String field, String searchString){
		
		String query = "";
		String cond = "";
		sex =  com.vodcaster.utils.TextUtil.getValue(sex);
		level =  com.vodcaster.utils.TextUtil.getValue(level);
		field =  com.vodcaster.utils.TextUtil.getValue(field);
		searchString =  CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(searchString));
		
		if(!searchString.equals(null)){
		    cond = '%' + searchString.trim() + '%';
		}
		String sub_query = "";
		
		if(!sex.equals(null)){
			sub_query = " and sex='" +sex+ "' ";
		}
		
		if(!level.equals(null)){
			sub_query += " and level=" +level+ " ";
		}
			
		if(field.equals("all") || field.equals(null)) { //��ü
			query = "select * from member "+
					" where del_flag='N' and (id!='' or id!=null) " + sub_query + " order by code desc";
		}else {
			query = "select * from member "+
					" where del_flag='N' and lower(" +field+ ") like lower('"+cond+"') and (id!='' or id!=null) " +sub_query+ " order by code desc";
		}
		
		return sqlbean.selectMemberListAll(query);
	}




/*****************************************************
	ȸ�����̵� �Է¹޾� ȸ������ ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return <br>
	@param ȸ�����̵�
******************************************************/
	public int deleteMember(String id, String user_name, String user_ip, String view_id) {
		
		id =  com.vodcaster.utils.TextUtil.getValue(id);
		if(id == null || id.length()<=0) return -1;
		return sqlbean.deleteMember(id, user_name, user_ip, view_id);
	}
	
	/*****************************************************
	�ӽ� �н����� ����.<p>
	<b>�ۼ���</b> : ������<br>
	@return ���� row��, ���� -1<br>
	@param  ���̵�, �ӽú�й�ȣ
******************************************************/
	public int updateImsiPasswd(String id, String ranPwd) {
		return sqlbean.updateImsiPassword(id,ranPwd);
	}



/*****************************************************
	ȸ������ �Է�.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
	@param HttpServletRequest
******************************************************/
	public int joinMember(HttpServletRequest req) throws Exception {
		
		MemberInfoBean bean = new MemberInfoBean();
		bean.initMember(req);
	
		return sqlbean.insertMember(bean);
	}
	
public int joinMemberRsa(MemberInfoBean bean) throws Exception {

		return sqlbean.insertMemberRsa(bean);
}


 public int joinMember(String id, String name, String email)  throws Exception
    {
		 id =  com.vodcaster.utils.TextUtil.getValue(id);
		 name =  CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(name));
		 email =  com.vodcaster.utils.TextUtil.getValue(email);
        return sqlbean.insertMember(id,name,email);
    }

 public int joinMember(String id, String name, String pwd, String email)  throws Exception
    {
		 id =  com.vodcaster.utils.TextUtil.getValue(id);
		 name =  CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(name));
		 email =  com.vodcaster.utils.TextUtil.getValue(email);
		 pwd =  CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(pwd));
        return sqlbean.insertMember(id,name,pwd,email);
    }

/*****************************************************
	ȸ������ ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
	@param HttpServletRequest
******************************************************/
	public int editMember(HttpServletRequest req, String view_id) throws Exception{
		
		MemberInfoBean bean = new MemberInfoBean();
		bean.initMember(req);
		
		return sqlbean.modifyMember(bean, view_id);
	}

	public int editMemberRsa(MemberInfoBean bean, String view_id) throws Exception{
		
		return sqlbean.modifyMemberRsa(bean, view_id);
	}


/*****************************************************
	Ư��ȸ�����̵��� ȸ�������� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
	@param ȸ�����̵�, ����� ȸ��������
******************************************************/
	
	public int editMember(String id, int level) throws Exception {
		id =  com.vodcaster.utils.TextUtil.getValue(id);
	    if(id != null && (level >= 0 && level <= 9)) {
	    	
	        MemberInfoBean bean = new MemberInfoBean();
	        return sqlbean.modifyLevel(id, level);
	    }else
	        return -1;
	}
	
	public int editMember2(String id, String level) throws Exception {
		id =  com.vodcaster.utils.TextUtil.getValue(id);
	    if(id != null && (level!= null)) {
	        MemberInfoBean bean = new MemberInfoBean();
	        try{
	        	if(Integer.parseInt(level) <0 || Integer.parseInt(level)>9) return -1;
	        }catch(Exception ex){
	        	return -1;
	        }
	        
	        return sqlbean.modifyLevel2(id, level);
	    }else
	        return -1;
	}
	

    public Vector selectQueryList(String query) {
        return sqlbean.selectQueryList(query);
    }



/*****************************************************
	ȸ���� ��ȣ���� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return<br>
	@param ȸ�����̵�, ȸ����ȣ
******************************************************/
    public Vector editPwd(String id, String pwd) {
        String query = "";

        if(id==null || pwd==null){
            return null;
        }else{
        	id =  com.vodcaster.utils.TextUtil.getValue(id);
        	pwd =  CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(pwd));
            query = "update member set pwd='" +pwd+ "' where id='" +id+ "'";
            return sqlbean.executeQuery(query);
        }
    }


/*****************************************************
	ȸ���� ����ī��Ʈ ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return<br>
	@param ȸ�����̵�
******************************************************/
    public Vector addCount(String id) {
        String query = "";

        if(id !=null && id.length() > 0){
        	id =  com.vodcaster.utils.TextUtil.getValue(id);
      		 
            query = "update member set login_count = login_count + 1, lastlogin_date=now() where id='" +id+ "'";
            return sqlbean.executeQuery(query);
        }else{
            return null;
        }
    }
    /*****************************************************
		������ ����  <p>
		<b>�ۼ���</b> : ����� <br>
		@return<br>
		@param ���� ����
	******************************************************/
    public int excuteQuery(String query) {
        
        return sqlbean.executeUpdate(query);
        
    }
    
    public Hashtable getMember_logListAll(String searchField, String searchString, int page){

        Hashtable result_ht;
		String query = "";
 		searchField =  com.vodcaster.utils.TextUtil.getValue(searchField);
		//searchString =  CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(searchString));
		String sub_query = "";
		if(searchString!= null && !searchString.equals("")) {
			if (searchField != null && searchField.equals("name")) {
				sub_query =  "and b." +searchField+ " = '" + SEEDUtil.getEncrypt(searchString) + "' ";
			} else {
				sub_query =  "and lower(a." +searchField+ ") like lower('%" + searchString + "%') ";
			}
		}
	 
			query = "select a.*, b.name from user_info_log a left join member b on a.userid=b.id "+
					" where a.userid is not null " +sub_query+ " order by a.seq desc";
 	
			//System.out.println(query);
        try {
            result_ht = sqlbean.selectMemberListAll(page,query);
        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Hashtable());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }

		//System.err.println("Query ====> " + query);
		//System.err.println("Sub Query ====> " + sub_query);
		return result_ht;
	}
    

    public int insert_login_history(String user_id , String user_ip , String flag) throws Exception {

		return sqlbean.insert_login_history(  user_id, user_ip , flag  );
}

    /*****************************************************
  		�α��� ���н� count++  <p>
  		<b>�ۼ���</b> : �ȿ��� <br>
  		@return<br>
  		@paramȸ�� ī��Ʈ �߰�
  	******************************************************/
      public int CountAdd(String username) {
          
          return sqlbean.countAdd(username);
          
      }
      
 
      
      public int resetCount(String username){
    	  return sqlbean.resetCount(username);
      }
      
      
      /*****************************************************
		�α��� ���н� count�� ��������  <p>
		<b>�ۼ���</b> : �ȿ��� <br>
		@return<br>
		@paramȸ�� ī��Ʈ ��������
	******************************************************/
      public Vector getMemberCount(String username){
    	  
    	  return sqlbean.getMemberCount(username);
      }

	public int updateMember_loginCheck(String username) {
		   return sqlbean.updateMember_loginCheck(username);
		
	}
    
}
