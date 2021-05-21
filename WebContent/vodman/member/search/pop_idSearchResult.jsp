<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>
<jsp:useBean id="textUtil" class="com.vodcaster.utils.TextUtil"/>
<jsp:useBean id="charSet" class="com.yundara.util.CharacterSet"/>
<jsp:useBean id="directMng" class="com.vodcaster.sqlbean.DirectoryNameManager"/>
<%
	String skin_full_name = "/include/skin/";

%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="<%=skin_full_name%>/css/basic.css" type="text/css">
<script language='javascript' src="<%=skin_full_name%>/js/script.js"></script>
<script language="JavaScript" type="text/JavaScript">
<!--



function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="400" border="0" cellpadding="0" cellspacing="0" background="<%=skin_full_name%>/images/pop_idSearchResult_bg.gif">
  <tr align="center"> 
    <td height="50" align="center"><img src="<%=skin_full_name%>/images/pop_member.gif" width="400" height="30"></td>
  </tr>
  <tr align="center"> 
    <td align="center"><table width="95%" height="150" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr> 
          <td align="center"><table width="90%" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="25" valign="top"><img src="<%=skin_full_name%>/images/member_idSearch_text_01.gif" width="120" height="20"></td>
              </tr>
              <tr> 
                <td height="2" bgcolor="#008E77"></td>
              </tr>
              <tr> 
                <td height="70" align="center"><table width="90%" height="40" border="0" cellpadding="0" cellspacing="0" bgcolor="#DFEEEC">
                    <tr> 
                      <td align="center"><strong><font color="#008E77">이윤희 회원님의 
                        아이디는 [yuney1] 입니다.</font></strong></td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td align="center"> <table border="0" cellspacing="0" cellpadding="2">
                    <tr> 
                      <td><img src="<%=skin_full_name%>/images/btn_login.gif" width="42" height="22"></td>
                      <td><img src="<%=skin_full_name%>/images/button_login_password.gif" width="72" height="22"></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr align="center"> 
    <td height="30"><img src="<%=skin_full_name%>/images/ico_close.gif" width="46" height="15"></td>
  </tr>
</table>
</body>
</html>
