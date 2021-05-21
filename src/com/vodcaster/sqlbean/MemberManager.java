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
 * 회원정보 관리 클래스
 */
public class MemberManager {
	private static MemberManager instance;
	
	private MemberSqlBean sqlbean = null;
    
	private MemberManager() {
        sqlbean = new MemberSqlBean();
        //System.err.println("MemberManager 인스턴스 생성");
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
	아이디 찾기.<p>
	<b>작성자</b> : 최희성<br>
	@return 검색결과<br>
	@param 회원이름, 회원 이메일
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
	검색아이디의 중복체크.<p>
	<b>작성자</b> : 최희성<br>
	@return 중복:true, 없음::false<br>
	@param 회원아이디
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
	로그인시 아이디 유무체크.<p>
	<b>작성자</b> : 최희성<br>
	@return 중복:true, 없음::false<br>
	@param 회원아이디
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
	특정 회원아이디, 암호 체크.<p>
	<b>작성자</b> : 최희성<br>
	@return 중복:true, 없음::false<br>
	@param 회원아이디, 회원암호
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
	특정 회원의 주민등록번호 체크.<p>
	<b>작성자</b> : 최희성<br>
	@return 중복:true, 없음::false<br>
	@param 회원주민등록번호
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
	특정 회원아이디의 회원레벨값 리턴.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원 레벨<br>
	@param 회원아이디
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
	회원아아디,암호 분실시 입력정보를 통해 분실된 정보 찾아줌.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원아이디, 회원암호<br>
	@param 회원이름, 회원주민번호, 회원이메일
******************************************************/
	public Vector findIDPwdEmail(String name, String ssn, String email){
		name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(name));
		ssn = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(ssn));
		email = com.vodcaster.utils.TextUtil.getValue(email);
		return sqlbean.selectIDPwdEmail(name, ssn, email);
	}



/*****************************************************
	회원아아디,암호 분실시 입력정보를 통해 분실된 정보 찾아줌.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원아이디<br>
	@param 회원이름, 회원주민번호
******************************************************/
	public Vector findID(String name, String ssn1, String ssn2){
        String ssn = ssn1 + ssn2;
        
        name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(name));
		ssn = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(ssn));
		return sqlbean.selectID(name, ssn);
	}



/*****************************************************
	회원암호 분실시 입력정보를 통해 분실된 정보를 메일로 알려줌.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원암호, 회원이메일<br>
	@param 회원이름, 회원아이디, 회원주민번호
******************************************************/
	public Vector findPwd(String name, String id, String ssn){
		name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(name));
		id =  com.vodcaster.utils.TextUtil.getValue(id);
		ssn = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(ssn));
        return sqlbean.selectIDPwdEmail(name,id,ssn);
	}


	/*****************************************************
		회원암호 분실시 입력정보를 통해 분실된 정보를 메일로 알려줌.<p>
		<b>작성자</b> : 최희성<br>
		@return 회원암호, 회원이메일<br>
		@param 회원아이디, 질문 번호, 답변
	******************************************************/
		public Vector findPwd_chk(String id, String pwd_ask_num, String pwd_answer){
			id = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(id));
			pwd_ask_num =  com.vodcaster.utils.TextUtil.getValue(pwd_ask_num);
			pwd_answer = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(pwd_answer));
	        return sqlbean.selectPwdChk(id,pwd_ask_num,pwd_answer);
		}

		/*****************************************************
		회원 탈퇴.<p>
		<b>작성자</b> : hrlee<br>
		@return  탈퇴 결과<br>
		@param 회원아이디, 질문 번호, 답변
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
		회원암호 분실시 입력정보를 통해 분실된 정보를 메일로 알려줌.<p>
		<b>작성자</b> : 최희성<br>
		@return 회원암호, 회원이메일<br>
		@param 회원이름, 회원아이디, 회원주민번호
	******************************************************/
		public Vector findId_chk(String name, String pwd_ask_num, String pwd_answer){
			name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(name));
			pwd_ask_num =  com.vodcaster.utils.TextUtil.getValue(pwd_ask_num);
			pwd_answer = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(pwd_answer));
	        return sqlbean.selectIdChk(name,pwd_ask_num,pwd_answer);
		}
/*****************************************************
	회원아이디 입력으로 회원의 이메일정보 리턴.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원이메일<br>
	@param 회원아이디
******************************************************/
	public Vector getEmail(String id){
		id =  com.vodcaster.utils.TextUtil.getValue(id);
		return sqlbean.selectEmail(id);
	}



/*****************************************************
	회원아이디 입력으로 회원의 전체정보 리턴.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원정보<br>
	@param 회원아이디
******************************************************/
	public Vector getMemberInfo(String id) {
		if(id == null || id.length()<=0) return null;
		id =  com.vodcaster.utils.TextUtil.getValue(id);
		return sqlbean.selectMemberAll(id);
	}




/*****************************************************
	회원전체 리스트를 이름순으로 출력.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원리스트<br>
	@param
******************************************************/
	public Vector getMemberListALL() {
	    return sqlbean.selectMemberListAll();
	}
	
	/*****************************************************
	회원전체 리스트를 이름순으로 출력.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원리스트<br>
	@param
******************************************************/
	public Vector getMemberListALL_Email() {
	    return sqlbean.selectMemberListAll_Email();
	}



/*****************************************************
	회원전체 리스트를 검색정보를 통해 페이징 리스트 출력.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원리스트<br>
	@param 성별,레벨,메일링허락,가입일,검색필드,검색어,페이지번호
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
		if(searchString.equals("")){//전체
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
	회원전체 리스트를 검색정보를 통해 리스트 출력.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원리스트<br>
	@param 성별,레벨,메일링허락,가입일,검색필드,검색어
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


		if(searchString.equals("")){//전체
			query = "select * from member "+
					" where del_flag='N' and (id!='' or id!=null) " + sub_query + " order by code desc";
		}else {
			query = "select * from member "+
					" where del_flag='N' and lower(" +searchField+ ") like lower('"+cond+"') and (id!='' or id!=null) " +sub_query+ " order by code desc";
		}

		return sqlbean.selectQueryList(query);
	}




/*****************************************************
	회원전체 리스트를 검색정보를 통해 리스트 출력.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원리스트<br>
	@param 성별,레벨,검색필드,검색어
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
			
		if(field.equals("all") || field.equals(null)) { //전체
			query = "select * from member "+
					" where del_flag='N' and (id!='' or id!=null) " + sub_query + " order by code desc";
		}else {
			query = "select * from member "+
					" where del_flag='N' and lower(" +field+ ") like lower('"+cond+"') and (id!='' or id!=null) " +sub_query+ " order by code desc";
		}
		
		return sqlbean.selectMemberListAll(query);
	}




/*****************************************************
	회원아이디 입력받아 회원정보 삭제.<p>
	<b>작성자</b> : 최희성<br>
	@return <br>
	@param 회원아이디
******************************************************/
	public int deleteMember(String id, String user_name, String user_ip, String view_id) {
		
		id =  com.vodcaster.utils.TextUtil.getValue(id);
		if(id == null || id.length()<=0) return -1;
		return sqlbean.deleteMember(id, user_name, user_ip, view_id);
	}
	
	/*****************************************************
	임시 패스워드 저장.<p>
	<b>작성자</b> : 박종성<br>
	@return 성공 row수, 실패 -1<br>
	@param  아이디, 임시비밀번호
******************************************************/
	public int updateImsiPasswd(String id, String ranPwd) {
		return sqlbean.updateImsiPassword(id,ranPwd);
	}



/*****************************************************
	회원정보 입력.<p>
	<b>작성자</b> : 최희성<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
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
	회원정보 수정.<p>
	<b>작성자</b> : 최희성<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
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
	특정회원아이디의 회원레벨값 변경.<p>
	<b>작성자</b> : 최희성<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param 회원아이디, 변경될 회원레벨값
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
	회원의 암호정보 변경.<p>
	<b>작성자</b> : 최희성<br>
	@return<br>
	@param 회원아이디, 회원암호
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
	회원의 접속카운트 설정.<p>
	<b>작성자</b> : 최희성<br>
	@return<br>
	@param 회원아이디
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
		쿼리문 실행  <p>
		<b>작성자</b> : 이희락 <br>
		@return<br>
		@param 성공 여부
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
  		로그인 실패시 count++  <p>
  		<b>작성자</b> : 안원규 <br>
  		@return<br>
  		@param회원 카운트 추가
  	******************************************************/
      public int CountAdd(String username) {
          
          return sqlbean.countAdd(username);
          
      }
      
 
      
      public int resetCount(String username){
    	  return sqlbean.resetCount(username);
      }
      
      
      /*****************************************************
		로그인 실패시 count값 가져오기  <p>
		<b>작성자</b> : 안원규 <br>
		@return<br>
		@param회원 카운트 가져오기
	******************************************************/
      public Vector getMemberCount(String username){
    	  
    	  return sqlbean.getMemberCount(username);
      }

	public int updateMember_loginCheck(String username) {
		   return sqlbean.updateMember_loginCheck(username);
		
	}
    
}
