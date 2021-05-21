/*
 * Created on 2005. 1. 3
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.sqlbean;


/**
 * @author 최희성
 *
 * 회원관리에 필요한 각각의 데이타 출력. 회원가입, 변경, 회원목록등의 정보 처리.
 */
import dbcp.SQLBeanExt;

import java.sql.PreparedStatement;
import java.util.*;
import java.util.logging.Logger;

import javax.servlet.http.*;
 
import com.yundara.util.CharacterSet;
import com.yundara.util.PageBean;
import com.security.SEEDUtil;

public class MemberSqlBean extends SQLBeanExt {
    public MemberSqlBean() {
		super();
	}



    /*****************************************************
	회원전체 리스트를 이름순으로 출력.<p>
	<b>작성자</b> : 최희성<br>
	@return 검색된 회원리스트<br>
	@param
******************************************************/
	public Vector selectSearchID(String name, String ssn){
		if (name != null && name.length() > 0 && ssn != null && ssn.length() > 0) {
			String query = "select id from member where del_flag='N' and name='"+name+"' and ssn=password('"+ssn+"')";
			return querymanager.selectEntity(query);
		} else {
			return null;
		}
	}

	
/*****************************************************
	회원전체 리스트를 이름순으로 출력.<p>
	<b>작성자</b> : 최희성<br>
	@return 검색된 회원리스트<br>
	@param
******************************************************/
	public Vector selectMemberListAll(){
		return querymanager.selectHashEntities("select * from member where del_flag='N' order by name");
	}
	
	/*****************************************************
	이메일 수신 가능한 회원리스트 출력.<p>
	<b>작성자</b> : 박종성<br>
	@return 검색된 회원리스트<br>
	@param
******************************************************/
	public Vector selectMemberListAll_Email(){
		return querymanager.selectHashEntities("select * from member where del_flag='N' and use_mailling='Y' order by code");
	}



/*****************************************************
	(특정 회원아이디)가 있는지 중복체크.<p>
	<b>작성자</b> : 최희성<br>
	@return 가입된 회원아이디정보<br>
	@param 회원아이디
 ******************************************************/
	public Vector selectID(String id) {
		if (id != null && id.length() > 0) {
			String query = "select id from member where id='" + id + "' ";
			return querymanager.selectHashEntity(query);
		} else {
			return null;
		}
	}
	
	
/*****************************************************
	로그인시 아이디 유무 체크.<p>
	<b>작성자</b> : 박종성<br>
	@return 가입된 회원아이디정보<br>
	@param 회원아이디
 ******************************************************/
	public Vector selectID_login(String id) {
		if (id != null && id.length() > 0) {
			String query = "select id from member where id='" + id + "' and del_flag='N'";
			return querymanager.selectHashEntity(query);
		} else {
			return null;
		}
	}



/*****************************************************
	(특정 회원아이디)분실시 이름과 주민등록번호로 아이디를 알려줌.<p>
	<b>작성자</b> : 최희성<br>
	@return 가입된 회원아이디정보<br>
	@param 회원아이디, 회원주민번호
 ******************************************************/
	public Vector selectID(String name, String ssn) {
		if (name != null && name.length() > 0 && ssn != null && ssn.length() > 0) {
			String query = "select id from member where del_flag='N' and name='" +name+ "' and substring(ssn,4,16)='" +ssn+ "'";
			return querymanager.selectEntity(query);
		} else {
			return null;
		}
	}



/*****************************************************
	(특정 회원아이디,암호)가 있는지 중복체크합니다.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원 아이디, 암호, 이름<br>
	@param 회원아이디, 회원암호
 ******************************************************/
	public Vector selectIDPwdName(String id, String pwd) {
		if (id != null && id.length() > 0 && pwd != null && pwd.length() > 0) {
			String query = "select id,pwd,name from member where del_flag='N' and id='"+id+"' and pwd=password('"+pwd+"') and approval='Y'";
			return querymanager.selectHashEntity(query);
		} else {
			return null;
		}
	}



	public Vector selectIDPwdName2(String id, String pwd) {
		if (id != null && id.length() > 0 && pwd != null && pwd.length() > 0) {
			String query = "select id,pwd,name from member where del_flag='N' and id='"+id+"' and pwd=password('"+pwd+"') and approval='Y'";
			//System.out.println(query);
			return querymanager.selectEntity(query);
		} else {
			return null;
		}
	}
	
	public Vector selectIDPwdName3(String id, String pwd) {
		if (id != null && id.length() > 0 && pwd != null && pwd.length() > 0) {
			String query = "select id,pwd,name,approval from member where del_flag='N' and id='"+id+"' and pwd=password('"+pwd+"')";
			return querymanager.selectEntity(query);
		} else {
			return null;
		}
	}




/*****************************************************
	(특정 회원 주민번호)가 있는지 중복체크합니다.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원 아이디, 이름<br>
	@param 회원주민번호
 ******************************************************/
	public Vector selectIDName(String ssn){
		if (ssn != null && ssn.length() > 0  ) {
			String query = "select id,name from member where ssn = password('"+ssn+"') and del_flag='N'";
			return 	querymanager.selectHashEntity(query);
		} else {
			return null;
		}
	}



/*****************************************************
	회원의 아이디,암호를 알려줌.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원 아이디, 회원암호, 회원이메일<br>
	@param 회원이름, 회원아이디, 회원주민번호
 ******************************************************/
	public Vector selectIDPwdEmail(String name, String id, String ssn){
		if (id != null && id.length() > 0 && name != null && name.length() > 0 && ssn != null && ssn.length() > 0) {
			String query = "select id, pwd, email from member where name='" +name.trim()+ "' and id='" +id+ "' and substring(ssn,4,16)='" +ssn+ "'";
			return 	querymanager.selectEntity(query);
		} else {
			return null;
		}
	}



	/*****************************************************
		회원의 아이디,암호를 알려줌.<p>
		<b>작성자</b> : 최희성<br>
		@return 회원 아이디, 회원암호, 회원이메일<br>
		@param 회원이름, 회원아이디, 회원주민번호
	 ******************************************************/
		public Vector selectPwdChk(String id, String pwd_ask_num, String pwd_answer){
			if (id != null && id.length() > 0 && pwd_ask_num != null && pwd_ask_num.length() > 0 && pwd_answer != null && pwd_answer.length() > 0) {
				String query = "select id, pwd, email from member where id='" +id+ "' and pwd_ask_num='" +pwd_ask_num+ "' and pwd_answer='" +pwd_answer+ "'";
				//System.out.println(query);
				return 	querymanager.selectEntity(query);
			} else {
				return null;
			}
		}
		
		/*****************************************************
		회원의 이름,암호를 알려줌.<p>
		<b>작성자</b> : 최희성<br>
		@return 회원 이름, 회원암호, 회원이메일<br>
		@param 회원이름, 질문, 답변
	 ******************************************************/
		public Vector selectIdChk(String name, String pwd_ask_num, String pwd_answer){
			if (name != null && name.length() > 0 && pwd_ask_num != null && pwd_ask_num.length() > 0 && pwd_answer != null && pwd_answer.length() > 0) {
				String query = "select id, pwd, email from member where name='" +name+ "' and pwd_ask_num='" +pwd_ask_num+ "' and pwd_answer='" +pwd_answer+ "'";
				//System.out.println(query);
				return 	querymanager.selectEntity(query);
			} else {
				return null;
			}
		}

/*****************************************************
	회원정보 삭제.<p>
	<b>작성자</b> : 최희성<br>
	@return<br>
	@param 회원아이디
 ******************************************************/
	public int deleteMember(String id, String user_name, String user_ip, String view_id) {
		
		if (id != null && id.length() > 0) {
			try {
				this. MemberLog_out( id,  user_name,  user_ip,  view_id );
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println(e);
			 
			} 		
			String query = "update member set del_flag='Y', leave_date=now() where id='" + id + "'";
			return querymanager.updateEntities(query);
		} else {
			return -1;
		}
	}
	
	/*****************************************************
	회원정보 삭제.<p>
	<b>작성자</b> : 최희성<br>
	@return<br>
	@param 회원아이디
 ******************************************************/
	public int leaveMember(String id, String ask_num, String answer, String pwd, String remote_ip, String work_id, String user_name) {
		
		if (id != null && id.length() > 0) {
		try {
			this. MemberLog_out( id,  user_name,  remote_ip,  work_id );
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println(e);
		 
		}
		
		String query = "update member set del_flag='Y',name='',email='',sex='',tel='',hp=''," +
				"zip='',address1='',address2='',level=0,office_name='',use_mailling='N', " +
				"login_count=0,auth_key='',approval='N',member_group='',buseo='',gray='',ssn=''," +
				"pwd_ask_num='',pwd_answer='', leave_date=now() ";
			if(pwd != null && pwd.length()>0){
				query = query + " where id='" + id + "' and pwd=password('"+pwd+"') ";
			}else{
				query = query = " where id='" + id + "' and pwd_ask_num="+ask_num + " and pwd_answer ='"+answer+"'";
			}
		//System.out.println(query);
		   return querymanager.updateEntities(query);
		} else{
			return -1;
		}
	}
	/*****************************************************
	임시 비밀번호 저장.<p>
	<b>작성자</b> : 박종성<br>
	@return<br>
	@param 아이디, 임시비밀번호
 ******************************************************/
	public int updateImsiPassword(String id, String ranPwd) {
		if (id != null && id.length() > 0 && ranPwd != null && ranPwd.length() > 0) {
		String query = "update member set pwd = password('"+ranPwd+"'), passchange_date=now() where id='"+id+"'";
		return querymanager.updateEntities(query);
		} else {
			return -1;
		}
	}




/*****************************************************
	회원전체 리스트 출력.<p>
	<b>작성자</b> : 최희성<br>
	@return 검색된 회원리스트<br>
	@param 검색 Query
 ******************************************************/
	public Vector selectMemberListAll(String query){
		
		Vector rtn = null;
		
		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {
			System.out.println(e);
		}
		
		return rtn;
	}



/*****************************************************
	회원전체 리스트 출력.<p>
	<b>작성자</b> : 최희성<br>
	@return 검색된 회원리스트<br>
	@param 검색 Query
 ******************************************************/
	public Hashtable selectMemberListAll(int page,String query){

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

	public Hashtable selectMemberListCnt(int page,String query, String cnt){

			 
			 Vector v = querymanager.selectEntities(cnt);
				int totalRecord = 0;
				if(v != null && v.size() > 0){
					totalRecord = Integer.parseInt(String.valueOf(((Vector)(v.elementAt(0))).elementAt(0)));
				}
				if(totalRecord <= 0){
					Hashtable ht = new Hashtable();
					ht.put("LIST", new Vector());
					ht.put("PAGE", new com.yundara.util.PageBean());
					return ht;
				}
		//139,4,10,1
		        PageBean pb = new PageBean(totalRecord, 10, 10, page);
		//totalrecord,lineperpage,pageperblock,page
		        
				// 해당 페이지의 리스트를 얻는다.
				String rquery ="";
				rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+10;
				Vector result_v = querymanager.selectHashEntities(rquery);
		//System.err.println(rquery);
				Hashtable ht = new Hashtable();
				if(result_v != null && result_v.size() > 0){
					ht.put("LIST",result_v);
					ht.put("PAGE",pb);
				}else{
					ht.put("LIST", new Vector());
					ht.put("PAGE", new com.yundara.util.PageBean());
				}
				

				return ht;
	}


/*****************************************************
	회원의 이메일정보 리턴.<p>
	<b>작성자</b> : 최희성<br>
	@return 검색된 회원이메일주소<br>
	@param 회원아이디
 ******************************************************/
	public Vector selectEmail(String id){
		if (id != null && id.length() > 0) {
			String query = "select email from member where del_flag='N' and id='" +id+ "'";
			return 	querymanager.selectHashEntity(query);
		} else {
			return null;
		}
	}	
	
	
	
/*****************************************************
	회원의 전체정보 출력.<p>
	<b>작성자</b> : 최희성<br>
	@return 검색된 회원정보 리스트<br>
	@param 회원아이디
 ******************************************************/
	public Vector selectMemberAll(String id){
		if (id != null && id.length() > 0) {
		String query = "select *, SUBDATE(NOW(), INTERVAL 6 MONTH) as check_date from member where del_flag='N' and id='" +id+ "'";
		return 	querymanager.selectHashEntity(query);
		} else {
			return null;
		}
	}




/*****************************************************
	회원정보 입력.<p>
	<b>작성자</b> : 최희성<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param MemberInfoBean
 ******************************************************/
	public int insertMember(MemberInfoBean memBean) throws Exception {
		
		String query = "insert into member"+
						" (id,pwd,name,email,sex,tel,hp,zip,address1,address2,office_name,use_mailling,login_count,level,join_date,auth_key,approval,pwd_ask_num,pwd_answer,member_group, buseo, gray, ssn, passchange_date) " +
						"values('" 		+
						CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(memBean.getId()))				+ "',password('" +
						CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(memBean.getPwd()))			+ "'),'" +
						CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(memBean.getName()))			+ "','" +
						com.vodcaster.utils.TextUtil.getValue(memBean.getEmail())			+ "','" +

						com.vodcaster.utils.TextUtil.getValue(memBean.getSex())			+ "','" +
						com.vodcaster.utils.TextUtil.getValue(memBean.getTel())			+ "','" +
						com.vodcaster.utils.TextUtil.getValue(memBean.getHp())			+ "','" +
						com.vodcaster.utils.TextUtil.getValue(memBean.getZip())			+ "','" +
						CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(memBean.getAddress1()))		+ "','" +
						CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(memBean.getAddress2()))		+ "','"	+
						CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(memBean.getOffice_name()))	+ "','" +
						com.vodcaster.utils.TextUtil.getValue(memBean.getUse_mailling())	+ "',1,1,now(),'"+
						com.vodcaster.utils.TextUtil.getValue(memBean.getAuth_key())	+ "','" +
						com.vodcaster.utils.TextUtil.getValue(memBean.getApproval())	+ "','" +
						memBean.getPwd_ask_num()	+ "','" +
						CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(memBean.getPwd_answer()))	+ "','" +

						CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(memBean.getMember_group()))	+ "','" +
						CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(memBean.getBuseo()))	+ "','" +
						CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(memBean.getGray()))	+ "',password('" +
						memBean.getSsn()			+ "'),  now())";
		
		
		//System.err.println("query == " + query);
		
		return querymanager.updateEntities(query);
	}


	public int insertMemberRsa(MemberInfoBean memBean) throws Exception {
		
		String query = "insert into member"+
						" (id,pwd,name,email,sex," +
						" tel,hp,zip,address1,address2," +
						" office_name,use_mailling,login_count,level,join_date," +
						" auth_key,approval,pwd_ask_num,pwd_answer,member_group," +
						" buseo, gray, ssn, passchange_date) " +
						"values('" 		+
						(com.vodcaster.utils.TextUtil.getValue(memBean.getId()))				+ "',password('" +
						(com.vodcaster.utils.TextUtil.getValue(memBean.getPwd()))			+ "'),'" +
						SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(memBean.getName()))			+ "','" +
						SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(memBean.getEmail()))			+ "','" +

						com.vodcaster.utils.TextUtil.getValue(memBean.getSex())			+ "','" +
						SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(memBean.getTel()))			+ "','" +
						SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(memBean.getHp()))			+ "','" +
						SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(memBean.getZip()))			+ "','" +
						SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(memBean.getAddress1()))		+ "','" +
						SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(memBean.getAddress2()))		+ "','"	+
						
						SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(memBean.getOffice_name()))	+ "','" +
						com.vodcaster.utils.TextUtil.getValue(memBean.getUse_mailling())	+ "',1,"+memBean.getLevel()+" ,now(),'"+
						
						com.vodcaster.utils.TextUtil.getValue(memBean.getAuth_key())	+ "','" +
						com.vodcaster.utils.TextUtil.getValue(memBean.getApproval())	+ "','" +
						memBean.getPwd_ask_num()	+ "','" +
						SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(memBean.getPwd_answer()))	+ "','" +
						SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(memBean.getMember_group()))	+ "','" +
						
						SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(memBean.getBuseo()))	+ "','" +
						SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(memBean.getGray()))	+ "',password('" +
						memBean.getSsn()			+ "'),  now())";
		
		
		//System.err.println("query == " + query);
		
		return querymanager.updateEntities(query);
	}
	

    public int insertMember(String id, String name, String email)
        throws Exception
    {
    	name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(name));
        String s3 ="insert into member (id,name,email,join_date)values('"+id+"','"+name+"','"+email+"',now())";
        return querymanager.updateEntities(s3);
    }
	public int insertMember(String id, String name,String pwd, String email)
        throws Exception
    {
		name = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(name));
		pwd = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(pwd));
        String s3 ="insert into member (id,name,pwd,email,join_date)values('"+id+"','"+name+"','"+pwd+"','"+email+"',now())";
        return querymanager.updateEntities(s3);
    }

/*****************************************************
	회원정보 수정.<p>
	<b>작성자</b> : 최희성<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param MemberInfoBean
 ******************************************************/
	public int modifyMember(MemberInfoBean bean, String view_id) throws Exception{

        String sub_query = "";
        Vector temp_vt =  null;
        String check_value = "";
        try {
        
        String temp_query = " select" +
        		" id, name, email, sex, tel" +
        		" , hp, zip, address1, address2, office_name " +
        		" , buseo , pwd_answer " +
        		" from member where del_flag='N' and id = '" + com.vodcaster.utils.TextUtil.getValue(bean.getId()) + "'";
        
        		temp_vt = querymanager.selectEntity(temp_query);
        }catch (Exception e){
        	System.out.println(e);
        	temp_vt = null;
        	return -1;
        }
 
      	if (temp_vt != null && temp_vt.size() > 0) {
      	// 생년월일  (생년월이이 없어 비밀번호 답변) pwd_answer
          if ( temp_vt.elementAt(11) != null &&  !temp_vt.elementAt(11).equals(com.vodcaster.utils.TextUtil.getValue(bean.getPwd_answer())) ) {
          	check_value = "O";
            	
          } else {
          	check_value = "X";
          }
          // 성별 sex
          if ( temp_vt.elementAt(3) != null &&  !temp_vt.elementAt(3).equals(com.vodcaster.utils.TextUtil.getValue(bean.getSex())) ){
          	check_value = check_value+"O";
       	
          }else {
          	check_value = check_value+"X";
          }
         //전화번호 tel
          if ( temp_vt.elementAt(4) != null &&  !temp_vt.elementAt(4).equals(com.vodcaster.utils.TextUtil.getValue(bean.getTel())) ){
          	check_value = check_value+"O";

          }else {
          	check_value = check_value+"X";
          }
          //휴대전화번호 hp
          if ( temp_vt.elementAt(5) != null &&  !temp_vt.elementAt(5).equals(com.vodcaster.utils.TextUtil.getValue(bean.getHp())) ) {
          	check_value = check_value+"O";

          }else {
          	check_value = check_value+"X";
          }
          // 우편번호 zip
          if ( temp_vt.elementAt(6) != null &&  !temp_vt.elementAt(6).equals(com.vodcaster.utils.TextUtil.getValue(bean.getZip())) ) {
          	check_value = check_value+"O";

          }else {
          	check_value = check_value+"X";
          }
          // 주소1 address1
          if ( temp_vt.elementAt(7) != null &&  !(temp_vt.elementAt(7).toString().trim()).equals(com.vodcaster.utils.TextUtil.getValue(bean.getAddress1()).trim()) ) {
          	check_value = check_value+"O";

          }else {
          	check_value = check_value+"X";
          }
          //주소2 address2
          if ( temp_vt.elementAt(8) != null &&  !(temp_vt.elementAt(8).toString().trim()).equals(com.vodcaster.utils.TextUtil.getValue(bean.getAddress2()).trim()) ) {
          	check_value = check_value+"O";
          }else {
          	check_value = check_value+"X";
          }
          //이메일 email
          if (  temp_vt.elementAt(2) != null &&  !temp_vt.elementAt(2).equals(com.vodcaster.utils.TextUtil.getValue(bean.getEmail())) ) {
          	check_value = check_value+"O";
          }else {
          	check_value = check_value+"X";
          }
          //직업 buseo
            if (  temp_vt.elementAt(10) != null &&  !(temp_vt.elementAt(10).toString().trim()).equals(CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getBuseo())).trim()) ) {
          	check_value = check_value+"O";
          }else {
          	check_value = check_value+"X";
          }
 
        
        if(!bean.getPwd().equals("")) {
            sub_query = "pwd = password('"			+ CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getPwd()))			+ "'), passchange_date=now()," ;
            check_value = check_value+"O";
        } else {
        	check_value = check_value+"X";
        }
        
        if (!check_value.equals("XXXXXXXXXX")) {
          	// 로그 정보 남김
          	 this.InsertMember_log( bean.getId(), temp_vt.elementAt(1).toString() , bean.getRequest_ip(), view_id, check_value );
          }
        
      	
        
		String query =	"update member set " +
						"email = '"			+ com.vodcaster.utils.TextUtil.getValue(bean.getEmail())		+ "', " +
                        sub_query +
                        "sex = '"			+ com.vodcaster.utils.TextUtil.getValue(bean.getSex())			+ "', "+
						"tel = '"			+ com.vodcaster.utils.TextUtil.getValue(bean.getTel())			+ "', " +
						"hp = '"			+ com.vodcaster.utils.TextUtil.getValue(bean.getHp())		+ "', " +
						"zip = '"			+ com.vodcaster.utils.TextUtil.getValue(bean.getZip())			+ "', " +
						"address1 = '"		+ CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getAddress1()))	+ "', " +
						"address2 = '"		+ CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getAddress2()))	+ "', " +
						"office_name = '"	+ CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getOffice_name())) 	+ "', " +
						"auth_key ='"+ 			com.vodcaster.utils.TextUtil.getValue(bean.getAuth_key())		+ "', " +
						"approval ='"+ com.vodcaster.utils.TextUtil.getValue(bean.getApproval())		+ "', " +
						"pwd_ask_num ='"+ bean.getPwd_ask_num()		+ "', " +
						"pwd_answer ='"+ CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getPwd_answer()))		+ "', " +
						"member_group ='"+ CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getMember_group()))		+ "', " +
						"buseo ='"+ CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getBuseo()))		+ "', " +
						"gray ='"+ CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(bean.getGray()))		+ "', " +
						"use_mailling = '" 	+ bean.getUse_mailling() + "' where id = '" + com.vodcaster.utils.TextUtil.getValue(bean.getId()) + "'";
		
		//System.err.println("query == " + query);
			return querymanager.updateEntities(query);
      	} else {
      		return -1;
      	}
	}


	public int modifyMemberRsa(MemberInfoBean bean, String view_id) throws Exception{

        String sub_query = "";
        Vector temp_vt = null;
        String check_value = "";
        try{
        String temp_query = " select" +
        		" id, name, email, sex, tel" +
        		" , hp, zip, address1, address2, office_name " +
        		" , buseo , pwd_answer " +
        		" from member where del_flag='N' and id = '" + com.vodcaster.utils.TextUtil.getValue(bean.getId()) + "'";
        
        		temp_vt = querymanager.selectEntity(temp_query);
//System.out.println(temp_query);        		
        } catch (Exception e){
        	System.out.println(e);        	
        	temp_vt = null;
        	return -1;
        }
        if (temp_vt != null && temp_vt.size() > 0) {
      	// 생년월일  (생년월이이 없어 비밀번호 답변) pwd_answer
      	 if ( temp_vt.elementAt(11) != null &&  !temp_vt.elementAt(11).equals(SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getPwd_answer()))) ) {
           	check_value = "O";
             	
           } else {
           	check_value = "X";
           }
           // 성별 sex
           if ( temp_vt.elementAt(3) != null &&  !temp_vt.elementAt(3).equals(com.vodcaster.utils.TextUtil.getValue(bean.getSex())) ){
           	check_value = check_value+"O";
        	
           }else {
           	check_value = check_value+"X";
           }
          //전화번호 tel
           if ( temp_vt.elementAt(4) != null &&  !temp_vt.elementAt(4).equals(SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getTel()))) ){
           	check_value = check_value+"O";

           }else {
           	check_value = check_value+"X";
           }
           //휴대전화번호 hp
           if ( temp_vt.elementAt(5) != null &&  !temp_vt.elementAt(5).equals(SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getHp()))) ) {
           	check_value = check_value+"O";

           }else {
           	check_value = check_value+"X";
           }
           // 우편번호 zip
           if ( temp_vt.elementAt(6) != null &&  !temp_vt.elementAt(6).equals(SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getZip()))) ) {
           	check_value = check_value+"O";

           }else {
           	check_value = check_value+"X";
           }
           // 주소1 address1
           if ( temp_vt.elementAt(7) != null &&  !(temp_vt.elementAt(7).toString()).equals(SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getAddress1()))) ) {
           	check_value = check_value+"O";

           }else {
           	check_value = check_value+"X";
           }
           //주소2 address2
           if ( temp_vt.elementAt(8) != null &&  !(temp_vt.elementAt(8).toString()).equals(SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getAddress2()))) ) {
           	check_value = check_value+"O";
           }else {
           	check_value = check_value+"X";
           }
           //이메일 email
           if (  temp_vt.elementAt(2) != null &&  !temp_vt.elementAt(2).equals(SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getEmail()))) ) {
           	check_value = check_value+"O";
           }else {
           	check_value = check_value+"X";
           }
           //직업 buseo
             if (  temp_vt.elementAt(10) != null &&  !(temp_vt.elementAt(10).toString()).equals(SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getBuseo()))) ) {
           	check_value = check_value+"O";
           }else {
           	check_value = check_value+"X";
           }
          
        
	        if(!bean.getPwd().equals("")) {
	            sub_query = "pwd = password('"			+ com.vodcaster.utils.TextUtil.getValue(bean.getPwd())	+ "'), passchange_date=now()," ;
	            check_value = check_value+"O";
	        } else {
	        	check_value = check_value+"X";
	        }
	        
	        if (!check_value.equals("XXXXXXXXXX")) {
	          	// 로그 정보 남김
	   
	          	 this.InsertMember_log( bean.getId(), temp_vt.elementAt(1).toString() , bean.getRequest_ip(), view_id, check_value );
           }
        
        
			String query =	"update member set " +
							"email = '"			+ SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getEmail()))		+ "', " +
	                        sub_query +
	                        "sex = '"			+ com.vodcaster.utils.TextUtil.getValue(bean.getSex())			+ "', "+
							"tel = '"			+ SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getTel()))			+ "', " +
							"hp = '"			+ SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getHp()))		+ "', " +
							"zip = '"			+ SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getZip()))			+ "', " +
							"address1 = '"		+ SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getAddress1()))	+ "', " +
							"address2 = '"		+ SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getAddress2()))	+ "', " +
							"office_name = '"	+ SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getOffice_name())) 	+ "', " +
							"auth_key ='"+ 			com.vodcaster.utils.TextUtil.getValue(bean.getAuth_key())		+ "', " +
							"approval ='"+ com.vodcaster.utils.TextUtil.getValue(bean.getApproval())		+ "', " +
							"pwd_ask_num ='"+ bean.getPwd_ask_num()		+ "', " +
							"pwd_answer ='"+ SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getPwd_answer()))		+ "', " +
							"member_group ='"+ SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getMember_group()))		+ "', " +
							"buseo ='"+ SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getBuseo()))		+ "', " +
							"gray ='"+ SEEDUtil.getEncrypt(com.vodcaster.utils.TextUtil.getValue(bean.getGray()))		+ "', " +
							"level ='"+ bean.getLevel()		+ "', " +
							"use_mailling = '" 	+ bean.getUse_mailling() + "' where id = '" + com.vodcaster.utils.TextUtil.getValue(bean.getId()) + "'";
			
		//System.err.println("query == " + query);
			
	
			return querymanager.updateEntities(query);
        } else {
        	return -1;
        }
	}
/*****************************************************
	회원레벨정보 리턴.<p>
	<b>작성자</b> : 최희성<br>
	@return 회원레벨<br>
	@param 회원아이디
 ******************************************************/
	public Vector selectLevel(String id) {
		if (id != null && id.length() > 0) {
		return querymanager.selectEntity("select level from member where del_flag='N' and id='" + id + "'");
		} else {
			return null;
		}
	}



/*****************************************************
	회원레벨정보 수정.<p>
	<b>작성자</b> : 최희성<br>
	@return<br>
	@param 회원아이디, 회원레벨값
 ******************************************************/
	public int modifyLevel(String id, int level) throws Exception {
		if (id != null && id.length() > 0 && level >= 0) {
		    String query = "update member set level=" +level+ " where id='" +id+ "'";
		    return querymanager.updateEntities(query);
		} else {
			return -1;
		}
	}
	
	public int modifyLevel2(String id, String level) throws Exception {
		if (id != null && id.length() > 0 && level != null && level.length() > 0) {
	    String query = "update member set approval='" +level+ "' where id='" +id+ "'";
	    
	    return querymanager.updateEntities(query);
		} else {
			return -1;
		}
	}



    public Vector selectQueryList(String query) {
        return querymanager.selectEntities(query);
    }



    public Vector executeQuery(String query){
        return querymanager.executeQuery(query, "");
    }

    public int executeUpdate(String query) {
    	try{
    		//System.err.println(query);
        return querymanager.updateEntities(query);
    	}catch(Exception ex){
    		System.err.println("member(excel) insert error : "+ ex.getMessage());
    		return -1;
    	}
    }
    
    // 회원 정보수정
    public void InsertMember_log( String user_id, String user_name, String user_ip, String work_id, String check_value ) throws Exception {
  
        String birthday = check_value.substring(0,1) ;
        String sex = check_value.substring(1,2) ;
        String tel = check_value.substring(2,3) ;
        String mobile = check_value.substring(3,4) ;
        String zipcode = check_value.substring(4,5) ;
        String addr1 = check_value.substring(5,6) ;
        String addr2 = check_value.substring(6,7) ;
        String email = check_value.substring(7,8) ;
        String deptcode = check_value.substring(8,9) ;
        String userpwd = check_value.substring(9,10) ;
            
         String query =
            " insert into user_info_log( " +
            "     userid, " +
            "     username, " +
            "     update_date, " +
            "     ip, " +
            "     birthday, " +
            "     sex, " +
            "     tel, " +
            "     mobile, " +
            "     zipcode, " +
            "     addr1, " +
            "     addr2, " +
            "     email, " +
            "	  deptcode, "+
            "	  etc, userpwd, user_out "+
            " ) values ( " +
            "  '"+user_id+"','',now(),'"+user_ip+"','"+birthday+"','"+sex+"','"+tel+"','"+mobile+"'" +
            " ,'"+zipcode+"','"+addr1+"','"+addr2+"','"+email+"','"+deptcode+"','"+work_id+"','"+userpwd+"','X') ";
        try{
//System.out.println("InsertMember_log::"+query);        	
        	querymanager.updateEntities(query);
 
        }catch( Exception e ){
            System.out.println(e);
        }  
    }
    
    // 회원 탈퇴 로그
    public void MemberLog_out( String user_id, String user_name, String user_ip, String work_id ) throws Exception {
       
         String query =
            " insert into user_info_log( " +
            "     userid, " +
            "     username, " +
            "     update_date, " +
            "     ip, " +
            "     birthday, " +
            "     sex, " +
            "     tel, " +
            "     mobile, " +
            "     zipcode, " +
            "     addr1, " +
            "     addr2, " +
            "     email, " +
            "	  deptcode, "+
            "	  etc, userpwd, user_out "+
            " ) values ('"+user_id+"','"+user_name+"',now(),'"+user_ip+"','X','X','X','X','X','X','X','X','X','"+work_id+"','X','O') ";
        try{
        	this.executeQuery(query);
 
        }catch( Exception e ){
            System.out.println(e);
        } 
    }
 

    
public int insert_login_history(String user_id , String user_ip, String flag) throws Exception {
		
		String query = "insert into login_history"+
						" (user_id,user_ip,input_date,input_flag,etc) " +
						"values('" 		+
						user_id	+ "','" +
						user_ip	+ "'," +
						"now(),'" +
						flag+ "','')";
		
		
		//System.err.println("query == " + query);
		
		return querymanager.updateEntities(query);
	}

public int countAdd(String username) {
	String query = "UPDATE member SET count = count+1 WHERE id='" + username + "' ";
	 
return querymanager.updateEntities(query);
}
 
public int updateMember_loginCheck(String username) {
	String query = "UPDATE member SET login_check = 'Y' WHERE id='" + username + "' ";
	 
return querymanager.updateEntities(query);
}


public int resetCount(String username){
String query = "UPDATE member set count ='0' , login_check='N' WHERE id='"+username+"'";
return querymanager.updateEntities(query);
}

public Vector getMemberCount(String username){
	String query =  "select count from member WHERE id='" + username + "' ";
	return querymanager.selectHashEntity(query);

}

}
