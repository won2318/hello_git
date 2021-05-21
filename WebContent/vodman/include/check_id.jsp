<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%
	/**
	 * @author 이희락 
	 *
	 * @description : 회원 아이디 중복체크 .
	 * date : 2007-09-04
	 */

    String mode = "find";
	//String mode = request.getParameter("mode");
	String fid = "";
	String msg = "";
	String rtn_script = "";

	if(mode != null && mode.equals("find")) {

		fid = request.getParameter("fid").replaceAll("<","").replaceAll(">","").trim();

		if(fid!= null && !fid.equals("")) {

			try {
				MemberManager mgr = MemberManager.getInstance();
				boolean rtn = mgr.checkID(fid);

				if(rtn) {
					msg = "<font color='#008E77'>이미 같은 아이디가 존재합니다.</font><br>\n" +
"                        <font color='#008E77'>다른 아이디를 입력해주세요.</font>";
				}else {
					msg = "<font color='#008E77'>축하합니다 ! <u>" +fid+ "</u>은(는) 사용 가능합니다.</font>";
					rtn_script = "<br><input type='button' value='사용하기' class='submit' onClick=\"javascript:useID('"+fid+"')\">";
				}

			}catch(Exception e) {}

		}

	}else{

		fid = request.getParameter("fid").replaceAll("<","").replaceAll(">","").trim();

		msg = "<font color='#008E77'>가입을 원하는 아이디를 입력하고 중복체크를 누르세요</font>";

	}

%>

<html>
<head>
<title>아이디 중복체크</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../style.css" type="text/css">
<script language="javascript" src="script.js"></script>
<script language="javascript">
<!--
	function useID(id) {
		opener.document.frmMember.id.value = id;
		opener.document.frmMember.pwd.focus();
		this.close();
		return;
	}

	function noUseID() {
		opener.document.frmMember.id.value = "";
		opener.document.frmMember.id.focus();
		this.close();
		return;
	}
//-->
</script>
</head>

<body bgcolor=white leftmargin=0 topmargin=0 marginwidth=0 marginheight=0>

<table align=center  width=100% cellpadding=01 cellspacing=0 bgcolor=#F6F6F6>
  <tr>
    <td>
	  <table align=center  width=100% cellpadding=02 cellspacing=0>
	    <form name="form1" method="post" action="check_id.jsp">
		<input type="hidden" name="mode" value="find">
		<tr bgcolor='#CCCCCC'>
		  <td class=white align=center height=30><b>아이디 중복체크</b></td>
		</tr>
		<tr>
		  <td height=10 align=center></td>
		</tr>
		<tr>
		  <td align=center>아이디 : <input onClick="this.select()" type=text name="fid" value="<%=fid%>" style=width:100 maxlength=14 class=txt> <input type=submit value='체크하기' class=submit></td>
		</tr>
		<tr>
		  <td height=25 align=center><%=msg%></td>
		</tr>
		<tr>
		  <td height=25 align=center><%=rtn_script%>&nbsp;&nbsp;<input type=button onClick="window.close()" class=submit value=' 창 닫기 '>&nbsp; </td>
		</tr>
		</form>
	  </table>
	</td>
  </tr>
</table>
</body>
</html>