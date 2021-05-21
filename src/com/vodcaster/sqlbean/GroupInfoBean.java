package com.vodcaster.sqlbean;

import com.yundara.beans.InfoBeanExt;
import com.yundara.util.CharacterSet;
import javax.servlet.http.*;

/**
 * @author Choi Hee-Sung
 * 예약형 미디어의 메모기능 관련 정보 클래스
 */
public class GroupInfoBean extends InfoBeanExt {

    private int seq        = 0;
    private String vodgroup    = "";
    private String comment = "";



public GroupInfoBean() {
        super();
    }
    
    
	public void initGroup( HttpServletRequest req ) {
	    
	    if(req.getParameter("seq") != null) {
	        seq = Integer.parseInt(req.getParameter("seq"));
	    }

		if(req.getParameter("vodgroup") != null) {
	       // vodgroup = req.getParameter("vodgroup");
			vodgroup = CharacterSet.toKorean(req.getParameter("vodgroup"));
	    }

	    if(req.getParameter("comment") != null) {
            //comment = req.getParameter("comment");
			comment = CharacterSet.toKorean(req.getParameter("comment"));
        }

	}  


    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

   
    public String getVodgroup() {
        return vodgroup;
    }

    public void setVodgroup(String vodgroup) {
        this.vodgroup = vodgroup;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

}
