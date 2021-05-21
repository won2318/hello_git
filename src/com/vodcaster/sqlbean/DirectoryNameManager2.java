
	package com.vodcaster.sqlbean;

	import java.util.Vector;

	/*
	 * Created on 2004. 12. 28
	 *
	 * TODO To change the template for this generated file go to
	 * Window - Preferences - Java - Code Style - Code Templates
	 */

	/**
	 * @author Hee-Sung Choi
	 *
	 * 클래스들의 기본 정보를 가지고 있는 클래스
	 * 사이트 정보, 절대경로정보, DBPOOL정보, 파일업로드 정보등.
	 */

		public class DirectoryNameManager
		{

		/**
			사이트 URL
		*/
		//public static Vector v = MediaManager.getInstance().selectQuery("select servername from site_admin");
		//public static String SERVERNAME = String.valueOf(v.elementAt(0));

		public static String MMS_SERVER = "//27.101.101.113:1935";  //와우자 서버아이피 (html5 적용 2019)
		public static String SERVERNAME = "http://localhost:8081";
		public static String SILVERLIGHT_SERVERNAME = "http://newsuwon-content.withustech.com";
		public static String WOWZA_SERVER_IP = "http://61.252.30.4:1935/newsuwon/_definst_/mp4:";

		
		/**
			업로드 디렉토리의 절대경로
		*/
		
		public static String VODROOT = "E:/vod_temp";
		public static String SILVERLIGHT_ROOT = "E:/homepage/Silverlight_newsuwon";
		public static String SERVERPATH = VODROOT+"/WEB-INF/classes";
		public static String UPLOAD = VODROOT+"/upload";
		
		
		/*동영상 업로드 경로 */
		public static String VOD_UPLOAD = VODROOT+"/Media";
		
		/**
			db_pool
		*/
		public static String SERVER_NAME = "vod";
		
		public static String DB_NAME ="silverlightmedia_newsuwon";
		public static String DB_USER ="silverlight";
		public static String DB_PASS ="light2007";
			
		
		/**
			실버라이트 미디어 디렉토리 설정
		*/
		public static String SILVERMEDIA ="/ClientBin/Media";

		/**
			게시판 업로드 디렉토리 설정
		*/
		public static String UPLOAD_BORADLIST   = UPLOAD + "/board_list";
		public static String UPLOAD_BORADLIST_IMG   = UPLOAD + "/board_list/img";  //썸네일 이미지 (게시판 포토)
		public static String UPLOAD_BORADLIST_IMG_MIDDLE   = UPLOAD + "/board_list/img_middle";  //보기 이미지 (게시판 포토)
		public static String UPLOAD_RESERVE   = UPLOAD + "/reserve";			   //생방송 관련 자료 
//		public static String UPLOAD_IMG       = "/homepage/dbcp_test/mediaROOT";
		public static String UPLOAD_VOD   = UPLOAD + "/vod_file";
		
		/**
			이벤트 업로드 디렉토리 설정
		*/	
		public static String UPLOAD_EVENT       = UPLOAD + "/event";
		
		/**
		PDF 디렉토리 설정
		*/	

		public static String PDF_ROOT       = "/pdf";	//서버설치시 이부분 주석 해제


		
		/**
			팝업 디렉토리 설정
		*/	 
		public static String UPLOAD_POPUP     =  UPLOAD + "/popup";

		/**
		미디어 업로드 디렉토리 설정
		*/	
		public static String UPLOAD_MEDIA       = VODROOT+"/mediaROOT";
		public static String MEDIA_ROOT         = "/mediaROOT";
		public static String UPLOAD_RMEDIA      = UPLOAD + "/reserve";

		/**
		메일서버 설정 
		*/
		public static String MAIL_SERVER = "61.252.30.1";
		public static String MAIL_FROM = "soome2003@naver.com";
		public static String MAIL_HOST = "withustech.com";

		/**
		FTP 설정 (고화질 - 강좌, wmv - 영상, 강좌, 음성)
		*/
		public static String FTP_REMOTE_DIR = "/";
		public static String FTP_SERVER = "61.252.30.4";
		public static String FTP_USER = "silver";
		public static String FTP_PASSWD = "light2007!";
		public static String FTP_PORT = "21";

		/**
		vod Configuration
		
		*/
		public static String SV_LIVE_SERVER_IP = "106.255.241.77";
		public static String SV_WM_SERVER_IP = "61.252.30.4";
		
		/**
	   	oracle 접속 정보
		**/
		
		public static String oracle_sid="";

		public static String oracle_id="";

		public static String oracle_pw="";

		public static String SEED_SECURITY = "vodcaster.co.kr.";
	}
