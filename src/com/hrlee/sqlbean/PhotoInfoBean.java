/*
 * Created on 2005. 1. 13
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
 * VOD������ ���� Ŭ����
 */
public class PhotoInfoBean extends InfoBeanExt {
    
    // for media Table

    private int seq 			= 0;		// ���� �ڵ�
	private int ocode 			= 0;		// �̹��� �ڵ�
	private String ccode 		= "";		// �̹��� �ڵ�
    private String title		= "";		// �̹��� ����
    private String text1		= "";		// �̹��� ����1
    private String text2		= "";		// �̹��� ����2
	private String text3		= "";		// �̹��� ����3
    private String text4		= "";		// �̹��� ����4
	private String text5		= "";		// �̹��� ����5
    private String text6		= "";		// �̹��� ����6
	private String filename		= "";		// �̹��� ����
    private String msecurity	= "";		// ȸ������
    private String mview_flag	= "";		// ���� �����	(0:����, 1:����)
    private String pflag        = "";       // �̹��� ���� (M ���� �̹��� , P ���� �̹���)
    private String ccategory1	= "";		// ��з� ī�װ�
    private String ccategory2	= "";		// �ߺз� ī�װ�
    private String ccategory3	= "";		// �Һз� ī�װ�    
	private int mhit = 0 ; // ī��Ʈ
	private String path	= "";		// �̹��� ���    
	private String owdate	= "";		// �Կ�����    
	private int plevel = 0;
    
    public PhotoInfoBean() {
        super();
    }

	public int getSeq() {
        return seq;
    }
    public void setSeq(int seq) {
        this.seq = seq;
    }
	public int getOcode() {
        return ocode;
    }
    public void setOcode(int ocode) {
        this.ocode = ocode;
    }
	public String getCcode() {
        return ccode;
    }
    public void setCcode(String ccode) {
        this.ccode = ccode;
    }

	public int getMhit() {
        return mhit;
    }
    public void setMhit(int mhit) {
        this.mhit = mhit;
    }

	public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

	public String getText1() {
        return text1;
    }

    public void setText1(String text1) {
        this.text1 = text1;
    }
	public String getText2() {
        return text2;
    }

    public void setText2(String text2) {
        this.text2 = text2;
    }
	public String getText3() {
        return text3;
    }

    public void setText3(String text3) {
        this.text3 = text3;
    }
	public String getText4() {
        return text4;
    }

    public void setText4(String text4) {
        this.text4 = text4;
    }
	public String getText5() {
        return text5;
    }

    public void setText5(String text5) {
        this.text5 = text5;
    }
	public String getText6() {
        return text6;
    }

    public void setText6(String text6) {
        this.text6 = text6;
    }
    
	public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }


	 public String getMsecurity() {
        return msecurity;
    }
    public void setMsecurity(String msecurity) {
        this.msecurity = msecurity;
    }
	 public String getMview_flag() {
        return mview_flag;
    }
    public void setMview_flag(String mview_flag) {
        this.mview_flag = mview_flag;
    }
	 public String getPflag() {
        return pflag;
    }
    public void setPflag(String pflag) {
        this.pflag = pflag;
    }
	public String getCcategory1() {
        return ccategory1;
    }
    public void setCcategory1(String ccategory1) {
        this.ccategory1 = ccategory1;
    }
    public String getCcategory2() {
        return ccategory2;
    }
    public void setCcategory2(String ccategory2) {
        this.ccategory2 = ccategory2;
    }
    public String getCcategory3() {
        return ccategory3;
    }
    public void setCcategory3(String ccategory3) {
        this.ccategory3 = ccategory3;
    }

	 public String getPath() {
        return path;
    }
    public void setPath(String path) {
        this.path = path;
    }

	public String getOwdate() {
        return owdate;
    }
    public void setOwdate(String owdate) {
        this.owdate = owdate;
    }

	public int getPlevel() {
        return plevel;
    }
    public void setPlevel(int plevel) {
        this.plevel = plevel;
    }


}
