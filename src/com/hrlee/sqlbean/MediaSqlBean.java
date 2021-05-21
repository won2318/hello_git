/*
 * Created on 2005. 1. 13
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;


import javax.servlet.http.*;

import dbcp.SQLBeanExt;

import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.yundara.util.FileUtil;
import com.yundara.util.PageBean;
import com.vodcaster.sqlbean.DirectoryNameManager;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import java.io.*;
import java.util.*;



/**
 * @author Choi Hee-Sung
 *
 * 미디어 DB QUERY 클래스
 */
public class MediaSqlBean  extends SQLBeanExt {

    public MediaSqlBean() {
		super();
	}




    /*****************************************************
    	특정 미디어 시청한 로그정보 저장.<p>
    	<b>작성자</b> : 최희성<br>
    	@return<br>
    	@param vod_id 회원아이디, 회원이름, 미디어코드, 회원아이피, 로그테이블명
    ******************************************************/
    public void insertVodLog(String vod_id, String vod_name, String vod_buseo, String vod_gray, String vod_code, String vod_ip, String ctype) {
  
    	if (vod_code != null && vod_code.length() > 0) {
	        int no = 0;
			String table = "vod_log";
	        String table2 = "vod_media";
	        String hit_query = "";
			hit_query = "update "+table2+" set hitcount=hitcount+1 where ocode='" +vod_code+"'";
	        
			String query = "";
	         if(ctype.equals("R") || ctype.equals("L")) {
	        	table = "live_log";
	        	table2 = "live_media";
	        	hit_query = "update "+table2+" set rhit=rhit+1 where rcode=" +vod_code;
	         }
			
			querymanager.updateEntities(hit_query);
	
	            if(ctype.equals("R")|| ctype.equals("L")) {
	            	query = "insert into "+table+" (ip,vod_id,vod_name, vod_buseo,vod_gray,regDate,vod_code,oflag) values ('" +
		                vod_ip          + "','" +
		                vod_id          + "','" +
		                vod_name        + "','" +
		                vod_buseo        + "','" +
		                vod_gray        + "'," +
		                "now()," + 
		                vod_code        + ",'"+
						ctype        + "')";
	            } else {
	            	query = "insert into "+table+" (ip,vod_id,vod_name, vod_buseo,vod_gray,regDate,vod_code,oflag) values ('" +
	                    vod_ip          + "','" +
	                    vod_id          + "','" +
	                    vod_name        + "','" +
	                    vod_buseo        + "','" +
	                    vod_gray        + "'," +
	                    "now(),'" + 
	                    vod_code        + "','"+
						ctype        + "')";
	            }
	
	
	       querymanager.updateEntities(query);
   
    	}
    }
    
    



    /*****************************************************
    	지정검색에 의해 미디어전체 리스트 출력.<p>
    	<b>작성자</b> : 최희성<br>
    	@return 미디어 목록<br>
    	@param query 검색 QUERY
    ******************************************************/
	public Vector selectMediaListAll(String query){

		Vector rtn = null;

		try {
			rtn = querymanager.selectHashEntities(query);
		}catch(Exception e) {
			System.err.println("selectMediaListAll ex : "+e.getMessage());
		}

		return rtn;
	}



    /*****************************************************
    	지정검색에 의해 미디어전체 리스트 출력.<p>
    	<b>작성자</b> : 최희성<br>
    	@return 미디어 목록<br>
    	@param query 검색 QUERY
    ******************************************************/
	public Vector selectMediaListAllExt(String query){

		Vector rtn = null;

		try {
			rtn = querymanager.selectEntities(query);
		}catch(Exception e) {
			System.err.println("selectMediaListAllExt ex : "+e.getMessage());
		}

		return rtn;
	}
	/*****************************************************
	지정검색에 의해 미디어전체 리스트 출력.<p>
	<b>작성자</b> : 최희성<br>
	@return 미디어 목록<br>
	@param query 검색 QUERY
******************************************************/
public Hashtable selectMediaListAllExtPage(String query, int page, int limit){

	Vector rtn = null;
	Hashtable ht = new Hashtable();
	int totalRecord = 0;
	if(limit < 0){
		limit = 20;
	}
	try {
		Vector v = querymanager.selectEntities(query);
		if(v != null && v.size()>0) totalRecord = v.size();
		if(totalRecord <= 0){
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}
//		rtn = querymanager.selectEntities(query);
		PageBean pb = new PageBean(totalRecord, limit, 20, page);
//		totalrecord,lineperpage,pageperblock,page
		        
				// 해당 페이지의 리스트를 얻는다.
				String rquery ="";
				rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+limit;
				Vector result_v = querymanager.selectHashEntities(rquery);

				
				if(result_v != null && result_v.size() > 0){
					ht.put("LIST",result_v);
					ht.put("PAGE",pb);
				}else{
					//ht.put("LIST", new Hashtable());
					ht.put("LIST", new Vector());
					ht.put("PAGE", new com.yundara.util.PageBean());
				}
				
				
	}catch(Exception e) {
		System.err.println("selectMediaListAllExtPage ex : "+e.getMessage());
	}

	return ht;
}






    /*****************************************************
    	주문형미디어의 하위미디어정보 출력.<p>
    	<b>작성자</b> : 최희성<br>
    	@return 주문형 미디어정보<br>
    	@param ocode 주문형 미디어코드
    ******************************************************/
	public Vector selectOMediaInfo(String ocode){
		if (ocode != null && ocode.length() > 0) {
			String query = "select * from vod_media where del_flag='N' and ocode='" +ocode+"'";
			return querymanager.selectHashEntity(query);
		} else {
			return null;
		}
	}
 
	public Vector selectOMediaInfo_cate(String ocode){
		if (ocode != null && ocode.length() > 0) {
			String query = " select a.*, b.ctitle   from vod_media a inner join category b on  a.ccode=b.ccode  "
						 + " where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' "
						 + " 	   and a.openflag='Y' and b.openflag='Y' and b.ctype='V' "  
						 + " 	   and a.ocode='" +ocode+"'";
			return querymanager.selectHashEntity(query);
		} else {
			return null;
		}
	}

	
	public Vector selectOMediaInfo_admin(String ocode){
		if (ocode != null && ocode.length() > 0) {
		String query = " select a.*   from vod_media a inner join category b on  a.ccode=b.ccode  "
					 + " where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' "
					 + " and b.ctype='V' "
					 + " and a.ocode='" +ocode+"'";
		return querymanager.selectHashEntity(query);
		} else {
			return null;
		}
	}

	
	/**
     * vod_images 썸네일 이미지 목록
     * @param ocode
     * @return Vector
     */
    public Vector selectMediaImages(String ocode) {
    	if (ocode != null && ocode.length() > 0) {
        String query = " SELECT DISTINCT * FROM thumbnail WHERE ocode = '" + ocode + "' ORDER BY time ";
        return querymanager.selectEntities(query);
    	} else {
			return null;
		}
    }

/*****************************************************
		주문형 미디어의 첨부파일 삭제.<p>
		<b>작성자</b> : 주현<br>
		@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
		@param ocode
	******************************************************/
	public int dropOMediaAttach(String ocode) throws Exception{
	
	    String query = "";
	    Vector v = null;
	    int rtn = -1;
 
	
	    if (ocode != null && ocode.length() > 0) { // 삭제시 정보확인
	
	        try {
	
	            // 미디어 화일 삭제
 
	            Vector vt = querymanager.selectEntity("select attach_file from vod_media where   ocode='"+ocode+"'");
	            String old_file = "";
	            if(vt != null && vt.size() > 0){
	            	old_file = String.valueOf(vt.elementAt(0));

					File deleteFile1 = new File(DirectoryNameManager.VODROOT+old_file);
				
					try{  
						deleteFile1.delete(); // 기존 이미지 파일 삭제
					}
					catch(Exception e){ // 
						System.err.println(" 기존 이미지 파일 삭제 Ex : " + e);	
					}
	            }

	            query = "update vod_media set attach_file ='' where     ocode='"+ocode+"'";
	
	            rtn = querymanager.executeQuery(query);
	
	            if(rtn != -1) {
	                return rtn;
	            }else
	                System.err.println("테이블정보수정 실패");
	
	        } catch (Exception e) {
	        	System.err.println(e.getMessage());
	        }
	
	        return rtn;
	
	    } else
	        return -1;
	
	}



    public int executeQuery(String query) {
        return querymanager.updateEntities(query);
    }





	public Hashtable getOMediaListAll(int page, String query){
		int linePerPage = 10;
//		 page정보를 얻는다.
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

        PageBean pb = new PageBean(totalRecord, linePerPage, 10, page);
//totalrecord,lineperpage,pageperblock,page
        
		// 해당 페이지의 리스트를 얻는다.
		String rquery ="";
		rquery = query + " limit "+ (pb.getStartRecord()-1) + ","+linePerPage;

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

    /*****************************************************
    	미디어 리스트 목록 리턴.<p>
    	<b>작성자</b> : 최희성<br>
    	@return <br>
    	@param page 페이지번호, 검색Query
    ******************************************************/
    public Hashtable getMediaList(int page,String query){
        return this.getMediaList(page, query, 10);
    }

    public Vector getMedia(String query){
//    	 page정보를 얻는다.
        
        Vector v = querymanager.selectHashEntity(query);
        return v;
    }
    
	public Hashtable getMediaList(int page,String query, int limit){
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
	

	public Hashtable getMediaListCnt(int page,String query, int limit, String cnt){
		// page정보를 얻는다.
		
		if (cnt != null && cnt.length() > 0) {
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
		} else {
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}
		
	}
	
	public Hashtable getMediaListCnt(int page,String query,String count_query, int limit){
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

        //PageBean pb = new PageBean(totalRecord, limit, 10, page);
		PageBean pb = new PageBean(totalRecord, limit, 5, page);
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
	
	public Hashtable getMediaList(int page,String query, int limit, int pagePerBlock){
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
		if(pagePerBlock < 1) pagePerBlock=10;
        PageBean pb = new PageBean(totalRecord, limit, pagePerBlock, page);
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
	
	public Hashtable getMediaListCnt(int page,String query, String count_query, int limit, int pagePerBlock){
		// page정보를 얻는다.
		
		// page정보를 얻는다.
        Vector v = querymanager.selectEntities(count_query);
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
		if(pagePerBlock < 1) pagePerBlock=10;
        PageBean pb = new PageBean(totalRecord, limit, pagePerBlock, page);
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
	
	public Vector getAllOrderMedia(){
		Vector v= null;
		String query = "select ocode, title from vod_media";
		try {
			v = querymanager.selectEntities(query);
		}catch(Exception e) {
			System.err.println("getAllOrderMedia ex : " + e.getMessage());
		}

		return v;
	}
	


    /**
     * order_media 조회수 증가
     * @param ocode
     */
    public void updateOrdermediaHit(String ocode) {
    	if (ocode != null && ocode.length() > 0) {
	        String query = " UPDATE vod_media SET HitCount = HitCount + 1 WHERE ocode='"+ocode+"' ";
	        querymanager.updateEntities(query);
    	}
    }

   


	 /*****************************************************
    	주문형미디어의 카테고리별 최근 미디어.<p>
    	<b>작성자</b> : 주현<br>
    	@return 주문형 미디어정보<br>
    	@param ocode 주문형 미디어코드
    ******************************************************/
	public Vector selectCode_1(String ccode,  String direction, int vod_level){
		String sub_query = "";
 
		if (ccode != null && ccode.length() > 11 )
		{
			String Code = ccode;
			if (ccode.substring(9,12).equals("000"))
			{
				Code = ccode.substring(0,9);
			}
			if (ccode.substring(6,12).equals("000000"))
			{
				Code = ccode.substring(0,6);
			}
			if (ccode.substring(3,12).equals("000000000"))
			{
				Code = ccode.substring(0,3);
			}

			sub_query =" and ccode like '" +Code + "%'";
		}
		
		if (direction == null || direction.length() <= 0) {
			direction = "desc";
		}
		String query = "select * from vod_media where olevel<="+vod_level+" and del_flag='N' and openflag='Y' "+sub_query+" order by ocode " + direction  +" limit 0,1";

//System.out.println(query);
		return querymanager.selectHashEntity(query);
	}
	
	public Vector selectCode_1_cate(String ccode,  String direction, int vod_level){
		String sub_query = "";
 
		if (ccode != null && ccode.length() > 11 )
		{
			String Code = ccode;
			if (ccode.substring(9,12).equals("000"))
			{
				Code = ccode.substring(0,9);
			}
			if (ccode.substring(6,12).equals("000000"))
			{
				Code = ccode.substring(0,6);
			}
			if (ccode.substring(3,12).equals("000000000"))
			{
				Code = ccode.substring(0,3);
			}

			sub_query =" and a.ccode like '" +Code + "%'";
		}
		if (direction == null || direction.length() <= 0) {
			direction = "desc";
		}
		String query = " select a.* from vod_media a inner join category b on  a.ccode=b.ccode  " +
					   " where a.ccode=b.ccode and a.del_flag='N' and b.del_flag='N' " +
					   "	   and a.openflag='Y' and b.openflag='Y' and b.ctype='V' " +
					   " 	   and a.olevel<=" + vod_level + sub_query +
					   " order by a.mk_date " + direction + " limit 0,1 ";
					   //" order by a.ocode " + direction + " limit 0,1 ";

//System.out.println(query);
		return querymanager.selectHashEntity(query);
	}

	/*****************************************************
    	주문형미디어의 추천(point) 반환<p>
    	<b>작성자</b> : 범희<br>
    	@return 주문형 미디어정보 (point) <br>
    	@param mtype, ocode 주문형 미디어코드
    ******************************************************/
	public Vector selectOMediaPoint(  String ocode) {
		if (ocode != null && ocode.length() > 0) {
			String query = "select recomcount from vod_media where  ocode='"+ocode+"' ";
			//System.out.println(query);
			return querymanager.selectEntity(query);
		} else {
			return null;
		}
	}

///////////////
// 첨부파일 등록
//  주현
///////////////

	public int insertOMediaFile2(OrderMediaInfoBean bean, String ctype) throws Exception{

	    String query = "";
	    String sub_query1 = "";
        String sub_query2 = "";

	    if(!String.valueOf(bean.getOimage()).equals("") && bean.getOimage() != null) { // 수정시 이미지화일을 업로드 할 경우

	        sub_query1 = String.valueOf(bean.getOimage());

	    }
            sub_query2 = "update vod_media set attach_file='";


        query = sub_query2 + sub_query1+ "' where oflag='"+ctype+"' and ocode='" +bean.getOcode()+"' ";
        return querymanager.updateEntities(query);
	}



/////////////
//  추천 하기
// insertBest_count(mtype,Integer.parseInt(ocode),Integer.parseInt(point));
/////////////
	public int insertBest_Point(  String ocode, int point) throws Exception {

	    int rtn = -1;

	    try {
	    	 if( ocode != null && ocode.length()>0 ) {

                String query = "update vod_media set recomcount = recomcount+" +point+" where ocode='"+ocode+"' ";
//System.out.println(query); 
                	rtn = querymanager.updateEntities(query);
 
            }

	    } catch(Exception e) {}

	    return rtn;
	}
	
	
	/*****************************************************
	추천 유무 조회<p>
	<b>작성자</b> : 박종성<br>
	@return <br>
	@param ocode , vod_id
******************************************************/
	
	public Vector selectBest_Point_user(String ocode, String vod_id) {
		if (ocode != null && ocode.length()> 0 && vod_id != null && vod_id.length() > 0) {
			String query = "select * from recommend where ocode='"+ocode+"' and user_id='"+vod_id+"'";
			return querymanager.selectEntities(query);
		} else {
			return null;
		}
	}

    /*****************************************************
	부서, 직위에 해당하는 코드를 가져옴<p>
	<b>작성자</b> : 박종성<br>
	@return tcode(미디어의 group_id와 같음)<br>
	@param deptcode : 부서, gradecode : 직위
******************************************************/
	
	public Vector selectTargetInfoSql(String deptcode, String gradecode){
		if (deptcode != null && deptcode.length()> 0 && gradecode != null && gradecode.length() > 0) {
	        String query = "select distinct tcode from user_target where select_group = '"+deptcode+":ALL' or select_group = '"+deptcode+":"+gradecode+"'";
	        return querymanager.selectEntities(query);
		} else {
			return null;
		}
	}

 
		public Vector selectQuery(String query) {
		    return querymanager.selectEntity(query);
		
		}
		

		  public Vector month_cnt_vod(int year, String month1, String month2) {
 
			  int year2 = year;
			  if (month1 == "01") {
				  year2 = year - 1;
			  }  
			  if (year > 0 && month1 != null && month1.length()> 0 && month2 != null && month2.length() > 0) {
//			     String query = "  select ifnull(B.ohit - ifnull((select ohit from VOD_HITLOG A where YY='"+year2+"' and MM='"+month2+"' and B.ocode =A.ocode),0),0) AS hit, " +
//			     " B.YY, B.MM,C.ocode, C.title, C.del_flag,(select ctitle from category D where D.ccode = C.ccode and D.del_flag='N' and ctype='V' ) ctitle  " +
//			     " from (select * from VOD_HITLOG where YY='"+year+"' and MM='"+month1+"') B, vod_media C " +
//			      
//			     " where B.ocode =C.ocode "+
//			     " order by ccode, B.ocode ";
				  
				  String query =" SELECT IFNULL( "+
				" (SELECT b.ohit FROM vod_hitlog B WHERE B.ocode = AA.ocode AND B.yy='"+year+"' AND B.mm='"+month1+"' ) - " +
				" (SELECT b.ohit FROM vod_hitlog B WHERE B.ocode = AA.ocode AND B.yy='"+year2+"' AND B.mm='"+month2+"' ),0 ) AS hit, "+
				" C.yy, C.mm, AA.ocode, AA.title, AA.del_flag "+
				" FROM vod_hitlog C LEFT JOIN vod_media AA ON C.ocode = AA.ocode WHERE C.yy='"+year+"' AND C.mm='"+month1+"'";
				  
			 		return querymanager.selectEntities(query);
			  } else {
				  return null;
			  }
		 }
		  
		
		 public int month_hit_log(String year , String month) {

		       String query = "";
		       int rtn = 0;
		      
		       if (  year != null && year.length()> 0 && month != null && month.length() > 0) {
		    	try {
		 
		    	     query = "INSERT INTO vod_hitlog (yy, mm,ohit,ocode)SELECT '"+year+"', '"+month+"',vod_media.hitcount,vod_media.ocode FROM vod_media  ";
		    	 
		    	     rtn = querymanager.executeQuery(query);
	    	     
		    	} catch(Exception e) {
		    		System.out.println(e);
		    	}
		    	try {
		    	     query = "INSERT INTO vod_hitlog (yy, mm,ohit,ocode)SELECT '"+year+"', '"+month+"',photo.mhit,photo.ocode FROM photo where pflag='M' ";
			    	 
		    	     rtn = querymanager.executeQuery(query);

		    	} catch(Exception e) {
		    		System.out.println(e);
		    	}
		       }
 
		    	return rtn;
		    }
		  

		    
		  public Vector month_hit_cnt(String year , String month) {
			  if (  year != null && year.length()> 0 && month != null && month.length() > 0) {
			    	 
		        String query = "select idx from vod_hitlog where yy='"+year+"' and mm='"+month+"' ";
		   		return querymanager.selectEntity(query);
			  } else {
				  return null;
			  }
		   }  	
		
		
}
