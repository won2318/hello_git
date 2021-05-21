package com.hrlee.silver;

import com.yundara.beans.InfoBeanExt;

public class OrderMediaInfoBean extends InfoBeanExt{
	private String ocode 			= "";		// 주문형미디어 코드 , 일시를 이용한 생성
	String ownerid = ""; 						//등록자 계정
	String title = ""; 							//제목
	String playtime = ""; 						//재생시간
	String description = "";					//내용
	String filename = ""; 						//동영상 파일 이름
	int isencoded = 0;							//인코딩 됐음을  표시
	int isended = 0;							//인코딩 시작/종료
	String modelimage = "";						//대표이미지명
	int hitcount = 0;							//재생 카운트
	int recomcount = 0;							//추천 카운트
	int replycount = 0;							//댓글 카운트
	String encodedfilename = "";				//인코딩된 파일명
	String subfolder = "";						//영상파일 저장 경로
	String profilename = "";					//인코딩 프로파일 이름
	String ccode = ""; 							//분류
	int olevel = 0;								//재생 가능 레벨  
 	String del_flag = "N";						//삭제 플래그
	String openflag = "Y";						//공개구분 
	String noencode = "N";
	String tag_info="";
	String linkcopy_flag ="Y";
	String download_flag = "Y";					// 영상 다운로드 설정
	String gcode = "0";
    String attach_file  = "";					// 첨부파일
	String tag_title  = "";    
	String openflag_mobile = "";
	String mobilefilename  = "";
	String mk_date         = "";
	int event_seq       = 0;
	int event_gread     = 0;
	String ctitle = "";       //카테고리 제목
	
	String user_tel = ""; //연락처
	String user_email = ""; //이메일
 
	String content_simple = ""; // 간략설명
	String org_attach_file  = "";					// 원본첨부파일
	String thumbnail_file = ""; // 대표이미지 수동 등록
	
	String open_date         = ""; // 영상 오픈 일자
	
	String close_date         = ""; // 영상 비공개 일자
	
	//맞춤형 서비스 검색 등록
	String gender_type="";
	String age_type="";
	String section_type="";
	String tag_kwd="";
	
	String posi_xy="";
	
	
 
	public String getPosi_xy() {
		return posi_xy;
	}
	public void setPosi_xy(String posi_xy) {
		this.posi_xy = posi_xy;
	}
	public String getGender_type() {
		return gender_type;
	}
	public void setGender_type(String gender_type) {
		this.gender_type = gender_type;
	}
	public String getAge_type() {
		return age_type;
	}
	public void setAge_type(String age_type) {
		this.age_type = age_type;
	}
	public String getSection_type() {
		return section_type;
	}
	public void setSection_type(String section_type) {
		this.section_type = section_type;
	}
	public String getTag_kwd() {
		return tag_kwd;
	}
	public void setTag_kwd(String tag_kwd) {
		this.tag_kwd = tag_kwd;
	}
	public String getClose_date() {
		return close_date;
	}
	public void setClose_date(String close_date) {
		this.close_date = close_date;
	}
	public String getOpen_date() {
		return open_date;
	}
	public void setOpen_date(String open_date) {
		this.open_date = open_date;
	}
	public String getThumbnail_file() {
		return thumbnail_file;
	}
	public void setThumbnail_file(String thumbnail_file) {
		this.thumbnail_file = thumbnail_file;
	}
	int id ;
 	String day;
	String time;
	String endtime;
	String temp1;
	
	String xcode;
	String ycode;
	
	String mediumfilename;
	String encoding_plan;
	
	int memo_cnt = 0; 
	
	public int getMemo_cnt() {
		return memo_cnt;
	}
	public void setMemo_cnt(int memo_cnt) {
		this.memo_cnt = memo_cnt;
	}
	public String getMediumfilename() {
		return mediumfilename;
	}
	public void setMediumfilename(String mediumfilename) {
		this.mediumfilename = mediumfilename;
	}
	public String getEncoding_plan() {
		return encoding_plan;
	}
	public void setEncoding_plan(String encoding_plan) {
		this.encoding_plan = encoding_plan;
	}
	public String getXcode() {
		return xcode;
	}
	public void setXcode(String xcode) {
		this.xcode = xcode;
	}
	public String getYcode() {
		return ycode;
	}
	public void setYcode(String ycode) {
		this.ycode = ycode;
	}
	public String getTemp1() {
		return temp1;
	}
	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getOrg_attach_file() {
		return org_attach_file;
	}
	public void setOrg_attach_file(String org_attach_file) {
		this.org_attach_file = org_attach_file;
	}
	public String getContent_simple() {
		return content_simple;
	}
	public void setContent_simple(String content_simple) {
		this.content_simple = content_simple;
	}
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
	public String getCtitle() {
		return ctitle;
	}
	public void setCtitle(String ctitle) {
		this.ctitle = ctitle;
	}
	public String getAttach_file() {
		return attach_file;
	}
	public void setAttach_file(String attach_file) {
		this.attach_file = attach_file;
	}
	public String getTag_title() {
		return tag_title;
	}
	public void setTag_title(String tag_title) {
		this.tag_title = tag_title;
	}
	public String getOpenflag_mobile() {
		return openflag_mobile;
	}
	public void setOpenflag_mobile(String openflag_mobile) {
		this.openflag_mobile = openflag_mobile;
	}
	public String getMobilefilename() {
		return mobilefilename;
	}
	public void setMobilefilename(String mobilefilename) {
		this.mobilefilename = mobilefilename;
	}
	public String getMk_date() {
		return mk_date;
	}
	public void setMk_date(String mk_date) {
		this.mk_date = mk_date;
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
	public String getDownload_flag() {
		return download_flag;
	}
	public void setDownload_flag(String download_flag) {
		this.download_flag = download_flag;
	}
	public String getNoencode() {
		return noencode;
	}
	public void setNoencode(String noencode) {
		this.noencode = noencode;
	}
	public String getTag_info() {
		return tag_info;
	}
	public void setTag_info(String tag_info) {
		this.tag_info = tag_info;
	}
	public String getLinkcopy_flag() {
		return linkcopy_flag;
	}
	public void setLinkcopy_flag(String linkcopy_flag) {
		this.linkcopy_flag = linkcopy_flag;
	}
	public String getGcode() {
		return gcode;
	}
	public void setGcode(String gcode) {
		this.gcode = gcode;
	}
	public String getOcode() {
		return ocode;
	}
	public void setOcode(String ocode) {
		this.ocode = ocode;
	}
	public String getOwnerid() {
		return ownerid;
	}
	public void setOwnerid(String ownerid) {
		this.ownerid = ownerid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPlaytime() {
		return playtime;
	}
	public void setPlaytime(String playtime) {
		this.playtime = playtime;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getCcode() {
		return ccode;
	}
	public void setCcode(String ccode) {
		this.ccode = ccode;
	}
	public int getIsencoded() {
		return isencoded;
	}
	public void setIsencoded(int isencoded) {
		this.isencoded = isencoded;
	}
	public int getIsended() {
		return isended;
	}
	public void setIsended(int isended) {
		this.isended = isended;
	}
	public String getDel_flag() {
		return del_flag;
	}
	public void setDel_flag(String del_flag) {
		this.del_flag = del_flag;
	}
	public String getOpenflag() {
		return openflag;
	}
	public void setOpenflag(String openflag) {
		this.openflag = openflag;
	}
	public int getOlevel() {
		return olevel;
	}
	public void setOlevel(int olevel) {
		this.olevel = olevel;
	}
	public String getModelimage() {
		return modelimage;
	}
	public void setModelimage(String modelimage) {
		this.modelimage = modelimage;
	}
	public int getHitcount() {
		return hitcount;
	}
	public void setHitcount(int hitcount) {
		this.hitcount = hitcount;
	}
	public int getRecomcount() {
		return recomcount;
	}
	public void setRecomcount(int recomcount) {
		this.recomcount = recomcount;
	}
	public int getReplycount() {
		return replycount;
	}
	public void setReplycount(int replycount) {
		this.replycount = replycount;
	}
	public String getEncodedfilename() {
		return encodedfilename;
	}
	public void setEncodedfilename(String encodedfilename) {
		this.encodedfilename = encodedfilename;
	}
	public String getSubfolder() {
		return subfolder;
	}
	public void setSubfolder(String subfolder) {
		this.subfolder = subfolder;
	}
	public String getProfilename() {
		return profilename;
	}
	public void setProfilename(String profilename) {
		this.profilename = profilename;
	}
	
	
	
}
