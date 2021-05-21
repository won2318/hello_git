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
* session�� ������������ ó���ϱ� ���� ���
* static�޼ҵ忡���� static����� �ϹǷ�static���� �����Ѵ�.
*/
public class LoginManager extends Handler implements HttpSessionBindingListener{

    private static LoginManager loginManager = null;
    
    //�α����� �����ڸ� ������� �ؽ����̺�
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
        //System.err.println("MemberManager �ν��Ͻ� ����");
    }
	
    /*
     * �̱��� ���� ���
     */
    public static synchronized LoginManager getInstance(){
        if(loginManager == null){
            loginManager = new LoginManager();
        }
        return loginManager;
    }
     
    
    /*
     * �� �޼ҵ�� ������ ��������� ȣ��ȴ�.(session.setAttribute("login", this))
     * Hashtable�� ���ǰ� ������ ���̵� �����Ѵ�.
     */
    public void valueBound(HttpSessionBindingEvent event) {
        //session���� put�Ѵ�.
        loginUsers.put(event.getSession(), event.getName());
        System.out.println(event.getName() + "���� �α��� �ϼ̽��ϴ�.");
        System.out.println("���� ������ �� : " +  getUserCount());
     }
    
    
     /*
      * �� �޼ҵ�� ������ �������� ȣ��ȴ�.(invalidate)
      * Hashtable�� ����� �α����� ������ ������ �ش�.
      */
     public void valueUnbound(HttpSessionBindingEvent event) {
         //session���� ã�Ƽ� �����ش�.
         loginUsers.remove(event.getSession());
         System.out.println("  " + event.getName() + "���� �α׾ƿ� �ϼ̽��ϴ�.");
         System.out.println("���� ������ �� : " +  getUserCount());
     }
     
     
     /*
      * �Է¹��� ���̵� �ؽ����̺��� ����. 
      * @param userID ����� ���̵�
      * @return void
      */ 
     public void removeSession(String userId){
          Enumeration e = loginUsers.keys();
          HttpSession session = null;
          while(e.hasMoreElements()){
               session = (HttpSession)e.nextElement();
               if(loginUsers.get(session).equals(userId)){
                   //������ invalidate�ɶ� HttpSessionBindingListener�� 
                   //�����ϴ� Ŭ������ valueUnbound()�Լ��� ȣ��ȴ�.
                   session.invalidate();
               }
          }
     }
     
     
     /*
      * ����ڰ� �Է��� ID, PW�� �´��� Ȯ���ϴ� �޼ҵ�
      * @param userID ����� ���̵�
      * @param userPW ����� �н�����
      * @return boolean ID/PW�� ��ġ�ϴ� �� ����
      * 
      */
     
public boolean isValid(String userId, String userPw){
         
         /*
          * �̺κп� Database ������ ����.
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
          * �̺κп� Database ������ ����.
          */
    	 
    	 try{
    		 com.vodcaster.sqlbean.MemberManager mgr = com.vodcaster.sqlbean.MemberManager.getInstance();
    		 
				Vector rtn = sqlbean.selectIDPwdName2(userId, userPw);
				if(rtn.size() > 0) {
				//System.out.println(rtn); 
 
					if(String.valueOf(rtn.elementAt(0)).equals(userId) ){
 						
						HttpSession session = null;
System.out.println("test22::test22");							
						// �α��� ���� ����
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
											//�α��� ī��Ʈ 0���� ����
											mgr.resetCount(userId);
											
										   session.setAttribute("admin_id", userId);
										   session.setAttribute("vod_id", userId);
										   session.setAttribute("vod_name", info_member.getName());
										   session.setAttribute("vod_level",  String.valueOf(info_member.getLevel()));
										   session.setAttribute("vod_buseo",  String.valueOf(info_member.getBuseo()));
										   session.setAttribute("user_key", userId+"_withustech");  // �Ǹ����� Ű ���Ƿ� ����
										   
										   session.setMaxInactiveInterval(3600);
										   
										   request.setAttribute("pwd_chk_date", info_member.getCheck_date());
										   request.setAttribute("pwd_change_date", info_member.getPasschange_date());
					 						// �α��� �α� ����
						               		mgr.insert_login_history(userId, request.getRemoteAddr(),"T");
										 } else {
												mgr.insert_login_history(userId, request.getRemoteAddr(),"F");
										   		mgr.CountAdd(userId);
											  	//ȸ�� ������ �α��� ���� ī��Ʈ ����
										   		request.setAttribute("login_cnt", count);
										 }
										
									}else {
										
									  // �н����� ���� 5ȸ Ʋ�� �α�������
										if (count > 4) {
										mgr.updateMember_loginCheck(userId);
										}
										if (info_member.getLogin_check() != null && info_member.getLogin_check().equals("Y")) {
										
										request.setAttribute("login_cnt", count);
										}
									
									}
								} catch (Exception e) {
									System.out.println("�α��� ���� ����_error:"+e);
		 						// �α��� ���� �α� ����
					   			mgr.insert_login_history(userId, request.getRemoteAddr(),"F");
						   		mgr.CountAdd(userId);
							  	//ȸ�� ������ �α��� ���� ī��Ʈ ����
								}
							} 
						
						return true;
					} else {
						
						System.out.println("manager login failed ");
						 // �α��� ���� �α� ����
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
     * �ش� ���̵��� ���� ����� �������ؼ� 
     * �̹� ������� ���̵������� Ȯ���Ѵ�.
     * @param userID ����� ���̵�
     * @return boolean �̹� ��� ���� ��� true, ������� �ƴϸ� false
     */
    public boolean isUsing(String userID){
        return loginUsers.containsValue(userID);
    }
     
    
    /*
     * �α����� �Ϸ��� ������� ���̵� ���ǿ� �����ϴ� �޼ҵ�
     * @param session ���� ��ü
     * @param userID ����� ���̵�
     */
    public void setSession(HttpSession session, String userId){
        //�̼����� Session Binding�̺�Ʈ�� �Ͼ�� ����
        //name������ userId, value������ �ڱ��ڽ�(HttpSessionBindingListener�� �����ϴ� Object)
        session.setAttribute(userId, this);//login�� �ڱ��ڽ��� ����ִ´�.
    }
     
     
    /*
      * �Է¹��� ����Object�� ���̵� �����Ѵ�.
      * @param session : ������ ������� session Object
      * @return String : ������ ���̵�
     */
    public String getUserID(HttpSession session){
        return (String)loginUsers.get(session);
    }
     
     
    /*
     * ���� ������ �� ����� ��
     * @return int  ���� ������ ��
     */
    public int getUserCount(){
        return loginUsers.size();
    }
     
     
    /*
     * ���� �������� ��� ����� ���̵� ���
     * @return void
     */
    public void printloginUsers(){
        Enumeration e = loginUsers.keys();
        HttpSession session = null;
        System.out.println("===========================================");
        int i = 0;
        while(e.hasMoreElements()){
            session = (HttpSession)e.nextElement();
            System.out.println((++i) + ". ������ : " +  loginUsers.get(session));
        }
        System.out.println("===========================================");
     }
     
    /*
     * ���� �������� ��� ����ڸ���Ʈ�� ����
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
            // ���ǿ� ����Ű�� ���ڿ��� Ű���Ͽ� ����Ű�� �����Ѵ�.
            session.setAttribute("__rsaPrivateKey__", privateKey);
             
            // ����Ű�� ���ڿ��� ��ȯ�Ͽ� JavaScript RSA ���̺귯�� �Ѱ��ش�.
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
		session.removeAttribute("__rsaPrivateKey__"); // Ű�� ������ ���´�. �׻� ���ο� Ű�� �޵��� ����.
 
		if (privateKey == null) {
			request.setAttribute("return_value", -88);
		    throw new RuntimeException("��ȣȭ ���Ű ������ ã�� �� �����ϴ�.");
		    
		} else {

			try {

				String username = decryptRsa(privateKey, securedUsername);
				String password = decryptRsa(privateKey, securedPassword);
				com.vodcaster.sqlbean.MemberManager mgr = com.vodcaster.sqlbean.MemberManager.getInstance();
//				System.out.println("username = " + username);
//				System.out.println("password = " + password);
//				System.out.println(mgr.checkID2(username, password));
 
				   // �α��� ���� ����
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
									//�α��� ī��Ʈ 0���� ����
									mgr.resetCount(username);
									
								   session.setAttribute("admin_id", username);
								   session.setAttribute("vod_id", username);
								   session.setAttribute("vod_name", info_member.getName());
								   session.setAttribute("vod_level",  String.valueOf(info_member.getLevel()));
								   session.setAttribute("vod_buseo",  String.valueOf(info_member.getBuseo()));
								   session.setAttribute("user_key", username+"_withustech");  // �Ǹ����� Ű ���Ƿ� ����
								   
								   session.setMaxInactiveInterval(3600);
								   
								   request.setAttribute("pwd_chk_date", info_member.getCheck_date());
								   request.setAttribute("pwd_change_date", info_member.getPasschange_date());
			 						// �α��� �α� ����
				               		mgr.insert_login_history(username, request.getRemoteAddr(),"T");
								 } else {
										mgr.insert_login_history(username, request.getRemoteAddr(),"F");
								   		mgr.CountAdd(username);
									  	//ȸ�� ������ �α��� ���� ī��Ʈ ����
								   		request.setAttribute("login_cnt", count);
								 }
								
							}else {
								
							  // �н����� ���� 5ȸ Ʋ�� �α�������
								if (count > 4) {
								mgr.updateMember_loginCheck(username);
								}
								if (info_member.getLogin_check() != null && info_member.getLogin_check().equals("Y")) {
								
								request.setAttribute("login_cnt", count);
								}
							
							}
						} catch (Exception e) {
							System.out.println("�α��� ���� ����_error:"+e);
 						// �α��� ���� �α� ����
			   			mgr.insert_login_history(username, request.getRemoteAddr(),"F");
				   		mgr.CountAdd(username);
					  	//ȸ�� ������ �α��� ���� ī��Ʈ ����
						}
	 
				 
			   }else{
				System.out.println("manager login failed ");
				 // �α��� ���� �α� ����
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
    		session.removeAttribute("__rsaPrivateKey__"); // Ű�� ������ ���´�. �׻� ���ο� Ű�� �޵��� ����.

    		if (privateKey == null) {
    			request.setAttribute("return_value", -88);
    		    throw new RuntimeException("��ȣȭ ���Ű ������ ã�� �� �����ϴ�.");
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
    				   // �α��� ���� ����
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
    						   session.setAttribute("user_key", username+"_tvSuwon");  // �Ǹ����� Ű ���Ƿ� ����
    						   
    						   session.setMaxInactiveInterval(3600);
    						   
    						   request.setAttribute("pwd_chk_date", info_member.getCheck_date());
    						   request.setAttribute("pwd_change_date", info_member.getPasschange_date());
     						// �α��� �α� ����
    	               		mgr.insert_login_history(username, request.getRemoteAddr(),"T");

    						} catch (Exception e) {
    							System.out.println("�α��� ���� ����_error:"+e);
     						// �α��� ���� �α� ����
    			   			mgr.insert_login_history(username, request.getRemoteAddr(),"F");
    						}
    	 
    					}else{
     						// �α��� ���� �α� ����
    			  			mgr.insert_login_history(username, request.getRemoteAddr(),"F");
    						System.out.println("member login failed -> getMemberInfo(username) ");
    					}
    			   }else{
    				System.out.println("manager login failed ");
    				 // �α��� ���� �α� ����
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
	session.removeAttribute("__rsaPrivateKey__"); // Ű�� ������ ���´�. �׻� ���ο� Ű�� �޵��� ����.
	if (privateKey == null) {
		request.setAttribute("return_value", -88);
	    throw new RuntimeException("��ȣȭ ���Ű ������ ã�� �� �����ϴ�.");
	} else {
	try {
 
	    MemberInfoBean bean = new MemberInfoBean();
	    /////////////////////// ��ȣȭ �ʵ� ���� /////////////////
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
		///////////////////////// ��ȣȭ �ʵ� ��/////////////////
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
	    	request.setAttribute("return_value", "-99"); // ȸ�� ���̵� �ߺ�
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
	session.removeAttribute("__rsaPrivateKey__"); // Ű�� ������ ���´�. �׻� ���ο� Ű�� �޵��� ����.
	if (privateKey == null) {
		request.setAttribute("return_value", -88);
	    throw new RuntimeException("��ȣȭ ���Ű ������ ã�� �� �����ϴ�.");
	} else {
 
	try {
 
	    MemberInfoBean bean = new MemberInfoBean();
	    /////////////////////// ��ȣȭ �ʵ� ���� /////////////////
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
		///////////////////////// ��ȣȭ �ʵ� ��/////////////////
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
	String decryptedValue = new String(decryptedBytes, "utf-8"); // ���� ���ڵ� ����.	
	return decryptedValue;
}

/**
* 16�� ���ڿ��� byte �迭�� ��ȯ�Ѵ�.
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
* BigInteger�� ����� hex�� byte[] �� �ٲ� ��� ���� ������ ���� ����� ��ȯ���� ���ϴ� ������ �ִ�.
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
 