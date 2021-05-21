package com.vodcaster.sqlbean;
import com.yundara.beans.InfoBeanExt;

public class LogInfoBean extends InfoBeanExt{
	int no = 0;	//sequence
	int y = 0;	//year
	int m = 0;
	int d = 0;
	int w = 0;
	String time = "";
	String ip = "";
	String vod_id = "";
	String vod_name = "";
	String vod_code = "";
	/**
	 * @return Returns the d.
	 */
	public int getD() {
		return d;
	}
	/**
	 * @param d The d to set.
	 */
	public void setD(int d) {
		this.d = d;
	}
	/**
	 * @return Returns the ip.
	 */
	public String getIp() {
		return ip;
	}
	/**
	 * @param ip The ip to set.
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}
	/**
	 * @return Returns the m.
	 */
	public int getM() {
		return m;
	}
	/**
	 * @param m The m to set.
	 */
	public void setM(int m) {
		this.m = m;
	}
	/**
	 * @return Returns the no.
	 */
	public int getNo() {
		return no;
	}
	/**
	 * @param no The no to set.
	 */
	public void setNo(int no) {
		this.no = no;
	}
	/**
	 * @return Returns the time.
	 */
	public String getTime() {
		return time;
	}
	/**
	 * @param time The time to set.
	 */
	public void setTime(String time) {
		this.time = time;
	}
	/**
	 * @return Returns the vod_code.
	 */
	public String getVod_code() {
		return vod_code;
	}
	/**
	 * @param vod_code The vod_code to set.
	 */
	public void setVod_code(String vod_code) {
		this.vod_code = vod_code;
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
	 * @return Returns the vod_name.
	 */
	public String getVod_name() {
		return vod_name;
	}
	/**
	 * @param vod_name The vod_name to set.
	 */
	public void setVod_name(String vod_name) {
		this.vod_name = vod_name;
	}
	/**
	 * @return Returns the w.
	 */
	public int getW() {
		return w;
	}
	/**
	 * @param w The w to set.
	 */
	public void setW(int w) {
		this.w = w;
	}
	/**
	 * @return Returns the y.
	 */
	public int getY() {
		return y;
	}
	/**
	 * @param y The y to set.
	 */
	public void setY(int y) {
		this.y = y;
	}
}
