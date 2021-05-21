package com.vodcaster.sqlbean;

import com.vodcaster.multpart.DefaultFileRenamePolicyITNC21;
import com.vodcaster.multpart.MultipartRequest;
import com.yundara.util.*;

import java.io.File;
import java.util.*;

import javax.servlet.http.*;

import dbcp.SQLBeanExt;


/**
 * @author Choi Hee-Sung
 * 설문조사관련 클래스
 * Date: 2005. 1. 27.
 * Time: 오후 8:26:26
 */

public class QuestionSqlBean extends SQLBeanExt implements java.io.Serializable {
	/*----------------------------------------------
	 * discription : 설문조사 등록
	 * 작성자       : 김종진
	 * 해당 파일    : /admin/question/quest_write.jsp
	 * 작성일       : 2002/09/10
	 *----------------------------------------------*/
	public QuestionSqlBean() {
		super();
	}


	public int createQuestion(HttpServletRequest req) throws Exception {

		QuestionInfoBean bean2 = new QuestionInfoBean();

        
        String rstime1 = "";
        String rstime2 = "";
        String rstime3 = "";
        String rstime4 = "";
        String rstime5 = "";
        String retime1 = "";
        String retime2 = "";
        String retime3 = "";
        String retime4 = "";
        String retime5 = "";

        if(req.getParameter("rstime1") !=null )
            rstime1 = req.getParameter("rstime1");

        if(req.getParameter("rstime2") !=null )
            rstime2 = req.getParameter("rstime2");

        if(req.getParameter("rstime3") !=null )
            rstime3 = req.getParameter("rstime3");

        if(req.getParameter("rstime4") !=null )
            rstime4 = req.getParameter("rstime4");

        if(req.getParameter("rstime5") !=null )
            rstime5 = req.getParameter("rstime5");

        if(req.getParameter("retime1") !=null )
            retime1 = req.getParameter("retime1");

        if(req.getParameter("retime2") !=null )
            retime2 = req.getParameter("retime2");

        if(req.getParameter("retime3") !=null )
            retime3 = req.getParameter("retime3");

        if(req.getParameter("retime4") !=null )
            retime4 = req.getParameter("retime4");

        if(req.getParameter("retime5") !=null )
            retime5 = req.getParameter("retime5");
       
        
        String content = req.getParameter("content");
        String [] item_content = req.getParameterValues("item_content");
        bean2.setContent(content);
        for( int i=0; item_content!=null && i < item_content.length ; i++ ) {
           // System.err.println("proc_pollAdd 추가" +i);
            item_content [i] =  item_content [i] ;
        }

   
        bean2.setRstime1(rstime1);
        bean2.setRstime2(rstime2);
        bean2.setRstime3(rstime3);
        bean2.setRstime4(rstime4);
        bean2.setRstime5(rstime5);
        bean2.setRetime1(retime1);
        bean2.setRetime2(retime2);
        bean2.setRetime3(retime3);
        bean2.setRetime4(retime4);
        bean2.setRetime5(retime5);
        String rs_time = TextUtil.zeroFill(1,4,bean2.getRstime1())  + "-" +
        TextUtil.zeroFill(1,2,bean2.getRstime2())   + "-" +
        TextUtil.zeroFill(1,2,bean2.getRstime3())   + " " +
        TextUtil.zeroFill(1,2,bean2.getRstime4())   + ":" +
        TextUtil.zeroFill(1,2,bean2.getRstime5());

		String re_time = TextUtil.zeroFill(1,4,bean2.getRetime1())  + "-" +
        TextUtil.zeroFill(1,2,bean2.getRetime2())   + "-" +
        TextUtil.zeroFill(1,2,bean2.getRetime3())   + " " +

        TextUtil.zeroFill(1,2,bean2.getRetime4())   + ":" +
        TextUtil.zeroFill(1,2,bean2.getRetime5());
		bean2.setEdate(re_time);
		bean2.setSdate(rs_time);
		
        return insertQuestion(bean2,item_content);
	}

	public int insertQuestion( QuestionInfoBean bean, String [] item_content) {
		
		String query = "insert into question(content, insert_day,sdate,edate) values('"+bean.getContent()+"',now(), '"+bean.getSdate()+"','" + bean.getEdate()+ "');";
		int result = querymanager.updateEntities(query);
		
		Vector v = querymanager.selectEntity("select quest_id from question order by quest_id desc");
		int quest_seq = 0;
		if(v != null && v.size() > 0) {
		quest_seq = Integer.parseInt(String.valueOf(v.elementAt(0)));
		}
		
		for(int i=0; i<item_content.length; i++) {
		query = "insert into quest_item(quest_id, item_no, item_content) values(" +quest_seq+ ", "+(i+1)+",'"+item_content[i]+"');";
		int result2 = querymanager.updateEntities(query);
		}
		return result;
	}
/*****************************************************
	설문조사 입력.<p>
	<b>작성자</b> : 최희성<br>
	@return 성공:row수, 실패:-1, 커넥션에러:-99<br>
	@param 내용, 설문정보
******************************************************/
	public int insertQuestion(String content, String [] item_content ) {
		/* String rs_time = TextUtil.zeroFill(1,4,bean2.getRstime1())  + "-" +
                                TextUtil.zeroFill(1,2,bean2.getRstime2())   + "-" +
                                TextUtil.zeroFill(1,2,bean2.getRstime3())   + " " +
                                TextUtil.zeroFill(1,2,bean2.getRstime4())   + ":" +
                                TextUtil.zeroFill(1,2,bean2.getRstime5());

                String re_time = TextUtil.zeroFill(1,4,bean2.getRetime1())  + "-" +
                                TextUtil.zeroFill(1,2,bean2.getRetime2())   + "-" +
                                TextUtil.zeroFill(1,2,bean2.getRetime3())   + " " +

                                TextUtil.zeroFill(1,2,bean2.getRetime4())   + ":" +
                                TextUtil.zeroFill(1,2,bean2.getRetime5());
		 * */
        String query = "insert into question(content, insert_day) values('"+content+"',now());";
        int result = querymanager.updateEntities(query);

        Vector v = querymanager.selectEntity("select quest_id from question order by quest_id desc");
        int quest_seq = 0;
        if(v != null && v.size() > 0) {
            quest_seq = Integer.parseInt(String.valueOf(v.elementAt(0)));
        }

        for(int i=0; i<item_content.length; i++) {
            query = "insert into quest_item(quest_id, item_no, item_content) values(" +quest_seq+ ", "+(i+1)+",'"+item_content[i]+"');";
            int result2 = querymanager.updateEntities(query);
        }
        return result;
	}



	/*----------------------------------------------
	 * discription : 설문조사 삭제
	 * 작성자       : 김종진
	 * 해당 파일    : /admin/question/quest_list.jsp
	 * 작성일       : 2002/09/10
	 *----------------------------------------------*/
	public int deleteQuestion( int quest_id ) {
		if (quest_id >= 0) {
        String query = "delete from quest_item where quest_id="+quest_id;
        int result = querymanager.updateEntities(query);

        query = "delete from question where quest_id="+quest_id;
        int result2 = querymanager.updateEntities(query);

        return result2;
		} else {
			return -1;
		}
    }


	/*----------------------------------------------
	 * discription : 최근 설문조사
	 * 작성자       : 김종진
	 * 해당 파일    : /main.jsp
	 * 작성일       : 2002/09/10
	 *----------------------------------------------*/
	public Vector getLastQuestion() {
        String query = "select * from question order by insert_day desc limit 1;";

        return querymanager.selectEntity(query);
	}

	/*----------------------------------------------
	 * discription : 오늘 날짜에 해당되는  설문조사
	 * 작성자       : 이희락
	 * 해당 파일    : /main.jsp
	 * 작성일       : 2006/06/09
	 *----------------------------------------------*/
	public Vector getTodayQuestion() {
		String query = "select * from question where sdate <= now() and edate >= now() order by insert_day desc limit 1;";
        

        return querymanager.selectEntity(query);
	}
	
	
	/*----------------------------------------------
	 * discription : 전체 설문조사
	 * 작성자       : 김종진
	 * 해당 파일    : /admin/question/question_list.jsp
	 * 작성일       : 2002/09/10
	 *----------------------------------------------*/
	public Vector getAllQuestion() {
        String query = "select * from question order by insert_day desc ;";
       // System.err.println(query);
        return querymanager.selectEntities(query);
    }



	/*----------------------------------------------
	 * discription : 최근 설문조사 , 투표결과보기
	 * 작성자       : 김종진
	 * 해당 파일    : /main.jsp
	 * 해당 파일    : /question/question_result.jsp
	 * 작성일       : 2002/09/10
	 *----------------------------------------------*/
	public Vector getQuestionItem(int quest_id) {
		if (quest_id >= 0) {
	        String query = "select * from quest_item where quest_id ="+quest_id+" order by item_no";
	        return querymanager.selectEntities(query);
		} else {
			return null;
		}
	}


	/*----------------------------------------------
	 * discription : 투표결과보기
	 * 작성자       : 김종진
	 * 해당 파일    : /question/question_result.jsp
	 * 작성일       : 2002/09/10
	 *----------------------------------------------*/
	public Vector getQuestion(int quest_id) {
		if (quest_id >= 0) {
	        String query = "select * from question where quest_id = "+quest_id;
	        return querymanager.selectEntity(query);
		} else {
			return null;
		}
	}


	/*----------------------------------------------
	 * discription : 투표하기
	 * 작성자       : 김종진
	 * 해당 파일    : /question/question_result.jsp
	 * 작성일       : 2002/09/10
	 *----------------------------------------------*/
	public int updateQuestionItem( int quest_id,  int item_no ){
		if (quest_id >= 0 && item_no >= 0) {
        String query =
			"update quest_item set ans_count = ans_count + 1 where quest_id = "+quest_id+" and item_no="+item_no;

        return querymanager.updateEntities(query);
		} else {
			return -1;
		}
    }
	
	/*----------------------------------------------
	 * discription : 진행중인 설문조사
	 * 작성자       : 유만호
	 * 해당 파일    : /sub/sub9/sub0906.jsp
	 * 작성일       : 2008/02/18
	 *----------------------------------------------*/
	public Vector getQuestionIng() {
        String query = "select * from question where sdate <= now() and now() <= edate order by insert_day desc";
        return querymanager.selectEntities(query);
	}
	
	/*----------------------------------------------
	 * discription : 마감된 설문조사
	 * 작성자       : 유만호
	 * 해당 파일    : /sub/sub9/sub0906.jsp
	 * 작성일       : 2008/02/18
	 *----------------------------------------------*/
	public Hashtable getQuestionEnd(int page, int limit) {
		Hashtable result_ht;
		
        String query = "select * from question where edate < now() order by insert_day desc";
        try {
			result_ht = this.getQuestionList(page, query, limit);

		} catch (Exception e) {
			result_ht = new Hashtable();
			result_ht.put("LIST", new Vector());
			result_ht.put("PAGE", new com.yundara.util.PageBean());
		}
		
        return result_ht;
	}

///////////////
//  설문 검색 결과 가져 오기
//  주현
////////////////////
	public Hashtable getQuestionSearch(String searchString , int page, int limit) {
		Hashtable result_ht;
		String sub_query = "";
		if (searchString != null && searchString.length() > 0) {
			sub_query =" and content like '%"+searchString+"%' ";
		}
		
        String query = "select * from question where  quest_id is not null order by insert_day";
        try {
			result_ht = this.getQuestionList(page, query, limit);

		} catch (Exception e) {
			result_ht = new Hashtable();
			result_ht.put("LIST", new Vector());
			result_ht.put("PAGE", new com.yundara.util.PageBean());
		}
		
        return result_ht;
	}
	
	////////////////
	// 해쉬 테이블 
	// 페이징 처리 
	/////////////
	public Hashtable getQuestionList(int page, String query, int limit) {

		// page정보를 얻는다.
		Vector v = querymanager.selectEntities(query);
		int totalRecord = 0;
		if (v != null && v.size() > 0) {
			totalRecord = v.size();
		}
		if (totalRecord <= 0) {
			Hashtable ht = new Hashtable();
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
			return ht;
		}
		PageBean pb = new PageBean(totalRecord, limit, 10, page);

		// 해당 페이지의 리스트를 얻는다.
		String rquery = "";
		rquery = query + " limit " + (pb.getStartRecord() - 1) + "," + limit;
		Vector result_v = querymanager.selectHashEntities(rquery);

		Hashtable ht = new Hashtable();
		if (result_v != null && result_v.size() > 0) {
			ht.put("LIST", result_v);
			ht.put("PAGE", pb);
		} else {
			ht.put("LIST", new Vector());
			ht.put("PAGE", new com.yundara.util.PageBean());
		}

		return ht;
	}
	
}

