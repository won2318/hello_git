package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class BoardListInfoBean extends InfoBeanExt {
	private int list_id;
	private int board_id;
	private int seq;
	private String list_name = "";
	private String list_title = "";
	private String list_contents = "";
	private String list_email = "";
	private String list_data_file = "";
	private String list_image_file = "";
	private String list_link = "";
	private String list_passwd = "";
	private int list_re_level;
	private int list_read_count;
	private int list_ref;
	private int list_step;
	private String list_html_use = "f";
	private String list_date = "";
	private String main = "";
	
	private String list_image_file2 = "";
	private String list_image_file3 = "";
	private String list_image_file4 = "";
	private String list_image_file5 = "";
	private String list_image_file6 = "";
	private String list_image_file7 = "";
	private String list_image_file8 = "";
	private String list_image_file9 = "";
	private String list_image_file10 = "";
	private String image_text = "";
	private String image_text2 = "";
	private String image_text3 = "";
	private String image_text4 = "";
	private String image_text5 = "";
	private String image_text6 = "";
	private String image_text7 = "";
	private String image_text8 = "";
	private String image_text9 = "";
	private String image_text10 = "";
	
	private String list_open = "";
	private String open_space = "";
	private String ip=""; 
	
	private int event_seq;
	private int event_gread;
	private String list_security="";
	private String user_tel="";
	private String user_email="";
	 
	
	
	public String getUser_tel() {
		return user_tel;
	}

	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public int getEvent_seq() {
		return event_seq;
	}

	public void setEvent_seq(int event_seq) {
		this.event_seq = event_seq;
	}

	public int getEvent_gread() {
		return event_gread;
	}

	public void setEvent_gread(int event_gread) {
		this.event_gread = event_gread;
	}

	public String getList_security() {
		return list_security;
	}

	public void setList_security(String list_security) {
		this.list_security = list_security;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	/**
	 * @return Returns the main.
	 */
	public String getMain() {
		return main;
	}

	/**
	 * @param main The main to set.
	 */
	public void setMain(String main) {
		this.main = main;
	}

	public BoardListInfoBean(){}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public String getList_contents() {
		return list_contents;
	}

	public void setList_contents(String list_contents) {
		this.list_contents = list_contents;
	}

	public String getList_data_file() {
		return list_data_file;
	}

	public void setList_data_file(String list_data_file) {
		this.list_data_file = list_data_file;
	}

	public String getList_date() {
		return list_date;
	}

	public void setList_date(String list_date) {
		this.list_date = list_date;
	}

	public String getList_email() {
		return list_email;
	}

	public void setList_email(String list_email) {
		this.list_email = list_email;
	}

	public String getList_html_use() {
		return list_html_use;
	}

	public void setList_html_use(String list_html_use) {
		this.list_html_use = list_html_use;
	}

	public int getList_id() {
		return list_id;
	}

	public void setList_id(int list_id) {
		this.list_id = list_id;
	}

	public String getList_image_file() {
		return list_image_file;
	}

	public void setList_image_file(String list_image_file) {
		this.list_image_file = list_image_file;
	}

	public String getList_link() {
		return list_link;
	}

	public void setList_link(String list_link) {
		this.list_link = list_link;
	}

	public String getList_name() {
		return list_name;
	}

	public void setList_name(String list_name) {
		this.list_name = list_name;
	}

	public String getList_passwd() {
		return list_passwd;
	}

	public void setList_passwd(String list_passwd) {
		this.list_passwd = list_passwd;
	}

	public int getList_re_level() {
		return list_re_level;
	}

	public void setList_re_level(int list_re_level) {
		this.list_re_level = list_re_level;
	}

	public int getList_read_count() {
		return list_read_count;
	}

	public void setList_read_count(int list_read_count) {
		this.list_read_count = list_read_count;
	}

	public int getList_ref() {
		return list_ref;
	}

	public void setList_ref(int list_ref) {
		this.list_ref = list_ref;
	}

	public int getList_step() {
		return list_step;
	}

	public void setList_step(int list_step) {
		this.list_step = list_step;
	}

	public String getList_title() {
		return list_title;
	}

	public void setList_title(String list_title) {
		this.list_title = list_title;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getList_image_file2() {
		return list_image_file2;
	}

	public void setList_image_file2(String list_image_file2) {
		this.list_image_file2 = list_image_file2;
	}

	public String getList_image_file3() {
		return list_image_file3;
	}

	public void setList_image_file3(String list_image_file3) {
		this.list_image_file3 = list_image_file3;
	}
	
	public String getList_image_file4() {
		return list_image_file4;
	}

	public void setList_image_file4(String list_image_file4) {
		this.list_image_file4 = list_image_file4;
	}
	
	public String getList_image_file5() {
		return list_image_file5;
	}

	public void setList_image_file5(String list_image_file5) {
		this.list_image_file5 = list_image_file5;
	}
	
	public String getList_image_file6() {
		return list_image_file6;
	}

	public void setList_image_file6(String list_image_file6) {
		this.list_image_file6 = list_image_file6;
	}
	
	public String getList_image_file7() {
		return list_image_file7;
	}

	public void setList_image_file7(String list_image_file7) {
		this.list_image_file7 = list_image_file7;
	}
	
	public String getList_image_file8() {
		return list_image_file8;
	}

	public void setList_image_file8(String list_image_file8) {
		this.list_image_file8 = list_image_file8;
	}
	
	public String getList_image_file9() {
		return list_image_file9;
	}

	public void setList_image_file9(String list_image_file9) {
		this.list_image_file9 = list_image_file9;
	}
	
	public String getList_image_file10() {
		return list_image_file10;
	}

	public void setList_image_file10(String list_image_file10) {
		this.list_image_file10 = list_image_file10;
	}

	public String getImage_text() {
		return image_text;
	}

	public void setImage_text(String image_text) {
		this.image_text = image_text;
	}

	public String getImage_text2() {
		return image_text2;
	}

	public void setImage_text2(String image_text2) {
		this.image_text2 = image_text2;
	}

	public String getImage_text3() {
		return image_text3;
	}

	public void setImage_text3(String image_text3) {
		this.image_text3 = image_text3;
	}
	
	public String getImage_text4() {
		return image_text4;
	}

	public void setImage_text4(String image_text4) {
		this.image_text4 = image_text4;
	}
	
	public String getImage_text5() {
		return image_text5;
	}

	public void setImage_text5(String image_text5) {
		this.image_text5 = image_text5;
	}
	
	public String getImage_text6() {
		return image_text6;
	}

	public void setImage_text6(String image_text6) {
		this.image_text6 = image_text6;
	}
	
	public String getImage_text7() {
		return image_text7;
	}

	public void setImage_text7(String image_text7) {
		this.image_text7 = image_text7;
	}
	
	public String getImage_text8() {
		return image_text8;
	}

	public void setImage_text8(String image_text8) {
		this.image_text8 = image_text8;
	}
	
	public String getImage_text9() {
		return image_text9;
	}

	public void setImage_text9(String image_text9) {
		this.image_text9 = image_text9;
	}
	
	public String getImage_text10() {
		return image_text10;
	}

	public void setImage_text10(String image_text10) {
		this.image_text10 = image_text10;
	}

	public String getList_open() {
		return list_open;
	}

	public void setList_open(String list_open) {
		this.list_open = list_open;
	}

	public String getOpen_space() {
		return open_space;
	}

	public void setOpen_space(String open_space) {
		this.open_space = open_space;
	}
}
