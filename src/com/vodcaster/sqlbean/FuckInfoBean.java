package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class FuckInfoBean extends InfoBeanExt {
	private int fuck_id;	//���� ��ȣ
	private String fucks; 	//�弳
	public int getFuck_id() {
		return fuck_id;
	}
	public void setFuck_id(int fuck_id) {
		this.fuck_id = fuck_id;
	}
	public String getFucks() {
		return fucks;
	}
	public void setFucks(String fucks) {
		this.fucks = fucks;
	}
}
