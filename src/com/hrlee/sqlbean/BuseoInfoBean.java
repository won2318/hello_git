package com.hrlee.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class BuseoInfoBean extends InfoBeanExt{
	int binx = 0;				//부서 인덱스
	String buseo_code = "";		//부서 코드 
	String buseo_name = "";		//부서 이름
	String buseo_comment = ""; 	//부서 설명
	String buseo_sosok = "";	//소속 기간코드 
	
	public String getBuseo_sosok() {
		return buseo_sosok;
	}
	public void setBuseo_sosok(String buseo_sosok) {
		this.buseo_sosok = buseo_sosok;
	}
	public int getBinx() {
		return binx;
	}
	public void setBinx(int binx) {
		this.binx = binx;
	}
	public String getBuseo_code() {
		return buseo_code;
	}
	public void setBuseo_code(String buseo_code) {
		this.buseo_code = buseo_code;
	}
	public String getBuseo_comment() {
		return buseo_comment;
	}
	public void setBuseo_comment(String buseo_comment) {
		this.buseo_comment = buseo_comment;
	}
	public String getBuseo_name() {
		return buseo_name;
	}
	public void setBuseo_name(String buseo_name) {
		this.buseo_name = buseo_name;
	}
}
