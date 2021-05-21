package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class FixedUserInfo extends InfoBeanExt{
	private String vod_id;
	private int seq;
	private String gubun;
	private int ocode;
	private String view_date;
	private String yn;
	/**
	 * @return Returns the gubun.
	 */
	public String getGubun() {
		return gubun;
	}
	/**
	 * @param gubun The gubun to set.
	 */
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	/**
	 * @return Returns the ocode.
	 */
	public int getOcode() {
		return ocode;
	}
	/**
	 * @param ocode The ocode to set.
	 */
	public void setOcode(int ocode) {
		this.ocode = ocode;
	}
	/**
	 * @return Returns the seq.
	 */
	public int getSeq() {
		return seq;
	}
	/**
	 * @param seq The seq to set.
	 */
	public void setSeq(int seq) {
		this.seq = seq;
	}
	/**
	 * @return Returns the view_date.
	 */
	public String getView_date() {
		return view_date;
	}
	/**
	 * @param view_date The view_date to set.
	 */
	public void setView_date(String view_date) {
		this.view_date = view_date;
	}
	/**
	 * @return Returns the vod_id.
	 */
	public String getVod_id() {
		return vod_id;
	}
	/**
	 * @param vod_id The vod_id to set.
	 */
	public void setVod_id(String vod_id) {
		this.vod_id = vod_id;
	}
	/**
	 * @return Returns the yn.
	 */
	public String getYn() {
		return yn;
	}
	/**
	 * @param yn The yn to set.
	 */
	public void setYn(String yn) {
		this.yn = yn;
	}

}
