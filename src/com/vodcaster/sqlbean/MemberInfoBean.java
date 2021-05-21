/*
 * Created on 2005. 1. 3
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;
import javax.servlet.http.*;
 
/**
 * @author Choi Hee-Sung
 *
 * 회원테이블 정보 관리 클래스
 */
public class MemberInfoBean extends InfoBeanExt {
    private int code = 0;					//회원코드
    private String id = "";					//회원아이디
    private String pwd = "";				//회원암호
    private String name = "";				//회원이름
    private String email = "";				//회원이메일
    private String ssn = "";				//회원주민번호
    private String sex = "";				//회원성별 (M:남자   F:여자)
    private String tel = "";				//회원전화번호
    private String hp = "";				//회원휴대폰
    private String zip = "";				//회원 자택 우편번호
    private String address1 = "";			//회원 자택 주소1
    private String address2 = "";			//회원자택 주소2
    private String join_date = "";			//회원 가입 년월일     
    private String office_name = "";			//회원 지장명
    private String use_mailling = "";		//회원 메일링허락유무 (Y:메일링허락  N:메일링불허
    private int login_count = 0;				//회원 로그인카운트
    private int level = 0;					//회원레벨
    private String approval = "";					//회원레벨
    private String auth_key= "";
    private int pwd_ask_num= 0;
    private String pwd_answer= "";
    private String member_group= "";
    private String buseo= ""; // 부서코드
    private String gray= ""; // 직급코드
    private String del_flag="";	//삭제 여부
    private String lastlogin_date="";		//마지막 로그인 일자
    private String leave_date="";			//탈퇴 일자 
    private String check_date="";			//현재 일자
    
   
     
	/**
     * 
     */
    private String passchange_date="";			//비밀번호 변경 일자 
    
    private String request_ip="";			//ip
    

 
	
    public String getCheck_date() {
		return check_date;
	}
	public void setCheck_date(String check_date) {
		this.check_date = check_date;
	}
	public String getRequest_ip() {
		return request_ip;
	}
	public void setRequest_ip(String request_ip) {
		this.request_ip = request_ip;
	}
	public String getPasschange_date() {
		return passchange_date;
	}
	public void setPasschange_date(String passchange_date) {
		this.passchange_date = passchange_date;
	}
	public String getDel_flag() {
		return del_flag;
	}
	public void setDel_flag(String del_flag) {
		this.del_flag = del_flag;
	}
	public String getLastlogin_date() {
		return lastlogin_date;
	}
	public void setLastlogin_date(String lastlogin_date) {
		this.lastlogin_date = lastlogin_date;
	}
	public String getLeave_date() {
		return leave_date;
	}
	public void setLeave_date(String leave_date) {
		this.leave_date = leave_date;
	}
	public String getBuseo() {
        return buseo;
        
    }
    public void setBuseo(String buseo) {
        this.buseo = buseo;
    }
    public String getGray() {
        return gray;
        
    }
    public void setGray(String gray) {
        this.gray = gray;
    }
    public int getPwd_ask_num() {
        return pwd_ask_num;
    }

    public void setPwd_ask_num(int pwd_ask_num) {
        this.pwd_ask_num = pwd_ask_num;
    }
     
    public String  getMember_group() {
        return member_group;
    	
    }
    public void setMember_group(String member_group) {
        this.member_group = member_group;
    }
    
    public String  getPwd_answer() {
        return pwd_answer;
    	
    }
    public void setPwd_answer(String pwd_answer) {
        this.pwd_answer = pwd_answer;
    }
    
    public String  getAuth_key() {
        return auth_key;
    }
    public void setAuth_key(String auth_key) {
        this.auth_key = auth_key;
    }
    
    
    public MemberInfoBean() {
       super();
    }
    
    
	public void initMember( HttpServletRequest req ) {
	    
	    if(req.getParameter("id") != null) {
	        id = req.getParameter("id").trim();
	    }

	    if(req.getParameter("pwd") != null) {
            pwd = req.getParameter("pwd");
        }

        if(req.getParameter("name") != null) {
            name = req.getParameter("name").trim();
        }
        
        String pre_email = req.getParameter("pre_email");
        if(pre_email != null && pre_email.length() > 0) {
           
            email = pre_email+ "@" +req.getParameter("email");
        }else {
        	 email = req.getParameter("email");
        }
 
        
        if(req.getParameter("sex") != null) {
        	sex			= req.getParameter("sex").trim();
        }
        if(req.getParameter("tel") != null) {
        	tel			= req.getParameter("tel").trim();
        }
        if(req.getParameter("hp") != null) {
        	hp		= req.getParameter("hp").trim();
        }
        if(req.getParameter("zip") != null) {
        	zip			= req.getParameter("zip");
        }
        if(req.getParameter("address1") != null) {
        	address1 	= req.getParameter("address1").trim();
        }
        if(req.getParameter("address2") != null) {
        	address2 	= req.getParameter("address2").trim();
        }
        if(req.getParameter("office_name") != null) {
        	office_name = req.getParameter("office_name").trim();
        }
        if(req.getParameter("use_mailling") != null) {
        	use_mailling	= req.getParameter("use_mailling").trim();	//Y:사용  N:사용않함
        }
        if(req.getParameter("approval") != null) {
        	approval 	= req.getParameter("approval").trim();
        }
        if(req.getParameter("auth_key") != null) {
        	auth_key 	= req.getParameter("auth_key").trim();
        }
        if(req.getParameter("pwd_ask_num") != null) {
        	pwd_ask_num = Integer.parseInt(req.getParameter("pwd_ask_num"));
        }
        if(req.getParameter("pwd_answer") != null) {
        	pwd_answer	= req.getParameter("pwd_answer").trim();	 
        }
        if(req.getParameter("member_group") != null) {
        	member_group	= req.getParameter("member_group").trim();	 
        }
        
        if(req.getParameter("buseo") != null) {
        	buseo	= req.getParameter("buseo").trim();	 
        }
        if(req.getParameter("gray") != null) {
        	gray	= req.getParameter("gray").trim();	 
        }
        if(req.getParameter("ssn") != null) {
        	ssn	= req.getParameter("ssn").trim();	 
        }
        
        request_ip = req.getRemoteAddr();
        

	}    
    
   	

    /**
     * @return Returns the address1.
     */
    public String getAddress1() {
        return address1;
    	
    }
    /**
     * @param address1 The address1 to set.
     */
    public void setAddress1(String address1) {
        this.address1 = address1;
    }
    /**
     * @return Returns the address2.
     */
    public String getAddress2() {
        return address2;
    	
    }
    /**
     * @param address2 The address2 to set.
     */
    public void setAddress2(String address2) {
        this.address2 = address2;
    }
    /**
     * @return Returns the code.
     */
    public int getCode() {
        return code;
    }
    /**
     * @param code The code to set.
     */
    public void setCode(int code) {
        this.code = code;
    }
    /**
     * @return Returns the email.
     */
    public String getEmail() {
        return email;
    	
    }
    /**
     * @param email The email to set.
     */
    public void setEmail(String email) {
        this.email = email;
      }
    /**
     * @return Returns the id.
     */
    public String getId() {
        return id;
    }
    /**
     * @param id The id to set.
     */
    public void setId(String id) {
        this.id = id;
    }
    /**
     * @return Returns the join_date.
     */
    public String getJoin_date() {
        return join_date;
    }
    /**
     * @param join_date The join_date to set.
     */
    public void setJoin_date(String join_date) {
        this.join_date = join_date;
    }
    /**
     * @return Returns the level.
     */
    public int getLevel() {
        return level;
    }
    /**
     * @param level The level to set.
     */
    public void setLevel(int level) {
        this.level = level;
    }
    
    public String  getApproval() {
        return approval;
    }
    /**
     * @param level The level to set.
     */
    public void setApproval(String approval) {
        this.approval = approval;
    }
    
   
    /**
     * @return Returns the login_count.
     */
    public int getLogin_count() {
        return login_count;
    }
    /**
     * @param login_count The login_count to set.
     */
    public void setLogin_count(int login_count) {
        this.login_count = login_count;
    }
    /**
     * @return Returns the hp.
     */
    public String getHp() {
        return hp;
    	
    }
    /**
     * @param hp The hp to set.
     */
    public void setHp(String hp) {
        this.hp = hp;
    }
    /**
     * @return Returns the name.
     */
    public String getName() {
        return name;
    	
    }
    /**
     * @param name The name to set.
     */
    public void setName(String name) {
        this.name = name;
    }
    /**
     * @return Returns the office_name.
     */
    public String getOffice_name() {
        return office_name;
    	
    }
    /**
     * @param office_name The office_name to set.
     */
    public void setOffice_name(String office_name) {
        this.office_name = office_name;
    }
    /**
     * @return Returns the pwd.
     */
    public String getPwd() {
        return pwd;
    }
    /**
     * @param pwd The pwd to set.
     */
    public void setPwd(String pwd) {
        this.pwd = pwd;
    }
    /**
     * @return Returns the sex.
     */
    public String getSex() {
        return sex;
    }
    /**
     * @param sex The sex to set.
     */
    public void setSex(String sex) {
        this.sex = sex;
    }
    /**
     * @return Returns the ssn.
     */
    public String getSsn() {
        return ssn;
    }
    /**
     * @param ssn The ssn to set.
     */
    public void setSsn(String ssn) {
        this.ssn = ssn;
    }
    /**
     * @return Returns the tel.
     */
    public String getTel() {
        return tel;
    	
    }
    /**
     * @param tel The tel to set.
     */
    public void setTel(String tel) {
        this.tel = tel;
    }
    /**
     * @return Returns the use_mailling.
     */
    public String getUse_mailling() {
        return use_mailling;
    }
    /**
     * @param use_mailling The use_mailling to set.
     */
    public void setUse_mailling(String use_mailling) {
        this.use_mailling = use_mailling;
    }
    /**
     * @return Returns the zip.
     */
    public String getZip() {
        return zip;
    	
    }
    /**
     * @param zip The zip to set.
     */
    public void setZip(String zip) {
        this.zip = zip;
    }
}
