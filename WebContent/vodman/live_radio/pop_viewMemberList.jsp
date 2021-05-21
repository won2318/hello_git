<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
                 java.util.Date"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "r_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<jsp:useBean id="pageBean" class="com.vodcaster.utils.PageBean" scope="page"/>

<%
	/**
	 * @author ����
	 *
	 * @description : vod ��ü������ ������.
	 * date : 2005-01-25
	 */

	String field = "";
	String searchstring = "";
    int vod_code;

	if(request.getParameter("field") != null && request.getParameter("field").length()>0 && !request.getParameter("field").equals("null"))
		field = com.vodcaster.utils.TextUtil.getValue(request.getParameter("field"));

	if( request.getParameter("searchstring") != null && request.getParameter("searchstring").length()>0 && !request.getParameter("searchstring").equals("null"))
		searchstring = CharacterSet.toKorean(com.vodcaster.utils.TextUtil.getValue(request.getParameter("searchstring")));

	try{
		if(request.getParameter("vod_code") != null && request.getParameter("vod_code").length()>0 && !request.getParameter("vod_code").equals("null"))
			vod_code = Integer.parseInt(com.vodcaster.utils.TextUtil.getValue(request.getParameter("vod_code")));
		else
			vod_code = 0;
	}catch(Exception ex){
		vod_code=0;
	}

	String strtmp = "";


	MediaManager mgr = MediaManager.getInstance();
	Vector vt = mgr.getOVODMemberList(vod_code, field, searchstring, "real_media");


	/******************************************************************************
	PAGEBEAN ����
	******************************************************************************/
	int totalArticle =0; //�� ���ڵ� ����
	int todayArticle = 0 ; //���� ��� ���ڵ� ��
	int pg = 0;
    String cpage = request.getParameter("page");

    if(cpage == null || cpage.equals("")) {
        pg = 1;
    }else {
		try{
			pg = Integer.parseInt(cpage);
		}catch(Exception ex){
			pg =1;
		}
    }

	String jspName = "";

	if(vt != null && vt.size() >0){
		totalArticle= vt.size(); // �� �Խù� ��

		jspName="pop_viewMemberList.jsp";

		try{
			pageBean.setTotalRecord(totalArticle);
			pageBean.setLinePerPage(Integer.parseInt("20"));
			pageBean.setPagePerBlock(10);
			pageBean.setPage(pg);
		}catch(Exception e){
			System.out.println("PAGEEXCEPTION = "+e);

		}
	}

    String strLink = "&field=" +field+ "&searchstring=" +searchstring;


	//************** �Խ��ǰ��� ���� �� *********************//
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">

</head>

<body leftmargin="5" topmargin="0" marginwidth="0" marginheight="0">
<table width="600" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>
	  <table width=100% border=0 cellpadding=0 cellspacing=0 align="center">
		<tr>
		  <td height="5">
		    <!-- ���ζ��� -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
			    <td height="2" background="/vodman/images/holine_bg.gif"></td>
			  </tr>
			</table>
		  </td>
		</tr>
		<tr>
		  <td>
		    <table width=100% border=0 cellpadding=0 cellspacing=0>
			  <tr>
			    <td height="25"><font color="#ADBD85">��</font> �� <%=vt.size()%>��</td>
			  </tr>
			  <tr>
			    <td>
				  <!-- �˻� -->
				  <table width="100%" border="0" cellpadding="5" cellspacing="2" bgcolor="#DBE2C9">
				    <tr>
					  <td bgcolor="#F0F0EF">
					    <table border="0" cellpadding="0" cellspacing="0">
						  <form name="search" method="post">
						    <tr>
							  <td width="30">�˻�</td>
                              <td><select name="field" class="scroll">
                                    <option value="">--����--</option>
                                    <option value="vod_id" <%=field.equals("vod_id") ? "selected" : ""%>>���̵�</option>
                                    <option value="vod_name" <%=field.equals("vod_name") ? "selected" : ""%>>�̸�</option>
                                    <option value="all" <%=field.equals("all") ? "selected" : ""%>>��ü</option>
                                  </select> <input type="text" name="searchstring" class="inputG" value="<%=searchstring%>">
                                  <input type="image" src="/vodman/images/bu_search.gif" border="0" align="absmiddle">
                                  </td>
							</tr>
						  </form>
						</table>
					  </td>
					</tr>
				  </table>
				</td>
			  </tr>
			  <tr>
			    <td height="3"></td>
			  </tr>
			  <tr>
			    <td>
				  <table width='100%' border='0' cellspacing='0' cellpadding='5'>
				    <tr bgcolor="#DBE2C9">
					  <td height="4" colspan="6"></td>
					</tr>
					<tr bgcolor="#ADBD85">
					  <td height="1" colspan="6"></td>
					</tr>
					<tr>
					  <td align=center width="10%">��ȣ</td>
					  <td align=center width="20%">���̵�</td>
					  <td align=center width="25%">�̸�</td>
					  <td align=center width="15%">��¥</td>
					  <td align=center width="15%">�ð�</td>
					  <td align=center width="15%">������</td>
					</tr>
					<tr>
					  <td height="1" colspan="6" bgcolor="#ADBD85"></td>
					</tr>

				<%
					String sub_link = "";

                    if(vt != null && vt.size() > 0){

                        String list_id = "";
                        String list_name = "";
                        String list_date = "";
                        String list_time = "";
                        String list_ip = "";



                        try{
                            for(int i = pageBean.getStartRecord()-1; i < pageBean.getEndRecord(); i++) {
                                //System.out.println("�� : " +pageBean.getStartRecord());

                                list_id = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(7));
                                list_name = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(8));
                                list_date = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(1))+ "-" +
                                            String.valueOf(((Vector)(vt.elementAt(i))).elementAt(2))+ "-" +
                                            String.valueOf(((Vector)(vt.elementAt(i))).elementAt(3));
                                list_time = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(5));
                                list_ip = String.valueOf(((Vector)(vt.elementAt(i))).elementAt(6));


				%>
					<tr bgcolor="#F2F4EC" onMouseOver="this.style.backgroundColor='#F6F6F6'" onMouseOut="this.style.backgroundColor=''"> 
					  <td align=center><b><%=pageBean.getTotalRecord()-i%></b></td>
					  <td align="center"><%=list_id%></td>
					  <td align="center"><%=list_name%></td>
					  <td align="center"><%=list_date%></td>
					  <td align="center"><%=list_time%></td>
					  <td align="center"><%=list_ip%></td>
					</tr>
					<tr bgcolor="#ADBD85">
					  <td height="1" colspan="6"></td>
					</tr>

				<%
					        }
                        }catch(Exception e) {}
                    }


				%>

				  </table>
				</td>

              </tr>
<%
if(vt != null && vt.size() > 0){
%>
              <tr>
                <td align="center"><%@ include file="page_link_vMember.jsp" %></td>

              </tr>
<%}%>
            </table></td>
        </tr>
      </table></td>
  </tr>

</table>
</body>
</html>