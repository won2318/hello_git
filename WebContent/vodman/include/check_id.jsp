<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%
	/**
	 * @author ����� 
	 *
	 * @description : ȸ�� ���̵� �ߺ�üũ .
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
					msg = "<font color='#008E77'>�̹� ���� ���̵� �����մϴ�.</font><br>\n" +
"                        <font color='#008E77'>�ٸ� ���̵� �Է����ּ���.</font>";
				}else {
					msg = "<font color='#008E77'>�����մϴ� ! <u>" +fid+ "</u>��(��) ��� �����մϴ�.</font>";
					rtn_script = "<br><input type='button' value='����ϱ�' class='submit' onClick=\"javascript:useID('"+fid+"')\">";
				}

			}catch(Exception e) {}

		}

	}else{

		fid = request.getParameter("fid").replaceAll("<","").replaceAll(">","").trim();

		msg = "<font color='#008E77'>������ ���ϴ� ���̵� �Է��ϰ� �ߺ�üũ�� ��������</font>";

	}

%>

<html>
<head>
<title>���̵� �ߺ�üũ</title>
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
		  <td class=white align=center height=30><b>���̵� �ߺ�üũ</b></td>
		</tr>
		<tr>
		  <td height=10 align=center></td>
		</tr>
		<tr>
		  <td align=center>���̵� : <input onClick="this.select()" type=text name="fid" value="<%=fid%>" style=width:100 maxlength=14 class=txt> <input type=submit value='üũ�ϱ�' class=submit></td>
		</tr>
		<tr>
		  <td height=25 align=center><%=msg%></td>
		</tr>
		<tr>
		  <td height=25 align=center><%=rtn_script%>&nbsp;&nbsp;<input type=button onClick="window.close()" class=submit value=' â �ݱ� '>&nbsp; </td>
		</tr>
		</form>
	  </table>
	</td>
  </tr>
</table>
</body>
</html>