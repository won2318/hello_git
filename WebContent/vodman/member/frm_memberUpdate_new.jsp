<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
com.rsa.*,
com.vodcaster.utils.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "m_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
//request.setCharacterEncoding("euc-kr");
 
 			LoginRsa handler = new LoginRsa( request );
			handler.processRequest(request);
			 
            String publicKeyModulus = (String) request.getAttribute("publicKeyModulus");
            String publicKeyExponent = (String) request.getAttribute("publicKeyExponent");
%>
<%@ include file="/vodman/include/top.jsp"%>
<%

	/**
	 * @author 주현
	 *
	 * @description : 회원정보 수정.
	 * date : 2009-10-19
	 */


	String id = request.getParameter("id").replaceAll("<","").replaceAll(">","");
 // 링크유지
    int pg = 0;
	String sex = "";
    String level = "";
	String useMailling = "";
	String joinDate1 = "";
	String joinDate2 = "";
	String searchField = "";
	String searchString = "";

    if(request.getParameter("page")==null){
        pg = 1;
    }else{
		try{
			if(com.vodcaster.utils.TextUtil.getValue(request.getParameter("page")) != ""){
				pg = Integer.parseInt(request.getParameter("page"));
			}
		}catch(Exception ex){
			pg =1;
		}
    }

	if(request.getParameter("sex") != null && request.getParameter("sex").length()>0 && !request.getParameter("sex").equals("null"))
		sex = request.getParameter("sex").replaceAll("<","").replaceAll(">","");

	if(request.getParameter("slevel") != null && request.getParameter("slevel").length()>0 && !request.getParameter("slevel").equals("null"))
		level = request.getParameter("slevel").replaceAll("<","").replaceAll(">","");

	if(request.getParameter("useMailling") != null && request.getParameter("useMailling").length()>0 && !request.getParameter("useMailling").equals("null"))
		useMailling = request.getParameter("useMailling").replaceAll("<","").replaceAll(">","");

	if(request.getParameter("joinDate1") != null && request.getParameter("joinDate1").length()>0 && !request.getParameter("joinDate1").equals("null"))
		joinDate1 = request.getParameter("joinDate1").replaceAll("<","").replaceAll(">","");

	if(request.getParameter("joinDate2") != null && request.getParameter("joinDate2").length()>0 && !request.getParameter("joinDate2").equals("null"))
		joinDate2 = request.getParameter("joinDate2").replaceAll("<","").replaceAll(">","");

	if(request.getParameter("searchField") != null && request.getParameter("searchField").length()>0 && !request.getParameter("searchField").equals("null"))
		searchField = request.getParameter("searchField").replaceAll("<","").replaceAll(">","");

	if(request.getParameter("searchString") != null && request.getParameter("searchString").length()>0 && !request.getParameter("searchString").equals("null"))
		searchString = request.getParameter("searchString").replaceAll("<","").replaceAll(">","");
	
       String strLink = "&page=" +pg+ "&ssex=" +sex+ "&slevel=" +level+ "&useMailling=" +useMailling+ "&joinDate1=" +joinDate1+ "&joinDate2=" +joinDate2+ "&searchField=" +searchField+ "&searchString=" +searchString;
    // 링크유지


	if(id == null || id.equals("") || id.equals("null")) {
		 
		String REF_URL="mng_memberList.jsp?mcode="+mcode +strLink;
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('잘 못된 접근입니다. 이전 페이지로 이동합니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		%>
		<%@ include file = "/vodman/include/REF_URL.jsp"%>
		<%
			return;
	}


   


	MemberManager mgr = MemberManager.getInstance();
	Vector vt = mgr.getMemberInfo(id);
	MemberInfoBeanRsa info = new MemberInfoBeanRsa();

	try {
		if(vt != null && vt.size()>0){
			Enumeration e = vt.elements();
			com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
		}else{
			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('처리 중 오류가 발생하였습니다.')");
			//out.println("history.go(-1)");
			out.println("</SCRIPT>");
			String REF_URL="mng_memberList.jsp?mcode="+mcode+strLink ;
			%>
		<%@ include file = "/vodman/include/REF_URL.jsp"%>
		<%
		}

	} catch (Exception e) {
		out.println("<SCRIPT LANGUAGE='JavaScript'>");
		out.println("alert('처리 중 오류가 발생하였습니다.')");
		//out.println("history.go(-1)");
		out.println("</SCRIPT>");
		String REF_URL="mng_memberList.jsp?mcode="+mcode+strLink ;
		%>
		<%@ include file = "/vodman/include/REF_URL.jsp"%>
		<%
	}

	
	String[] tel = null;
	String tel1 = "";
	String tel2 = "";
	String tel3 = "";
	String[] hp = null;
	String hp1 = "";
	String hp2 = "";
	String hp3 = "";
	
	String email1 = "";
	String email2 = "";
	
	if(info.getEmail() != null && info.getEmail().length() > 0) {
	    email1 = com.vodcaster.utils.TextUtil.resstr(info.getEmail(), "@", -1).equals("null") ? "" : com.vodcaster.utils.TextUtil.resstr(info.getEmail(), "@", -1);
	    email2 = com.vodcaster.utils.TextUtil.resstr(info.getEmail(), "@", 1).equals("null") ? "" : com.vodcaster.utils.TextUtil.resstr(info.getEmail(), "@", 1);
	}
	
	if(info.getTel() != null && info.getTel().length()>3 && !info.getTel().equals("--") && info.getTel().length() <= 14){
		tel = info.getTel().split("-");
		if (tel.length > 0) {
		tel1 = tel[0];
		}
		if (tel.length > 1) {
		tel2 = tel[1];
		}
		//if(info.getTel().substring(0,info.getTel().lastIndexOf("-")+1).length() < info.getTel().length()) {
		if (tel.length > 2) {
			tel3 = tel[2];
		}
 
	}
 
	if(info.getHp() != null && info.getHp().length()>3 && !info.getHp().equals("--") && info.getHp().length() <= 14){
		hp = info.getHp().split("-");
		hp1 = hp[0];
		hp2 = hp[1];
		try{
			if(info.getHp().substring(0,info.getHp().lastIndexOf("-")+1).length() < info.getHp().length()) {
				hp3 = hp[2];
			}
		}catch(Exception ex){
			hp3 = "0";
		}
	}
	 
%>


		<script type="text/javascript" src="/include/js/rsa/jsbn.js"></script>
        <script type="text/javascript" src="/include/js/rsa/rsa.js"></script>
        <script type="text/javascript" src="/include/js/rsa/prng4.js"></script>
        <script type="text/javascript" src="/include/js/rsa/rng.js"></script>
        <script type="text/javascript" src="/include/js/member2.js"></script>
        
<script language="javascript">
<!--
	function chkForm() {
	 
		
		if (document.getElementById("pwd").value != document.getElementById("pwd2").value) {
				alert("암호가 같지 않습니다. 다시 입력해주세요.");
				document.getElementById("pwd").focus();
				return;
			}
		
		if(!pwCheck1(document.getElementById("pwd").value) || document.getElementById("pwd").value.length < 0){
				document.getElementById("pwd").focus();
				alert("영문+숫자+특수 문자를 최소 한자 이상씩 조합한 8자 이상, 12자 이내로 입력하시기 바랍니다.");
				return;
		}

		if(!document.getElementById("email1").value  || !document.getElementById("email2").value || (document.getElementById("email2").value == "direct" && !document.getElementById("email3").value )) {
			alert("이메일주소를 입력해주세요.");
			document.getElementById("email1").focus();
			return;
		}

		var email = document.getElementById("email1").value + "@" + document.getElementById("email2").value;
		if( document.getElementById("email2").value == 'direct') {
			email = document.getElementById("email1").value + "@" + document.getElementById("email3").value;
		}
		document.getElementById("email").value = email;

		if(check_email(email) == false) {
			alert("이메일주소가 잘못되었습니다.");
			document.getElementById("email1").focus();
			return;
		}

		var tel = document.getElementById("tel1").value + "-"+ document.getElementById("tel2").value +"-"+ document.getElementById("tel3").value;
		document.getElementById("tel").value = tel;
		//var hp = document.getElementById("hp1").value +"-"+  document.getElementById("hp2").value +"-"+ document.getElementById("hp3").value;
		//document.getElementById("hp").value = hp;

		if(confirm("저장하시겠습니까?")){
			//member.js 에서 호출
			validateEncryptedForm();
		}
		

	}


	function find_zip() {

		window.open('/vodman/member/search/pop_zipCode.jsp','zip','width=550, height=350, scrollbars=no');

	}
	function length_check(){
 
		if(document.getElementById("pwd").value.length <8 || document.getElementById("pwd").value.length >12){
			alert("영문+숫자+특수 문자를 최소 한자 이상씩 조합한 8자 이상, 12자 이내로 입력하시기 바랍니다.");
			document.getElementById("pwd").value = "";
			document.getElementById("pwd").focus();
			return false;
		}
	}

	function change(sel_value) {
		 
		var dir = document.getElementById("dir");
		if(sel_value == "direct") {
			dir.style.display = "inline";
		} else {
			dir.style.display = "none";
		}
	}

//-->
</script>

<%@ include file="/vodman/member/member_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
		<%
			if(mcode != null && mcode.equals("1004")){
			%>
			<h3><span>모니터링단</span> 수정</h3>
			<p class="location">관리자페이지 &gt; 관리자관리 &gt; <span>모니터링단 수정</span></p>
			<%
			}else{
			%>
			<h3><span>관리자</span> 수정</h3>
			<p class="location">관리자페이지 &gt; 관리자관리 &gt; <span>관리자 수정</span></p>
			<%
			}
			%>
			
			<div id="content">
				<table cellspacing="0" class="board_view" summary="관리자 수정">
				<caption>관리자 수정</caption>
				<colgroup>
					<col width="17%" class="back_f7"/>
					<col/>
				</colgroup>
			 <input type="hidden" id="rsaPublicKeyModulus" value="<%=publicKeyModulus%>" />
	         <input type="hidden" id="rsaPublicKeyExponent" value="<%=publicKeyExponent%>" />
				<input type="hidden" name="id" id="id" value="<%=id%>" />
				<input type="hidden" name="name" id="name" value="<%=info.getName()%>" />
				<input type="hidden" name="hp" id="hp" value="<%=info.getHp()%>" />
				<input type="hidden" name="tel" id="tel" value="<%=info.getTel()%>" />
				
				<input type="hidden" name="sex" id="sex" value="<%=info.getSex()%>" />
				<input type="hidden" name="office_name" id="office_name" value="<%=info.getOffice_name()%>" />
		 
				<input type="hidden" name="email" id="email" value="<%=info.getEmail()%>" />
<%-- 				<input type="hidden" name="level" id="level" value="<%=info.getLevel()%>"> --%>
				<input type="hidden" name="useMailling" id="useMailling" value="<%=useMailling%>">
				<input type="hidden" name="approval" id="approval" value="<%=info.getApproval()%>" />
				<input type="hidden" name="ssn" id="ssn" value="<%=info.getSsn()%>" />
				
				<input type="hidden" name="gray" id="gray" value="<%=info.getGray()%>" />			
				<input type="hidden" name="use_mailling" id="use_mailling" value="<%=info.getUse_mailling()%>" />			
				<input type="hidden" name="auth_key" id="auth_key"  value="<%=info.getAuth_key()%>" />
				<input type="hidden" name="member_group" id="member_group"  value="<%=info.getMember_group()%>" />
				<input type="hidden" name="zip" id="zip" value="" />
				<input type="hidden" name="address1" id="address1" value=""/> 
				<input type="hidden" name="address2" id="address2" value="" />
				<tbody class="bor_top03 font_127">
					<tr>
						<th class="bor_bottom01"><strong>이름</strong></th>
						<td class="bor_bottom01 pa_left"><%=info.getName()%></td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>아이디</strong></th>
						<td class="bor_bottom01 pa_left"><%=info.getId()%>&nbsp;</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>비밀번호</strong></th>
						<td class="bor_bottom01 pa_left"><input type="password" name="pwd" id="pwd"  maxlength="12" value="" class="input01" style="width:150px;" maxlength="12" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;비밀번호 확인 <input type="password" name="pwd2" id="pwd2" maxlength="12" value="" class="input01" style="width:150px;" maxlength="12"  onfocus="javascript:length_check();"/> 
						<br/>비밀번호를 수정하려면 입력하세요.<br> [암호는 반드시 영문+숫자+특수문자 조합, 8~12자로 입력.]</td>
					</tr>
					 
					<tr>
						<th class="bor_bottom01"><strong>성별</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio" name="sex1" value="M" onclick="document.getElementById('sex').value='M';" <%if(info.getSex().equals("M")){out.println("checked");}%> /> 남&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sex1" value="F" onclick="document.getElementById('sex').value='F';" <%if(info.getSex().equals("F")){out.println("checked");}%> /> 여</td>
					</tr>
					<%--
					<tr>
						<th class="bor_bottom01"><strong>생년월일</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="ssn" id="ssn"  value="<%=info.getSsn()%>" class="input01" style="width:150px;" maxlength="30"/>&nbsp;예)20110401</td>
					</tr>
					
					<tr>
						<th class="bor_bottom01">계급</th>
						<td  class="bor_bottom01 pa_left">
							<select name="gray" id="gray" class="sec01" style="width:120px;">
							
							<option value="20" <%= (info.getGray()!= null && info.getGray().equals("20")) ? "selected" : ""%>>기타</option>


							</select>
						</td>
					</tr>
					--%>
					 
					 
					<tr>
						<th class="bor_bottom01"><strong>이메일주소</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="email1" id="email1" maxlength="30" value="<%=email1%>" class="input02" style="width:150px;"  onkeyup="checkLength(this,30)" /> @
							<span id="dir" <%if(!email2.equals("naver.com") &&!email2.equals("daum.net")&&!email2.equals("hanmail.net")&&!email2.equals("empas.com")
										&&!email2.equals("nate.com")&&!email2.equals("cyworld.com")&&!email2.equals("lycos.co.kr")&&!email2.equals("netsgo.com")&&!email2.equals("hotmail.com")
										&&!email2.equals("yahoo.co.kr")&&!email2.equals("gmail.com")) {%> style="display: inline"<%} else {%> style="display: none"<%}%>>
								<INPUT type="text" name="email3" id="email3" maxlength="20" class="input02" value="<%=email2%>" style="width:30%">
							</span>
							<span id="dir1" style="display: inline">
							<select name="email2" id="email2" class="sec02" style="width:130px;" onChange="change(this.value);">
								<option value="naver.com" 	<%if(email2.equals("naver.com"))	 	{%>selected="selected"<%}%>>naver.com	 	</option>
								<option value="daum.net" 	<%if(email2.equals("daum.net"))	 	{%>selected="selected"<%}%>>daum.net	 	</option>
								<option value="hanmail.net" <%if(email2.equals("hanmail.net"))	{%>selected="selected"<%}%>>hanmail.net 	</option>
								<option value="nate.com" 	<%if(email2.equals("nate.com"))	 	{%>selected="selected"<%}%>>nate.com	 	</option>
								<option value="cyworld.com" <%if(email2.equals("cyworld.com"))	{%>selected="selected"<%}%>>cyworld.com 	</option>
								<option value="lycos.co.kr" <%if(email2.equals("lycos.co.kr"))	{%>selected="selected"<%}%>>lycos.co.kr	</option>
								<option value="netsgo.com" 	<%if(email2.equals("netsgo.com"))	{%>selected="selected"<%}%>>netsgo.com	 	</option>
								<option value="hotmail.com" <%if(email2.equals("hotmail.com"))	{%>selected="selected"<%}%>>hotmail.com 	</option>
								<option value="yahoo.co.kr" <%if(email2.equals("yahoo.co.kr"))	{%>selected="selected"<%}%>>yahoo.co.kr 	</option>
								<option value="gmail.com" 	<%if(email2.equals("gmail.com"))	 	{%>selected="selected"<%}%>>gmail.com	 	</option>
								<option value="empas.com" 	<%if(email2.equals("empas.com"))	 	{%>selected="selected"<%}%>>empas.com	 	</option>
								<option value="direct" <%if(!email2.equals("naver.com") &&!email2.equals("daum.net")&&!email2.equals("hanmail.net") && !email2.equals("empas.com")
										&&!email2.equals("nate.com")&&!email2.equals("cyworld.com")&&!email2.equals("lycos.co.kr")&&!email2.equals("netsgo.com")&&!email2.equals("hotmail.com")
										&&!email2.equals("yahoo.co.kr")&&!email2.equals("gmail.com")) {%>selected="selected"<%}%>>직접입력</option>
							</select>
							</span>
						</td>
					</tr>
 
					<tr>
						<th class="bor_bottom01"><strong>비밀번호 재발급 질문</strong></th>
						<td class="bor_bottom01 pa_left">
						<select name="pwd_ask_num"  id="pwd_ask_num" class="sec01" style="width:200px;">
								<option value="1" <%=info.getPwd_ask_num() == 1 ? "selected" : ""%>>자신의 별명은</option>
								<option value="2" <%=info.getPwd_ask_num() == 2 ? "selected" : ""%>>잊지 못할 장소는</option>
								<option value="3" <%=info.getPwd_ask_num() == 3 ? "selected" : ""%>>가장 기억에 남는 장소는</option>
								<option value="4" <%=info.getPwd_ask_num() == 4 ? "selected" : ""%>>가장 인상깊게 읽었던 책은</option>
								<option value="5" <%=info.getPwd_ask_num() == 5 ? "selected" : ""%>>가장 기억에 남는 인물은</option>
								<option value="6" <%=info.getPwd_ask_num() == 6 ? "selected" : ""%>>가장 좋아하는 캐릭터는</option>
								<option value="7" <%=info.getPwd_ask_num() == 7 ? "selected" : ""%>>자신의 보물 1호는</option>
								<option value="8" <%=info.getPwd_ask_num() == 8 ? "selected" : ""%>>좋아하는 색깔은</option>
								<option value="9" <%=info.getPwd_ask_num() == 9 ? "selected" : ""%>>가장 소중한 물건은</option>
								<option value="10" <%=info.getPwd_ask_num() == 10 ? "selected" : ""%>>애인 이름은</option>
								<option value="11" <%=info.getPwd_ask_num() == 11 ? "selected" : ""%>>기타</option>
							</select>
							혹시 비밀번호를 잊어버리신 경우 여기에서 선택한 질문을 하게됩니다. 
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>비밀번호 재발급 답변 </strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="pwd_answer" id="pwd_answer" value="<%=info.getPwd_answer()%>" class="input01" style="width:150px;" maxlength="30" onkeyup="checkLength(this,30)" />&nbsp;(한글 15자이하, 영문 30자이하 내외로 작성)</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>소속</strong></th>
						<td class="bor_bottom01 pa_left">
 
							<input type="text" name="buseo" id="buseo" value="<%=info.getBuseo()%>" class="input01" style="width:150px;" maxlength="30" onkeyup="checkLength(this,30)" />  
					 
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>회원 구분 </strong></th>
						<td class="bor_bottom01 pa_left">
						<select name="level" id="level" class="sec01" style="width:200px;">
								<option value="1" <%=info.getLevel() == 1 ? "selected" : ""%>>일반회원</option>
								<option value="2" <%=info.getLevel() == 2 ? "selected" : ""%>>모니터링단</option>
								<option value="9" <%=info.getLevel() == 9 ? "selected" : ""%>>관리자</option>
							 
							</select>
						</td>
					</tr>

					<tr>
						<th class="bor_bottom01"><strong>전화번호</strong></th>
						<td class="bor_bottom01 pa_left">
 
							<input type="text" name="tel1" id="tel1" value="<%=tel1%>" class="input01" style="width:50px;" maxlength="4"  onKeyDown="onlyNumber(this);"/> -
							<input type="text" name="tel2" id="tel2"  value="<%=tel2%>" class="input01" style="width:50px;" maxlength="4"  onKeyDown="onlyNumber(this);"/> - 
							<input type="text" name="tel3" id="tel3" value="<%=tel3%>" class="input01" style="width:50px;" maxlength="4"  onKeyDown="onlyNumber(this);"/>
						</td>
					</tr>
<%--
					<tr>
						<th class="bor_bottom01"><strong>휴대폰</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="hp1" id="hp1" class="sec01" style="width:50px;">
								<option value='' <%if(hp1 == null || hp1.length() == 0){out.println("selected");}%>>선택</option>
														<option value="010" <%=hp1.equals("010") ? "selected" : ""%>>010</option>
														<option value="011" <%=hp1.equals("011") ? "selected" : ""%>>011</option>
														<option value="016" <%=hp1.equals("016") ? "selected" : ""%>>016</option>
														<option value="017" <%=hp1.equals("017") ? "selected" : ""%>>017</option>
														<option value="018" <%=hp1.equals("018") ? "selected" : ""%>>018</option>
														<option value="019" <%=hp1.equals("019") ? "selected" : ""%>>019</option>
							</select> - 
							<input type="text" name="hp2" id="hp2" value="<%=hp2%>" class="input01" style="width:50px;" maxlength="4" onkeypress="onlyNumber();"/> - 
							<input type="text" name="hp3" id="hp3" value="<%=hp3%>" class="input01" style="width:50px;" maxlength="4" onkeypress="onlyNumber();"/>
						</td>
					</tr>
 
					<tr>
						<th class="bor_bottom01"><strong>자택주소</strong></th>
						<td class="bor_bottom01 pa_left">
							<input type="text" name="zip" id="zip" value="<%=info.getZip()%>" class="input01" style="width:100px;" readonly/>&nbsp;<a href="javascript:find_zip(document.frmMember);" title="우편번호찾기"><img src="/vodman/include/images/but_zipcheck.gif" alt="우편번호찾기"/></a>&nbsp;<br/>
							<input type="text" name="address1" id="address1" maxlength="50" value="<%=info.getAddress1()%>" class="input01" style="width:250px;" readonly/>&nbsp;
							<input type="text" name="address2" id="address2" maxlength="50" value="<%=info.getAddress2()%>" class="input01" style="width:200px;"/>
						</td>
					</tr>
 
<%-- 
					 <%
					  BuseoManager Bmgr = BuseoManager.getInstance();
					  BuseoInfoBean b_info = new BuseoInfoBean();

					  Vector b_vt = Bmgr.getBuseo_ListAll();
					  %>
					<tr>
						<th class="bor_bottom01"><strong>부서</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="buseo" id="buseo" class="sec01" style="width:130px;">
								<option value="">부서선택</option>
								<%
									if ( b_vt != null && b_vt.size() > 0){
										for(int i = 0;i<b_vt.size(); i++ ){
											com.yundara.beans.BeanUtils.fill(b_info, (Hashtable)b_vt.elementAt(i));
											%>
											<option value='<%=b_info.getBuseo_code()%>' <%if( info.getBuseo() != null && info.getBuseo().length()>0 &&  b_info.getBuseo_code().equals(info.getBuseo())){ out.println(" selected ");} %>><%=b_info.getBuseo_name()%></option>
											<%
										}
									}

									%>
							</select>
						</td>
					</tr>

					<%

					  GrayManager Gmgr = GrayManager.getInstance();
					  GrayInfoBean g_info = new GrayInfoBean();

					  Vector g_vt = Gmgr.getGray_ListAll();
					  %>
					<tr>
						<th class="bor_bottom01"><strong>직급</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="gray" id="gray" class="sec01" style="width:130px;">
								<option value="">직급선택</option>
								<%
								if ( g_vt != null && g_vt.size() > 0){
									for(int i = 0;i<g_vt.size(); i++ ){
										com.yundara.beans.BeanUtils.fill(g_info, (Hashtable)g_vt.elementAt(i));
										%>
										<option value='<%=g_info.getGray_code()%>' <%if(info.getBuseo() != null && info.getBuseo().length()>0 &&  g_info.getGray_code().equals(info.getGray())){ out.println(" selected ");} %>><%=g_info.getGray_name()%></option>
										<%
									}
								}

								%>
							</select>
						</td>
					</tr>
 --%>
					
			 
				 		
				 
				</tbody>
				</table>
				
				<div class="but01">
					<a href="javascript:chkForm();" title="저장"><img src="/vodman/include/images/but_save.gif" alt="저장"/></a>
					<a href="mng_memberList.jsp?mcode=<%=mcode%><%=strLink%>" title="취소"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
				</div>	
				
				<br/><br/>
				 
				 <form id="securedLoginForm" name="securedLoginForm" action="proc_memberUpdate_new.jsp" method="post" style="display: none;">
				 	
		            <input type="hidden" name="id_" id="id_" value="" />
		            <input type="hidden" name="pwd_" id="pwd_" value="" />
		            <input type="hidden" name="name_" id="name_" value="" />
		            <input type="hidden" name="email_" id="email_" value="" />
		            <input type="hidden" name="sex_" id="sex_" value="" />
		            <input type="hidden" name="tel_" id="tel_" value="" />
		            <input type="hidden" name="hp_" id="hp_" value="" />
		            <input type="hidden" name="zip_" id="zip_" value="" />
		            <input type="hidden" name="address1_" id="address1_" value="" />
		            <input type="hidden" name="address2_" id="address2_" value="" />
		            <input type="hidden" name="office_name_" id="office_name_" value="" />
		            <input type="hidden" name="level_" id="level_" value="" />
		            <input type="hidden" name="use_mailling_" id="use_mailling_" value="" />
		            <input type="hidden" name="auth_key_" id="auth_key_" value="" />
		            <input type="hidden" name="approval_" id="approval_" value="" />
		            <input type="hidden" name="pwd_ask_num_" id="pwd_ask_num_" value="" />
		            <input type="hidden" name="pwd_answer_" id="pwd_answer_" value="" />
		            <input type="hidden" name="member_group_" id="member_group_" value="" />
		            <input type="hidden" name="buseo_" id="buseo_" value="" />
		            <input type="hidden" name="gray_" id="gray_" value="" />
		            <input type="hidden" name="ssn_" id="ssn_" value="" />
		            
			        <input type="hidden" name="mcode"  value="<%=mcode%>" />
					<input type="hidden" name="slevel" value="<%=level%>" />
					<input type="hidden" name="ssex"  value="<%=sex%>" />
					<input type="hidden" name="pg" id="pg" value="<%=pg%>" />
					<input type="hidden" name="joinDate1" id="joinDate1" value="<%=joinDate1%>" />
					<input type="hidden" name="joinDate2" id="joinDate2" value="<%=joinDate2%>" />
					<input type="hidden" name="searchField" id="searchField" value="<%=searchField%>" />
					<input type="hidden" name="searchString" id="searchString" value="<%=searchString%>" />

		        </form>
		        
			</div>
		</div>	
<%@ include file="/vodman/include/footer.jsp"%>