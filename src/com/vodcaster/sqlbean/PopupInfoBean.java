package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class PopupInfoBean extends InfoBeanExt{

//	popup
    int seq = 0;                
    String title ="";         
    String use_html ="";         
    int width =0;          
    int height =0;        
    String is_visible ="";           
    int pop_level = 0;           
    String pop_link ="";            
    String img_name ="";
	int pos_x = 0;
	int pos_y = 0;
	String rstime ="";            
    String retime ="";
    String pop_flag = "";
    String img_name_mobile ="";
    
    
    
	public String getImg_name_mobile() {
		return img_name_mobile;
	}
	public void setImg_name_mobile(String img_name_mobile) {
		this.img_name_mobile = img_name_mobile;
	}
	public String getPop_flag() {
		return pop_flag;
	}
	public void setPop_flag(String pop_flag) {
		this.pop_flag = pop_flag;
	}
	public String getRstime() {
		return rstime;
	}
	public void setRstime(String rstime) {
		this.rstime = rstime;
	}
	public String getRetime() {
		return retime;
	}
	public void setRetime(String retime) {
		this.retime = retime;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public String getImg_name() {
		return img_name;
	}
	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}
	public String getIs_visible() {
		return is_visible;
	}
	public void setIs_visible(String is_visible) {
		this.is_visible = is_visible;
	}
	public int getPop_level() {
		return pop_level;
	}
	public void setPop_level(int pop_level) {
		this.pop_level = pop_level;
	}
	public String getPop_link() {
		return pop_link;
	}
	public void setPop_link(String pop_link) {
		this.pop_link = pop_link;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUse_html() {
		return use_html;
	}
	public void setUse_html(String use_html) {
		this.use_html = use_html;
	}
	public int getWidth() {
		return width;
	}
	public void setWidth(int width) {
		this.width = width;
	} 
    public int getPos_x() {
		return pos_x;
	}
	public void setPos_x(int pos_x) {
		this.pos_x = pos_x;
	}
	public int getPos_y() {
		return pos_y;
	}
	public void setPos_y(int pos_y) {
		this.pos_y = pos_y;
	}
}
