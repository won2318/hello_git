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
 * VOD������ ���� Ŭ����
 */
public class MediaInfoBean extends InfoBeanExt {
    
    // for media Table
    private int mcode 			= 0;		// �̵�� �ڵ�
    private String ccode 		= "";		// ī�װ� �ڵ�
    private String ccode_name 		= "";		// ī�װ���
    private String mtitle		= "";		// �̵�� ����
    private String msimple		= "";		// �̵�� ���� �Ұ�
    private String mcontents	= "";		// �̵�� �󼼼Ұ�
    private int mhit			= 0;		// �� �����  Ƚ��
    private int mtotal_count	= 0;		// ���� �̵�� ��
    private String msecurity	= "";		// ȸ������
    private String mtype		= "";		// �ֹ���/�ǽð� �÷���	(1:�ֹ���, 2:�ǽð�)
    private String mview_flag	= "";		// �̵�� ���� �÷���	(0:����, 1:����)
    private String mhtml_flag	= "";		// �󼼼Ұ� HTML �÷���  (0:text, 1:html, 2:auto )
    private String mflag        = "";       // ����,����� �÷��� (V:����, A:�����)
    private String ccategory1	= "";		// ��з� ī�װ�
    private String ccategory2	= "";		// �ߺз� ī�װ�
    private String ccategory3	= "";		// �Һз� ī�װ�    
 

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
