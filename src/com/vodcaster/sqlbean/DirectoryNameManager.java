
	package com.vodcaster.sqlbean;

	import java.util.Vector;

	/*
	 * Created on 2004. 12. 28
	 *
	 * TODO To change the template for this generated file go to
	 * Window - Preferences - Java - Code Style - Code Templates
	 */

	/**
	 * @author Lee Hee Rak
	 * @date 2012-01-05
	 * 클래스들의 기본 정보를 가지고 있는 클래스
	 * 사이트 정보, 절대경로정보, DBPOOL정보, 파일업로드 정보등.
	 */

		public class DirectoryNameManager
		{

		/**
			사이트 URL
		*/
		
		public static String MMS_SERVER = "http://211.210.30.208";  //contents server address
		public static String SERVERNAME = "http://211.210.30.208";
		public static String SILVERLIGHT_SERVERNAME = "http://evod.jbedu.kr";
		public static String SILVERLIGHT_PHYSICAL = "D:/silverlight";

		/**
			업로드 디렉토리의 절대경로
		*/
		
		public static String VODROOT = "//172.16.40.111/eduvod/vodROOT";
		public static String SERVERPATH = VODROOT+"/WEB-INF/classes";
		public static String UPLOAD = VODROOT+"/upload";
		public static String SKIN = VODROOT+"/skin";
	

		
		/**
			db_pool
		*/
		public static String SERVER_NAME = "vod";
		
		public static String DB_NAME ="silverlight";
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

		//생방송 관련 자료
		public static String UPLOAD_RESERVE   = UPLOAD + "/reserve";			    

		
		/**
			이벤트 업로드 디렉토리 설정
		*/	
		public static String UPLOAD_EVENT       = UPLOAD + "/event";
		
	
		
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
		public static String MAIL_SERVER = "211.210.30.208";
		public static String MAIL_FROM = "support@withustech.com";
		public static String MAIL_HOST = "withustech.com";

		

		/**
		vod Configuration
		
		*/
		public static String SV_LIVE_SERVER_IP = "evod.jbedu.kr";
		public static String SV_WM_SERVER_IP = "";
		
		/**
	   	oracle 접속 정보
		**/
		
		public static String oracle_sid="";
		public static String oracle_id="";
		public static String oracle_pw="";

		
	}
