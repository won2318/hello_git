/*
 * Created on 2005. 1. 14
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;

import com.yundara.beans.InfoBeanExt;
import com.yundara.util.CharacterSet;
import com.vodcaster.sqlbean.DirectoryNameManager;

import javax.servlet.http.*;
/**
 * @author Choi Hee-Sung
 *
 * 주문형 미디어정보 클래스
 */
public class OrderMediaInfoBean extends InfoBeanExt  {

    private int ocode 			= 0;		// 주문형미디어 코드 (자동 카운팅)
    private int mcode			= 0;		// 미디어테이블   외래키
    private String ccode		= "";		// 카테고리
    private String ccode_name	= "";		// 카테고리명
    private String oplay_time	= "";		// 재생시간 
    private String osimple		= "";		// 간략설명 

    private String ocontents	= "";		// 상세설명 
    private int ohit			= 0;		// 힛트수 
    private String oquality		= "";		// 미디어 품질
    private int olevel			= 0;		// 출력순서 
    private String oflag		= "";		// 비디오, 오디오 플래그 (V:VOD, A:AOD)
    private String ofilename	= "";		// 미디어화일명 , 혹은  링크 (저화질)
    private String ofilename2   = "";       // 미디어화일명, 혹은 링크 (고화질)
    private String ooldfilename	= "";		// 미디어정보 수정시 예전화일정보 저장
    private String ooldfilename2= "";		// 미디어정보 수정시 예전화일정보 저장
    private String ooldfilename3= "";		// 미디어정보 수정시 예전화일정보 저장
    private String owdate		= "";		// 등록일
    private String ohtml_flag	= "";		// 상세설명 html기능 (0:TEXT, 1:HTML, 2:AUTO)
    private String oimagefile1	= "";
    private String oimagefile2	= "";
    private String oimagefile3	= "";

    private String attach_file  = "";       // 첨부화일
    private int auth_level      = 0;        // 미디어 레벨별 접근제한
    private String otitle       = "";       // 주문형 미디어 타이틀

    private int no              = 0;        // 이미지추가시 이미지의 번호
    private String oimage       = "";       // 이미지추가시 이미지의 화일명
    private String ofiletemp    = "";       // 미디어화일 수정시 화일명 임시저장변수
    private String ofiletemp2    = "";       // 미디어화일 수정시 화일명 임시저장변수
    
    private String omedianame = "";
    private String omedianame2 = "";

    private String oomedianame = "";
    private String oomedianame2 = "";

	 private String user_id = "";
	 private String user_pwd = "";
     private String openflag = "";			//공개구분
    
    private int property_id = 0;			//미디어 프로퍼티 ID
    
    private String ccategory1	= "";		// 대분류 카테고리
    private String ccategory2	= "";		// 중분류 카테고리
    private String ccategory3	= "";		// 소분류 카테고리    ]
	private String group_id = "";			// 그룹정보
	private String mk_date = "";			// 촬영일자
    private String omedia_type ="";

 
	private int point = 0;					// 추천

	private String file_pdf	= "";		// pdf 파일   
    private String file_html	= "";		// 강좌
    private String doc_no	= "";		// 문서번호
	private String doc_ver	= "";		// 문서버젼
	
	private String ip	= "";			// 로그 ip
	private String regdate	= "";		// 로그 등록일자
	private String logflag	= "";		// 로그 flag
	
	
	private int id=0;
	private String day ="";
	private String time="";
	private String endtime="";
	
	
	
    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	/**
	 * @return Returns the property_id.
	 */
	public int getProperty_id() {
		return property_id;
	}

	/**
	 * @param property_id The property_id to set.
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getIp() {
        return ip;
    }
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getRegdate() {
        return regdate;
    }
	public void setLogflag(String logflag) {
		this.logflag = logflag;
	}

	public String getLogflag() {
        return logflag;
    }
	public void setProperty_id(int property_id) {
		this.property_id = property_id;
	}

	public String getOoldfilename3() {
        return ooldfilename3;
    }

    public void setOoldfilename3(String ooldfilename3) {
        this.ooldfilename3 = ooldfilename3;
    }

    public String getOtitle() {
        return otitle;
    }

    public String getOfilename2() {
        return ofilename2;
    }

    public void setOfilename2(String ofilename2) {
        this.ofilename2 = ofilename2;
    }

    public void setOtitle(String otitle) {
        this.otitle = otitle;
    }

    public String getAttach_file() {
        return attach_file;
    }

    public void setAttach_file(String attach_file) {
        this.attach_file = attach_file;
    }

    public String getOoldfilename2() {
        return ooldfilename2;
    }

    public void setOoldfilename2(String ooldfilename2) {
        this.ooldfilename2 = ooldfilename2;
    }

    public String getOfiletemp2() {
        return ofiletemp2;
    }

    public void setOfiletemp2(String ofiletemp2) {
        this.ofiletemp2 = ofiletemp2;
    }

    public int getAuth_level() {
        return auth_level;
    }

    public void setAuth_level(int auth_level) {
        this.auth_level = auth_level;
    }

    public OrderMediaInfoBean() {
        super();
    }

    public String getOfiletemp() {
        return ofiletemp;
    }

    public void setOfiletemp(String ofiletemp) {
        this.ofiletemp = ofiletemp;
    }

    public String getOimage() {
        return oimage;
    }

    public void setOimage(String oimage) {
        this.oimage = oimage;
    }

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

  
    /**
     * @return Returns the ocode.
     */
    public int getOcode() {
        return ocode;
    }
    /**
     * @param ocode The ocode to set.
     */
    public void setOcode(int ocode) {
        this.ocode = ocode;
    }
    /**
     * @return Returns the ocontents.
     */
    public String getOcontents() {
        return ocontents;
    }
    /**
     * @param ocontents The ocontents to set.
     */
    public void setOcontents(String ocontents) {
        this.ocontents = ocontents;
    }
    /**
     * @return Returns the ofilename.
     */
    public String getOfilename() {
        return ofilename;
    }
    /**
     * @param ofilename The ofilename to set.
     */
    public void setOfilename(String ofilename) {
        this.ofilename = ofilename;
//        printLog(ofilename);
    }
    /**
     * @return Returns the oflag.
     */
    public String getOflag() {
        return oflag;
    }
    /**
     * @param oflag The oflag to set.
     */
    public void setOflag(String oflag) {
        this.oflag = oflag;
    }
    /**
     * @return Returns the ohit.
     */
    public int getOhit() {
        return ohit;
    }
    /**
     * @param ohit The ohit to set.
     */
    public void setOhit(int ohit) {
        this.ohit = ohit;
    }
    /**
     * @return Returns the ohtml_flag.
     */
    public String getOhtml_flag() {
        return ohtml_flag;
    }
    /**
     * @param ohtml_flag The ohtml_flag to set.
     */
    public void setOhtml_flag(String ohtml_flag) {
        this.ohtml_flag = ohtml_flag;
    }
    /**
     * @return Returns the olevel.
     */
    public int getOlevel() {
        return olevel;
    }
    /**
     * @param olevel The olevel to set.
     */
    public void setOlevel(int olevel) {
        this.olevel = olevel;
    }
    /**
     * @return Returns the oplay_time.
     */
    public String getOplay_time() {
        return oplay_time;
    }
    /**
     * @param oplay_time The oplay_time to set.
     */
    public void setOplay_time(String oplay_time) {
        this.oplay_time = oplay_time;
    }
    /**
     * @return Returns the oquality.
     */
    public String getOquality() {
        return oquality;
    }
    /**
     * @param oquality The oquality to set.
     */
    public void setOquality(String oquality) {
        this.oquality = oquality;
    }
    
    /**
     * @return Returns the owdate.
     */
    public String getOwdate() {
        return owdate;
    }
    /**
     * @param owdate The owdate to set.
     */
    public void setOwdate(String owdate) {
        this.owdate = owdate;
    }
    /**
     * @return Returns the oimagefile1.
     */
    public String getOimagefile1() {
        return oimagefile1;
    }
    /**
     * @param oimagefile1 The oimagefile1 to set.
     */
    public void setOimagefile1(String oimagefile1) {
        this.oimagefile1 = oimagefile1;
    }

	  public String getOimagefile2() {
        return oimagefile2;
    }
    /**
     * @param oimagefile1 The oimagefile1 to set.
     */
    public void setOimagefile2(String oimagefile2) {
        this.oimagefile2 = oimagefile2;
    }

	  public String getOimagefile3() {
        return oimagefile3;
    }
    /**
     * @param oimagefile1 The oimagefile1 to set.
     */
    public void setOimagefile3(String oimagefile3) {
        this.oimagefile3 = oimagefile3;
    }
    
    /**
     * @return Returns the ooldfilename.
     */
    public String getOoldfilename() {
        return ooldfilename;
    }
    /**
     * @param ooldfilename The ooldfilename to set.
     */
    public void setOoldfilename(String ooldfilename) {
        this.ooldfilename = ooldfilename;
    }
    
    public String getOmedianame() {
        return omedianame;
    }

    public void setOmedianame(String omedianame) {
        this.omedianame = omedianame;
    }

    public String getOmedianame2() {
        return omedianame2;
    }

    public void setOmedianame2(String omedianame2) {
        this.omedianame2 = omedianame2;
    }

    public String getOomedianame() {
        return oomedianame;
    }

    public void setOomedianame(String oomedianame) {
        this.oomedianame = oomedianame;
    }

    public String getOomedianame2() {
        return oomedianame2;
    }

    public void setOomedianame2(String oomedianame2) {
        this.oomedianame2 = oomedianame2;
    }

	 public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }
	 public String getUser_pwd() {
        return user_pwd;
    }

    public void setUser_pwd(String user_pwd) {
        this.user_pwd = user_pwd;
    }
	 public String getOpenflag() {
        return openflag;
    }

    public void setOpenflag(String openflag) {
        this.openflag = openflag;
    }

	/**
	 * @return Returns the ccategory1.
	 */
	public String getCcategory1() {
		return ccategory1;
	}

	/**
	 * @param ccategory1 The ccategory1 to set.
	 */
	public void setCcategory1(String ccategory1) {
		this.ccategory1 = ccategory1;
	}

	/**
	 * @return Returns the ccategory2.
	 */
	public String getCcategory2() {
		return ccategory2;
	}

	/**
	 * @param ccategory2 The ccategory2 to set.
	 */
	public void setCcategory2(String ccategory2) {
		this.ccategory2 = ccategory2;
	}

	/**
	 * @return Returns the ccategory3.
	 */
	public String getCcategory3() {
		return ccategory3;
	}

	/**
	 * @param ccategory3 The ccategory3 to set.
	 */
	public void setCcategory3(String ccategory3) {
		this.ccategory3 = ccategory3;
	}


	/**
	 * @return Returns the ccode.
	 */
	public String getCcode() {
		return ccode;
	}

	/**
	 * @param ccode The ccode to set.
	 */
	public void setCcode(String ccode) {
		this.ccode = ccode;
	}

	/**
	 * @return Returns the ccode_name.
	 */
	public String getCcode_name() {
		return ccode_name;
	}

	/**
	 * @param ccode_name The ccode_name to set.
	 */
	public void setCcode_name(String ccode_name) {
		this.ccode_name = ccode_name;
	}

	
	/**
	 * @return Returns the ccode_name.
	 */
	public String getGroup_id() {
		return group_id;
	}

	/**
	 * @param ccode_name The ccode_name to set.
	 */
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}

	/**
	 * @return Returns the ccode_name.
	 */
	public String getMk_date() {
		return mk_date;
	}

	/**
	 * @param ccode_name The ccode_name to set.
	 */
	public void setMk_date(String mk_date) {
		this.mk_date = mk_date;
	}

			/**
	 * @return Returns the ccode_name.
	 */
	public String getOmedia_type() {
		return omedia_type;
	}

	/**
	 * @param ccode_name The ccode_name to set.
	 */
	public void setOmedia_type(String omedia_type) {
		this.omedia_type = omedia_type;
	}

	public String getFile_pdf() {
		return file_pdf;
	}
	public void setFile_pdf(String file_pdf) {
		this.file_pdf = file_pdf;
	}
	public String getFile_html() {
		return file_html;
	}
	public void setFile_html(String file_html) {
		this.file_html = file_html;
	}
	public String getDoc_no() {
		return doc_no;
	}
	public void setDoc_no(String doc_no) {
		this.doc_no = doc_no;
	}
	public String getDoc_ver() {
		return doc_ver;
	}
	public void setDoc_ver(String doc_ver) {
		this.doc_ver = doc_ver;
	}

    /**
     * @return Returns the mcode.
     */
    public int getMcode() {
        return mcode;
    }
    /**
     * @param mcode The mcode to set.
     */
    public void setMcode(int mcode) {
        this.mcode = mcode;
    }
	/**
     * @return Returns the osimple.
     */
    public String getOsimple() {
        return osimple;
    }
    /**
     * @param osimple The osimple to set.
     */
    public void setOsimple(String osimple) {
        this.osimple = osimple;
    }

	 public int getPoint() {
        return point;
    }
    public void setPoint(int point) {
        this.point = point;
    }
}
