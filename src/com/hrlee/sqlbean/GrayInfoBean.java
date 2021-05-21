package com.hrlee.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class GrayInfoBean extends InfoBeanExt {
	int ginx = 0;				//직급 인덱스
	String gray_code = "";		//직급  코드 
	String gray_name = "";		//직급  이름
	String gray_comment = ""; 	//직급 설명
	public int getGinx() {
		return ginx;
	}
	public void setGinx(int ginx) {
		this.ginx = ginx;
	}
	public String getGray_code() {
		return gray_code;
	}
	public void setGray_code(String gray_code) {
		this.gray_code = gray_code;
	}
	public String getGray_comment() {
		return gray_comment;
	}
	public void setGray_comment(String gray_comment) {
		this.gray_comment = gray_comment;
	}
	public String getGray_name() {
		return gray_name;
	}
	public void setGray_name(String gray_name) {
		this.gray_name = gray_name;
	}
}
