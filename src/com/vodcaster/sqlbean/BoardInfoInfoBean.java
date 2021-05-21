package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;

public class BoardInfoInfoBean extends InfoBeanExt {
	private int board_id;
	private int seq;
	private String board_title = "";
	private int board_page_line;
	private String board_image_flag = "f";
	private String board_file_flag = "f";
	private String board_link_flag = "f";
	private String board_top_comments = "";
	private String board_footer_comments = "";
	private String board_user_flag = "";
	private int board_priority;
	private String board_date = "";
	private String flag = "";
	private int board_auth_list;
	private int board_auth_read;
	private int board_auth_write;
	private int board_ccode;
	
	public BoardInfoInfoBean(){}

	
	public int getBoard_ccode() {
		return board_ccode;
	}


	public void setBoard_ccode(int board_ccode) {
		this.board_ccode = board_ccode;
	}


	public int getBoard_auth_list() {
		return board_auth_list;
	}

	public void setBoard_auth_list(int board_auth_list) {
		this.board_auth_list = board_auth_list;
	}

	public int getBoard_auth_read() {
		return board_auth_read;
	}

	public void setBoard_auth_read(int board_auth_read) {
		this.board_auth_read = board_auth_read;
	}

	public int getBoard_auth_write() {
		return board_auth_write;
	}

	public void setBoard_auth_write(int board_auth_write) {
		this.board_auth_write = board_auth_write;
	}

	public String getBoard_date() {
		return board_date;
	}

	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}

	public String getBoard_file_flag() {
		return board_file_flag;
	}

	public void setBoard_file_flag(String board_file_flag) {
		this.board_file_flag = board_file_flag;
	}

	public String getBoard_footer_comments() {
		return board_footer_comments;
	}

	public void setBoard_footer_comments(String board_footer_comments) {
		this.board_footer_comments = board_footer_comments;
	}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public String getBoard_image_flag() {
		return board_image_flag;
	}

	public void setBoard_image_flag(String board_image_flag) {
		this.board_image_flag = board_image_flag;
	}

	public String getBoard_link_flag() {
		return board_link_flag;
	}

	public void setBoard_link_flag(String board_link_flag) {
		this.board_link_flag = board_link_flag;
	}

	public int getBoard_page_line() {
		return board_page_line;
	}

	public void setBoard_page_line(int board_page_line) {
		this.board_page_line = board_page_line;
	}

	public int getBoard_priority() {
		return board_priority;
	}

	public void setBoard_priority(int board_priority) {
		this.board_priority = board_priority;
	}

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_top_comments() {
		return board_top_comments;
	}

	public void setBoard_top_comments(String board_top_comments) {
		this.board_top_comments = board_top_comments;
	}

	public String getBoard_user_flag() {
		return board_user_flag;
	}

	public void setBoard_user_flag(String board_user_flag) {
		this.board_user_flag = board_user_flag;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}
}
