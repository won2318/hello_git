<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.hrlee.sqlbean.MediaManager"%>
 <jsp:useBean id="contact" class="com.vodcaster.sqlbean.ContactBean"/>
<%@ include file = "/include/chkLogin.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />

</head>
 <jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
 
<%
contact.setPage_cnn_cnt("W"); // 페이지 접속 카운트 증가

	SubjectManager mgr = SubjectManager.getInstance();
	SubjectInfoBean Sin = new SubjectInfoBean();

	String sub_flag = "S"; // S - 설문 ,  E - 이벤트, H - hot7
 
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag");
	}
 
	Vector vt = mgr.getSubjectListDate(sub_flag);
	Vector vt1 = null;

	String sub_idx = "";
	String sub_title = "";
	String sub_start = "";
	String sub_end = "";
 
	String sub_person = "";
	String sub_name = "";
	String sub_mf = "";
	String sub_tel = "";
	String sub_email = "";
	String sub_etc = "";
	String sub_user_on = "N";
	int user_cnt = 0;
	if (vt != null && vt.size() > 0) 
	{  // if (vt)
		sub_idx = String.valueOf(vt.elementAt(0));
		sub_title = String.valueOf(vt.elementAt(1));
		sub_person = String.valueOf(vt.elementAt(4));
		sub_name = String.valueOf(vt.elementAt(5));
		sub_mf = String.valueOf(vt.elementAt(6));
		sub_tel = String.valueOf(vt.elementAt(7));
		sub_email = String.valueOf(vt.elementAt(8));
		sub_etc = String.valueOf(vt.elementAt(9));
		sub_user_on = String.valueOf(vt.elementAt(11));
		user_cnt = Integer.parseInt(String.valueOf(vt.elementAt(12)));
		
		
		if ( ( sub_user_on != null && sub_user_on.equals("N") )|| ( vod_id != null && vod_id.length() > 0 )) 
		{ // 실명확인 체크
			
			
			if (sub_person != null && Integer.parseInt(sub_person) < user_cnt) {
				out.println("<script>alert('설문 참여 인원에 제한이 있습니다. 창을 닫습니다.');self.close();</script>");
			} else {
				
				
				if (( sub_user_on != null && sub_user_on.equals("N") )&& ( vod_id == null || vod_id.length() <= 0 )) {
					java.util.Date day = new java.util.Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
					String todayDate = sdf.format(day);
					vod_id = todayDate;
				}
				
				if (mgr.getSubjectUser_check(sub_idx, user_key) != null && mgr.getSubjectUser_check(sub_idx, user_key).length() > 0) {
							out.println("<script>alert('이미 참여 하셨습니다. 창을 닫습니다.');self.close();</script>");
				} 
				else 
				{
%>

<script language="javascript">
//	if( getCookie("cyberPoll") == "done")
//	{
//		alert('이미 참여 하셨습니다.');
//		self.close();
//	}

	function getCookie(Name)
	{
		var search = Name + "=";
		if(document.cookie.length > 0 )
		{
			offset = document.cookie.indexOf(search);
			if( offset != -1)
			{
				offset += search.length;
				end = document.cookie.indexOf(";",offset);
				if( end == -1)
				{
					end = document.cookie.length;
				}
				return unescape(document.cookie.substring(offset, end));
				
			}
		}
	}

	function setCookie(name, value, expiredays)
	{
		var todayDate = new Date();
		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}

	function checkCheckbox(frm,obj,num)
	{
		var str = obj.name;
		var len = frm.length;
 
		var chk = 0;
		for(i=0; i<len; i++)
		{
			if (frm[i].name == str && frm[i].checked == true)
			{
 
				chk++;
			}

			if (chk > num)
			{
				alert(num + "개를 선택하세요.");
				obj.checked = false;
				break;
			}
		}
	}

	// 다중선택 제한 갯수 확인 체크
	function checkCheckbox2( str,num, q_no )
	{
		//var str = obj.name;
		var len = document.getElementsByName(str).length;
  
		var chk = 0;
		for(i=0; i<len; i++)
		{
 
			var array_str = document.getElementsByName(str);
			if (document.getElementsByName(str)[i].checked == true )
			{ 
				chk++; 
			} 
		}
		if (chk != parseInt(num))
		{
			alert(q_no +" 번 항목은 "+ num + "개를 선택하세요.");
			return true; 
		}
	}

	function aa_submit()
	{
		var f = document.subject_user;
		
		<% if (sub_name != null && sub_name.equals("Y"))
		{ %>
			if(f.user_name.value == "")
			{
					alert("이름을 입력 하세요!");
					f.user_name.focus();
				return;
			}
		<%} 
		if (sub_mf != null && sub_mf.equals("Y"))
		{%>
			var ret = false;
			for(var i=0; i<f.user_mf.length; i++)
			{
				if(f.user_mf[i].checked)
				{
					ret = true;
					break;
				}
			}
	
			if(!ret)
			{
			   alert('성별을 체크하여 주십시오.');
			   return ;
			}

		<%} 
		if (sub_tel != null && sub_tel.equals("Y"))
		{ %>
			if(f.user_tel.value == "")
			{
				alert("연락처를 입력 하세요!");
				f.user_tel.focus();
				return;
			}
		<%}
		if (sub_email != null && sub_email.equals("Y"))
		{%>
			if(f.user_email.value == "")
			{
				alert("이메일을 입력 하세요!");
				f.user_email.focus();
				return;
			}
		<%}%>

		var temp_check_cnt = document.getElementById("check_cnt").value;
		if (temp_check_cnt > 0) {

			if (temp_check_cnt == 1) {  

				if(checkCheckbox2(f.check_no.value ,f.check_num.value , f.q_no.value )){
					return;
				}
				 
			} else {
				for (var i = 0; i < temp_check_cnt; i++) {
						if(checkCheckbox2(f.check_no[i].value ,f.check_num[i].value,f.q_no[i].value)){
							return;
						}					 
					}
				 
			}
			 
		}
		 
		setCookie("cyberPoll", "done", 1);
		document.subject_user.submit();
	}
	
	
	function vod_view(ocode){
		 
		var url = "/2013/video/video_700k.jsp?ocode="+ocode;
		window.open(url,"700k_player","width=910,height=790,scrollbars=yes,status=no");
	 
	}
	
</script>

<body>

<div id="pWrapMiddle">
	<!-- container::메인컨텐츠 -->
 
<div id="pContainerMiddle">
 <form name='subject_user' method='post' action="proc_subject_user.jsp">
	<input type='hidden' name='sub_flag' value='<%=sub_flag%>' />
	<input type='hidden' name='user_etc' value='<%=session.getValue("user_key")%>' /> 
	
	<input type="hidden" value="0" name="check_cnt" id="check_cnt" />
	
	<div id="pContent">
			<h3 class="pTitle"><%=sub_title%></h3>
			<div class="pSubject">
				<span class="con"><% if (sub_etc != null && sub_etc.length() > 0 )  { %> <%=chb.getContent(sub_etc)%> <%}%></span>
				<span class="infoUser">
					<span class="personalInfoTitle">개인정보입력</span>
					<div class="personalInfo">
					<%if(sub_name != null && sub_name.equals("Y")){ %>
					<dl>
						<dt><label for="user_name">작성자</label></dt>
						<dd><input type="text" name="user_name" value="" id="user_name" size="70" title="작성자" class="inputType"/></dd>
					</dl>
					<%}%>
					<%if(sub_mf != null && sub_mf.equals("Y")){ %>
					<dl>
						<dt><label for="male">성별</label></dt>
						<dd>
							<input type="radio" name="user_mf" id="male" value="M" title="남"/> <label for="male">남</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="user_mf" id="female" value="W" title="여"/> <label for="female">여</label>
						</dd>
					</dl>
					<%} %>
					<%if(sub_tel != null && sub_tel.equals("Y")){ %>
					<dl>
						<dt><label for="user_tel">연락처</label></dt>
						<dd>
							<input type="text" name="user_tel" value="" id="user_tel" size="13" maxlength="13" title="연락처 " class="inputType"/>
							 
						</dd>
					</dl>
					<%} %>
					<%if(sub_tel != null && sub_tel.equals("Y")) { %>
					 
					<dl>
						<dt><label for="user_email">이메일</label></dt>
						<dd><input type="text" name="user_email" value="" id="user_email" size="70" title="이메일" class="inputType"/></dd>
					</dl>
					<%} %>
					</div>
				</span>
				<ul class="researchList">
		<%
        vt1 =  mgr.getSubject_QuiestionList( sub_idx );  // sub_idx
		String question_idx = "";
		String question_content = "";
		String question_option = "";
		String question_info = "";
		String question_etc = "";
		String question_num = "";
		String question_image = "";
		if(vt1 != null && vt1.size() > 0)
		{  // if (vt1)
		%>			
			<input type='hidden' name='sub_idx' value='<%=sub_idx%>' />
			<input type='hidden' name='question_count' value='<%=vt1.size()%>' />
		<%
	//out.println(vt1);
			for(int i = 0 ; i < vt1.size() ; i++)
			{ // for (vt1)
				question_idx = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(0));
				question_content = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(2));
				question_option = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(3));
				question_info = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(4));
				question_etc = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(5));
				question_num = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(6));
				question_image = String.valueOf(((Vector)(vt1.elementAt(i))).elementAt(7));
	             
	    	    Vector vt2 = mgr.getSubject_AnsList( question_idx );   
				String ans_idx = "";
				String step_flag = "";
				String ans_num = "";
				String ans_content = "";
				String ans_order = "";
				String ans_etc = "";
				String ans_img = "";
				String ans_hot7_ocode = "";

				if (question_option.equals("4")) { %>
			   <input type='hidden' name="Q<%=i%>" value="option4_<%=question_idx%>" />
			   <% } else if (question_option.equals("3") || question_option.equals("2") ||   question_option.equals("6")){
				   
				  if (question_option.equals("3") || question_option.equals("6")) {
					  %>
					   	<input type="hidden" value="<%=question_idx%>" name="check_no"   />
					   	<input type="hidden" value="<%=question_etc %>" name="check_num"   />
					   	<input type="hidden" value="<%=question_num%>" name="q_no"   />
					   	
							<script language="javascript">
							var temp_cnt = document.getElementById("check_cnt").value;
							document.getElementById("check_cnt").value = parseInt(temp_cnt)+1;
							//alert(temp_cnt);
							</script> 
					   <%
				  }
			   %>
			   <input type='hidden' name="Q<%=i%>" value="option3_<%=question_idx%>" />
			   <% } else if (question_option.equals("5"))  { %>
			   <input type='hidden' name="Q<%=i%>" value="option5_<%=question_idx%>" />
			   <% } else {%>
			   <input type='hidden' name="Q<%=i%>" value="<%=question_idx%>" />
			   <% } %>
			   
			   <li class="<% if (question_option.equals("4")) {out.print("table");} else if (question_option.equals("6")) {out.print("vod");} else if (question_option.equals("5")) {out.println("suject");} else {out.print("normal");}  %>">
			   <h3><%=question_num%>.&nbsp;<%=question_content%></h3> 
			   <!-- ///////////설문 (다중반복)/////////////  -->
					<%
						Vector info = new Vector();
					int option_4_size = 0;
						if (question_option.equals("4")){ // 다중선택 반복
							if (question_info != null && question_info.length() > 0)
							{
								StringTokenizer question_info_st = new StringTokenizer(question_info, ","); 
								while (question_info_st.hasMoreTokens())
								{
									info.add(question_info_st.nextToken());
								}
							}
						
					 option_4_size = info.size();
							
							%>
  
							<div class="tableItem">
							<table class="tableList" cellspacing="0" summary="<%=question_content%>">
								<caption>항목</caption>
								<colgroup>
								<col width="*"/>
					<%
					if (info != null && info.size() > 0)
					{
						int width_size = 60/option_4_size;
						for ( int k = 0 ; k < option_4_size ; k++){%>
								<col width="<%=width_size%>%"/>
					<% 	}
					}%>				
					
								</colgroup>
								<thead>
								<tr>
								<th scope="col" >*항목을 선택 하세요!</th>
					<%
					for ( int k = 0 ; k < option_4_size ; k++){%>
					 
							    <th scope="col" abbr="<%=info.elementAt(k) %>"><%=info.elementAt(k) %></th>
					<% 	}
					%>			
								</tr>
								</thead>

 
								
						<%	}else if (question_option.equals("5")){  //textarea %>
						<ul>
								<textarea name="<%=question_idx%>" cols="85" rows="5" id="subject" title="내용"></textarea> 
								
						<%	} else { %>
						<ul>
						<%} %>
					
					
					<%if (vt2 != null && vt2.size() > 0){		// if (vt2)
					 	for (int j = 0 ; j < vt2.size() ; j++ ){ // for end (vt2)
							ans_idx = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(0));
							step_flag = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(2));
							ans_num = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(3));
							ans_content = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(4));
							ans_order = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(5));
							ans_etc = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(6));
							ans_img = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(7));
							ans_hot7_ocode = String.valueOf(((Vector)(vt2.elementAt(j))).elementAt(8));
					%>
							<!-- ////////설문 항목(질문 선택항목)////////////////  -->
							<%
							if(question_option.equals("4"))
							{ // 다중선택 반복
							%>
							
			<tr>
				<td class="list"><%=ans_content%></td>
				<input type='hidden' name='<%=question_idx%>_num' value='<%=ans_num%>' />
				<%
				if (info != null && info.size() > 0)
				{
					for ( int k = 0 ; k < option_4_size ; k++) {%>
				
				<td><input type="radio" name="<%=question_idx%>_<%=ans_num%>" value="<%=k+1%>"  /></td>
				<%	}
				}%>
				
				 

						<%	}else if (question_option.equals("3")){ // 다중선택 제한
							%> 
									<li>
										(<%=j+1%>) <input name="<%=question_idx%>" type="checkbox" onClick='checkCheckbox(this.form,this,<%=question_etc %>)' value="<%=ans_num%>">
										<%=ans_content%>&nbsp;<% if (ans_order != null && ans_order.equals(ans_num)) {  out.println("&nbsp;&nbsp;<span class='inputType'><input type='text' size='35' name='"+question_idx+"_order_"+ans_num+"' class='inputType'></span>"); }  %>
								  	</li>
 
						<%	}else if (question_option.equals("2")){ // 다중선택 무제한
							%>
 
									<li>
										(<%=j+1%>) <input name="<%=question_idx%>" type="checkbox" value="<%=ans_num%>">
										<%=ans_content%>&nbsp;<% if (ans_order != null && ans_order.equals(ans_num)) { out.println("&nbsp;&nbsp;<span class='inputType'><input type='text' size='35' name='"+question_idx+"_order_"+ans_num+"' class='inputType'></span>"); }  %>
								  	</li>
 
						<%	}else if (question_option.equals("1")){ %>
 
									<li>
										(<%=j+1%>) <input type="radio" name="<%=question_idx%>" value="<%=ans_num%>">
										<%=ans_content%>&nbsp;<% if (ans_order != null && ans_order.equals(ans_num) ) { if ( sub_flag.equals("S")) {  out.println("&nbsp;&nbsp;<span class='inputType'><input type='text' size='35' name='"+question_idx+"_order_"+ans_num+"' class='inputType'></span>"); } } %>
								 	</li>
 
						<%	}else if (question_option.equals("6")) {   // hot7
						ans_content = ans_content.replaceAll("&#39;", "").replaceAll("\"","").replaceAll("\n","").replaceAll("\r","").replaceAll("\n\r",""); 
						%>
		 
								<li>
									<span class="img">(<%=j+1%>) <input name="<%=question_idx%>" type="checkbox" onClick='checkCheckbox(this.form,this,<%=question_etc %>)' value="<%=ans_num%>">
									<%if (ans_hot7_ocode != null && ans_hot7_ocode.length() > 0 ) { %>
									<a href="javascript:vod_view('<%=ans_hot7_ocode%>');"><img src="<%=ans_img%>" alt="<%=ans_content%>"/></a>
									<%} else { %>
									<img src="<%=ans_img%>" alt="<%=ans_content%>"/>
									<%} %>
									</span>
									<span class="sub">
										<span class="title"><%=ans_content%></span>
										<span class="subject"><%=ans_etc %></span>
										&nbsp;<% if (ans_order != null && ans_order.equals(ans_num) ) { if ( sub_flag.equals("S")) { out.println("&nbsp;&nbsp;<span class='inputType'><input type='text' size='35' name='"+question_idx+"_order_"+ans_num+"' class='inputType'></span>"); } } %>
									</span>
								</li>
								
						<%	}
						}

					}
		if (question_option.equals("4")){				
			%>
						</tr>
						</table>
					</div>
						
			<%	} else { %>
					</ul>
			<% }
					%>
				 </li>
			<%}
		}
		%>
		
				
				 
				</ul>
				
				<div class="btn3">
					<a href="javascript:aa_submit();"><img src="../include/images/btn_save.gif" alt="저장"></a>
					<a href="javascript:self.close();"><img src="../include/images/btn_cancel.gif" alt="취소"></a>
				</div>
				<p class="moongu sem"><img src="../include/images/main/logo.png" alt="수원iTV" width="90" height="45" > <span>끝까지 설문에 응해주셔서 감사합니다. <br/>귀하의 소중한 의견을 반영하여 보다 나은 수원시 인터넷방송 만들기 위해 최선을 다하겠습니다.</span></p>
						
				
			</div>
		
		</div>

		</form>
		
	</div>
	
	
</div> 
<%
				}//참여 여부
			}//인원제한
		}//실명인증 체크
		else 
		{
			//2013.01.22
			//실명인증 페이지로 이동시키고, 후에 설문  페이지로 이동 처리 해야 함.
			out.println("<script>alert('실명인증후 참여 가능합니다.');self.close();</script>");
		}
}else{
		out.println("<script>alert('잘 못된 요청입니다.');self.close();</script>");
}
%>

</body>
</html>