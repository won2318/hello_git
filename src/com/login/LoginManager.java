package com.login;

import java.io.IOException;
import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Security;
import java.security.spec.RSAPublicKeySpec;
import java.util.*;

import javax.crypto.Cipher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.vodcaster.sqlbean.MemberInfoBean;
import com.vodcaster.sqlbean.MemberSqlBean;
import com.vodcaster.utils.Handler;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.vodcaster.sqlbean.MemberSqlBean;
/*
* session이 끊어졌을때를 처리하기 위해 사용
* static메소드에서는 static만사용 하므로static으로 선언한다.
*/
public class LoginManager extends Handler implements HttpSessionBindingListener{

    private static LoginManager loginManager = null;
    
    //로그인한 접속자를 담기위한 해시테이블
    private static Hashtable loginUsers = new Hashtable();
    
    public LoginManager( HttpServletRequest request ){
		super(request);
	}

    public LoginManager( HttpServletRequest request, HttpServletResponse response ){
    	super(request, response);
    }
    
    
    private MemberSqlBean sqlbean = null;
    
	private LoginManager() {
        sqlbean = new MemberSqlBean();
        //System.err.println("MemberManager 인스턴스 생성");
    }
	
    /*
     * 싱글톤 패턴 사용
     */
    public static synchronized LoginManager getInstance(){
        if(loginManager == null){
            loginManager = new LoginManager();
        }
        return loginManager;
    }
     
    
    /*
     * 이 메소드는 세션이 연결되을때 호출된다.(session.setAttribute("login", this))
     * Hashtable에 세션과 접속자 아이디를 저장한다.
     */
    public void valueBound(HttpSessionBindingEvent event) {
        //session값을 put한다.
        loginUsers.put(event.getSession(), event.getName());
        System.out.println(event.getName() + "님이 로그인 하셨습니다.");
        System.out.println("현재 접속자 수 : " +  getUserCount());
     }
    
    
     /*
      * 이 메소드는 세션이 끊겼을때 호출된다.(invalidate)
      * Hashtable에 저장된 로그인한 정보를 제거해 준다.
      */
     public void valueUnbound(HttpSessionBindingEvent event) {
         //session값을 찾아서 없애준다.
         loginUsers.remove(event.getSession());
         System.out.println("  " + event.getName() + "님이 로그아웃 하셨습니다.");
         System.out.println("현재 접속자 수 : " +  getUserCount());
     }
     
     
     /*
      * 입력받은 아이디를 해시테이블에서 삭제. 
      * @param userID 사용자 아이디
      * @return void
      */ 
     public void removeSession(String userId){
          Enumeration e = loginUsers.keys();
          HttpSession session = null;
          while(e.hasMoreElements()){
               session = (HttpSession)e.nextElement();
               if(loginUsers.get(session).equals(userId)){
                   //세션이 invalidate될때 HttpSessionBindingListener를 
                   //구현하는 클레스의 valueUnbound()함수가 호출된다.
                   session.invalidate();
               }
          }
     }
     
     
     /*
      * 사용자가 입력한 ID, PW가 맞는지 확인하는 메소드
      * @param userID 사용자 아이디
      * @param userPW 사용자 패스워드
      * @return boolean ID/PW가 일치하는 지 여부
      * 
      */
     
public boolean isValid(String userId, String userPw){
         
         /*
          * 이부분에 Database 로직이 들어간다.
          */
    	 
    	 try{
				Vector rtn = sqlbean.selectIDPwdName2(userId, userPw);
				//System.out.println(rtn);
				if(rtn.size() > 0) {
	
	//				System.err.println(String.valueOf(rtn.elementAt(0))+"::"+String.valueOf(rtn.elementAt(1)));
	
					if(String.valueOf(rtn.elementAt(0)).equals(userId) ){
						
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
        
     }


     public boolean isValid2(String userId, String userPw){
         
         /*
          * 이부분에 Database 로직이 들어간다.
          */
    	 
    	 try{
    		 com.vodcaster.sqlbean.MemberManager mgr = com.vodcaster.sqlbean.MemberManager.getInstance();
    		 
				Vector rtn = sqlbean.selectIDPwdName2(userId, userPw);
				if(rtn.size() > 0) {
				//System.out.println(rtn); 
 
					if(String.valueOf(rtn.elementAt(0)).equals(userId) ){
 						
						HttpSession session = null;
System.out.println("test22::test22");							
						// 로그인 세션 생성
						   Vector vt_member = mgr.getMemberInfo(userId);
System.out.println("vt_member::"+vt_member); 						   
							if(vt_member != null && vt_member.size()> 0){
								com.vodcaster.sqlbean.MemberInfoBeanRsa info_member = new com.vodcaster.sqlbean.MemberInfoBeanRsa();
								try {

									Enumeration e = vt_member.elements();
									com.yundara.beans.BeanUtils.fill(info_member, (Hashtable)e.nextElement());
								 
									int count = info_member.getCount(); 
		//System.out.println(count+info_member.getLogin_check());
									if(	(count < 5 && info_member.getLogin_check() != null && info_member.getLogin_check().equals("N"))
										 || (count == 0 ) )	{ 
										
										 if ( mgr.checkID2(userId, userPw)) {
											//로그인 카운트 0으로 변경
											mgr.resetCount(userId);
											
										   session.setAttribute("admin_id", userId);
										   session.setAttribute("vod_id", userId);
										   session.setAttribute("vod_name", info_member.getName());
										   session.setAttribute("vod_level",  String.valueOf(info_member.getLevel()));
										   session.setAttribute("vod_buseo",  String.valueOf(info_member.getBuseo()));
										   session.setAttribute("user_key", userId+"_withustech");  // 실명인증 키 임의로 생성
										   
										   session.setMaxInactiveInterval(3600);
										   
										   request.setAttribute("pwd_chk_date", info_member.getCheck_date());
										   request.setAttribute("pwd_change_date", info_member.getPasschange_date());
					 						// 로그인 로그 남김
						               		mgr.insert_login_history(userId, request.getRemoteAddr(),"T");
										 } else {
												mgr.insert_login_history(userId, request.getRemoteAddr(),"F");
										   		mgr.CountAdd(userId);
											  	//회원 정보에 로그인 실패 카운트 증가
										   		request.setAttribute("login_cnt", count);
										 }
										
									}else {
										
									  // 패스워드 연속 5회 틀림 로그인제한
										if (count > 4) {
										mgr.updateMember_loginCheck(userId);
										}
										if (info_member.getLogin_check() != null && info_member.getLogin_check().equals("Y")) {
										
										request.setAttribute("login_cnt", count);
										}
									
									}
								} catch (Exception e) {
									System.out.println("로그인 세션 생성_error:"+e);
		 						// 로그인 실패 로그 남김
					   			mgr.insert_login_history(userId, request.getRemoteAddr(),"F");
						   		mgr.CountAdd(userId);
							  	//회원 정보에 로그인 실패 카운트 증가
								}
							} 
						
						return true;
					} else {
						
						System.out.println("manager login failed ");
						 // 로그인 실패 로그 남김
					  	 mgr.insert_login_history(userId, request.getRemoteAddr(),"F");
					  	 mgr.CountAdd(userId);
					  	 request.setAttribute("login_cnt", userId);
					  
						return false;
					}
				}else {
					return false;
				}
			 
			} catch (Exception e){
				System.out.println(e);
				return false;
			}
        
     }


    /*
     * 해당 아이디의 동시 사용을 막기위해서 
     * 이미 사용중인 아이디인지를 확인한다.
     * @param userID 사용자 아이디
     * @return boolean 이미 사용 중인 경우 true, 사용중이 아니면 false
     */
    public boolean isUsing(String userID){
        return loginUsers.containsValue(userID);
    }
     
    
    /*
     * 로그인을 완료한 사용자의 아이디를 세션에 저장하는 메소드
     * @param session 세션 객체
     * @param userID 사용자 아이디
     */
    public void setSession(HttpSession session, String userId){
        //이순간에 Session Binding이벤트가 일어나는 시점
        //name값으로 userId, value값으로 자기자신(HttpSessionBindingListener를 구현하는 Object)
        session.setAttribute(userId, this);//login에 자기자신을 집어넣는다.
    }
     
     
    /*
      * 입력받은 세션Object로 아이디를 리턴한다.
      * @param session : 접속한 사용자의 session Object
      * @return String : 접속자 아이디
     */
    public String getUserID(HttpSession session){
        return (String)loginUsers.get(session);
    }
     
     
    /*
     * 현재 접속한 총 사용자 수
     * @return int  현재 접속자 수
     */
    public int getUserCount(){
        return loginUsers.size();
    }
     
     
    /*
     * 현재 접속중인 모든 사용자 아이디를 출력
     * @return void
     */
    public void printloginUsers(){
        Enumeration e = loginUsers.keys();
        HttpSession session = null;
        System.out.println("===========================================");
        int i = 0;
        while(e.hasMoreElements()){
            session = (HttpSession)e.nextElement();
            System.out.println((++i) + ". 접속자 : " +  loginUsers.get(session));
        }
        System.out.println("===========================================");
     }
     
    /*
     * 현재 접속중인 모든 사용자리스트를 리턴
     * @return list
     */
    public Collection getUsers(){
        Collection collection = loginUsers.values();
        return collection;
    }
    
    
    public static final int KEY_SIZE = 1024;

    public void processRequest(HttpServletRequest request)
            throws ServletException, IOException {
 	
        try {
        	Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());

            //KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA","BC");
        	KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
            generator.initialize(KEY_SIZE);
            
            KeyPair keyPair = generator.genKeyPair();
            //KeyFactory keyFactory = KeyFactory.getInstance("RSA","BC");
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");

            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();

            HttpSession session = request.getSession();
            // 세션에 공개키의 문자열을 키로하여 개인키를 저장한다.
            session.setAttribute("__rsaPrivateKey__", privateKey);
             
            // 공개키를 문자열로 변환하여 JavaScript RSA 라이브러리 넘겨준다.
            RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);

            String publicKeyModulus = publicSpec.getModulus().toString(16);
            String publicKeyExponent = publicSpec.getPublicExponent().toString(16);

            request.setAttribute("publicKeyModulus", publicKeyModulus);
            request.setAttribute("publicKeyExponent", publicKeyExponent);
        
        } catch (Exception ex) {
        	System.out.println("Login_error: "+ex);
            throw new ServletException(ex.getMessage(), ex);
        }
    }
 
    public void processRequest(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
		String securedUsername = request.getParameter("securedUsername");
		String securedPassword = request.getParameter("securedPassword");
		HttpSession session = request.getSession();
 
		PrivateKey privateKey = (PrivateKey) session.getAttribute("__rsaPrivateKey__");
		session.removeAttribute("__rsaPrivateKey__"); // 키의 재사용을 막는다. 항상 새로운 키를 받도록 강제.
 
		if (privateKey == null) {
			request.setAttribute("return_value", -88);
		    throw new RuntimeException("암호화 비밀키 정보를 찾을 수 없습니다.");
		    
		} else {

			try {

				String username = decryptRsa(privateKey, securedUsername);
				String password = decryptRsa(privateKey, securedPassword);
				com.vodcaster.sqlbean.MemberManager mgr = com.vodcaster.sqlbean.MemberManager.getInstance();
//				System.out.println("username = " + username);
//				System.out.println("password = " + password);
//				System.out.println(mgr.checkID2(username, password));
 
				   // 로그인 세션 생성
				   Vector vt_member = mgr.getMemberInfo(username);
					if(vt_member != null && vt_member.size()> 0){
						com.vodcaster.sqlbean.MemberInfoBeanRsa info_member = new com.vodcaster.sqlbean.MemberInfoBeanRsa();
						try {

							Enumeration e = vt_member.elements();
							com.yundara.beans.BeanUtils.fill(info_member, (Hashtable)e.nextElement());
						 
							int count = info_member.getCount(); 
//System.out.println(count+info_member.getLogin_check());
							if(	(count < 5 && info_member.getLogin_check() != null && info_member.getLogin_check().equals("N"))
								 || (count == 0 ) )	{ 
								
								 if ( mgr.checkID2(username, password)) {
									//로그인 카운트 0으로 변경
									mgr.resetCount(username);
									
								   session.setAttribute("admin_id", username);
								   session.setAttribute("vod_id", username);
								   session.setAttribute("vod_name", info_member.getName());
								   session.setAttribute("vod_level",  String.valueOf(info_member.getLevel()));
								   session.setAttribute("vod_buseo",  String.valueOf(info_member.getBuseo()));
								   session.setAttribute("user_key", username+"_withustech");  // 실명인증 키 임의로 생성
								   
								   session.setMaxInactiveInterval(3600);
								   
								   request.setAttribute("pwd_chk_date", info_member.getCheck_date());
								   request.setAttribute("pwd_change_date", info_member.getPasschange_date());
			 						// 로그인 로그 남김
				               		mgr.insert_login_history(username, request.getRemoteAddr(),"T");
								 } else {
										mgr.insert_login_history(username, request.getRemoteAddr(),"F");
								   		mgr.CountAdd(username);
									  	//회원 정보에 로그인 실패 카운트 증가
								   		request.setAttribute("login_cnt", count);
								 }
								
							}else {
								
							  // 패스워드 연속 5회 틀림 로그인제한
								if (count > 4) {
								mgr.updateMember_loginCheck(username);
								}
								if (info_member.getLogin_check() != null && info_member.getLogin_check().equals("Y")) {
								
								request.setAttribute("login_cnt", count);
								}
							
							}
						} catch (Exception e) {
							System.out.println("로그인 세션 생성_error:"+e);
 						// 로그인 실패 로그 남김
			   			mgr.insert_login_history(username, request.getRemoteAddr(),"F");
				   		mgr.CountAdd(username);
					  	//회원 정보에 로그인 실패 카운트 증가
						}
	 
				 
			   }else{
				System.out.println("manager login failed ");
				 // 로그인 실패 로그 남김
			  	 mgr.insert_login_history(username, request.getRemoteAddr(),"F");
			  	 mgr.CountAdd(username);
			  	 request.setAttribute("login_cnt", password);
			   }
	//		    System.out.println("username:"+username);
	//		    System.out.println("password:"+password);
	//		    request.setAttribute("username", username);
	//		    request.setAttribute("password", password);
			  
			} catch (Exception ex) {
				System.out.println("login_error"+ ex);
				throw new ServletException(ex.getMessage(), ex);
			}
		
		}
	 
	}
    
    
    public void processLoginMember(HttpServletRequest request, HttpServletResponse response)
    	    throws ServletException, IOException {
    		String securedUsername = request.getParameter("securedUsername");
    		String securedPassword = request.getParameter("securedPassword");
    		HttpSession session = request.getSession();
    		PrivateKey privateKey = (PrivateKey) session.getAttribute("__rsaPrivateKey__");
    		session.removeAttribute("__rsaPrivateKey__"); // 키의 재사용을 막는다. 항상 새로운 키를 받도록 강제.

    		if (privateKey == null) {
    			request.setAttribute("return_value", -88);
    		    throw new RuntimeException("암호화 비밀키 정보를 찾을 수 없습니다.");
    		} else {

    			try {
    				String username = decryptRsa(privateKey, securedUsername);
    				String password = decryptRsa(privateKey, securedPassword);
    				com.vodcaster.sqlbean.MemberManager mgr = com.vodcaster.sqlbean.MemberManager.getInstance();
//    				System.out.println("username = " + username);
//    				System.out.println("password = " + password);
//    				System.out.println(mgr.checkID2(username, password));
    	   if ( mgr.checkID2(username, password))
    			   {
    				   // 로그인 세션 생성
    				   Vector vt_member = mgr.getMemberInfo(username);
    					if(vt_member != null && vt_member.size()> 0){
    						com.vodcaster.sqlbean.MemberInfoBeanRsa info_member = new com.vodcaster.sqlbean.MemberInfoBeanRsa();
    						try {

    							Enumeration e = vt_member.elements();
    							com.yundara.beans.BeanUtils.fill(info_member, (Hashtable)e.nextElement());
 
    						   session.setAttribute("vod_id", username);
    						   session.setAttribute("vod_name", info_member.getName());
    						   session.setAttribute("vod_level",  String.valueOf(info_member.getLevel()));
    						   session.setAttribute("vod_buseo",  String.valueOf(info_member.getBuseo()));
    						   session.setAttribute("user_key", username+"_tvSuwon");  // 실명인증 키 임의로 생성
    						   
    						   session.setMaxInactiveInterval(3600);
    						   
    						   request.setAttribute("pwd_chk_date", info_member.getCheck_date());
    						   request.setAttribute("pwd_change_date", info_member.getPasschange_date());
     						// 로그인 로그 남김
    	               		mgr.insert_login_history(username, request.getRemoteAddr(),"T");

    						} catch (Exception e) {
    							System.out.println("로그인 세션 생성_error:"+e);
     						// 로그인 실패 로그 남김
    			   			mgr.insert_login_history(username, request.getRemoteAddr(),"F");
    						}
    	 
    					}else{
     						// 로그인 실패 로그 남김
    			  			mgr.insert_login_history(username, request.getRemoteAddr(),"F");
    						System.out.println("member login failed -> getMemberInfo(username) ");
    					}
    			   }else{
    				System.out.println("manager login failed ");
    				 // 로그인 실패 로그 남김
    			  	 mgr.insert_login_history(username, request.getRemoteAddr(),"F");
    			   }
 
    			  
    			} catch (Exception ex) {
    				throw new ServletException(ex.getMessage(), ex);
    			}
    		
    		}
    	 
    	}
    
    
    public void processRequestMember(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    
    	//id,pwd,name,email,sex,tel,hp,zip,address1,address2,office_name,use_mailling,login_count,level,join_date,auth_key,approval,pwd_ask_num,pwd_answer,member_group, buseo, gray, ssn
	String id_ = request.getParameter("id_");
	String pwd_ = request.getParameter("pwd_");
	String name_ = request.getParameter("name_");
	String email_ = request.getParameter("email_");
	String sex_ = request.getParameter("sex_");
	String tel_ = request.getParameter("tel_");
	String hp_ = request.getParameter("hp_");
	String zip_ = request.getParameter("zip_");
	String address1_ = request.getParameter("address1_");
	String address2_ = request.getParameter("address2_");
	String office_name_ = request.getParameter("office_name_");
	String level_ = request.getParameter("level_");
	String use_mailling_ = request.getParameter("use_mailling_");
	String auth_key_ = request.getParameter("auth_key_");
	String approval_ = request.getParameter("approval_");
	String pwd_ask_num_ = request.getParameter("pwd_ask_num_");
	String pwd_answer_ = request.getParameter("pwd_answer_");
	String member_group_ = request.getParameter("member_group_");
	String buseo_ = request.getParameter("buseo_");
	String gray_ = request.getParameter("gray_");
	String ssn_ = request.getParameter("ssn_");
	
 
	HttpSession session = request.getSession();
	PrivateKey privateKey = (PrivateKey) session.getAttribute("__rsaPrivateKey__");
	session.removeAttribute("__rsaPrivateKey__"); // 키의 재사용을 막는다. 항상 새로운 키를 받도록 강제.
	if (privateKey == null) {
		request.setAttribute("return_value", -88);
	    throw new RuntimeException("암호화 비밀키 정보를 찾을 수 없습니다.");
	} else {
	try {
 
	    MemberInfoBean bean = new MemberInfoBean();
	    /////////////////////// 암호화 필드 시작 /////////////////
	    bean.setId( decryptRsa(privateKey, id_));
	    bean.setPwd(decryptRsa(privateKey, pwd_));
	    bean.setName( decryptRsa(privateKey, name_));
	    bean.setEmail( decryptRsa(privateKey, email_));
	    bean.setSex( decryptRsa(privateKey, sex_));
	    bean.setTel( decryptRsa(privateKey, tel_));
	    bean.setHp( decryptRsa(privateKey, hp_));
	  /*  bean.setZip( decryptRsa(privateKey, zip_));
	    bean.setAddress1( decryptRsa(privateKey, address1_));
	    bean.setAddress2( decryptRsa(privateKey, address2_));
	    bean.setOffice_name( decryptRsa(privateKey, office_name_));
	   
	    bean.setUse_mailling( decryptRsa(privateKey, use_mailling_));
	    bean.setAuth_key( decryptRsa(privateKey, auth_key_));
	    bean.setApproval( decryptRsa(privateKey, approval_));
	   
	    
	    bean.setBuseo( decryptRsa(privateKey, buseo_));
	    bean.setGray( decryptRsa(privateKey, gray_));
	    
	      level_ =  decryptRsa(privateKey, level_);
	    if (level_ != null && level_.length() > 0) {
	    	bean.setLevel( Integer.parseInt(level_));
	    } else {
	    	 bean.setLevel(1);
	    }
	    
	     
	    */
	  
	    pwd_ask_num_ =  decryptRsa(privateKey, pwd_ask_num_);
	    if (pwd_ask_num_ != null && pwd_ask_num_.length() > 0) {
	    	bean.setPwd_ask_num( Integer.parseInt(pwd_ask_num_));
	    } else {
	    	 bean.setPwd_ask_num(1);
	    }
	    bean.setPwd_answer( decryptRsa(privateKey, pwd_answer_));
	    bean.setBuseo( decryptRsa(privateKey, buseo_));
	    bean.setSsn( decryptRsa(privateKey, ssn_));
		///////////////////////// 암호화 필드 끝/////////////////
	    bean.setZip( zip_);
	    bean.setAddress1(  address1_);
	    bean.setAddress2( address2_);
	    bean.setOffice_name( office_name_);
	    if (level_ != null && level_.length() > 0) {
	    	bean.setLevel( Integer.parseInt(level_));
	    } else {
	    	 bean.setLevel(1);
	    }
	    bean.setUse_mailling(use_mailling_);
	    bean.setAuth_key(  auth_key_);
	    bean.setApproval(  approval_);
 	    
	    bean.setMember_group(  member_group_);
	    bean.setGray( gray_);
	    
	    bean.setRequest_ip( request.getRemoteAddr());
		//bean.initMember(request);
		 
		com.vodcaster.sqlbean.MemberManager mgr = com.vodcaster.sqlbean.MemberManager.getInstance();
		
		

	    if (mgr.checkID(decryptRsa(privateKey, id_))){
	    	request.setAttribute("return_value", "-99"); // 회원 아이디 중복
	    } else {
			int return_value = mgr.joinMemberRsa(bean) ;
			request.setAttribute("return_value", return_value);
	    }
 
	  
	
	} catch (Exception ex) {
	    throw new ServletException(ex.getMessage(), ex);
	}
	}
}
   
    
    public void processRequestMemberUpdate(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    
    	//id,pwd,name,email,sex,tel,hp,zip,address1,address2,office_name,use_mailling,login_count,level,join_date,auth_key,approval,pwd_ask_num,pwd_answer,member_group, buseo, gray, ssn
	String id_ = request.getParameter("id_");
	String pwd_ = request.getParameter("pwd_");
	String name_ = request.getParameter("name_");
	String email_ = request.getParameter("email_");
	String sex_ = request.getParameter("sex_");
	String tel_ = request.getParameter("tel_");
	String hp_ = request.getParameter("hp_");
	String zip_ = request.getParameter("zip_");
	String address1_ = request.getParameter("address1_");
	String address2_ = request.getParameter("address2_");
	String office_name_ = request.getParameter("office_name_");
	String level_ = request.getParameter("level_");
	String use_mailling_ = request.getParameter("use_mailling_");
	String auth_key_ = request.getParameter("auth_key_");
	String approval_ = request.getParameter("approval_");
	String pwd_ask_num_ = request.getParameter("pwd_ask_num_");
	String pwd_answer_ = request.getParameter("pwd_answer_");
	String member_group_ = request.getParameter("member_group_");
	String buseo_ = request.getParameter("buseo_");
	String gray_ = request.getParameter("gray_");
	String ssn_ = request.getParameter("ssn_");
	
 
	HttpSession session = request.getSession();
	PrivateKey privateKey = (PrivateKey) session.getAttribute("__rsaPrivateKey__");
	session.removeAttribute("__rsaPrivateKey__"); // 키의 재사용을 막는다. 항상 새로운 키를 받도록 강제.
	if (privateKey == null) {
		request.setAttribute("return_value", -88);
	    throw new RuntimeException("암호화 비밀키 정보를 찾을 수 없습니다.");
	} else {
 
	try {
 
	    MemberInfoBean bean = new MemberInfoBean();
	    /////////////////////// 암호화 필드 시작 /////////////////
	    bean.setId( decryptRsa(privateKey, id_));
	    bean.setPwd(decryptRsa(privateKey, pwd_));
	    bean.setName( decryptRsa(privateKey, name_));
	    bean.setEmail( decryptRsa(privateKey, email_));
	    bean.setSex( decryptRsa(privateKey, sex_));
	    bean.setTel( decryptRsa(privateKey, tel_));
	    bean.setHp( decryptRsa(privateKey, hp_));
 
	  /*  bean.setZip( decryptRsa(privateKey, zip_));
	    bean.setAddress1( decryptRsa(privateKey, address1_));
	    bean.setAddress2( decryptRsa(privateKey, address2_));
	    bean.setOffice_name( decryptRsa(privateKey, office_name_));
	   
	    bean.setUse_mailling( decryptRsa(privateKey, use_mailling_));
	    bean.setAuth_key( decryptRsa(privateKey, auth_key_));
	    bean.setApproval( decryptRsa(privateKey, approval_));
	   
	    
	    bean.setBuseo( decryptRsa(privateKey, buseo_));
	    bean.setGray( decryptRsa(privateKey, gray_));
	    level_ =  decryptRsa(privateKey, level_);
	    if (level_ != null && level_.length() > 0) {
	    	bean.setLevel( Integer.parseInt(level_));
	    } else {
	    	 bean.setLevel(1);
	    }
	    */
 
	   
	    pwd_ask_num_ =  decryptRsa(privateKey, pwd_ask_num_);
	    if (pwd_ask_num_ != null && pwd_ask_num_.length() > 0) {
	    	bean.setPwd_ask_num( Integer.parseInt(pwd_ask_num_));
	    } else {
	    	 bean.setPwd_ask_num(1);
	    }
	    bean.setPwd_answer( decryptRsa(privateKey, pwd_answer_));
	    bean.setBuseo( decryptRsa(privateKey, buseo_));
	    bean.setSsn( decryptRsa(privateKey, ssn_));
		///////////////////////// 암호화 필드 끝/////////////////
	    bean.setZip( zip_);
	    bean.setAddress1(  address1_);
	    bean.setAddress2( address2_);
	    bean.setOffice_name( office_name_);
	    if (level_ != null && level_.length() > 0) {
	    	bean.setLevel( Integer.parseInt(level_));
	    } else {
	    	 bean.setLevel(1);
	    }
	    bean.setUse_mailling(use_mailling_);
	    bean.setAuth_key(  auth_key_);
	    bean.setApproval(  approval_);
 	    
	    bean.setMember_group(  member_group_);
	    bean.setGray( gray_);
	    
	    bean.setRequest_ip( request.getRemoteAddr());
	 
		com.vodcaster.sqlbean.MemberManager mgr = com.vodcaster.sqlbean.MemberManager.getInstance();
		
		String view_id = "";
	 
		if(  session.getAttribute("vod_id") != null && ((String) session.getAttribute("vod_id")).length() > 0){
			view_id =  com.vodcaster.utils.TextUtil.getValue((String) session.getAttribute("vod_id"));
		}
	 
		int return_value = mgr.editMemberRsa(bean, view_id) ;
		request.setAttribute("return_value", return_value);
		
//	    System.out.println("username:"+username);
//	    System.out.println("password:"+password);
//	    request.setAttribute("username", username);
//	    request.setAttribute("password", password);
	  
	} catch (Exception ex) {
	    throw new ServletException(ex.getMessage(), ex);
	}
	}
}
    

private String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
	
	Cipher cipher = Cipher.getInstance("RSA");
	// Cipher cipher = Cipher.getInstance("RSA/NONE/PKCS1Padding", "BC"); 
	 
 	byte[] encryptedBytes = hexToByteArray(securedValue);
	cipher.init(Cipher.DECRYPT_MODE, privateKey);
	byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
	String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.	
	return decryptedValue;
}

/**
* 16진 문자열을 byte 배열로 변환한다.
*/
public static byte[] hexToByteArray(String hex) {
if (hex == null || hex.length() % 2 != 0) {
    return new byte[]{};
}

byte[] bytes = new byte[hex.length() / 2];
for (int i = 0; i < hex.length(); i += 2) {
    byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
    bytes[(int) Math.floor(i / 2)] = value;
}
return bytes;
}

/**
* BigInteger를 사용해 hex를 byte[] 로 바꿀 경우 음수 영역의 값을 제대로 변환하지 못하는 문제가 있다.
*/
@Deprecated
public static byte[] hexToByteArrayBI(String hexString) {
	return new BigInteger(hexString, 16).toByteArray();
}

public static String base64Encode(byte[] data) throws Exception {
	BASE64Encoder encoder = new BASE64Encoder();
	String encoded = encoder.encode(data);
	return encoded;
}

public static byte[] base64Decode(String encryptedData) throws Exception {
	BASE64Decoder decoder = new BASE64Decoder();
	byte[] decoded = decoder.decodeBuffer(encryptedData);
	return decoded;
}

}
 