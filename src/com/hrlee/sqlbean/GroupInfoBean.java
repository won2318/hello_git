package com.hrlee.sqlbean;

import com.yundara.beans.InfoBeanExt;
import com.yundara.util.CharacterSet;
import javax.servlet.http.*;

public class GroupInfoBean extends InfoBeanExt{
	int group_seq=0;		//그룹 순차
	String group_name = "";	//그룹명
	String group_code = "";	//그룹 코드
	String group_comment = ""; //  그룹 코멘트
	/**
	 * @return Returns the group_code.
	 */
	public String getGroup_code() {
		return group_code;
	}
	/**
	 * @param group_code The group_code to set.
	 */
	public void setGroup_code(String group_code) {
		this.group_code = group_code;
	}
	/**
	 * @return Returns the group_name.
	 */
	public String getGroup_name() {
		return group_name;
	}
	/**
	 * @param group_name The group_name to set.
	 */
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	/**
	 * @return Returns the group_seq.
	 */
	public int getGroup_seq() {
		return group_seq;
	}
	/**
	 * @param group_seq The group_seq to set.
	 */
	public void setGroup_seq(int group_seq) {
		this.group_seq = group_seq;
	}

	
	public void setGroup_comment(String group_comment) {
		this.group_comment = group_comment;
	}

	public String getGroup_comment() {
		return group_comment;
	}

}
