/*
 * Created on 2005. 1. 3
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
 * VOD카테고리 정보 클래스
 */
public class CategoryInfoBean extends InfoBeanExt {
    private int cuid = 0;					//일련번호
    private String ccode = "";				//카테고리 코드
    private String ctype = "";				//카테고리 타입 (V:VOD, A:AOD)
    private String cparent_code = "";		//상위카테고리
    private String ctitle = "";				//카테고리명
    private int clevel = 50;				//카테고리 순위
    private String cinfo = "";				//카테고리 레벨 (상중하 : A,B,C)
    private String ccategory1 ="";
    private String ccategory2 = "";
    private String ccategory3 = "";
    private String ccategory4 = "";
    private String openflag = "Y";
    
    
    public String getCcategory4() {
		return ccategory4;
	}

	public void setCcategory4(String ccategory4) {
		this.ccategory4 = ccategory4;
	}
	//카테고리 수정시 기존카테고리와의 변경여부를 확인하기 위한 변수
    private String org_category1 = "";
    private String org_category2 = "";
    private String org_category3 = "";
    private String org_category4 = "";
    
    private String memo = ""; //카테고리 설명정보
    

    public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getOpenflag() {
		return openflag;
	}

	public void setOpenflag(String openflag) {
		this.openflag = openflag;
	}
	
    public String getOrg_category4() {
		return org_category4;
	}

	public void setOrg_category4(String org_category4) {
		this.org_category4 = org_category4;
	}

	public CategoryInfoBean() {
        super();
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
     * @return Returns the cinfo.
     */
    public String getCinfo() {
        return cinfo;
    }
    /**
     * @param cinfo The cinfo to set.
     */
    public void setCinfo(String cinfo) {
        this.cinfo = cinfo;
    }
    /**
     * @return Returns the clevel.
     */
    public int getClevel() {
        return clevel;
    }
    /**
     * @param clevel The clevel to set.
     */
    public void setClevel(int clevel) {
        this.clevel = clevel;
    }
    /**
     * @return Returns the cparent_code.
     */
    public String getCparent_code() {
        return cparent_code;
    }
    /**
     * @param cparent_code The cparent_code to set.
     */
    public void setCparent_code(String cparent_code) {
        this.cparent_code = cparent_code;
    }
    /**
     * @return Returns the ctitle.
     */
    public String getCtitle() {
        return ctitle;
    }
    /**
     * @param ctitle The ctitle to set.
     */
    public void setCtitle(String ctitle) {
        this.ctitle = ctitle;
    }
    /**
     * @return Returns the ctype.
     */
    public String getCtype() {
        return ctype;
    }
    /**
     * @param ctype The ctype to set.
     */
    public void setCtype(String ctype) {
        this.ctype = ctype;
    }
    /**
     * @return Returns the cuid.
     */
    public int getCuid() {
        return cuid;
    }
    /**
     * @param cuid The cuid to set.
     */
    public void setCuid(int cuid) {
        this.cuid = cuid;
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
     * @return Returns the ccatetory2.
     */
    public String getCcategory2() {
        return ccategory2;
    }
    /**
     * @param ccatetory2 The ccatetory2 to set.
     */
    public void setCcategory2(String ccategory2) {
        this.ccategory2 = ccategory2;
    }
    /**
     * @return Returns the org_category1.
     */
    public String getOrg_category1() {
        return org_category1;
    }
    /**
     * @param org_category1 The org_category1 to set.
     */
    public void setOrg_category1(String org_category1) {
        this.org_category1 = org_category1;
    }
    /**
     * @return Returns the org_category2.
     */
    public String getOrg_category2() {
        return org_category2;
    }
    /**
     * @param org_category2 The org_category2 to set.
     */
    public void setOrg_category2(String org_category2) {
        this.org_category2 = org_category2;
    }
    /**
     * @return Returns the org_category3.
     */
    public String getOrg_category3() {
        return org_category3;
    }
    /**
     * @param org_category3 The org_category3 to set.
     */
    public void setOrg_category3(String org_category3) {
        this.org_category3 = org_category3;
    }
}
