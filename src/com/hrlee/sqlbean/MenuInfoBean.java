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
 * @author 이 희 락
 *
 * VOD메뉴 정보 클래스
 */
public class MenuInfoBean extends InfoBeanExt {
    private int muid = 0;					//일련번호
    private String mcode = "";				//메뉴 코드
    private String mparent_code = "";		//상위메뉴
    private String mtitle = "";				//메뉴명
    private int mlevel = 9;				//메뉴 순위
    private String minfo = "";				//메뉴 레벨 (상중하 : A,B,C)
    private String mmenu1 ="";
    private String mmenu2 = "";
    private String mmenu3 = "";
    private String mmenu4 = "";
    //메뉴 수정시 기존메뉴와의 변경여부를 확인하기 위한 변수
    private String org_menu1 = "";
    private String org_menu2 = "";
    private String org_menu3 = "";
    private String org_menu4 = "";
    private int sub_count = 0;			//서브 메뉴 카운트
    private int sum_hit1 = 0;
    private int sum_hit2 = 0;
    private int sum_hit3 = 0;
    private int day = 0;
    private int cnt = 0;
    
    private String ctitle ="";
    private int Cyear = 0;
    private int Cmonth = 0;
    private int Cday = 0;
    private String ccode = "";
    
    
    
    
	public String getCcode() {
		return ccode;
	}


	public void setCcode(String ccode) {
		this.ccode = ccode;
	}


	public String getCtitle() {
		return ctitle;
	}


	public void setCtitle(String ctitle) {
		this.ctitle = ctitle;
	}


	public int getCyear() {
		return Cyear;
	}


	public void setCyear(int cyear) {
		Cyear = cyear;
	}


	public int getCmonth() {
		return Cmonth;
	}


	public void setCmonth(int cmonth) {
		Cmonth = cmonth;
	}


	public int getCday() {
		return Cday;
	}


	public void setCday(int cday) {
		Cday = cday;
	}


	public int getCnt() {
		return cnt;
	}


	public void setCnt(int cnt) {
		this.cnt = cnt;
	}


	public int getDay() {
		return day;
	}


	public void setDay(int day) {
		this.day = day;
	}


	public int getSum_hit2() {
		return sum_hit2;
	}


	public void setSum_hit2(int sum_hit2) {
		this.sum_hit2 = sum_hit2;
	}


	public int getSum_hit3() {
		return sum_hit3;
	}


	public void setSum_hit3(int sum_hit3) {
		this.sum_hit3 = sum_hit3;
	}


	public int getSum_hit1() {
		return sum_hit1;
	}


	public void setSum_hit1(int sum_hit1) {
		this.sum_hit1 = sum_hit1;
	}


	public int getSub_count() {
		return sub_count;
	}


	public void setSub_count(int sub_count) {
		this.sub_count = sub_count;
	}


	public String getMmenu4() {
		return mmenu4;
	}


	public void setMmenu4(String mmenu4) {
		this.mmenu4 = mmenu4;
	}


	public String getOrg_menu4() {
		return org_menu4;
	}


	public void setOrg_menu4(String org_menu4) {
		this.org_menu4 = org_menu4;
	}


	private String murl = "";				//메뉴 경로
	private int morder = 1;					//메뉴 정렬 순서
    

    /**
	 * @return the morder
	 */
	public int getMorder() {
		return morder;
	}


	/**
	 * @param morder the morder to set
	 */
	public void setMorder(int morder) {
		this.morder = morder;
	}


	public MenuInfoBean() {
        super();
    }


	/**
	 * @return the mcode
	 */
	public String getMcode() {
		return mcode;
	}


	/**
	 * @param mcode the mcode to set
	 */
	public void setMcode(String mcode) {
		this.mcode = mcode;
	}


	/**
	 * @return the minfo
	 */
	public String getMinfo() {
		return minfo;
	}


	/**
	 * @param minfo the minfo to set
	 */
	public void setMinfo(String minfo) {
		this.minfo = minfo;
	}


	/**
	 * @return the mlevel
	 */
	public int getMlevel() {
		return mlevel;
	}


	/**
	 * @param mlevel the mlevel to set
	 */
	public void setMlevel(int mlevel) {
		this.mlevel = mlevel;
	}


	/**
	 * @return the mmenu1
	 */
	public String getMmenu1() {
		return mmenu1;
	}


	/**
	 * @param mmenu1 the mmenu1 to set
	 */
	public void setMmenu1(String mmenu1) {
		this.mmenu1 = mmenu1;
	}


	/**
	 * @return the mmenu2
	 */
	public String getMmenu2() {
		return mmenu2;
	}


	/**
	 * @param mmenu2 the mmenu2 to set
	 */
	public void setMmenu2(String mmenu2) {
		this.mmenu2 = mmenu2;
	}


	/**
	 * @return the mmenu3
	 */
	public String getMmenu3() {
		return mmenu3;
	}


	/**
	 * @param mmenu3 the mmenu3 to set
	 */
	public void setMmenu3(String mmenu3) {
		this.mmenu3 = mmenu3;
	}


	/**
	 * @return the mparent_code
	 */
	public String getMparent_code() {
		return mparent_code;
	}


	/**
	 * @param mparent_code the mparent_code to set
	 */
	public void setMparent_code(String mparent_code) {
		this.mparent_code = mparent_code;
	}


	/**
	 * @return the mtitle
	 */
	public String getMtitle() {
		return mtitle;
	}


	/**
	 * @param mtitle the mtitle to set
	 */
	public void setMtitle(String mtitle) {
		this.mtitle = mtitle;
	}


	/**
	 * @return the muid
	 */
	public int getMuid() {
		return muid;
	}


	/**
	 * @param muid the muid to set
	 */
	public void setMuid(int muid) {
		this.muid = muid;
	}


	/**
	 * @return the murl
	 */
	public String getMurl() {
		return murl;
	}


	/**
	 * @param murl the murl to set
	 */
	public void setMurl(String murl) {
		this.murl = murl;
	}


	/**
	 * @return the org_menu1
	 */
	public String getOrg_menu1() {
		return org_menu1;
	}


	/**
	 * @param org_menu1 the org_menu1 to set
	 */
	public void setOrg_menu1(String org_menu1) {
		this.org_menu1 = org_menu1;
	}


	/**
	 * @return the org_menu2
	 */
	public String getOrg_menu2() {
		return org_menu2;
	}


	/**
	 * @param org_menu2 the org_menu2 to set
	 */
	public void setOrg_menu2(String org_menu2) {
		this.org_menu2 = org_menu2;
	}


	/**
	 * @return the org_menu3
	 */
	public String getOrg_menu3() {
		return org_menu3;
	}


	/**
	 * @param org_menu3 the org_menu3 to set
	 */
	public void setOrg_menu3(String org_menu3) {
		this.org_menu3 = org_menu3;
	}

}
