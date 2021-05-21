/*
 * Created on 2005. 1. 13
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hrlee.sqlbean;


import com.vodcaster.utils.WebutilsExt;
import com.vodcaster.multpart.MultipartRequest;
import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
import com.vodcaster.sqlbean.DirectoryNameManager;
import java.io.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import com.yundara.util.CharacterSet;
import com.yundara.util.TextUtil;
import com.yundara.util.TimeUtil;
import javazoom.upload.*;
import java.io.*;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.math.NumberUtils;


/**
 * @author Choi Hee-Sung
 *
 * photo 관리 클래스
 */
public class PhotoManager {

	private static PhotoManager instance;
	
	private PhotoSqlBean sqlbean = null;
    
	private PhotoManager() {
        sqlbean = new PhotoSqlBean();
        //sqlbean.printLog("PhotoManager 인스턴스 생성");
    }
    
	public static PhotoManager getInstance() {
		if(instance == null) {
			synchronized(PhotoManager.class) {
				if(instance == null) {
					instance = new PhotoManager();
				}
			}
		}
		return instance;
	}
    

/*****************************************************
  Photo Main 이미지 정보 목록 리스트
  김주현 
  pflag = M  대표 이미지

******************************************************/

public Hashtable getPhotoListMain(String field, String searchstring,int page, int limit) {

        Hashtable result_ht;

        String query = "";
        String sub_query = "";

        if(!field.equals("") && field != null && !searchstring.equals("") && searchstring != null) {
            if(field.equals("title"))
                sub_query = " and title like '%" +searchstring+ "%' ";
            else if(field.equals("text1"))
                sub_query = " and text1 like '%" +searchstring+ "%' ";
			else if(field.equals("text2"))
                sub_query = " and text2 like '%" +searchstring+ "%' ";
			else if(field.equals("text3"))
                sub_query = " and text3 like '%" +searchstring+ "%' ";
			else if(field.equals("text4"))
                sub_query = " and text4 like '%" +searchstring+ "%' ";
			else if(field.equals("text5"))
                sub_query = " and text5 like '%" +searchstring+ "%' ";
			else if(field.equals("text6"))
                sub_query = " and text6 like '%" +searchstring+ "%' ";
            else if(field.equals("all"))
                sub_query = " and (title like '%" +searchstring+ "%' or text1 like '%" +searchstring+
                        "%' or text2 like '%" +searchstring+ "%' or text3 like '%" +searchstring+ "%' or text4 like '%" +searchstring+ "%' or text5 like '%" +searchstring+ "%' or text6 like '%" +searchstring+ "%') ";
        }

        query = "select * from photo where pflag='M' " +sub_query +" order by seq desc";

        try {
            result_ht = sqlbean.getPhotoList(page, query, limit);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;


    }
	

/*****************************************************
  Photo 하위 이미지 정보 목록 리스트
  김주현 
  ocode (하위 이미지를 위한 코드)
  pflag = P  하위 이미지
******************************************************/
public Hashtable getPhotoListSub(int page, int limit) {

        Hashtable result_ht;

        String query = "";

        query = "select * from photo where pflag='P' order by seq desc";

        try {
            result_ht = sqlbean.getPhotoList(page, query, limit);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;


    }

/*****************************************************
  Photo 선택 이미지 정보 목록 리스트
  김주현 
  ocode (하위 이미지를 위한 코드)
  pflag = P  하위 이미지
******************************************************/
public Vector getPhoto(String seq) {

		if (seq != null && seq.length() > 0) {
		      String query = "select * from photo where seq='"+seq +"' order by seq desc";
		
				return sqlbean.selectQuery(query);
		} else {
			return null;
		}
    }

public Vector getNewPhoto() {


    String query = "select * from photo where pflag='M' and mview_flag='Y' order by seq desc limit 0,1";

		return sqlbean.selectQuery(query);

  }


/*****************************************************
  Photo 선택 이미지 정보 목록 리스트
  김주현 
  ocode (하위 이미지를 위한 코드)
  pflag = P  하위 이미지 , 앞, 뒤 이미지를 위한 순서
******************************************************/

public Vector Photo_view_befor(String ocode, String seq) {

	if (ocode != null && ocode.length() > 0 && seq != null && seq.length() > 0) {
	String	query = "select * from photo where pflag='P' and ocode="+ocode+" and seq < "+seq+" order by seq desc";
	
	return sqlbean.selectQuery(query);
	} else {
		return null;
	}

}

public Vector Photo_view_next(String ocode, String seq) {
	if (ocode != null && ocode.length() > 0 && seq != null && seq.length() > 0) {
		String	query = "select * from photo where pflag='P' and ocode="+ocode+" and seq > "+seq+" order by seq asc";
	
		return sqlbean.selectQuery(query);
	} else {
		return null;
	}
}
/*
 * 사진 그룹의 이전 자료와 다음자료의  
 */

public Hashtable Photo_view_next_before( String seq) {
	Hashtable result_ht;
	if (seq != null && seq.length()> 0) {
		String	query = "select seq from photo where pflag='M' and seq > "+seq+" order by seq asc";
		Vector vtNext = sqlbean.selectQuery(query);
		query = "select seq from photo where pflag='M' and seq < "+seq+" order by seq desc";
		Vector vtBefore = sqlbean.selectQuery(query);
		
		
		result_ht = new Hashtable();
		if(vtNext == null || vtNext.size() <=0){
			 result_ht.put("NEXT", new Vector());
		}else{
			result_ht.put("NEXT", vtNext);
		}
		if(vtBefore == null || vtBefore.size() <=0){
			 result_ht.put("BEFORE", new Vector());
		}else{
			result_ht.put("BEFORE", vtBefore);
		}
	} else {
		result_ht = new Hashtable();
        result_ht.put("LIST", new Vector());
        result_ht.put("PAGE", new com.yundara.util.PageBean());
	}
	return result_ht;

}

/*****************************************************
  Photo 전체 이미지 정보 목록 리스트
  김주현

******************************************************/
public Hashtable getPhotoListAll(int page, int limit) {

        Hashtable result_ht;

        String query = "";
        String sub_query = "";

        query = "select * from photo order by seq desc";

        try {
            result_ht = sqlbean.getPhotoList(page, query, limit);

        }catch (Exception e) {
            result_ht = new Hashtable();
            result_ht.put("LIST", new Vector());
            result_ht.put("PAGE", new com.yundara.util.PageBean());
        }
		return result_ht;


    }





/*****************************************************
    주문형 미디어목록 리턴.<p>
	<b>작성자</b> : 김주현 <br>
	@return 주문형 미디어 목록<br>
	@param ccode 카테고리,시작레코드,종료레코드
	******************************************************/

	public Hashtable getPhotoListAll( String ccode, String pflag, String field, String searchstring, int page, int limit){
       
		Hashtable result_ht;

		String query = "";
        String sub_query = "";
		String code = "";
		String code_like="";

	if (ccode != null && ccode.length() > 0){

			Vector v = sqlbean.selectQuery("select cinfo from category where ctype='P' and ccode='" +ccode+ "'");
			String strtmp = "A";
			if(v != null && v.size() > 0){
				strtmp = String.valueOf(v.elementAt(0));
			}

			if(strtmp.equals("A")) {
				code = ccode.substring(0,3);
			}else if(strtmp.equals("B")) {
				code = ccode.substring(0,6);
			}else if(strtmp.equals("C")) {
				code = ccode.substring(0,9);
			}else if(strtmp.equals("D")) {
				code = ccode;
			}
	}


		if(  field != null && field.length() > 0 &&  searchstring != null && searchstring.length() > 0) {
            if(field.equals("title"))
                sub_query = " and b.title like '%" +searchstring+ "%' ";
            else if(field.equals("text1"))
                sub_query = " and b.text1 like '%" +searchstring+ "%' ";
			else if(field.equals("text2"))
                sub_query = " and b.text2 like '%" +searchstring+ "%' ";
			else if(field.equals("text3"))
                sub_query = " and b.text3 like '%" +searchstring+ "%' ";
			else if(field.equals("text4"))
                sub_query = " and b.text4 like '%" +searchstring+ "%' ";
			else if(field.equals("text5"))
                sub_query = " and b.text5 like '%" +searchstring+ "%' ";
			else if(field.equals("text6"))
                sub_query = " and b.text6 like '%" +searchstring+ "%' ";
            else if(field.equals("all"))
                sub_query = " and (b.title like '%" +searchstring+ "%' or b.text1 like '%" +searchstring+
                        "%' or b.text2 like '%" +searchstring+ "%' or b.text3 like '%" +searchstring+ "%' or b.text4 like '%" +searchstring+ "%' or b.text5 like '%" +searchstring+ "%' or b.text6 like '%" +searchstring+ "%') ";
        }

		if (ccode != null && ccode.length() > 0)
		{
			code_like ="and b.ccode like '"+code+"%'";
		}


        query = "select b.* from  photo as b where b.pflag='"+pflag+"' " +code_like+sub_query +" order by b.seq desc ";

        try {
	        result_ht = sqlbean.getPhotoList(page, query, limit);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	
		return result_ht;

	}

	

	public Hashtable getPhotoListAll2( String ccode, String pflag, String field, String searchstring,String sorder,String direction, int page, int limit, int vod_level){

		
       
		Hashtable result_ht;

		String query = "";
        String sub_query = "";
		String code = "";
		String code_like="";

		String sub_query1="";

		 if(!sorder.equals("")) {
	            sub_query1 = "order by b."+sorder + " " + direction;
	    }else
	        sub_query1 = "order by b.seq desc";
	


		 if (ccode != null && ccode.length() > 0){
	
			Vector v = sqlbean.selectQuery("select cinfo from category where ctype='P' and   ccode='" +ccode+ "'");
			String strtmp = "A";
			if(v != null && v.size() > 0){
				strtmp = String.valueOf(v.elementAt(0));
			}
	
			if(strtmp.equals("A")) {
				code = ccode.substring(0,3);
			}else if(strtmp.equals("B")) {
				code = ccode.substring(0,6);
			}else if(strtmp.equals("C")) {
				code = ccode.substring(0,9);
			}else if(strtmp.equals("D")) {
				code = ccode;
			}
		}


		if( field != null && field.length() > 0 &&  searchstring != null && searchstring.length() > 0) {
            if(field.equals("title"))
                sub_query = " and b.title like '%" +searchstring+ "%' ";
            else if(field.equals("text1"))
                sub_query = " and b.text1 like '%" +searchstring+ "%' ";
			else if(field.equals("text2"))
                sub_query = " and b.text2 like '%" +searchstring+ "%' ";
			else if(field.equals("text3"))
                sub_query = " and b.text3 like '%" +searchstring+ "%' ";
			else if(field.equals("text4"))
                sub_query = " and b.text4 like '%" +searchstring+ "%' ";
			else if(field.equals("text5"))
                sub_query = " and b.text5 like '%" +searchstring+ "%' ";
			else if(field.equals("text6"))
                sub_query = " and b.text6 like '%" +searchstring+ "%' ";
            else if(field.equals("all"))
                sub_query = " and (b.title like '%" +searchstring+ "%' or b.text1 like '%" +searchstring+
                        "%' or b.text2 like '%" +searchstring+ "%' or b.text3 like '%" +searchstring+ "%' or b.text4 like '%" +searchstring+ "%' or b.text5 like '%" +searchstring+ "%' or b.text6 like '%" +searchstring+ "%') ";
        }

		if (ccode != null && ccode.length() > 0)
		{
			code_like ="and b.ccode like '"+code+"%'";
		}


        query = "select b.* from  photo as b where b.mview_flag='Y' and b.plevel <="+vod_level+" and b.pflag='"+pflag+"' " +code_like+sub_query + sub_query1;

//System.out.println(query);

		try {
	        result_ht = sqlbean.getPhotoList(page, query, limit);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	
		return result_ht;

	}

/*****************************************************
    주문형 미디어목록 리턴.<p>
	<b>작성자</b> : 김주현 <br>
	@return 주문형 미디어 목록<br>
	@param ocode 카테고리,시작레코드,종료레코드
	******************************************************/

	public Hashtable getPhotoListOcode( String ocode, String ccode,String pflag, String field, String searchstring, int page, int limit){

		
       
		Hashtable result_ht;

		String query = "";
        String sub_query = "";
		String code = "";
		String code_like="";

		if (ccode != null && ccode.length() > 0){
	
			Vector v = sqlbean.selectQuery("select cinfo from category where  ctype='P' and ccode='" +ccode+ "'");
			String strtmp = "A";
			if(v != null && v.size() > 0){
				strtmp = String.valueOf(v.elementAt(0));
			}
	
			if(strtmp.equals("A")) {
				code = ccode.substring(0,3);
			}else if(strtmp.equals("B")) {
				code = ccode.substring(0,6);
			}else if(strtmp.equals("C")) {
				code = ccode.substring(0,9);
			}else if(strtmp.equals("D")) {
				code = ccode;
			}
		}
	


		if( field != null && field.length() > 0 &&  searchstring != null && searchstring.length() > 0) {
            if(field.equals("title"))
                sub_query = " and b.title like '%" +searchstring+ "%' ";
            else if(field.equals("text1"))
                sub_query = " and b.text1 like '%" +searchstring+ "%' ";
			else if(field.equals("text2"))
                sub_query = " and b.text2 like '%" +searchstring+ "%' ";
			else if(field.equals("text3"))
                sub_query = " and b.text3 like '%" +searchstring+ "%' ";
			else if(field.equals("text4"))
                sub_query = " and b.text4 like '%" +searchstring+ "%' ";
			else if(field.equals("text5"))
                sub_query = " and b.text5 like '%" +searchstring+ "%' ";
			else if(field.equals("text6"))
                sub_query = " and b.text6 like '%" +searchstring+ "%' ";
            else if(field.equals("all"))
                sub_query = " and (b.title like '%" +searchstring+ "%' or b.text1 like '%" +searchstring+
                        "%' or b.text2 like '%" +searchstring+ "%' or b.text3 like '%" +searchstring+ "%' or b.text4 like '%" +searchstring+ "%' or b.text5 like '%" +searchstring+ "%' or b.text6 like '%" +searchstring+ "%') ";
        }

		if (ccode != null && ccode.length() > 0)
		{
			code_like ="and b.ccode like '"+code+"%'";
		}
		if (ocode != null && ocode.length() > 0 )
		{
			code_like = code_like + "and b.ocode = '"+ocode+"'";
		}


        query = "select b.* from  photo as b where b.pflag='"+pflag+"' " +code_like+sub_query +" order by b.seq desc ";

		try {
	        result_ht = sqlbean.getPhotoList(page, query, limit);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
	
		return result_ht;

	}


	public Hashtable getPhotoListOcode2( String ocode, String ccode,String pflag, String field, String searchstring, int page, int limit){

		
       
		Hashtable result_ht;

		String query = "";
        String sub_query = "";
		String code = "";
		String code_like="";

		if (ccode != null && ccode.length() > 0){
	
			Vector v = sqlbean.selectQuery("select cinfo from category  where ctype='P' and ccode='" +ccode+ "'");
			String strtmp = "A";
			if(v != null && v.size() > 0){
				strtmp = String.valueOf(v.elementAt(0));
			}

			if(strtmp.equals("A")) {
				code = ccode.substring(0,3);
			}else if(strtmp.equals("B")) {
				code = ccode.substring(0,6);
			}else if(strtmp.equals("C")) {
				code = ccode.substring(0,9);
			}else if(strtmp.equals("D")) {
				code = ccode;
			}
			
			if(pflag.equals("P")) {
				code = ccode;
			}
		}
 
		if( field != null && field.length() > 0 &&  searchstring != null && searchstring.length() > 0) {
            if(field.equals("title"))
                sub_query = " and b.title like '%" +searchstring+ "%' ";
            else if(field.equals("text1"))
                sub_query = " and b.text1 like '%" +searchstring+ "%' ";
			else if(field.equals("text2"))
                sub_query = " and b.text2 like '%" +searchstring+ "%' ";
			else if(field.equals("text3"))
                sub_query = " and b.text3 like '%" +searchstring+ "%' ";
			else if(field.equals("text4"))
                sub_query = " and b.text4 like '%" +searchstring+ "%' ";
			else if(field.equals("text5"))
                sub_query = " and b.text5 like '%" +searchstring+ "%' ";
			else if(field.equals("text6"))
                sub_query = " and b.text6 like '%" +searchstring+ "%' ";
            else if(field.equals("all"))
                sub_query = " and (b.title like '%" +searchstring+ "%' or b.text1 like '%" +searchstring+
                        "%' or b.text2 like '%" +searchstring+ "%' or b.text3 like '%" +searchstring+ "%' or b.text4 like '%" +searchstring+ "%' or b.text5 like '%" +searchstring+ "%' or b.text6 like '%" +searchstring+ "%') ";
        }

		if (ccode != null && ccode.length() > 0)
		{
			code_like ="and b.ccode like '"+code+"%'";
		}
		if (ocode != null && ocode.length() > 0 )
		{
			code_like = code_like + "and b.ocode = '"+ocode+"'";
		}


        query = "select b.* from  photo as b where b.pflag='"+pflag+"' " +code_like+sub_query +" and b.mview_flag='Y' order by b.seq desc ";

//        System.out.println(query);
		try {
	        result_ht = sqlbean.getPhotoList(page, query, limit);
	
	    }catch (Exception e) {
	        result_ht = new Hashtable();
	        result_ht.put("LIST", new Vector());
	        result_ht.put("PAGE", new com.yundara.util.PageBean());
	    }
		return result_ht;



	}
	/*****************************************************
	주문형 미디어목록 count 리턴.<p>
	<b>작성자</b> : 김주현 <br>
	@return 주문형 미디어 목록<br>
	@param ccode 카테고리
	******************************************************/
	public Vector getPhotoOcount(String ccode, String ocode, String pflag, String field, String searchstring){

	String query = "";

	String sub_query = "";

        if( field != null && field.length() > 0 &&  searchstring != null && searchstring.length() > 0) {
            if(field.equals("title"))
                sub_query = " and title like '%" +searchstring+ "%' ";
            else if(field.equals("text1"))
                sub_query = " and text1 like '%" +searchstring+ "%' ";
			else if(field.equals("text2"))
                sub_query = " and text2 like '%" +searchstring+ "%' ";
			else if(field.equals("text3"))
                sub_query = " and text3 like '%" +searchstring+ "%' ";
			else if(field.equals("text4"))
                sub_query = " and text4 like '%" +searchstring+ "%' ";
			else if(field.equals("text5"))
                sub_query = " and text5 like '%" +searchstring+ "%' ";
			else if(field.equals("text6"))
                sub_query = " and text6 like '%" +searchstring+ "%' ";
            else if(field.equals("all"))
                sub_query = " and (title like '%" +searchstring+ "%' or text1 like '%" +searchstring+
                        "%' or text2 like '%" +searchstring+ "%' or text3 like '%" +searchstring+ "%' or text4 like '%" +searchstring+ "%' or text5 like '%" +searchstring+ "%' or text6 like '%" +searchstring+ "%') ";
        }

		query = "select count(*) from photo where ccode='"+ccode+"' and ocode='"+ocode+"' and pflag='"+pflag+"'"+sub_query;
	
	return sqlbean.selectQuery(query);
	}

	/*****************************************************
    사진 정보 삭제.<p>
	<b>작성자</b> : 김주현 <br>
	@return 사진정보<br>
	@param seq 일련번호
	******************************************************/

	public int deletePhoto(String seq) throws Exception {
	    
		return sqlbean.deletePhoto(seq);
	}
	
	public int deletePhotoImg(String seq) throws Exception {
		    
			return sqlbean.updatePhotoImg(seq);
		}
	/*
	 * 비밀번호를 구한다.
	 * 이희락 2007.02.13
	 * seq를 이용한다.
	 * return password(text4)
	 */

	public String getPass(String seq)throws Exception {
	    
		return sqlbean.getPass(seq);
	}


   /**
     * order_media 조회수 증가
     * @param ocode
     */
    public void setPhotoHit(String seq) {
        sqlbean.updatePhotoHit(seq);
    }


/*
 photo 카테고리 별 최신 이미지
*/

public Vector Photo_Ccode_limit(String ccode, int limit, int vod_level) {

		String code = "";

		if (ccode != null && ccode.length() > 0 ){

			Vector v = sqlbean.selectQuery("select cinfo from category where ctype='P' and ccode='" +ccode+ "'");
			String strtmp = "A";
			if(v != null && v.size() > 0){
				strtmp = String.valueOf(v.elementAt(0));
			}

			if(strtmp.equals("A")) {
				code = ccode.substring(0,3);
			}else if(strtmp.equals("B")) {
				code = ccode.substring(0,6);
			}else if(strtmp.equals("C")) {
				code = ccode.substring(0,9);
			}else if(strtmp.equals("D")) {
				code = ccode;
			}
	}


		String	query = "select * from photo where pflag='M' and plevel<="+vod_level+" and mview_flag ='Y' and ccode like '"+code+"%' order by seq desc limit 0,"+limit;
	
	return sqlbean.selectPhotoListAll(query);

}

public Vector PhotoList(String ccode, String ocode, int vod_level) {

	if (vod_level > 0 && ccode != null && ccode.length() > 0 && ocode != null && ocode.length() > 0 ) {
	String	query = "select * from photo where pflag='M' and mview_flag='Y' and plevel<="+vod_level+" and ccode = '"+ccode+"' and ocode='"+ocode+"' ";

	return sqlbean.selectPhotoListAll(query);
	} else {
		return null;
	}

}

public boolean passwordChk(String seq, String pwd) {
	boolean flag = false;

	if (seq != null && seq.length() > 0 && pwd != null && pwd.length() > 0) {
	String	query = "select * from photo where seq='"+seq+"' and text1=password('"+pwd+"')";
//	System.out.println(query);
	Vector v = sqlbean.selectQuery(query);
 
		if(v != null && v.size() > 0 ) {
			flag = true;
		}
	}
	return flag;
	

}





}
