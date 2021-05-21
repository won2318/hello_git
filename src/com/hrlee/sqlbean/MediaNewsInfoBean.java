package com.hrlee.sqlbean;
import com.yundara.beans.InfoBeanExt;
public class MediaNewsInfoBean extends InfoBeanExt{
	int seq = 0;				// 인덱스
	String ocode = "";		//영상코드
	String title = "";		//제목
	String link = ""; 	//링크
	String wdate = ""; 	//등록일
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getOcode() {
		return ocode;
	}
	public void setOcode(String ocode) {
		this.ocode = ocode;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	@Override
	public String toString() {
		return "SosokInfoBean [seq=" + seq + ", ocode=" + ocode + ", title=" + title + ", link=" + link + ", wdate="
				+ wdate + "]";
	}
	 
	
}
