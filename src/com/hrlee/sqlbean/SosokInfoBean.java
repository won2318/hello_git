package com.hrlee.sqlbean;
import com.yundara.beans.InfoBeanExt;
public class SosokInfoBean extends InfoBeanExt{
	int sinx = 0;				//�Ҽ� �ε���
	String sosok_code = "";		//�Ҽ� �ڵ� 
	String sosok_name = "";		//�Ҽ� �̸�
	String sosok_comment = ""; 	//�Ҽ� ����
	public int getSinx() {
		return sinx;
	}
	public void setSinx(int sinx) {
		this.sinx = sinx;
	}
	public String getSosok_code() {
		return sosok_code;
	}
	public void setSosok_code(String sosok_code) {
		this.sosok_code = sosok_code;
	}
	public String getSosok_comment() {
		return sosok_comment;
	}
	public void setSosok_comment(String sosok_comment) {
		this.sosok_comment = sosok_comment;
	}
	public String getSosok_name() {
		return sosok_name;
	}
	public void setSosok_name(String sosok_name) {
		this.sosok_name = sosok_name;
	}
}

