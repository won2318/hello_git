
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
	 * Ŭ�������� �⺻ ������ ������ �ִ� Ŭ����
	 * ����Ʈ ����, ����������, DBPOOL����, ���Ͼ��ε� ������.
	 */

		public class DirectoryNameManager
		{

		/**
			����Ʈ URL
		*/
		//public static Vector v = MediaManager.getInstance().selectQuery("select servername from site_admin");
		//public static String SERVERNAME = String.valueOf(v.elementAt(0));

		public static String MMS_SERVER = "//27.101.101.113:1935";  //�Ϳ��� ���������� (html5 ���� 2019)
		public static String SERVERNAME = "http://localhost:8081";
		public static String SILVERLIGHT_SERVERNAME = "http://newsuwon-content.withustech.com";
		public static String WOWZA_SERVER_IP = "http://61.252.30.4:1935/newsuwon/_definst_/mp4:";

		
		/**
			���ε� ���丮�� ������
		*/
		
		public static String VODROOT = "E:/vod_temp";
		public static String SILVERLIGHT_ROOT = "E:/homepage/Silverlight_newsuwon";
		public static String SERVERPATH = VODROOT+"/WEB-INF/classes";
		public static String UPLOAD = VODROOT+"/upload";
		
		
		/*������ ���ε� ��� */
		public static String VOD_UPLOAD = VODROOT+"/Media";
		
		/**
			db_pool
		*/
		public static String SERVER_NAME = "vod";
		
		public static String DB_NAME ="silverlightmedia_newsuwon";
		public static String DB_USER ="silverlight";
		public static String DB_PASS ="light2007";
			
		
		/**
			�ǹ�����Ʈ �̵�� ���丮 ����
		*/
		public static String SILVERMEDIA ="/ClientBin/Media";

		/**
			�Խ��� ���ε� ���丮 ����
		*/
		public static String UPLOAD_BORADLIST   = UPLOAD + "/board_list";
		public static String UPLOAD_BORADLIST_IMG   = UPLOAD + "/board_list/img";  //����� �̹��� (�Խ��� ����)
		public static String UPLOAD_BORADLIST_IMG_MIDDLE   = UPLOAD + "/board_list/img_middle";  //���� �̹��� (�Խ��� ����)
		public static String UPLOAD_RESERVE   = UPLOAD + "/reserve";			   //����� ���� �ڷ� 
//		public static String UPLOAD_IMG       = "/homepage/dbcp_test/mediaROOT";
		public static String UPLOAD_VOD   = UPLOAD + "/vod_file";
		
		/**
			�̺�Ʈ ���ε� ���丮 ����
		*/	
		public static String UPLOAD_EVENT       = UPLOAD + "/event";
		
		/**
		PDF ���丮 ����
		*/	

		public static String PDF_ROOT       = "/pdf";	//������ġ�� �̺κ� �ּ� ����


		
		/**
			�˾� ���丮 ����
		*/	 
		public static String UPLOAD_POPUP     =  UPLOAD + "/popup";

		/**
		�̵�� ���ε� ���丮 ����
		*/	
		public static String UPLOAD_MEDIA       = VODROOT+"/mediaROOT";
		public static String MEDIA_ROOT         = "/mediaROOT";
		public static String UPLOAD_RMEDIA      = UPLOAD + "/reserve";

		/**
		���ϼ��� ���� 
		*/
		public static String MAIL_SERVER = "61.252.30.1";
		public static String MAIL_FROM = "soome2003@naver.com";
		public static String MAIL_HOST = "withustech.com";

		/**
		FTP ���� (��ȭ�� - ����, wmv - ����, ����, ����)
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
	   	oracle ���� ����
		**/
		
		public static String oracle_sid="";

		public static String oracle_id="";

		public static String oracle_pw="";

		public static String SEED_SECURITY = "vodcaster.co.kr.";
	}
