package com.hrlee.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class BuseoInfoBean extends InfoBeanExt{
	int binx = 0;				//�μ� �ε���
	String buseo_code = "";		//�μ� �ڵ� 
	String buseo_name = "";		//�μ� �̸�
	String buseo_comment = ""; 	//�μ� ����
	String buseo_sosok = "";	//�Ҽ� �Ⱓ�ڵ� 
	
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
