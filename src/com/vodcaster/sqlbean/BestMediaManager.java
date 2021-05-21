package com.vodcaster.sqlbean;

import java.util.*;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

/**
 * @author Choi Hee-Sung
 *
 * 메인페이지에 출력될 베스트컨텐츠관련 Control 클래스
 * 베스트컨텐츠 출력,수정,삭제
 * Date: 2005. 1. 26.
 * Time: 오후 3:40:18
 */
public class BestMediaManager {

	private static BestMediaManager instance;

	private BestMediaSqlBean sqlbean = null;

	private BestMediaManager() {
        sqlbean = new BestMediaSqlBean();
       // sqlbean.printLog("BestMediaManager 인스턴스 생성");
    }

	public static BestMediaManager getInstance() {
		if(instance == null) {
			synchronized(BestMediaManager.class) {
				if(instance == null) {
					instance = new BestMediaManager();
				}
			}
		}
		return instance;
	}


/*****************************************************
	베스트컨텐츠 정보 입력.<p>
	<b>작성자</b>       : 최희성<br>
	@return 성공:row수, 에러:-1, 커넥션에러:-99<br>
	@param HttpServletRequest
	@see
******************************************************/
    public int insertBest(HttpServletRequest req) throws Exception {

		BestMediaInfoBean bean = new BestMediaInfoBean();
        com.yundara.util.WebUtils.fill(bean, req);
		return sqlbean.insertBest(bean);

    }


/*****************************************************
	베스트컨텐츠 삭제.<p>
	<b>작성자</b>       : 최희성<br>
	@return 성공:row수, 에러:-1, 커넥션에러:-99<br>
	@param 베스트컨텐츠 코드번호
	@see
******************************************************/
    public int deleteBest(int uid) {

    	if ( uid >= 0) {
        String query = "delete from best_list where uid=" +uid;
        return sqlbean.deleteBest(query);
    	} else {
    		return -1;
    	}
    }


/*****************************************************
	베스트컨텐츠 수정.<p>
	<b>작성자</b>       : 최희성<br>
	@return 성공:row수, 에러:-1, 커넥션에러:-99<br>
	@param HttpServletRequest
	@see
******************************************************/
    public int updateBest(HttpServletRequest req) throws Exception {

		BestMediaInfoBean bean = new BestMediaInfoBean();
        com.yundara.util.WebUtils.fill(bean, req);
		return sqlbean.updateBest(bean);

    }


/*****************************************************
	베스트컨텐츠 목록 출력.<p>
	<b>작성자</b>       : 최희성<br>
	@return 검색된 목록 출력<br>
	@param 미디어종류, view플래그
	@see
******************************************************/
    public Vector getBestList(String oflag, String isview) {

        String query = "";
        String subquery = "";
        Vector rtn = null;
        oflag = com.vodcaster.utils.TextUtil.getValue(oflag);
        isview = com.vodcaster.utils.TextUtil.getValue(isview);
		if (oflag != null && oflag.length() > 0 ) {
		        if(isview != null && isview.length()> 0 ) {
		            subquery = " and isview='" +isview+ "'";
		        }
		        try {
		            query = "select * from best_list where oflag='" +oflag+ "' " +subquery+ " order by border, uid";
		            rtn = sqlbean.getBestList(query);
		        }catch(Exception e) {
		        	System.err.println("getBestList ex : " + e.getMessage());
		        }
		}
        return rtn;

    }

/*****************************************************
	특정 코드에 해당되는 베스트컨텐츠 리턴.<p>
	<b>작성자</b>       : 최희성<br>
	@return 검색된 특정 컨텐츠 출력<br>
	@param 컨텐츠 코드번호
	@see
******************************************************/
    public Vector getBestInfo(String uid) {
    	uid = com.vodcaster.utils.TextUtil.getValue(uid);
    	if (uid != null && uid.length() > 0) {
        String query = "select * from best_list where uid=" +uid;
        return sqlbean.selectBest(query);
    	} else {
    		return null;
    	}
    }
    
    /**
     * 베스트 10 정보 1개 읽기
     * @return Vector
     */
    public Vector getBestTopInfo() {
        String query = " SELECT * FROM best_top_info ORDER BY bti_id LIMIT 0,1 ";
        return sqlbean.selectBest(query);
    }
    
    /**
     * 베스트 10 정보 1개 읽기
     * @return Vector
     */
    public Vector getBestTopInfo(int bti_id) {
    	if (bti_id >= 0) {
        String query = " SELECT * FROM best_top_info where bti_id = "+bti_id;
        return sqlbean.selectBest(query);
    	} else {
    		return null;
    	}
    }

    /**
     * 베스트 10 정보 1개 중 그에 관련된 베스트 정보 리스트
     * @param bti_id
     * @param endLimit
     * @return
     * @throws Exception
     */
    public Vector getBestTopSubList(String bti_id, String endLimit) throws Exception {
    	bti_id = com.vodcaster.utils.TextUtil.getValue(bti_id);
    	endLimit = com.vodcaster.utils.TextUtil.getValue(endLimit);
    	
    	if (bti_id != null && bti_id.length() > 0 && endLimit != null && endLimit.length() > 0
    			&& com.yundara.util.TextUtil.isNumeric(endLimit) && com.yundara.util.TextUtil.isNumeric(bti_id)) 
    	{
	        String query = " SELECT * FROM best_top_sub WHERE bti_id = " + bti_id + " ORDER BY bts_order, bts_id LIMIT 0, " + endLimit;
	        Vector rtn = new Vector();
	        try {
	            rtn =  sqlbean.getBestList(query);
	        } catch(Exception e) {
	        	System.err.println("getBestTopsubList ex : " + e.toString());
	        }
	        return rtn;
    	} else {
    		return null;
    	}
    }

    public Vector getBestTopSubList_order(int bti_id, int endLimit) throws Exception {
    	if (bti_id >= 0 && endLimit >= 0) {
	       // String query = " SELECT * FROM best_top_sub WHERE bti_id = " + bti_id + " ORDER BY bts_order, bts_id LIMIT 0, " + endLimit;
	        
	       String query = " SELECT a.bts_order, a.bts_ocode, a.bts_type,a.bts_uid, b.ccode, b.title, b.modelimage, b.playtime, b.hitcount, b.recomcount, b.replycount, b.olevel, b.mk_date, b.subfolder, b.thumbnail_file, b.ocode, b.posi_xy, b.content_simple "
	    		   +" ,(select ctitle from category D where D.ccode = b.ccode and D.del_flag='N' and ctype='V' ) ctitle "
	    		   + " FROM best_top_sub a, vod_media b "
	    		   + " WHERE a.bts_ocode = b.ocode AND b.del_flag='N' AND b.openflag = 'Y' AND a.bti_id="+bti_id+" ORDER BY bts_order, bts_id LIMIT 0, "+ endLimit;
	        Vector rtn = new Vector();
	        try {
	            rtn =  sqlbean.getBestList(query);
	        } catch(Exception e) {
	        	System.err.println("getBestTopsubList ex : " + e.toString());
	        }
	        return rtn;
    	} else {
    		return null;
    	}
    }
    
    public Vector getBestTopSubList_toDay(int bti_id ) throws Exception {
    	if (bti_id >= 0  ) {
	       // String query = " SELECT * FROM best_top_sub WHERE bti_id = " + bti_id + " ORDER BY bts_order, bts_id LIMIT 0, " + endLimit;
	        
	       String query = " SELECT a.bts_order, a.bts_ocode, a.bts_type,a.bts_uid, b.ccode, b.title, b.modelimage, b.playtime, b.hitcount, b.recomcount, b.replycount, b.olevel, b.mk_date, b.subfolder, b.thumbnail_file, b.ocode, b.content_simple "
	    		   + " FROM best_top_sub a, vod_media b "
	    		   + " WHERE a.bts_ocode = b.ocode AND b.del_flag='N' AND b.openflag = 'Y' AND a.bti_id="+bti_id+" ORDER BY bts_order, bts_id ";
	        Vector rtn = new Vector();
	        try {
	            rtn =  sqlbean.getBestList(query);
	        } catch(Exception e) {
	        	System.err.println("getBestTopsubList_toDay ex : " + e.toString());
	        }
	        return rtn;
    	} else {
    		return null;
    	}
    }
    

    public Vector getBestTopSubList_order_union(int endLimit) throws Exception
    {
      if (endLimit >= 0) {
        String query = " (SELECT bts_id, bti_id, bts_order, bts_ocode FROM best_top_sub WHERE bti_id = 2 ORDER BY bts_order, bts_id LIMIT 0, " + endLimit;
        query = query + " ) union all ";
        query = query + " ( SELECT bts_id, bti_id, bts_order, bts_ocode FROM best_top_sub WHERE bti_id = 3 ORDER BY bts_order, bts_id LIMIT 0, " + endLimit;
        query = query + " ) union all ";
        query = query + " ( SELECT bts_id, bti_id, bts_order, bts_ocode FROM best_top_sub WHERE bti_id = 4 ORDER BY bts_order, bts_id LIMIT 0, " + endLimit + " ) " + 
          " order by bti_id ASC, bts_id asc, bts_order ASC ";
        Vector rtn = new Vector();
        try {
          rtn = this.sqlbean.getBestList(query);
        } catch (Exception e) {
          System.err.println("getBestTopsubList ex : " + e.toString());
        }
        return rtn;
      }
      return null;
    }
    
    /**
     * 베스트 10 정보 저장
     * @param request
     * @param bti_uid
     * @return
     * @throws Exception
     */
    public int saveBestTopInfo(HttpServletRequest request, String bti_uid) throws Exception {
        BestTopInfoBean btiBean = new BestTopInfoBean();
        com.yundara.util.WebUtils.fill(btiBean, request);
        btiBean.setBti_uip(request.getRemoteAddr());
        bti_uid = com.vodcaster.utils.TextUtil.getValue(bti_uid);
        btiBean.setBti_uid(bti_uid);

        ArrayList btsList = new ArrayList();

        int loopMax = btiBean.getBti_mng_num();

        String[] bts_ocodeArr = request.getParameterValues("bts_ocode");
        String[] bts_uidArr = request.getParameterValues("bts_uid");
        String[] bts_titleArr = request.getParameterValues("bts_title");
        String[] bts_typeArr = request.getParameterValues("bts_type");
        //System.out.println(bts_orderArr);
        //System.out.println(bts_titleArr);
        //System.out.println(bts_typeArr);
        //System.out.println(bts_ocodeArr);
        
        try{
	        if (bts_ocodeArr != null && bts_ocodeArr.length != 0 && bts_typeArr != null 
	                && bts_titleArr != null && bts_titleArr.length != 0 && bts_typeArr.length != 0) {
	            if (loopMax > bts_ocodeArr.length) {
	                loopMax = bts_ocodeArr.length;
	            }
	            for (int i=0; i < loopMax; i++) {
	                if (StringUtils.isNotBlank(bts_ocodeArr[i])  && StringUtils.isNotBlank(bts_titleArr[i])) {
	                    BestTopSubBean btsBean = new BestTopSubBean();
	                    btsBean.setBts_ocode(bts_ocodeArr[i]);
	                    String tmpOrder = "bts_order" + (i+1);
	                   // System.out.println(tmpOrder);
	                    btsBean.setBts_order(Integer.parseInt(request.getParameter(tmpOrder)));
	                    btsBean.setBts_title(bts_titleArr[i]);
	                    btsBean.setBts_type(bts_typeArr[i]);
	                    btsBean.setBts_uip(request.getRemoteAddr());
	                    btsBean.setBts_uid(bts_uidArr[i]);
	                   // System.out.println(Integer.parseInt(bts_orderArr[i]));
	                   // System.out.println(bts_titleArr[i]);
	                   // System.out.println(bts_typeArr[i]);
	                   // System.out.println(bts_ocodeArr[i]);
	                   // System.out.println(bti_uid);
	                    btsList.add(btsBean);
	                }
	            }
	        }else{
	        	System.out.println("saveBestTopInfo 등록할 데이터가 올바르지 않음");
	        	return -1;
	        }
        }catch(Exception ex){
        	System.out.println("saveBestTopInfo ex = " + ex);
        	return -1;
        }
        return sqlbean.saveBestTopInfo(btiBean, btsList);
    }
    
    
    public int saveList_link(HttpServletRequest request ) throws Exception {
    	
    		String title="";
    		String link="";
    		String etc ="";
    		
    		if (request.getParameter("title") != null && request.getParameter("title").length() > 0) {
    			title = com.vodcaster.utils.TextUtil.getValue(request.getParameter("title")) ;
    		}
    		if (request.getParameter("link") != null && request.getParameter("link").length() > 0) {
    			link =request.getParameter("link") ;
    		}
    		if (request.getParameter("etc") != null && request.getParameter("etc").length() > 0) {
    			etc = com.vodcaster.utils.TextUtil.getValue(request.getParameter("etc")) ;
    		}
    		
    		//String query = "insert into life_plus (title, link, etc) values('"+title+"','"+link+"','"+etc+"')";
    		String query = "update life_plus set  title='"+title+"', link='"+link+"', etc='"+etc+"' ";
    		//System.out.println(query);
    		return sqlbean.deleteBest(query);
    }


    /**
     * 베스트 10 삭제
     * @param bti_id
     * @return
     * @throws Exception
     */
    public int deleteBestTopInfo(int bti_id) throws Exception {
    	if (bti_id >= 0) {
        return sqlbean.deleteBestTop(bti_id);
    	} else {
    		return -1;
    	}
    }

    /**
     * 사용자 조회 순 목록
     * @param endLimit
     * @return Vector
     */
    public Vector getBestHitList(int endLimit) {
    	if (endLimit > 0) {
        StringBuffer query = new StringBuffer("");
        query.append(" SELECT a.*, b.* ");
        query.append(" FROM vod_media AS a, ( ");
        query.append("     SELECT COUNT(*) AS no, vod_code FROM vod_log GROUP BY vod_code ) AS b ");
        query.append(" WHERE a.ocode = b.vod_code AND a.filename <> '' and a.filename <> 'null' AND  a.openflag='Y' ");
        query.append(" ORDER BY b.no DESC LIMIT 0, ").append(String.valueOf(endLimit));
        //query.append(" WHERE a.ocode = b.vod_code AND a.oflag = 'V' ");
        return sqlbean.getBestHitList(query.toString());
    	} else {
    		return null;
    	}
    }

    
    public Vector getList_link() {

        String query = " select * from life_plus ";
 
        return sqlbean.list_link(query);

    }

    
}
