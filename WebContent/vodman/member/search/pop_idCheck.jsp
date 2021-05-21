<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
 <%@ include file = "/vodman/include/auth_pop.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
	<head>
		<title>아이디 체크</title>
		<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="/vodman/include/js/script.js"></script>
<script language="JavaScript" type="text/JavaScript">
<!--

    function MM_preloadImages() { //v3.0
      var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
        var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
        if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
    }

	function useID(id) {
		 
		opener.document.getElementById("approval").value = "Y";
		 
		opener.document.getElementById("id").readOnly = true;
	 
		opener.document.getElementById("id").value = id;
	 
		opener.document.getElementById("pwd").focus();
	 
		this.close();
		return;
	}

	function noUseID() {
		
		opener.document.getElementById("id").value = "";
		opener.document.getElementById("id").focus();
		this.close();
		return;
	}

	function checkForm(form) {
		if(document.getElementById("fid") && document.getElementById("fid").value == "") {
			alert("아이디를 입력해주세요.");
			document.getElementById("fid").focus();
			return;
		}
		if (document.getElementById("fid").value.length < 8 || document.getElementById("fid").value.length > 12) {
				alert("아이디는 8자 이상 - 12자 이하로 입력하세요");
				document.getElementById("fid").focus();
				return;
			}
		if(!pwCheck(document.getElementById("fid").value)){
				document.getElementById("fid").focus();
				alert("아이디는 영문+숫자를 최소한 한자 이상씩 조합한 8자 이상, 12자 이내로 입력하시기 바랍니다.");
				return;
			}
		mid = document.getElementById("fid").value;
		searchko = mid.value;

		if(!isNaN(searchko)){
			alert("숫자만 입력할 수 없습니다!");
			mid.value="";
			mid.focus();
			return ;
		} 
		form.submit();	
	}
//-->
</script>
<%
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
					%>
					<script language="JavaScript" type="text/JavaScript">
					opener.document.getElementById("approval").value = "N";
					</script>
					<%
					msg = "이미 같은 아이디가 존재합니다.<br>" +
"                        다른 아이디를 입력해주세요.";
					rtn_script ="";
				}else {
					
					%>
					<script language="JavaScript" type="text/JavaScript">
					opener.document.getElementById("approval").value = "Y";
					</script>
					<%
					msg = "축하합니다 ! <span class='font_120'>" +fid+ "</span>은(는) 사용 가능합니다.</font>";
					rtn_script = "<br><span style='cursor:hand' onClick=\"useID('"+fid+"')\"><img src='/vodman/include/images/but_busi.gif' border='0'></span>";
				}

			}catch(Exception e) {}

		}

	}else{

		fid = request.getParameter("fid").replaceAll("<","").replaceAll(">","").trim();

		msg = "가입을 원하는 아이디를 입력하고 중복체크를 누르세요";

	}

%>
	</head>
<body>
<div id="research">
	<h3><img src="/vodman/include/images/a_idcheck_title.gif" alt="아이디중복체크"/></h3>
	<div id="research_top"></div>
	<div id="research_cen">
	<form name="form1" method="post" action="pop_idCheck.jsp" >
		<table cellspacing="0" class="close" summary="아이디중복체크">
			<caption>아이디중복체크</caption>
			<colgroup>
				<col/>
				<col/>
				<col/>
			</colgroup>
			<tbody class="font_127 align_center">
				<tr class="height_50">
					<td colspan="3"><%=msg%><br/><%=rtn_script%></td>
				</tr>
				<tr>
					<td class="height_5 bor_bottom01" colspan="3"></td>
				</tr>
				<tr>
					<td class="height_5" colspan="3"></td>
				</tr>
				<tr>
				<td class="align_right02">다른 아이디를 입력해주세요.</td>
				<td><input type="text" id="fid" name="fid" value="<%=fid%>" class="input01" maxlength="12" style="width:180px;" onkeyup="fc_chk_byte(this,12)" /></td>
				<td class="pa_left"><a href="javascript:checkForm(document.form1);" title="중복체크"><img src="/vodman/include/images/but_idcheck.gif" alt="중복체크"/></a></td>
				</tr>
			</tbody>
			
		</table>
		</form>
	</div>
	<div id="research_bot"></div>
	<div class="but01">
		<a href="javascript:self.close();"><img src="/vodman/include/images/but_close.gif" alt="닫기"/></a>
	</div>		
</div>
</body>
</html>