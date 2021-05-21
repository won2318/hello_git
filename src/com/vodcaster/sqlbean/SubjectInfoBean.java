package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;


/**
 * @author Choi Hee-Sung
 *
 * VODÄÁÅÙÃ÷ Á¤º¸ Å¬·¡½º
 */
public class SubjectInfoBean extends InfoBeanExt {

    //subject
	String sub_idx = "";
	String sub_title = "";
	String sub_start = "";
	String sub_end = "";
	String sub_person = "";
	String sub_name ="";
	String sub_mf ="";
	String sub_tel ="";
	String sub_email ="";
	String sub_etc ="";
	String sub_flag = "";
	
	//subject_question
	String question_idx = "";
//	String sub_idx = "";
	String question_content = "";
	String question_option = "";
	String question_info = "";
	String question_etc = "";
	String question_num = "";
	String question_image = "";
	
	//subject_ans 
	String ans_idx = "";
//	String question_idx = "";
	String step_flag = "";
	String ans_num = "";
	String ans_content = "";
	String ans_order = "";
	String ans_etc = "";
	
	//subject_user
	String user_idx = "";
	String user_name = "";
	String user_mf = "";
	String user_tel = "";
	String user_email = "";
	String user_etc = "";
	String user_ip = "";
	String user_date = "";
	String event_point = "";
	String info_user = "";
	
	//subject_info
	String info_idx = "";
//	String sub_idx = "";
//	String question_idx = "";
	String info_ip = "";
	String info_date = "";
	String info_other = "";
	String info_order = "";
	String info_etc = "";
//	String user_idx = "";
	String ans = "";
//	String ans_order = "";
	
	public String getAns_content() {
		return ans_content;
	}
	public void setAns_content(String ans_content) {
		this.ans_content = ans_content;
	}
	public String getAns_etc() {
		return ans_etc;
	}
	public void setAns_etc(String ans_etc) {
		this.ans_etc = ans_etc;
	}
	public String getAns_idx() {
		return ans_idx;
	}
	public void setAns_idx(String ans_idx) {
		this.ans_idx = ans_idx;
	}
	public String getAns_num() {
		return ans_num;
	}
	public void setAns_num(String ans_num) {
		this.ans_num = ans_num;
	}
	public String getAns_order() {
		return ans_order;
	}
	public void setAns_order(String ans_order) {
		this.ans_order = ans_order;
	}
	public String getInfo_date() {
		return info_date;
	}
	public void setInfo_date(String info_date) {
		this.info_date = info_date;
	}
	public String getInfo_etc() {
		return info_etc;
	}
	public void setInfo_etc(String info_etc) {
		this.info_etc = info_etc;
	}
	public String getInfo_idx() {
		return info_idx;
	}
	public void setInfo_idx(String info_idx) {
		this.info_idx = info_idx;
	}
	public String getInfo_ip() {
		return info_ip;
	}
	public void setInfo_ip(String info_ip) {
		this.info_ip = info_ip;
	}
	public String getInfo_other() {
		return info_other;
	}
	public void setInfo_other(String info_other) {
		this.info_other = info_other;
	}
	public String getInfo_user() {
		return info_user;
	}
	public void setInfo_user(String info_user) {
		this.info_user = info_user;
	}
	public String getQuestion_content() {
		return question_content;
	}
	public void setQuestion_content(String question_content) {
		this.question_content = question_content;
	}
	public String getQuestion_etc() {
		return question_etc;
	}
	public void setQuestion_etc(String question_etc) {
		this.question_etc = question_etc;
	}
	public String getQuestion_idx() {
		return question_idx;
	}
	public void setQuestion_idx(String question_idx) {
		this.question_idx = question_idx;
	}
	public String getQuestion_info() {
		return question_info;
	}
	public void setQuestion_info(String question_info) {
		this.question_info = question_info;
	}
	public String getQuestion_num() {
		return question_num;
	}
	public void setQuestion_num(String question_num) {
		this.question_num = question_num;
	}
	public String getQuestion_option() {
		return question_option;
	}
	public void setQuestion_option(String question_option) {
		this.question_option = question_option;
	}
	public String getStep_flag() {
		return step_flag;
	}
	public void setStep_flag(String step_flag) {
		this.step_flag = step_flag;
	}
	public String getSub_end() {
		return sub_end;
	}
	public void setSub_end(String sub_end) {
		this.sub_end = sub_end;
	}
	public String getSub_idx() {
		return sub_idx;
	}
	public void setSub_idx(String sub_idx) {
		this.sub_idx = sub_idx;
	}
	public String getSub_person() {
		return sub_person;
	}
	public void setSub_person(String sub_person) {
		this.sub_person = sub_person;
	}
	public String getSub_start() {
		return sub_start;
	}
	public void setSub_start(String sub_start) {
		this.sub_start = sub_start;
	}
	public String getSub_title() {
		return sub_title;
	}
	public void setSub_title(String sub_title) {
		this.sub_title = sub_title;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_etc() {
		return user_etc;
	}
	public void setUser_etc(String user_etc) {
		this.user_etc = user_etc;
	}
	public String getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(String user_idx) {
		this.user_idx = user_idx;
	}
	public String getUser_mf() {
		return user_mf;
	}
	public void setUser_mf(String user_mf) {
		this.user_mf = user_mf;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_tel() {
		return user_tel;
	}
	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}
	public String getAns() {
		return ans;
	}
	public void setAns(String ans) {
		this.ans = ans;
	}
	public String getSub_email() {
		return sub_email;
	}
	public void setSub_email(String sub_email) {
		this.sub_email = sub_email;
	}
	public String getSub_mf() {
		return sub_mf;
	}
	public void setSub_mf(String sub_mf) {
		this.sub_mf = sub_mf;
	}
	public String getSub_name() {
		return sub_name;
	}
	public void setSub_name(String sub_name) {
		this.sub_name = sub_name;
	}
	public String getSub_tel() {
		return sub_tel;
	}
	public void setSub_tel(String sub_tel) {
		this.sub_tel = sub_tel;
	}

	public String getSub_etc() {
		return sub_etc;
	}
	public void setSub_etc(String sub_etc) {
		this.sub_etc = sub_etc;
	}

	public String getSub_flag() {
		return sub_flag;
	}
	public void setSub_flag(String sub_flag) {
		this.sub_flag = sub_flag;
	}
	public String getInfo_order() {
		return info_order;
	}
	public void setInfo_order(String info_order) {
		this.info_order = info_order;
	}
	public String getUser_ip() {
		return user_ip;
	}
	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}
	public String getUser_date() {
		return user_date;
	}
	public void setUser_date(String user_date) {
		this.user_date = user_date;
	}
	public String getEvent_point() {
		return event_point;
	}
	public void setEvent_point(String event_point) {
		this.event_point = event_point;
	}
	public String getQuestion_image() {
		return question_image;
	}
	public void setQuestion_image(String question_image) {
		this.question_image = question_image;
	}


}
