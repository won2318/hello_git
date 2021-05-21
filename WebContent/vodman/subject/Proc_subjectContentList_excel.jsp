<%@ page language="java" contentType="application/vnd.ms-excel; charset=euc-kr"%>
<%@ page import="java.sql.*,java.util.*,com.vodcaster.sqlbean.*,com.yundara.util.*"%>
<%@ include file="/vodman/include/auth.jsp"%>
<%

	String sub_flag = "S"; // S - 설문 ,  E - 이벤트
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag").replaceAll("<","").replaceAll(">","");
	}
	String question_idx = ""; 
	if(request.getParameter("question_idx") != null && request.getParameter("question_idx").length()>0){
		question_idx = request.getParameter("question_idx").replaceAll("<","").replaceAll(">","");
	}
	String ans_num = ""; 
	if(request.getParameter("ans_num") != null && request.getParameter("ans_num").length()>0){
		ans_num = request.getParameter("ans_num").replaceAll("<","").replaceAll(">","");
	}
	String user_mf = ""; // M - 남 ,  W - 여
	if(request.getParameter("user_mf") != null && request.getParameter("user_mf").length()>0){
		user_mf = request.getParameter("user_mf").replaceAll("<","").replaceAll(">","");
	}
	
    int pg = 0;

    if(request.getParameter("page")==null){
        pg = 1;
    }else{
        pg = Integer.parseInt(request.getParameter("page"));
    }

	int listCnt = 1000000;		//페이지 목록 갯수 

    SubjectManager mgr = SubjectManager.getInstance();

    Vector Vt_sub = mgr.getSubject_Question(question_idx);
	String sub_title = "";
	if (Vt_sub != null && Vt_sub.size() > 0) {
		sub_title =  String.valueOf(Vt_sub.elementAt(2));
	}
	
	Hashtable result_ht = null;
	result_ht = mgr.getSubject_ContentList(question_idx,ans_num, pg,listCnt, user_mf );

	Vector vt = null;
	com.yundara.util.PageBean pageBean = null;
	if(!result_ht.isEmpty() ) {
		vt = (Vector)result_ht.get("LIST");

		if ( vt != null && vt.size() > 0){
			pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
			if(pageBean != null){
				pageBean.setPagePerBlock(10);
				pageBean.setPage(pg);
			}
		}
	}
	response.setHeader("Content-Disposition", "inline; filename=SubjectUserList.xls");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">


</head>
<script language="javascript">
</script>



<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="subjectList" method="post">
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr bgcolor="#dbe2ed">
		<td height="4" colspan="2"></td>
	</tr>
	<tr bgcolor="#dbe2ed">
		<td colspan="2" height="45">&nbsp;&nbsp;▶&nbsp;<%=sub_title%></td>
	</tr>
	<tr bgcolor="#dbe2ed">
		<td height="1" colspan="2"></td>
	</tr>
	<tr style="padding-top: 5px;padding-bottom: 2px">
		<td colspan='2' align='right'>총 <%if(vt != null && vt.size()>0){out.println(pageBean.getTotalRecord());}else{out.println("0");}%>개</tD>
	</tr>
	<tr>
		<td height="1" colspan="2"></td>
	</tr>
	<tr>
		<td height="1" colspan="2" bgcolor="#dbe2ed"></td>
	</tr>
	<tr style="padding-top: 5px;padding-bottom: 2px">
		<td align="center" width="6%">번호</td>
		<td align="center">기타 의견</td>
	</tr>
	<tr>
		<td height="1" colspan="2" bgcolor="#dbe2ed"></td>
	</tr>
	<tr>
		<td colspan="2">
			<table width="600"  border="0" align="center" cellpadding="0" cellspacing="0">
<%
		SubjectInfoBean Sin = new SubjectInfoBean();
		int list = 0;
		if ( vt != null && vt.size() > 0){
			for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
				com.yundara.beans.BeanUtils.fill(Sin, (Hashtable)vt.elementAt(list));
%>
				<tr onMouseOver="this.style.backgroundColor='#F6F6F6'" onMouseOut="this.style.backgroundColor=''" style="padding-top: 5px;padding-bottom: 2px">
					<td align="center"><%=i+1%></td>
					<td style="padding-left: 10px" align="left"><%if(Sin.getAns_order()!=null && Sin.getAns_order().length()>0){%><%=Sin.getAns_order()%><%}else{%><%=Sin.getInfo_order()%><%} %></td>
				</tr>
				<tr bgcolor="#dbe2ed">
					<td height="1" colspan="2"></td>
				</tr>
<%
			}
		}else {
%>
				<tr>
					<td colspan="2" align="center">입력된 내용이 없습니다.</td>
				</tr>
<%
		}
%>
			</table>
		</td>
	</tr>
	<tr bgcolor="#dbe2ed">
		<td height="1" colspan="2"></td>
	</tr>
</table>
</form>
</body>
</html>
