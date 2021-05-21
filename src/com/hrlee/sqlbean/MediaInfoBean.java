/*
 * Created on 2005. 1. 13
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;

import com.yundara.beans.InfoBeanExt;
import com.yundara.util.CharacterSet;
import javax.servlet.http.*;
import com.vodcaster.sqlbean.DirectoryNameManager;


/**
 * @author Choi Hee-Sung
 *
 * VOD컨텐츠 정보 클래스
 */
public class MediaInfoBean extends InfoBeanExt {
    
    // for media Table
    private int mcode 			= 0;		// 미디어 코드
    private String ccode 		= "";		// 카테고리 코드
    private String ccode_name 		= "";		// 카테고리명
    private String mtitle		= "";		// 미디어 제목
    private String msimple		= "";		// 미디어 간략 소개
    private String mcontents	= "";		// 미디어 상세소개
    private int mhit			= 0;		// 총 실행된  횟수
    private int mtotal_count	= 0;		// 서브 미디어 수
    private String msecurity	= "";		// 회원제한
    private String mtype		= "";		// 주문형/실시간 플레그	(1:주문형, 2:실시간)
    private String mview_flag	= "";		// 미디어 숨김 플레그	(0:숨김, 1:보임)
    private String mhtml_flag	= "";		// 상세소개 HTML 플래그  (0:text, 1:html, 2:auto )
    private String mflag        = "";       // 비디오,오디오 플레그 (V:비디오, A:오디오)
    private String ccategory1	= "";		// 대분류 카테고리
    private String ccategory2	= "";		// 중분류 카테고리
    private String ccategory3	= "";		// 소분류 카테고리    
 

    public MediaInfoBean() {
        super();
    }
    /**
     * @return Returns the ccode.
     */
    public String getCcode() {
        return ccode;
    }

    public String getMflag() {
        return mflag;
    }

    public void setMflag(String mflag) {
        this.mflag = mflag;
    }
    
    /**
     * @param ccode The ccode to set.
     */
    public void setCcode(String ccode) {
        this.ccode = ccode;
    }
   
    /**
     * @return Returns the mcontents.
     */
    public String getMcontents() {
        return mcontents;
    }
    /**
     * @param mcontents The mcontents to set.
     */
    public void setMcontents(String mcontents) {
        this.mcontents = mcontents;
    }
    /**
     * @return Returns the mhit.
     */
    public int getMhit() {
        return mhit;
    }
    /**
     * @param mhit The mhit to set.
     */
    public void setMhit(int mhit) {
        this.mhit = mhit;
    }
    /**
     * @return Returns the msecurity.
     */
    public String getMsecurity() {
        return msecurity;
    }
    /**
     * @param msecurity The msecurity to set.
     */
    public void setMsecurity(String msecurity) {
        this.msecurity = msecurity;
    }
    /**
     * @return Returns the msimple.
     */
    public String getMsimple() {
        return msimple;
    }
    /**
     * @param msimple The msimple to set.
     */
    public void setMsimple(String msimple) {
        this.msimple = msimple;
    }
    /**
     * @return Returns the mtitle.
     */
    public String getMtitle() {
        return mtitle;
    }
    /**
     * @param mtitle The mtitle to set.
     */
    public void setMtitle(String mtitle) {
        this.mtitle = mtitle;
    }
    /**
     * @return Returns the mtotal_count.
     */
    public int getMtotal_count() {
        return mtotal_count;
    }
    /**
     * @param mtotal_count The mtotal_count to set.
     */
    public void setMtotal_count(int mtotal_count) {
        this.mtotal_count = mtotal_count;
    }
    /**
     * @return Returns the mtype.
     */
    public String getMtype() {
        return mtype;
    }
    /**
     * @param mtype The mtype to set.
     */
    public void setMtype(String mtype) {
        this.mtype = mtype;
    }
    /**
     * @return Returns the mview_flag.
     */
    public String getMview_flag() {
        return mview_flag;
    }
    /**
     * @param mview_flag The mview_flag to set.
     */
    public void setMview_flag(String mview_flag) {
        this.mview_flag = mview_flag;
    }
    /**
     * @return Returns the mhtml_flag.
     */
    public String getMhtml_flag() {
        return mhtml_flag;
    }
    /**
     * @param mhtml_flag The mhtml_flag to set.
     */
    public void setMhtml_flag(String mhtml_flag) {
        this.mhtml_flag = mhtml_flag;
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

	 public int getMcode() {
        return mcode;
    }
    public void setMcode(int mcode) {
        this.mcode = mcode;
    }

 

}
