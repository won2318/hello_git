/*
 * Created on 2005. 1. 19
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.vodcaster.sqlbean;

/**
 * @author 최희성
 *
 * 스킨시스템 DB관련정보
 */

import java.util.*;

import javax.servlet.http.*;
import dbcp.*;
import com.yundara.util.CharacterSet;
import com.yundara.util.PageBean;
import com.yundara.util.TextUtil;
import com.yundara.util.FileUtil;

public class PopupSqlBean extends SQLBeanExt {

    public PopupSqlBean() {
		super();
	}
    
	
	/*----------------------------------------------
	 * discription : instance 생성
	 * 작성자       : 유만호
	 * 작성일       : 2007/12/17
	 *----------------------------------------------*/
	private static PopupSqlBean instance;
	public static PopupSqlBean getInstance() {
		if(instance == null) {
			synchronized(PopupSqlBean.class) {
				if(instance == null) {
					instance = new PopupSqlBean();
				}
			}
		}
		return instance;
	}

    public Vector selectQueryList(String query) {
        return querymanager.selectHashEntities(query);
    }



    public Vector selectQueryListExt(String query) {
        return querymanager.selectEntities(query);
    }


    public Vector selectQuery(String query) {
        return querymanager.selectEntity(query);
    }


    public int executeQuery(String query) {
        return querymanager.updateEntities(query);
    }


	
	public int updatePOP(String query) throws Exception {

		int iResult = -1;
        try {
        	iResult = querymanager.executeQuery(query);

        } catch(Exception e) {
            System.err.println("updatePOP ex "+e.getMessage());
        }

        return iResult;
	}
	
	/*----------------------------------------------
	팝업창에 첨부이미지 입력.<p>
	<b>작성자</b> : 유만호<br>
	date : 2007-12-17
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param bean RealMediaInfoBean
	*----------------------------------------------*/
	public int insertPopImage(PopupInfoBean bean) throws Exception{

		String query = "update popupman set img_name = '" + bean.getImg_name().replace("'", "''")+ "' where seq = " + bean.getSeq();
		return querymanager.updateEntities(query);

	}
	
	/*****************************************************
	팝업 첨부이미지 삭제.<p>
	<b>작성자</b> : 유만호<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param rcode 예약형 미디어코드, 미디엄코드
	******************************************************/
	public int dropPopupImage(String seq, String gubun) throws Exception{
	
	    String query = "";
	    Vector v = null;
	    int rtn = -1;
	
	    if(seq != null 
	    		&& seq.length()> 0
	    		&&  com.yundara.util.TextUtil.isNumeric(seq)
	    		&& gubun != null 
	    		&& gubun.length()>0
	    		&& com.yundara.util.TextUtil.isNumeric(gubun)) { // 삭제시 정보확인
	        try {
	            // 미디어 화일 삭제
				String dir = DirectoryNameManager.UPLOAD_POPUP ;

                // 기존화일 삭제모듈
				String fileName = PopupManager.getInstance().getUploadFile(seq, gubun);
                if(FileUtil.existsFile( dir, fileName ) ) {
                    if(FileUtil.delete(dir, fileName) ) {
                        //System.err.println("화일 삭제 성공");
                    } else {
                        System.err.println("화일 삭제 실패 : " + fileName);
                    }
                }
               
                if(gubun.equals("2")){
                	query = "update popupman set img_name_mobile='' where seq=" +seq;
                }else{
                	query = "update popupman set img_name='' where seq=" +seq;
                }
	           //  System.err.println("이미지 삭제 =================>" + query);
	            int iResult = querymanager.executeQuery(query);
	
	            return iResult;
	        } catch (Exception e) {
				System.err.println("dropRMediaImage : "+ e.getMessage());
	        }
	        
	        if(v == null)
	            return -1;
	        else
	            return v.size();
	
	    } else
	        return -1;
	
	}
	
	/*----------------------------------------------
	 * discription : 팝업 리스트
	 * 작성자       : 유만호
	 * 해당 파일    : /admin/site/frm_popList.jsp
	 * 작성일       : 2007/12/14
	 *----------------------------------------------*/
	public Hashtable getAllPopup(int page, int limit) {

		Hashtable result_ht;

		String query = "";

		query = " select * from popupman order by seq desc";
		String count_query =  " select count(*) from popupman ";
		//System.out.println("list query ::: " + query);
		try {
			result_ht = this.getMediaList(page, query,count_query,  limit);

		} catch (Exception e) {
			result_ht = new Hashtable();
			//result_ht.put("LIST", new Hashtable());
			result_ht.put("LIST", new Vector());
			result_ht.put("PAGE", new com.yundara.util.PageBean());
		}

		return result_ht;
	}
	
	
	/*----------------------------------------------
	 * discription : 팝업 삭제
	 * 작성자       : 유만호
	 * 해당 파일    : /admin/site/frm_popList.jsp
	 * 작성일       : 2007/12/14
	 *----------------------------------------------*/
	public int deletePopup(String seq) {
		String query = "delete from popupman where seq = " + seq;
		int result2 = querymanager.updateEntities(query);

		return result2;
	}
	
	////////////////
	// 해쉬 테이블 
	// 페이징 처리 
	/////////////
	public Hashtable getMediaList(int page, String query, String count_query, int limit) {

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
		//139,4,10,1
		PageBean pb = new PageBean(totalRecord, limit, 10, page);
		//totalrecord,lineperpage,pageperblock,page

		// 해당 페이지의 리스트를 얻는다.
		String rquery = "";
		//if(pb.getStartRecord()-1 > limit){
		//	rquery = query + " limit 0,"+limit;
		//	pb = null;
		//	pb = new PageBean(totalRecord, limit, 10,1);
		//}else{
		rquery = query + " limit " + (pb.getStartRecord() - 1) + "," + limit;
		//}
		//log.printlog("MovieBoardSQLBean getBoardList method query"+query);
		//System.err.println(rquery);
		Vector result_v = querymanager.selectHashEntities(rquery);

		Hashtable ht = new Hashtable();
		if (result_v != null && result_v.size() > 0) {
			ht.put("LIST", result_v);
			ht.put("PAGE", pb);
		} else {
			//ht.put("LIST", new Hashtable());
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		}

		return ht;
	}
}
