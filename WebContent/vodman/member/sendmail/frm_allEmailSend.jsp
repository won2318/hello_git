<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.lifelong.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/admin/adminMember/security.jsp"%>

<html>
<head>
<link rel="stylesheet" href=/admin/css/style.css type=text/css>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="javascript">

function sendMailNext(){
	var f = document.sendMail;
	if(f.title.value ==''){
		alert('제목을 입력하세요!');
		f.title.focus();
		return;
	}
	if(f.message.value ==''){
		alert('내용을 입력하세요!');
		f.message.focus();
		return;
	}

	document.sendMail.action="proc_mailAllSend.jsp";
	document.sendMail.submit();

}

</script>
</head>
<body background=/admin/images/common/bg_rbottom.gif leftmargin=0 topmargin=0 marginwidth=0 marginheight=0>

<table width=101% border=0 cellpadding=0 cellspacing=0>
    <!-- top start-->
	<jsp:include page="/admin/top.jsp" />
	<!-- top  end-->
  <tr bgcolor=#ffffff height=100%> 
    <td rowspan=4 bgcolor=#dadada><img src=/admin/images/common/sp.gif width=5></td>
    <td valign=top> 
      <!-- left  start-->
	  <jsp:include page="/admin/left.jsp" />
	  <!-- left end-->
    </td>
    <td rowspan=4 bgcolor=#dadada width=1><img src=/admin/images/common/sp.gif width=1></td>
    <td colspan=3 valign=top> <table width=100% height=100% border=0 cellpadding=0 cellspacing=0>
        <tr> 
          <td width=700 align="center" valign=top> 
            <!-- main start-->
            <table width="650" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="center" class="font1" height="156"> 
                    <table width="600" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td height="50" valign="bottom"> 
                          <table width=97% border=0 cellpadding=0 cellspacing=0 align=center>
                            <tr height=35 valign=bottom> 
                              
                            <td align=left style='padding:2 2 5 2;font-weight:bold'><img src=/admin/images/member/i_sub_title.gif>&nbsp;&nbsp;회원전체메일보내기</td>
                              
                            <td align=right class=f_path>홈 / 관리자 / 그룹관리 / 회원전체메일보내기</td>
                            </tr>
                            <tr height=1> 
                              <td bgcolor=#dadada colspan=2><img src=/admin/images/common/sp.gif></td>
                            </tr>
                            
                          <tr bgcolor="#f7f7f7" height=4> 
                            <td colspan=2><img src=/admin/images/common/sp.gif></td>
                            </tr>
                          </table> 
                        <br>
                        <table width="600" border="0" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td> 
							
							
							<form name="sendMail" method="post" >
							<table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" class="font1">
							  <tr> 
								<td align="center"> <table width="97%" border="0" cellspacing="1" cellpadding="5" class="FONT"  align="center">
                                        <tr bgcolor="#F7FBFF"> 
									  <td width="20%" >제목</td>
									  <td width="80%" ><input name="title" type="text" id="title" size="40" maxlength="50"></td>
									</tr>
									<tr bgcolor="#F7FBFF"> 
									  <td >내용</td>
									  <td align="left" valign="top" > <input type=checkbox name="chkFlag" value="1">
										<font color="#0066FF"><strong>HTML일경우 체크하세요!</strong></font><br>
										<br>
										<TEXTAREA name="message" COLS="80" ROWS="25" id="message"></TEXTAREA> 
									  </td>
									</tr>
								  </table>
								  <br>
								  <div align="center">
									<input name="sendEmail" type="button" id="sendEmail" value="보내기" onClick="sendMailNext();" class=f_button>
									&nbsp;&nbsp;
									<input name="reset" type="reset" id="reset" value="다시쓰기" class=f_button >
								  </div></td>
							  </tr>
							</table>
						  </form>
							  
							  
							  
							  </td>
                          </tr>
                        </table> </td>
                      </tr>
                      <tr> 
                        <td height="20">&nbsp;</td>
                      </tr>
                    </table>
                </td>
              </tr>
            </table>
            <!-- main end-->
          </td>
          <td width=9 background=/admin/images/common/bg_rbottom_shadow.gif><img src=/admin/images/common/spacer.gif width=9 height=100%></td>
          <td background=/admin/images/common/bg_rbottom.gif><img src=/admin/images/common/spacer.gif width=9 height=100%></td>
        </tr>
      </table></td>
  </tr>
  <tr height=1> 
    <td bgcolor=#dadada width=213><img src=/admin/images/common/sp.gif height=1></td>
    <td bgcolor=#dadada width=700><img src=/admin/images/common/sp.gif height=1></td>
    <td rowspan=3 bgcolor=#dadada width=1><img src=/admin/images/common/sp.gif height=1></td>
    <td width="340" bgcolor=#ffffff><img src=/admin/images/common/sp.gif height=1></td>
  </tr>
  <!-- footer start-->
  <jsp:include page="/admin/footer.jsp" />
  <!-- footer end-->
</table> 
</body>
</html>  
