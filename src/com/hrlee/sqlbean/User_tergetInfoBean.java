package com.hrlee.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class User_tergetInfoBean extends InfoBeanExt{
	int idx = 0;				//부서 인덱스
	String tcode = "";				// 영상 코드 
	String select_group = "";	//선택 부서 코드
	String etc = "";			//기타 
	

	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	
	public String getTcode() {
		return tcode;
	}
	public void setTcode(String tcode) {
		this.tcode = tcode;
	}
	
	public String getSelect_group() {
		return select_group;
	}
	public void setSelect_group(String select_group) {
		this.select_group = select_group;
	}
	
	public String getEtc() {
		return etc;
	}
	public void setetc(String etc) {
		this.etc = etc;
	}

}
