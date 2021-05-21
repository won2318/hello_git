package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class BroadScheduleInfoBean extends InfoBeanExt {
	private int bs_id;
	private String bs_title = "";
	private String bs_schedule = "";
	private String bs_contents = "";
	private String bs_html_flag = "1";
	private String bs_uip = "";
	private String bs_uid = "";
	private String bs_udate = "";
	private String bs_rdate = "";

	public BroadScheduleInfoBean(){
        super();
    }

	public String getBs_contents() {
		return bs_contents;
	}

	public void setBs_contents(String bs_contents) {
		this.bs_contents = bs_contents;
	}

	public String getBs_html_flag() {
		return bs_html_flag;
	}

	public void setBs_html_flag(String bs_html_flag) {
		this.bs_html_flag = bs_html_flag;
	}

	public int getBs_id() {
		return bs_id;
	}

	public void setBs_id(int bs_id) {
		this.bs_id = bs_id;
	}

	public String getBs_rdate() {
		return bs_rdate;
	}

	public void setBs_rdate(String bs_rdate) {
		this.bs_rdate = bs_rdate;
	}

	public String getBs_schedule() {
		return bs_schedule;
	}

	public void setBs_schedule(String bs_schedule) {
		this.bs_schedule = bs_schedule;
	}

	public String getBs_title() {
		return bs_title;
	}

	public void setBs_title(String bs_title) {
		this.bs_title = bs_title;
	}

	public String getBs_udate() {
		return bs_udate;
	}

	public void setBs_udate(String bs_udate) {
		this.bs_udate = bs_udate;
	}

	public String getBs_uid() {
		return bs_uid;
	}

	public void setBs_uid(String bs_uid) {
		this.bs_uid = bs_uid;
	}

	public String getBs_uip() {
		return bs_uip;
	}

	public void setBs_uip(String bs_uip) {
		this.bs_uip = bs_uip;
	}
}
