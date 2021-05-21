<%@ page language="java" %>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%
    String mode = "";
    String f_addr3 = "";

    if(request.getParameter("mode") != null) {
        mode = request.getParameter("mode");
    }

    if(request.getParameter("f_addr3") != null) {
        f_addr3 = CharacterSet.toKorean(request.getParameter("f_addr3"));
    }

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
	<head>
		<title>관리자페이지</title>
		<link href="/vodman/include/css/a_base.css" rel="stylesheet" type="text/css" />
		<script language="JavaScript" type="text/JavaScript">
<!--

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

	function select_addr() {
		var f_index = document.form2.f_address.selectedIndex;
		document.form2.f_addr5.value = document.form2.f_address.options[f_index].value;
		document.form2.f_addr6.focus();
	}
	function zip_result() {
		var f_index = document.form2.f_address.selectedIndex;
		if(f_index == 0) {
			alert('먼저 주소를 선택하세요');
			return;
		}
		if(document.form2.f_addr5.value == "" || document.form2.f_addr6.value == "") {
			alert('나머지 주소를 입력하세요');
			document.form2.f_addr6.focus();
			return;
		}
		var f_address = document.form2.f_addr5.value;
		var f_zip1 = f_address.substring(1,4);
		var f_zip2 = f_address.substring(5,8);
		var f_zip_other = f_address.substring(10, f_address.length) + document.form2.f_addr6.value;

		opener.document.frmMember.zip.value = f_zip1 + "-" + f_zip2;
		opener.document.frmMember.address1.value = f_address.substring(10, f_address.length);
		opener.document.frmMember.address2.value = document.form2.f_addr6.value;
//		opener.document.frmMember.office_name.focus();
		window.close();
	}
	function check_form() {
		if(!document.form1.f_addr3.value) {
			alert('읍/면/동 이름을 입력하세요');
			document.form1.f_addr3.focus();
			return ;
		}
		document.form1.submit();
	}

//-->
</script>

	</head>
<body>
<div id="research">
	<h3><img src="/vodman/include/images/a_zip_title.gif" alt="우편번호찾기"/></h3>
	<div id="research_top"></div>
	<div id="research_cen">
		<table cellspacing="0" class="close" summary="우편번호찾기">
			<caption>우편번호찾기</caption>
			<colgroup>
				<col/>
			</colgroup>
			<tbody class="font_127">
			
				<tr>
					<td class="title_dot01">동/읍/면의 이름을 입력하시고 '주소찾기'를 클릭하세요.<br/>(예 : 삼성동 또는 창녕읍 또는 홍동면)</td>
				</tr>
				<tr>
					<td class="height_5"></td>
				</tr>
				<form name="form1" method="post" action="pop_zipCode.jsp">
				<input type="hidden" name="mode" value="search" />
				<tr>
					<td class="back_f7 align_center height_35 bor_bottom01 bor_top01"><input type="text" name="f_addr3" value="<%=f_addr3%>" class="input01" style="width:200px;" value="<%=f_addr3%>"/>&nbsp;<a href="javascript:check_form();" title="주소찾기"><img src="/vodman/include/images/but_zip.gif" alt="주소찾기"/></a></td>
				</tr>
				</form>
				<tr>
					<td class="height_15"></td>
				</tr>
				 <%
                    if(mode.equals("search")) {
                        String query = "select c_zip, c_addr1, c_addr2, c_addr3, c_addr4 from zipcode where c_addr2 like '%" +f_addr3+ "' or c_addr3 like '%" +f_addr3+ "%'";
                        Vector v = MemberManager.getInstance().selectQueryList(query);

                        if(v.size() > 0) {
                 %>
				 <form name="form2" method="post">
				<tr class="height_35">
					<td class="title_dot01">주소를 선택해 주세요.<br/>
						<select name="f_address" class="sec01" style="width:350px;" onChange="select_addr();">
						<option value=''>주소를 선택해 주세요</option>
						 <%
                            String c_zip = "";
                            String c_addr1 = "";
                            String c_addr2 = "";
                            String c_addr3 = "";
                            String c_addr4 = "";

                            try{
                                for(int i=0; i<v.size(); i++) {
                                    c_zip = String.valueOf(((Vector)(v.elementAt(i))).elementAt(0));
                                    c_addr1 = String.valueOf(((Vector)(v.elementAt(i))).elementAt(1));
                                    c_addr2 = String.valueOf(((Vector)(v.elementAt(i))).elementAt(2));
                                    c_addr3 = String.valueOf(((Vector)(v.elementAt(i))).elementAt(3));
                                    c_addr4 = String.valueOf(((Vector)(v.elementAt(i))).elementAt(4));

                                    String zip1 = c_zip.substring(0, 3);
                                    String zip2 = c_zip.substring(3, 6);
                                    String zip_full = "[" +zip1+ "-" +zip2+ "] " +c_addr1+ " " +c_addr2+ " " +c_addr3+ " " +c_addr4;
                                    String zip_full_ = "[" +zip1+ "-" +zip2+ "] " +c_addr1+ " " +c_addr2+ " " +c_addr3;
                                    out.println("<option value='" +zip_full_+ "'>" +zip_full+ "</option>");
                                }
                            }catch(Exception e) {
                                System.out.println(e.getMessage());
                            }

						%>
							</select>
					</td>
				</tr>
				<tr>
					<td class="height_15"></td>
				</tr>
				<tr class="height_35">
					<td class="title_dot01">선택된 주소<br/><input type="text" name="f_addr5" value="" class="input01" style="width:350px;"/></td>
				</tr>
				<tr>
					<td class="height_15"></td>
				</tr>
				<tr>
					<td class="title_dot01">나머지 주소를 입력해주세요.<br/>	<input type="text" name="f_addr6" value="" class="input01" style="width:200px;"/>&nbsp;<a href="javascript:zip_result();" title="확인"><img src="/vodman/include/images/but_ok.gif" alt="확인"/></a>
					</td>
				</tr>
				</form>
				  <%
                        }
                    }
                %>
			</tbody>
		</table>
	</div>
	<div id="research_bot"></div>
	<div class="but01">
		<a href="javascript:self.close();"><img src="/vodman/include/images/but_close.gif" alt="닫기"/></a>
	</div>		
</div>
</body>
</html>