package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class AdminLoginLog extends InfoBeanExt{
	private int seq = 0;
	private String user_id = "";
	private String user_ip = "";
	private String input_date = "";
	private String input_flag = "";
	private String etc = "";
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_ip() {
		return user_ip;
	}
	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}
	public String getInput_date() {
		return input_date;
	}
	public void setInput_date(String input_date) {
		this.input_date = input_date;
	}
	public String getInput_flag() {
		return input_flag;
	}
	public void setInput_flag(String input_flag) {
		this.input_flag = input_flag;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	@Override
	public String toString() {
		return "AdminLoginLog [seq=" + seq + ", user_id=" + user_id + ", user_ip=" + user_ip + ", input_date="
				+ input_date + ", input_flag=" + input_flag + ", etc=" + etc + "]";
	}
	
	
}
