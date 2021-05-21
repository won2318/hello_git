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
 * 회원테이블 정보 관리 클래스
 */
public class MemberLogBean extends InfoBeanExt {
    private int seq = 0;					//회원코드
    private String userid = "";					//회원아이디
    private String username = "";				//회원이름
    private String update_date = "";				//수정일자
    private String ip = "";			//IP
    private String birthday = "";				//출생년월일
    private String sex = "";				//회원성별 (M:남자   F:여자)
    private String tel = "";				//회원전화번호
    private String mobile = "";				//회원휴대폰
    private String zipcode = "";				//회원 자택 우편번호
    private String addr1 = "";			//회원 자택 주소1
    private String addr2 = "";			//회원자택 주소2
    private String email = "";			//이메일     
    private String deptcode = "";			//부서
    private String etc = "";			//수정한사람
    private String userpwd = "";			//비밀번호 변경
    private String user_out = "";		//회원탈퇴
    private String name = "";		//이름
    
    
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
