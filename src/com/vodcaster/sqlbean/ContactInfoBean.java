package com.vodcaster.sqlbean;

import dbcp.SQLBeanExt;

import java.util.Calendar;
import java.util.Hashtable;
import java.util.Vector;

import com.hrlee.sqlbean.MediaManager;
import com.yundara.beans.InfoBeanExt;
import com.yundara.util.PageBean;

/** 
	�� Ŭ������ ���θ��� index.jsp, login process page���� ����ȸ���� ������(ip)�� �Է�ó�� �մϴ�.
*/
public class ContactInfoBean extends InfoBeanExt{
	int cnt = 0;
	String day ="";
	String flag = "";
	
	int hour = 0;
	String ip = "";
	int dayofWeek =0;
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public int getHour() {
		return hour;
	}
	public void setHour(int hour) {
		this.hour = hour;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getDayofWeek() {
		return dayofWeek;
	}
	public void setDayofWeek(int dayofWeek) {
		this.dayofWeek = dayofWeek;
	}
	
	
	
}