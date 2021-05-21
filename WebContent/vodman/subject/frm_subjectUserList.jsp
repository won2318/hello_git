<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*,java.util.*,com.vodcaster.sqlbean.*,com.yundara.util.*"%>

<%


	String sub_idx = ""; 
	if(request.getParameter("sub_idx") != null && request.getParameter("sub_idx").length()>0){
		sub_idx = request.getParameter("sub_idx").replaceAll("<","").replaceAll(">","");
	}
	String sub_flag = "S"; // S - 설문 ,  E - 이벤트
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag").replaceAll("<","").replaceAll(">","");
	}
	String point_event = ""; // S - 설문 ,  E - 이벤트
	if(request.getParameter("point_event") != null && request.getParameter("point_event").length()>0){
		point_event = request.getParameter("point_event").replaceAll("<","").replaceAll(">","");
	}

    int pg = 0;
    if(request.getParameter("page")==null){
        pg = 1;
    }else{
        pg = Integer.parseInt(request.getParameter("page"));
    }
	int listCnt = 15;		//페이지 목록 갯수 

    SubjectManager mgr = SubjectManager.getInstance();
	
    Vector Vt_sub = mgr.getSubject(sub_idx);
	String sub_title = "";
	if (Vt_sub != null && Vt_sub.size() > 0) {
		sub_title =  String.valueOf(Vt_sub.elementAt(1));
	}
	
	Hashtable result_ht = null;
    //result_ht = mgr.getSubject_UserList(sub_idx, pg,listCnt );
	result_ht = mgr.getSubject_UserList(sub_idx, pg,listCnt,point_event );

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
	
	String strLink = "&page=" +pg+ "&sub_idx="+sub_idx + "&sub_flag=" +sub_flag;
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/vodman/style.css" type="text/css">


</head>
<script language="javascript">
function go_user_select(user_idx){
	window.open("/vodman/subject/subject_user_select.jsp?sub_flag=<%=sub_flag%>&sub_idx=<%=sub_idx%>&user_idx="+user_idx, "subject_content1" , "width=630,height=700,left=700,scrollbars=yes");
//	window.self.close();
}
</script>



<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="subjectList" method="post">
<table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr bgcolor="#dbe2ed">
		<td height="4"></td>
	</tr>
	<tr bgcolor="#dbe2ed">
		<td>&nbsp;&nbsp;▶&nbsp;<%=sub_title%></td>
	</tr>
	<tr bgcolor="#dbe2ed">
		<td height="1"></td>
	</tr>
	<tr>
		<td align='right'>총 <%if(vt != null && vt.size()>0){out.println(pageBean.getTotalRecord());}else{out.println("0");}%>명</tD>
	</tr>
	<tr>
		<td height="1" ></td>
	</tr>
	<tr>
		<td height="1" bgcolor="#dbe2ed"></td>
	</tr>
	<tr>
		<td>
		<table width="750"  border="0" align="center" cellpadding="0" cellspacing="0">
<%
	if(sub_flag.equals("S")){
%>
			<tr>
				<td align=center width="150">IP</td>
				<td align=center width="150">등록일</td>
				<td align=center width="90">이름</td>
				<!-- <td align=center width="60">성별</td>
				<td align=center width="150">연락처</td>
				<td align=center width="150">이메일</td> -->
			</tr>
<%	}else{ %>
			<tr>
				<td align=center width="120">IP</td>
				<td align=center width="120">등록일</td>
				<td align=center width="90">이름</td>
				<!-- <td align=center width="60">성별</td>
				<td align=center width="150">연락처</td>
				<td align=center width="150">이메일</td>
				<td align=center width="60">점수</td> -->
			</tr>
<%	} %>
		</table>
		</td>
	</tr>
	<tr>
		<td height="1" bgcolor="#dbe2ed"></td>
	</tr>
	<tr>
		<td>
			<table width="750"  border="0" align="center" cellpadding="0" cellspacing="0">
<%
		SubjectInfoBean Sin = new SubjectInfoBean();
		int count =1;
		String sub_link = "";
		String sex ="";
		int list = 0;
		if(sub_flag.equals("S")){
			if ( vt != null && vt.size() > 0){
				for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
					com.yundara.beans.BeanUtils.fill(Sin, (Hashtable)vt.elementAt(list));
					String mf = Sin.getUser_mf();
					if(mf.equals("M")){sex="남자";}else if(mf.equals("W")){sex="여자";}
%>
				<tr onMouseOver="this.style.backgroundColor='#F6F6F6'" onMouseOut="this.style.backgroundColor=''" style="padding-top: 5px;padding-bottom: 2px">
					<td align="center" width="150"><a href="javascript:go_user_select('<%=Sin.getUser_idx() %>');"><%=Sin.getUser_ip()%></a></td>
					<td align="center" width="150"><%=Sin.getUser_date()%></td>
					<td align="center" width="90"><%=Sin.getUser_name()%></td>
					<!-- <td align="center" width="60"><%=sex%></td>
					<td align="center" width="150"><%=Sin.getUser_tel()%></td>
					<td style="padding-left: 10px" width="150"><%=Sin.getUser_email()%></td> -->
				</tr>
				<tr bgcolor="#dbe2ed">
					<td height="1" colspan="6"></td>
				</tr>
<%
				}
			}else {
%>
				<tr>
					<td colspan="6" align="center">입력된 내용이 없습니다.</td>
				</tr>
<%
			}
		}else{
			if ( vt != null && vt.size() > 0){
				for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
					com.yundara.beans.BeanUtils.fill(Sin, (Hashtable)vt.elementAt(list));
					String point = Sin.getEvent_point();
					String mf = Sin.getUser_mf();

					if(mf != null && mf.length() > 0 && mf.equals("M")){sex="남자";}else if(mf != null && mf.length() > 0 && mf.equals("W")){sex="여자";}
					
%>
				<tr onMouseOver="this.style.backgroundColor='#F6F6F6'" onMouseOut="this.style.backgroundColor=''" style="padding-top: 5px;padding-bottom: 2px">
					<td align="center" width="120"><a href="javascript:go_user_select('<%=Sin.getUser_idx() %>');"><%=Sin.getUser_ip()%></a></td>
					<td align="center" width="120"><%=Sin.getUser_date()%></td>
					<td align="center" width="90"><%=Sin.getUser_name()%></td>
					<!-- <td align="center" width="60"><%=sex%></td>
					<td align="center" width="150"><%=Sin.getUser_tel()%></td>
					<td style="padding-left: 10px" width="150"><%=Sin.getUser_email()%></td> -->
					<td align="center" width="60"><%
					if(point != null && !point.equals("-1") && point.length()>0){out.println(point);}else{out.println("0");}%></td>
				</tr>
				<tr bgcolor="#dbe2ed">
					<td height="1" colspan="7"></td>
				</tr>
<%
				}
			}else {
%>
				<tr>
					<td colspan="7" align="center">입력된 내용이 없습니다.</td>
				</tr>
<%
			}
		} 
%>
			</table>
		</td>
	</tr>
	<tr bgcolor="#dbe2ed">
		<td height="1" ></td>
	</tr>
	<tr>
		<td align="center">
<%
	String jspName = "frm_subjectUserList.jsp"; 
	if(vt != null && vt.size() > 0 && pageBean!= null){ 
%>
		  <%@ include file="page_link.jsp" %>
<%	}	%>
		</td>
	</tr>
	<tr>
		<td align='center'><br>
			<a href="javascript:self.close();">
				<img src="images/subject/bt_02.jpg" width="48" height="19" border="0">
			</a>
		</td>
	</tr>
</table>
</form>
</body>
</html>