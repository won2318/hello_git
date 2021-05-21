package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class TimeMediaInfoBean extends InfoBeanExt  {

	
	int id ;
	String ocode ;
	String day;
	String time;
	String endtime;
	String ccode;
	
	 public TimeMediaInfoBean() {
	        super();
	 }
	 
	@Override
	public String toString() {
		return "TimeMediaInfoBean [id=" + id + ", ocode=" + ocode + ", day="
				+ day + ", time=" + time + ", endtime=" + endtime + ", ccode="
				+ ccode + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TimeMediaInfoBean other = (TimeMediaInfoBean) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOcode() {
		return ocode;
	}
	public void setOcode(String ocode) {
		this.ocode = ocode;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getCcode() {
		return ccode;
	}
	public void setCcode(String ccode) {
		this.ccode = ccode;
	}
	
	
}
