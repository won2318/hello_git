/*
 * Created on 2005. 1. 13
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;

import com.yundara.util.*;

import java.io.File;
import java.util.*;

import javax.servlet.http.*;
import dbcp.SQLBeanExt;

import com.tistory.antop.Thumbnail;
import com.vodcaster.sqlbean.DirectoryNameManager;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
import java.io.*;
import java.awt.Image;
import com.vodcaster.utils.ImageUtil;

/** 
 * @author Choi Hee-Sung
 *
 * 미디어 DB QUERY 클래스
 */
public class LiveSqlBean  extends SQLBeanExt {

    public LiveSqlBean() {
		super();
	}


	public Hashtable getLive_List(int page,String query, int limit){

		// page정보를 얻는다.
        Vector v = querymanager.selectEntities(query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			totalRecord  = v.size();
		}
		if(totalRecord <= 0){
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}
        PageBean pb = new PageBean(totalRecord, limit, 10, page);
		String rquery ="";
		rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
		Vector result_v = querymanager.selectHashEntities(rquery);

		Hashtable ht = new Hashtable();
		if(result_v != null && result_v.size() > 0){
			ht.put("LIST",result_v);
			ht.put("PAGE",pb);
		}else{
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		}

		return ht;
	}
	
	public Hashtable getLive_ListCnt(int page,String query, int limit, String count_query){
 
		
		// page정보를 얻는다.
		// page정보를 얻는다.
	    Vector v = querymanager.selectEntities(count_query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			try{
				totalRecord = Integer.parseInt(String.valueOf(((Vector)(v.elementAt(0))).elementAt(0)));
			}catch(Exception ex){
				Hashtable ht = new Hashtable();
				ht.put("LIST", new Vector());
				ht.put("PAGE", new com.yundara.util.PageBean());
				return ht;
			}
		}

        PageBean pb = new PageBean(totalRecord, limit, 10, page);
		String rquery ="";
		rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
		//System.out.println(rquery);
		Vector result_v = querymanager.selectHashEntities(rquery);
		Hashtable ht = new Hashtable();
		if(result_v != null && result_v.size() > 0){
			ht.put("LIST",result_v);
			ht.put("PAGE",pb);
		}else{
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		}
		return ht;
				
	}
	
/*
 * live list를 쿼리문의 결과에 따라서 Vector 형태로 리턴한다.	
 */
	public Vector getLive_List(String query){

		// page정보를 얻는다.
        Vector v = querymanager.selectEntities(query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			totalRecord  = v.size();
		}
		if(totalRecord <= 0){
			return new Vector();
		}
		
		Vector result_v = querymanager.selectHashEntities(query);

		if(result_v != null && result_v.size() > 0){
			return result_v;
		}else{
			return  new Vector();
		}
	}



public Hashtable getLive_List(int page,String query, int limit, int limit2){

		// page정보를 얻는다.
        Vector v = querymanager.selectEntities(query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			totalRecord  = v.size();
		}
		if(totalRecord <= 0){
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}

        PageBean pb = new PageBean(totalRecord, limit, limit2, page);
		String rquery ="";
		rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
		Vector result_v = querymanager.selectHashEntities(rquery);

		Hashtable ht = new Hashtable();
		if(result_v != null && result_v.size() > 0){
			ht.put("LIST",result_v);
			ht.put("PAGE",pb);
		}else{
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		}

		return ht;
	}

	public Vector selectQuery(String query) {
	    return querymanager.selectEntity(query);

	}



	public Vector getNowLive(){
		
		Vector v = null;
		try {

	        // 현재 상영되는 예약미디어 출력
	        String cur_date = TimeUtil.getDetailTime();
	        cur_date = cur_date.substring(0,19);

	        String query = "select b.rtitle,b.rcode,b.ralias, b.rcontents, b.rlevel, b.rstart_time," +
	        		" b.rend_time, b.inoutflag, b.mobile_stream from live_media as b where b.openflag='Y'" +
	        		" and  (b.rstart_time <= '" +
	                        cur_date+ "') and " + "(b.rend_time >= '" +cur_date+ "')";
	        //System.out.println(query);
	         v = this.selectHashQuery(query);

	        

			//****************** top 스킨 끝 *****************************
			//*********************************************************
		}catch(Exception e) {
			System.err.println("getNowLive ex : "+e.getMessage());
		}

		return v;
	}

	public Vector getNowLive_rcode(String rcode){
		
		Vector v = null;
		if (rcode != null && rcode.length() > 0) {
		try {

	        // 현재 상영되는 예약미디어 출력
	        String cur_date = TimeUtil.getDetailTime();
	        cur_date = cur_date.substring(0,19);

	        String query = "select b.rtitle,b.rcode,b.ralias, b.rcontents, b.inoutflag from live_media as b where  (b.rstart_time <= '" +
	                        cur_date+ "') and " + "(b.rend_time >= '" +cur_date+ "') and rcode='"+rcode+"' ";
	        //System.out.println(query);
	         v = this.selectQuery(query);

	        

			//****************** top 스킨 끝 *****************************
			//*********************************************************
		}catch(Exception e) {
			System.err.println("getNowLive_rcode ex : "+e.getMessage());
		}
		}

		return v;
	}

	public Vector selectHashQuery(String query){

		Vector rtn = null;

		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {
			System.err.println("selectliveHash ex " + e.getMessage());
		}

		return rtn;
	}

	
	/*****************************************************
	사진을 등록합니다.(insert문, 파일 등록)<p>
	<b>작성자</b>       : 호종현<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param req HttpServletRequest정보
	@see QueryManager#updateEntities
	******************************************************/
	public int write(HttpServletRequest req) throws Exception 
	{
        String UPLOAD_PATH = DirectoryNameManager.UPLOAD_RESERVE;
		
		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, 20 * 1024 * 1024, new DefaultFileRenamePolicyITNC21());
	
		String rtitle = "";
		String rcontents = "";
		String rbcast_time = "";
		String ralias = "";
		String mobile_stream = "";
		String rstart_time = "";
		String rend_time = "";
		String rflag = "";
		String rstatus = "";
		String rwdate = "";
		int rlevel = 0;  // 레벨
		String rfilename = "";
		String rid = "";
		String rimagefile = "";
		int property_id = 0;
		String openflag = "";
		String group_id = "";
		String inoutflag = "";
		
		if(multi.getParameter("rtitle") !=null && multi.getParameter("rtitle").length()>0) {
			rtitle = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rtitle")));
		}
		if(multi.getParameter("rcontents") !=null && multi.getParameter("rcontents").length()>0) {
			rcontents = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rcontents")));
		}
		 
		if(multi.getParameter("rlevel") !=null && multi.getParameter("rlevel").length()>0) 
			try{
			rlevel = Integer.parseInt(multi.getParameter("rlevel"));
			}catch(Exception ex){
				rlevel = 0;
			}
		if(multi.getParameter("property_id") !=null && multi.getParameter("property_id").length()>0) {
			try{
				property_id = Integer.parseInt(multi.getParameter("property_id"));
			}catch(Exception ex){
				property_id = 0;
			}
		}

		if(multi.getParameter("rbcast_time") !=null && multi.getParameter("rbcast_time").length()>0) {
			rbcast_time = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rbcast_time")));
		}
		if(multi.getParameter("ralias") !=null && multi.getParameter("ralias").length()>0) {
			ralias = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ralias"));
		}
		if(multi.getParameter("mobile_stream") !=null && multi.getParameter("mobile_stream").length()>0){ 
			mobile_stream = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mobile_stream"));
		}
		
		
		if(multi.getParameter("rstart_time") !=null && multi.getParameter("rstart_time").length()>0) 
			rstart_time = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rstart_time"));
		if(multi.getParameter("rend_time") !=null && multi.getParameter("rend_time").length()>0) 
			rend_time = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rend_time"));
		if(multi.getParameter("rflag") !=null && multi.getParameter("rflag").length()>0) 
			rflag = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rflag"));
		if(multi.getParameter("rstatus") !=null && multi.getParameter("rstatus").length()>0) 
			rstatus = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rstatus"));
		if(multi.getParameter("rwdate") !=null && multi.getParameter("rwdate").length()>0) 
			rwdate = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rwdate"));

		if(multi.getParameter("rid") !=null && multi.getParameter("rid").length()>0) 
			rid = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rid")));
		if(multi.getParameter("openflag") !=null && multi.getParameter("openflag").length()>0) 
			openflag = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag"));
		if(multi.getParameter("group_id") !=null && multi.getParameter("group_id").length()>0) 
			group_id = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("group_id"));
		if(multi.getParameter("inoutflag") !=null && multi.getParameter("inoutflag").length()>0) 
			inoutflag = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("inoutflag"));

		String org_rfilename = "";
		try {
			org_rfilename = CharacterSet.toKorean(multi.getOriginalFileName("rfilename"));
			rfilename = multi.getFilesystemName("rfilename");
			String ext = com.vodcaster.utils.TextUtil.getExtension(rfilename);
			if(!ext.equals("")){
				if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"ATTACH")){
					File del_file_file = new File(UPLOAD_PATH+"/"+rfilename);
					del_file_file.delete(); // 기존 파일삭제
				}
			}else{
				rfilename="";
				org_rfilename = "";
			}
		} catch(Exception e) {
			rfilename="";
			org_rfilename = "";
		}

		
		try {
			 
			rimagefile = multi.getFilesystemName("rimagefile");
			String ext = com.vodcaster.utils.TextUtil.getExtension(rimagefile);
			if(!ext.equals("")){
				if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"IMG")){
					File del_file_file = new File(UPLOAD_PATH+"/"+rimagefile);
					del_file_file.delete(); // 기존 파일삭제
				} else {
					Thumbnail.createThumb(UPLOAD_PATH + "/" + rimagefile, UPLOAD_PATH + "/middle/" + rimagefile, 450, 450);			// 썸네일 생성
		            Thumbnail.createThumb(UPLOAD_PATH + "/" + rimagefile, UPLOAD_PATH + "/small/" + rimagefile, 100, 100);			// 썸네일 생성
				}
			}else{
				rimagefile="";
			 
			}
		} catch(Exception e) {
			rimagefile="";
 
		}

		String query = "insert into live_media (rtitle, rcontents, rbcast_time, ralias, rstart_time, rend_time, rflag," +
				" rstatus, rwdate, rlevel, rfilename, rid, rimagefile, property_id,openflag,group_id,mobile_stream, inoutflag, org_rfilename )" +
				" values('"+rtitle+"', '"+rcontents+"', '"+rbcast_time+"', '"+ralias+"','"+rstart_time+"','"+rend_time
				+"','"+rflag+"', '"+rstatus+"',now() ,'"+rlevel+"', '"+rfilename+"','"+rid+"','"+rimagefile
				+"','"+property_id+"','"+openflag+"','"+group_id+"','"+mobile_stream+"','"+inoutflag+"','"+org_rfilename+"')";

		int iReturn = querymanager.updateEntities(query);
		return iReturn;
	}
	
	
	/*****************************************************
	사진수정.(update, 파일 등록)<p>
	<b>작성자</b>       : 김주현<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param req HttpServletRequest정보
	@see QueryManager#updateEntities
	******************************************************/
	public int update(HttpServletRequest req) throws Exception 
	{
		String seq="";
        String UPLOAD_PATH = DirectoryNameManager.UPLOAD_RMEDIA;
		
		MultipartRequest multi = new MultipartRequest(req, UPLOAD_PATH, 20 * 1024 * 1024, new DefaultFileRenamePolicyITNC21());

		String rtitle = "";
		String rcontents = "";
		String rbcast_time = "";
		String ralias = "";
		String rstart_time = "";
		String rend_time = "";
		String rflag = "";
		String rstatus = "";
		String mobile_stream="";
		String rwdate = "";
		int rlevel = 0;  // 레벨
		String rfilename = "";
		String rid = "";
		String rimagefile = "";
		int property_id = 0;
		String openflag = "";
		String group_id = "";
		String vod_del="";
		String vod_del2="";
		String vod_del3="";
		
		String ocode = "";			//VOD index
		String otitle = "";	//vod title
		
		String ocode2 = "";			//VOD index
		String otitle2 = "";	//vod title
		
		String ocode3 = "";			//VOD index
		String otitle3 = "";	//vod title
		
		String inoutflag= "";

		
		if(multi.getParameter("rcode") !=null && multi.getParameter("rcode").length()>0) {
			seq = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rcode"));
		}else{
			return -1;
		}
			
		String qry = "select rfilename,rimagefile from live_media where rcode="+seq;
		String old_file="";
		String old_image="";
		Vector v = querymanager.selectEntity(qry);
		if(v != null && v.size() > 0) {
			old_file = String.valueOf(v.elementAt(0));
			old_image = String.valueOf(v.elementAt(1));
		}
		
		if(multi.getParameter("rtitle") !=null && multi.getParameter("rtitle").length()>0) {
			rtitle = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rtitle")));
		}
		if(multi.getParameter("rcontents") !=null && multi.getParameter("rcontents").length()>0) {
			rcontents = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rcontents")));
		}
		 
		if(multi.getParameter("rlevel") !=null && multi.getParameter("rlevel").length()>0) {
			try{
				rlevel = Integer.parseInt(multi.getParameter("rlevel"));
			}catch(Exception ex){
				rlevel = 0;
			}
		}
		if(multi.getParameter("property_id") !=null && multi.getParameter("property_id").length()>0) {
			try{
			property_id = Integer.parseInt(multi.getParameter("property_id"));
			}catch(Exception ex){
				property_id = 0;
			}
		}

		if(multi.getParameter("rbcast_time") !=null && multi.getParameter("rbcast_time").length()>0 ) {
			rbcast_time = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rbcast_time")));
		}
		if(multi.getParameter("ralias") !=null  && multi.getParameter("ralias").length()>0) {
			ralias = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ralias"));
		}
		
		if(multi.getParameter("mobile_stream") !=null  && multi.getParameter("mobile_stream").length()>0) 
			mobile_stream = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("mobile_stream"));
		
		
		if(multi.getParameter("rstart_time") !=null && multi.getParameter("rstart_time").length()>0) {
			rstart_time = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rstart_time"));
		}
		if(multi.getParameter("rend_time") !=null && multi.getParameter("rend_time").length()>0){ 
			rend_time = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rend_time"));
		}
		if(multi.getParameter("rflag") !=null && multi.getParameter("rflag").length()>0) 
			rflag = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rflag"));
		if(multi.getParameter("rstatus") !=null && multi.getParameter("rstatus").length()>0) 
			rstatus = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rstatus"));
		if(multi.getParameter("rwdate") !=null && multi.getParameter("rwdate").length()>0) 
			rwdate = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rwdate"));
		if(multi.getParameter("rwdate") !=null && multi.getParameter("rwdate").length()>0 ) 
			rwdate = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rwdate"));
		if(multi.getParameter("rid") !=null && multi.getParameter("rid").length()>0) 
			rid = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("rid")));
		if(multi.getParameter("ocode") !=null && multi.getParameter("ocode").length()>0) 
			ocode = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ocode"));
		if(multi.getParameter("otitle") !=null && multi.getParameter("otitle").length()>0) {
			otitle = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("otitle")));
		}
		
		if(multi.getParameter("ocode2") !=null && multi.getParameter("ocode2").length()>0) 
			ocode2 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ocode2"));
		if(multi.getParameter("otitle2") !=null && multi.getParameter("otitle2").length()>0) {
			otitle2 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("otitle2")));
		}
		
		if(multi.getParameter("ocode3") !=null && multi.getParameter("ocode3").length()>0) 
			ocode3 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("ocode3"));
		if(multi.getParameter("otitle3") !=null && multi.getParameter("otitle3").length()>0) {
			otitle3 = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(multi.getParameter("otitle3")));
		}
		
		if(multi.getParameter("openflag") !=null && multi.getParameter("openflag").length()>0) 
			openflag = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("openflag"));
		if(multi.getParameter("group_id") !=null && multi.getParameter("group_id").length()>0) 
			group_id = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("group_id"));
		if(multi.getParameter("vod_del") !=null && multi.getParameter("vod_del").length()>0) 
			vod_del = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("vod_del"));
		
		if(multi.getParameter("vod_del2") !=null && multi.getParameter("vod_del2").length()>0) 
			vod_del2 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("vod_del2"));
		
		if(multi.getParameter("vod_del3") !=null && multi.getParameter("vod_del3").length()>0) 
			vod_del3 = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("vod_del3"));
		
		
		
		if(multi.getParameter("inoutflag") !=null && multi.getParameter("inoutflag").length()>0) 
			inoutflag = com.vodcaster.utils.TextUtil.getValue(multi.getParameter("inoutflag"));

		
		String org_rfilename = "";
		try {
			org_rfilename = CharacterSet.toKorean(multi.getOriginalFileName("rfilename"));
			rfilename = multi.getFilesystemName("rfilename");
			String ext = com.vodcaster.utils.TextUtil.getExtension(rfilename);
			if(!ext.equals("")){
				if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"ATTACH")){
					File del_file_file = new File(UPLOAD_PATH+"/"+rfilename);
					del_file_file.delete(); // 기존 파일삭제
				}
			}else{
				rfilename="";
				org_rfilename = "";
			}
		} catch(Exception e) {
			rfilename="";
			org_rfilename = "";
		}

		
		try {
			 
			rimagefile = multi.getFilesystemName("rimagefile");
			String ext = com.vodcaster.utils.TextUtil.getExtension(rimagefile);
 		
			if(!ext.equals("")){
				if(!com.vodcaster.utils.TextUtil.getEnableExtension(ext,"IMG")){
				 
					File del_file_file = new File(UPLOAD_PATH+"/"+rimagefile);
					del_file_file.delete(); // 기존 파일삭제
				} else {
				 
					Thumbnail.createThumb(UPLOAD_PATH + "/" + rimagefile, UPLOAD_PATH + "/middle/" + rimagefile, 450, 450);			// 썸네일 생성
		            Thumbnail.createThumb(UPLOAD_PATH + "/" + rimagefile, UPLOAD_PATH + "/small/" + rimagefile, 100, 100);			// 썸네일 생성
				}
			}else{
				rimagefile="";
			 
			}
		} catch(Exception e) {
			System.out.println("rimagefile_error:"+e);
			rimagefile="";
 
		}
 

		String query = 
			"update live_media set "+
			" rtitle ='"+rtitle+"'";
			if (rcontents != null && !rcontents.equals(""))
			{
				query=query+", rcontents= '"+rcontents+"'";
			}

			if (rbcast_time != null && !rbcast_time.equals(""))
			{
				query=query+", rbcast_time= '"+rbcast_time+"'";
			}
			if (ralias != null && !ralias.equals(""))
			{
				query=query+", ralias='" +ralias+"'";
			}
			if (rstart_time != null && !rstart_time.equals(""))
			{
				query=query+", rstart_time='" +rstart_time+"'";
			}
			if (rend_time != null &&  !rend_time.equals(""))
			{
				query=query+", rend_time ='"+rend_time+"'";
			}
			if (rflag != null && !rflag.equals(""))
			{
				query=query+", rflag ='"+rflag+"'";
			}
			if (rstatus != null && !rstatus.equals(""))
			{
				query=query+", rstatus ='"+rstatus+"'";
			}
			if (mobile_stream != null && !mobile_stream.equals(""))
			{
				query=query+", mobile_stream ='"+mobile_stream+"'";
			}
			
			
			if (rlevel>= 0 )
			{
				query=query+", rlevel ="+rlevel;
			}

			if (rfilename != null && !rfilename.equals(""))
			{
				query=query+", rfilename ='"+rfilename+"', org_rfilename = '"+org_rfilename+"'";			
			}
			if (rid != null && !rid.equals(""))
			{
				query=query+", rid ='"+rid+"'";			
			}
			if (rimagefile != null && !rimagefile.equals(""))
			{
				query=query+", rimagefile ='"+rimagefile+"'";			
			}
			if (rlevel> 0 )
			{
				query=query+", property_id ='"+property_id+"'";			
			}
			if (openflag != null && !openflag.equals(""))
			{
				query=query+", openflag ='"+openflag+"'";			
			}
			
			if (ocode != null && !ocode.equals(""))
			{
				query=query+", ocode ='"+ocode+"' ";			
			}
			if (otitle != null && !otitle.equals(""))
			{
				query=query+", otitle ='"+otitle+"' ";			
			}
			if (vod_del != null && vod_del.equals("Y")) {
				query = query+" , ocode='' , otitle='' ";
			}
			
			if (ocode2 != null && !ocode2.equals(""))
			{
				query=query+", ocode2 ='"+ocode2+"' ";			
			}
			if (otitle2 != null && !otitle2.equals(""))
			{
				query=query+", otitle2 ='"+otitle2+"' ";			
			}
			if (vod_del2 != null && vod_del2.equals("Y")) {
				query = query+" , ocode2='' , otitle2='' ";
			}
			
			if (ocode3 != null && !ocode3.equals(""))
			{
				query=query+", ocode3 ='"+ocode3+"' ";			
			}
			if (otitle3 != null && !otitle3.equals(""))
			{
				query=query+", otitle3 ='"+otitle3+"' ";			
			}
			if (vod_del3 != null && vod_del3.equals("Y")) {
				query = query+" , ocode3='' , otitle3='' ";
			}
			
			
			if (inoutflag != null && !inoutflag.equals(""))
			{
				query=query+", inoutflag ='"+inoutflag+"'";			
			}
			if (group_id != null && !group_id.equals(""))
			{
				query=query+", group_id ='"+group_id+"'";
			}
			
			query=query+" where rcode ="+seq;
//System.out.println(query);

		if(querymanager.updateEntities(query) == 1){
			if (rfilename != null && !rfilename.equals("") && old_file != null && !old_file.equals(""))// 기존 파일 삭제
			{
				String old_file_name=UPLOAD_PATH+"/"+old_file;
			
				File old_file_name1 = new File(old_file_name);
				
				try{  
					if(old_file_name1.exists()){
						old_file_name1.delete(); // 기존 이미지 파일 삭제
					}
				}
				catch(Exception e){ // 
					System.err.println(" 기존 파일 삭제 Ex : " + e);	
				}
			}
			if (rimagefile != null && !rimagefile.equals("") && old_image != null && !old_image.equals(""))// 기존 이미지 삭제
			{
				String old_image_name=UPLOAD_PATH+"/"+old_image;
				File old_image_name1 = new File(old_image_name);
				//String old_simage_name=UPLOAD_PATH+"/simg/"+old_image;
				//File old_simage_name1 = new File(old_simage_name);
				try{  
					if(old_image_name1.exists()){
						old_image_name1.delete(); // 기존 이미지 파일 삭제
					}
					//if(old_simage_name1.exists()){
					//	old_simage_name1.delete(); // 기존 이미지 파일 삭제
					//}
				}
				catch(Exception e){ // 
					System.err.println(" 기존 이미지 파일 삭제 Ex : " + e);	
				}
			}
			return 1;
		} else {
			return -1;
		}
		
	}

	
	
	/*****************************************************
	생방송.(update, 파일 삭제)<p>
	<b>작성자</b>       : 김주현<br>
	@return 쿼리문의 실행이 성공이면 row수, 에러가 나면 -1<br>
	@param req HttpServletRequest정보
	@see QueryManager#updateEntities
	******************************************************/

public int deleteLive(String seq) throws Exception 
	{
	
	if (seq != null && seq.length()>0) {

		String qry = "select rfilename,rimagefile from live_media where rcode="+seq;
		String old_file="";
		String old_image="";
		Vector v = querymanager.selectEntity(qry);
		if(v != null && v.size() > 0) {
			old_file = String.valueOf(v.elementAt(0));
			old_image = String.valueOf(v.elementAt(1));
		}

		String query = "delete from live_media where rcode = " + seq;

		if(querymanager.updateEntities(query) == 1){
				if (!old_file.equals("") && old_file.length() > 0 )// 기존 파일 삭제
			{
				String old_file_name=DirectoryNameManager.UPLOAD_RMEDIA+"/"+old_file;
			
				File old_file_name1 = new File(old_file_name);
				
				try{  
					old_file_name1.delete(); // 기존 이미지 파일 삭제
				}
				catch(Exception e){ // 
					System.err.println(" 기존 파일 삭제 Ex : " + e);	
				}
			}
			if (!old_image.equals("") && old_image.length() > 0)// 기존 이미지 삭제
			{
				String old_image_name=DirectoryNameManager.UPLOAD_RMEDIA+"/"+old_image;
				File old_image_name1 = new File(old_image_name);
				String old_simage_name=DirectoryNameManager.UPLOAD_RMEDIA+"/simg/"+old_image;
				File old_simage_name1 = new File(old_simage_name);
				try{  
					old_image_name1.delete(); // 기존 이미지 파일 삭제
					old_simage_name1.delete(); // 기존 이미지 파일 삭제
				}
				catch(Exception e){ // 
					System.err.println(" 기존 이미지 파일 삭제 Ex : " + e);	
				}
			}
			return 1;
		} else {
			return -1;
		}
	} else {
		return -1;
	}

	}

	public int deletefile(String seq, String flag) throws Exception 
	{
		if (seq != null && seq.length() >0 && flag != null && flag.length() > 0) {

		String qry = "select rfilename,rimagefile from live_media where rcode="+seq;
		String old_file="";
		String old_image="";
		Vector v = querymanager.selectEntity(qry);
		if(v != null && v.size() > 0) {
			old_file = String.valueOf(v.elementAt(0));
			old_image = String.valueOf(v.elementAt(1));
		}

		String query = "";


		if (flag != null && flag.equals("img"))
		{
			query = "update live_media set rimagefile ='' where rcode = " + seq;
		}
		else if (flag != null && flag.equals("file"))
		{
			query = "update live_media set rfilename ='', org_rfilename ='' where rcode = " + seq;
		}

		if(query != null && query.length() > 0 && querymanager.updateEntities(query) == 1){
				if (flag.equals("file") && !old_file.equals("") && old_file.length() > 0 )// 기존 파일 삭제
			{
				String old_file_name=DirectoryNameManager.UPLOAD_RMEDIA+"/"+old_file;
			
				File old_file_name1 = new File(old_file_name);
				
				try{  
					old_file_name1.delete(); // 기존 이미지 파일 삭제
				}
				catch(Exception e){ // 
					System.err.println(" 기존 파일 삭제 Ex : " + e);	
				}
			}
			if (flag.equals("img") && !old_image.equals("") && old_image.length() > 0)// 기존 이미지 삭제
			{
				String old_image_name=DirectoryNameManager.UPLOAD_RMEDIA+"/"+old_image;
				File old_image_name1 = new File(old_image_name);
				//String old_simage_name=DirectoryNameManager.UPLOAD_RMEDIA+"/simg/"+old_image;
				//File old_simage_name1 = new File(old_simage_name);
				try{  
					old_image_name1.delete(); // 기존 이미지 파일 삭제
					//old_simage_name1.delete(); // 기존 이미지 파일 삭제
				}
				catch(Exception e){ // 
					System.err.println(" 기존 이미지 파일 삭제 Ex : " + e);	
				}
			}
			return 1;
		} else {
			return -1;
		}
		} else {
			return -1;
		}

	}


    public void updateLive_Hit(String seq) {
    	if(seq != null && !seq.equals("")){
	        String query = " UPDATE live_media SET rhit = rhit + 1 WHERE rcode = " + seq + " ";
	        querymanager.updateEntities(query);
    	}
    }
    

    
    public Hashtable getMediaList(int page, String query, int limit){
		// page정보를 얻는다.
        Vector v = querymanager.selectEntities(query);
		int totalRecord = 0;
		if(v != null && v.size() > 0){
			totalRecord = v.size();
		}
		if(totalRecord <= 0){
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}

        PageBean pb = new PageBean(totalRecord, limit, 10, page);
		String rquery ="";
		rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
		Vector result_v = querymanager.selectHashEntities(rquery);

		Hashtable ht = new Hashtable();
		if(result_v != null && result_v.size() > 0){
			ht.put("LIST",result_v);
			ht.put("PAGE",pb);
		}else{
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		}
		return ht;
	}
    public Hashtable getMediaListCnt(int page, String query, int limit, String cnt){
		// page정보를 얻는다.
    	if (cnt != null && cnt.length() > 0 ) {
			String cnt_query = "select count(cnt."+cnt+") from ( "+ query +" ) as cnt";
	        Vector v = querymanager.selectEntities(cnt_query);
			int totalRecord = 0;
			if(v != null && v.size() > 0){
				totalRecord = Integer.parseInt(String.valueOf(((Vector)(v.elementAt(0))).elementAt(0)));
			} 
			if(totalRecord <= 0){
				Hashtable ht = new Hashtable();
				ht.put("LIST", new Vector());
				ht.put("PAGE", new com.yundara.util.PageBean());
				return ht;
			}
	
	        PageBean pb = new PageBean(totalRecord, limit, 10, page);
			String rquery ="";
			rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
			Vector result_v = querymanager.selectHashEntities(rquery);
	
			Hashtable ht = new Hashtable();
			if(result_v != null && result_v.size() > 0){
				ht.put("LIST",result_v);
				ht.put("PAGE",pb);
			}else{
				ht.put("LIST", new Vector());
				ht.put("PAGE", new com.yundara.util.PageBean());
			}
			return ht;
    	} else {
    		Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
    	}
	}
    
    
}