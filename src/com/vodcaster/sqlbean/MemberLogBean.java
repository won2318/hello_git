/*
 * Created on 2005. 1. 3
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;
import javax.servlet.http.*;
import com.security.SEEDUtil;
/**
 * @author Choi Hee-Sung
 *
 * ȸ�����̺� ���� ���� Ŭ����
 */
public class MemberLogBean extends InfoBeanExt {
    private int seq = 0;					//ȸ���ڵ�
    private String userid = "";					//ȸ�����̵�
    private String username = "";				//ȸ���̸�
    private String update_date = "";				//��������
    private String ip = "";			//IP
    private String birthday = "";				//��������
    private String sex = "";				//ȸ������ (M:����   F:����)
    private String tel = "";				//ȸ����ȭ��ȣ
    private String mobile = "";				//ȸ���޴���
    private String zipcode = "";				//ȸ�� ���� �����ȣ
    private String addr1 = "";			//ȸ�� ���� �ּ�1
    private String addr2 = "";			//ȸ������ �ּ�2
    private String email = "";			//�̸���     
    private String deptcode = "";			//�μ�
    private String etc = "";			//�����ѻ��
    private String userpwd = "";			//��й�ȣ ����
    private String user_out = "";		//ȸ��Ż��
    private String name = "";		//�̸�
    
    
	public String getName() {
		//return name;
		return SEEDUtil.getDecrypt(name);
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		//return username;
		return SEEDUtil.getDecrypt(username);
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDeptcode() {
		return deptcode;
	}
	public void setDeptcode(String deptcode) {
		this.deptcode = deptcode;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getUserpwd() {
		return userpwd;
	}
	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}
	public String getUser_out() {
		return user_out;
	}
	public void setUser_out(String user_out) {
		this.user_out = user_out;
	}
  
 
    
}
