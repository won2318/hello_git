package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class StatVisitInfoBean extends InfoBeanExt {
    private int sv_total = 1234;
    private int sv_today = 10;
    private int sv_yesterday = 125;
    private String sv_day = "";
    
    public StatVisitInfoBean(){}
    
    public int getSv_total() {
		return sv_total;
	}

	public void setSv_total(int sv_total) {
		this.sv_total = sv_total;
	}
	
	public int getSv_today() {
		return sv_today;
	}

	public void setSv_today(int sv_today) {
		this.sv_today = sv_today;
	}
	
	public int getSv_yesterday() {
		return sv_yesterday;
	}

	public void setSv_yesterday(int sv_yesterday) {
		this.sv_yesterday = sv_yesterday;
	}
	
	public String getSv_day() {
		return sv_day;
	}

	public void setSv_day(String sv_day) {
		this.sv_day = sv_day;
	}
}
