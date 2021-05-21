/*
 * Created on 2005. 1. 13
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;

import com.yundara.beans.InfoBeanExt;
 
/**
 * @author Choi Hee-Sung
 *
 * VOD컨텐츠 정보 클래스
 */
public class EventInfoBean extends InfoBeanExt {
    
    // for media Table

    private int seq 			= 0;		// 순차 코드
    private String title		= "";		// 이미지 제목
	private String sdate	= "";		// 시작일자
	private String edate	= "";		// 종료일자
	private String content	= "";		// 종료일자
	private int people_cnt = 0;		//인원수
	private String insert_dt		= "";		// 등록일 
	private String open_flag		= "";		// 공개구분
	private String event_type		= "";		// 이벤트구분
	private String del_flag		= "";		// 삭제 구분
	private String event_img		= "";		// 이미지 파일
	private int hit = 0 ; // 카운트
	private int event_cnt = 0;		//인원수
	private String rstime1      = "";
	private String rstime2      = "";
	private String rstime3      = "";
	private String rstime4      = "";
	private String rstime5      = "";
	private String retime1      = "";
	private String retime2      = "";
	private String retime3      = "";
	private String retime4      = "";
	private String retime5      = "";
	private String pubdate	= "";		// 추첨일
	private String pubtime1      = "";
	private String pubtime2      = "";
	private String pubtime3      = "";
	public String list_data_file = "";
	
	public String org_data_file = "";
	

    
    public String getOrg_data_file() {
		return org_data_file;
	}



	public void setOrg_data_file(String org_data_file) {
		this.org_data_file = org_data_file;
	}



	public String getList_data_file() {
		return list_data_file;
	}



	public void setList_data_file(String list_data_file) {
		this.list_data_file = list_data_file;
	}



	public EventInfoBean() {
        super();
    }
    
    

	public int getEvent_cnt() {
		return event_cnt;
	}



	public void setEvent_cnt(int event_cnt) {
		this.event_cnt = event_cnt;
	}



	public String getPubdate() {
		return pubdate;
	}



	public void setPubdate(String pubdate) {
		this.pubdate = pubdate;
	}



	public String getPubtime1() {
		return pubtime1;
	}



	public void setPubtime1(String pubtime1) {
		this.pubtime1 = pubtime1;
	}



	public String getPubtime2() {
		return pubtime2;
	}



	public void setPubtime2(String pubtime2) {
		this.pubtime2 = pubtime2;
	}



	public String getPubtime3() {
		return pubtime3;
	}



	public void setPubtime3(String pubtime3) {
		this.pubtime3 = pubtime3;
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

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public String getEdate() {
		return edate;
	}

	public void setEdate(String edate) {
		this.edate = edate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getPeople_cnt() {
		return people_cnt;
	}

	public void setPeople_cnt(int people_cnt) {
		this.people_cnt = people_cnt;
	}

	public String getInsert_dt() {
		return insert_dt;
	}

	public void setInsert_dt(String insert_dt) {
		this.insert_dt = insert_dt;
	}

	public String getOpen_flag() {
		return open_flag;
	}

	public void setOpen_flag(String open_flag) {
		this.open_flag = open_flag;
	}

	public String getEvent_type() {
		return event_type;
	}

	public void setEvent_type(String event_type) {
		this.event_type = event_type;
	}

	public String getDel_flag() {
		return del_flag;
	}

	public void setDel_flag(String del_flag) {
		this.del_flag = del_flag;
	}

	public String getEvent_img() {
		return event_img;
	}

	public void setEvent_img(String event_img) {
		this.event_img = event_img;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public String getRstime1() {
		return rstime1;
	}

	public void setRstime1(String rstime1) {
		this.rstime1 = rstime1;
	}

	public String getRstime2() {
		return rstime2;
	}

	public void setRstime2(String rstime2) {
		this.rstime2 = rstime2;
	}

	public String getRstime3() {
		return rstime3;
	}

	public void setRstime3(String rstime3) {
		this.rstime3 = rstime3;
	}

	public String getRstime4() {
		return rstime4;
	}

	public void setRstime4(String rstime4) {
		this.rstime4 = rstime4;
	}

	public String getRstime5() {
		return rstime5;
	}

	public void setRstime5(String rstime5) {
		this.rstime5 = rstime5;
	}

	public String getRetime1() {
		return retime1;
	}

	public void setRetime1(String retime1) {
		this.retime1 = retime1;
	}

	public String getRetime2() {
		return retime2;
	}

	public void setRetime2(String retime2) {
		this.retime2 = retime2;
	}

	public String getRetime3() {
		return retime3;
	}

	public void setRetime3(String retime3) {
		this.retime3 = retime3;
	}

	public String getRetime4() {
		return retime4;
	}

	public void setRetime4(String retime4) {
		this.retime4 = retime4;
	}

	public String getRetime5() {
		return retime5;
	}

	public void setRetime5(String retime5) {
		this.retime5 = retime5;
	}
 
    
    
}
