package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class WebLogInfo extends InfoBeanExt {
	private int log_seq;
	private String log_ip;
	private String log_date;
	private String log_day;
	private String log_referer;
	private String log_uri;
	private String log_query;
	private String log_agent;
	private String log_sessionID;
	private String log_method;
	
	public int getLog_seq() {
		return log_seq;
	}
	public void setLog_seq(int log_seq) {
		this.log_seq = log_seq;
	}
	public String getLog_ip() {
		return log_ip;
	}
	public void setLog_ip(String log_ip) {
		this.log_ip = log_ip;
	}
	public String getLog_date() {
		return log_date;
	}
	public void setLog_date(String log_date) {
		this.log_date = log_date;
	}
	public String getLog_day() {
		return log_day;
	}
	public void setLog_day(String log_day) {
		this.log_day = log_day;
	}
	public String getLog_uri() {
		return log_uri;
	}
	public void setLog_uri(String log_uri) {
		this.log_uri = log_uri;
	}
	public String getLog_query() {
		return log_query;
	}
	public String getLog_referer() {
		return log_referer;
	}
	public void setLog_referer(String log_referer) {
		this.log_referer = log_referer;
	}
	public void setLog_query(String log_query) {
		this.log_query = log_query;
	}
	public String getLog_agent() {
		return log_agent;
	}
	public void setLog_agent(String log_agent) {
		this.log_agent = log_agent;
	}
	public String getLog_sessionID() {
		return log_sessionID;
	}
	public void setLog_sessionID(String log_sessionID) {
		this.log_sessionID = log_sessionID;
	}
	public String getLog_method() {
		return log_method;
	}
	public void setLog_method(String log_method) {
		this.log_method = log_method;
	}
	
}
