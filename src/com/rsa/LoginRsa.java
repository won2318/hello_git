/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.rsa;

import java.io.IOException;
import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Security;

import java.security.spec.RSAPublicKeySpec;

import javax.crypto.Cipher;
import javax.servlet.ServletException;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import java.util.*;

import com.vodcaster.sqlbean.MemberInfoBean;
import com.vodcaster.utils.*;
 
/**
 *
 * @author kwon37xi
 */
public class LoginRsa extends Handler {
	
	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public LoginRsa( HttpServletRequest request ){
		super(request);
	}

    public LoginRsa( HttpServletRequest request, HttpServletResponse response ){
    	super(request, response);
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
								   		request.setAttribute("login_check", info_member.getLogin_check());
								 }
								
							}else {
								
							  // 패스워드 연속 5회 틀림 로그인제한
								if (count > 4) {
								mgr.updateMember_loginCheck(username);
								}
								if (info_member.getLogin_check() != null && info_member.getLogin_check().equals("Y")) {
								
								request.setAttribute("login_cnt", count);
								request.setAttribute("login_check", info_member.getLogin_check());
								
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
