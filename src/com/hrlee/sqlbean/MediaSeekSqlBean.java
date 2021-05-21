package com.hrlee.sqlbean;

import dbcp.SQLBeanExt;

import com.yundara.util.CharacterSet;
import com.vodcaster.sqlbean.DirectoryNameManager;

import javax.servlet.http.HttpServletRequest;
import java.util.Vector;

/**
 * @author Choi Hee-Sung
 *
 * �̵�� �ε��̱�� ���� Ŭ����
 * Date: 2005. 2. 25.
 * Time: ���� 3:43:58
 */
public class MediaSeekSqlBean extends SQLBeanExt {
    public MediaSeekSqlBean() {
		super();
	}


/*****************************************************
	Ư�� �ֹ����̵���� ��� �ε��������� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return �̵���� �ε������� ����<br>
	@param �ֹ����̵���ڵ�
******************************************************/
    public Vector selectSeek(int ocode) {
        String query = "select * from media_seek where ocode=" +ocode;
        Vector v = querymanager.selectEntity(query);

        return v;
    }


/*****************************************************
	�̵� �ε������� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
	@param HttpServletRequest
******************************************************/
	public int insertSeek(HttpServletRequest req) throws Exception {
        int rtn = -1;

        String txt1 = "";
        String txt2 = "";
        String txt3 = "";
        String txt4 = "";
        String txt5 = "";

        int ocode = Integer.parseInt(req.getParameter("ocode"));
        int link1 = Integer.parseInt(req.getParameter("link1"));
        int link2 = Integer.parseInt(req.getParameter("link2"));
        int link3 = Integer.parseInt(req.getParameter("link3"));
        int link4 = Integer.parseInt(req.getParameter("link4"));
        int link5 = Integer.parseInt(req.getParameter("link5"));

        if(req.getParameter("txt1")!=null)
            txt1 = req.getParameter("txt1").trim();

        if(req.getParameter("txt2")!=null)
            txt2 = req.getParameter("txt2").trim();

        if(req.getParameter("txt3")!=null)
            txt3 = req.getParameter("txt3").trim();

        if(req.getParameter("txt4")!=null)
            txt4 = req.getParameter("txt4").trim();

        if(req.getParameter("txt5")!=null)
            txt5 = req.getParameter("txt5").trim();
        try {

            Vector v = this.selectSeek(ocode);
            //System.err.println("���� ũ��� " + v.size());

            if(v.size() > 0) {
                return -1;
            } else {

                String query = "insert into media_seek (ocode,txt1,link1,txt2,link2,txt3,link3,txt4,link4,txt5,link5) values(" +
                        ocode   + ",'"  +
                        txt1    + "',"  +
                        link1   + ",'"  +
                        txt2    + "',"  +
                        link2   + ",'"  +
                        txt3    + "',"  +
                        link3   + ",'"  +
                        txt4    + "',"  +
                        link4   + ",'"  +
                        txt5    + "',"  +
                        link5   + ")";

                //System.err.println("MediaSeek query == " + query);
                rtn = querymanager.updateEntities(query);
            }

	    } catch(Exception e) {}

	    return rtn;
	}



/*****************************************************
	�ε������� ����.<p>
	<b>�ۼ���</b> : ����<br>
	@return ����:row��, ����:-1, Ŀ�ؼǿ���:-99<br>
	@param HttpServletRequest
******************************************************/
	public int updateSeek(HttpServletRequest req) throws Exception {
        int rtn = -1;

        String txt1 = "";
        String txt2 = "";
        String txt3 = "";
        String txt4 = "";
        String txt5 = "";

        int ocode = Integer.parseInt(req.getParameter("ocode"));
        int link1 = Integer.parseInt(req.getParameter("link1"));
        int link2 = Integer.parseInt(req.getParameter("link2"));
        int link3 = Integer.parseInt(req.getParameter("link3"));
        int link4 = Integer.parseInt(req.getParameter("link4"));
        int link5 = Integer.parseInt(req.getParameter("link5"));

        if(req.getParameter("txt1")!=null)
            txt1 = req.getParameter("txt1").trim();

        if(req.getParameter("txt2")!=null)
            txt2 = req.getParameter("txt2").trim();

        if(req.getParameter("txt3")!=null)
            txt3 = req.getParameter("txt3").trim();

        if(req.getParameter("txt4")!=null)
            txt4 = req.getParameter("txt4").trim();

        if(req.getParameter("txt5")!=null)
            txt5 = req.getParameter("txt5").trim();

        try {

            Vector v = this.selectSeek(ocode);
            if(v==null || v.size() < 0) {
                return -1;
            } else {

                String query = "update media_seek set " +
                        "txt1='"    + txt1  + "',"  +
                        "txt2='"    + txt2  + "',"  +
                        "txt3='"    + txt3  + "',"  +
                        "txt4='"    + txt4  + "',"  +
                        "txt5='"    + txt5  + "',"  +
                        "link1="    + link1 + ","   +
                        "link2="    + link2 + ","   +
                        "link3="    + link3 + ","   +
                        "link4="    + link4 + ","   +
                        "link5="    + link5 + " where ocode=" +ocode;

                //System.err.println("MediaSeek query == " + query);
                rtn = querymanager.updateEntities(query);
            }

	    } catch(Exception e) {}

	    return rtn;
	}
}
