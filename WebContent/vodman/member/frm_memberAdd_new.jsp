<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*,
com.rsa.*,
com.vodcaster.utils.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "m_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
 
 			LoginRsa handler = new LoginRsa( request );
			handler.processRequest(request);
			 
            String publicKeyModulus = (String) request.getAttribute("publicKeyModulus");
            String publicKeyExponent = (String) request.getAttribute("publicKeyExponent");
%>
<%@ include file="/vodman/include/top.jsp"%>

		<script type="text/javascript" src="/include/js/rsa/jsbn.js"></script>
        <script type="text/javascript" src="/include/js/rsa/rsa.js"></script>
        <script type="text/javascript" src="/include/js/rsa/prng4.js"></script>
        <script type="text/javascript" src="/include/js/rsa/rng.js"></script>
        <script type="text/javascript" src="/include/js/member2.js"></script>
        
<script language="javascript">
<!--
	function chkForm() {
		if(!document.getElementById("id").value) {
			alert("���̵� �Է����ּ���.");
			document.getElementById("id").focus();
			return;
		}
		if (document.getElementById("id").value.length < 8 || document.getElementById("id").value.length > 12) {
				alert("���̵�� 8�� �̻� - 12�� ���Ϸ� �Է��ϼ���");
				document.getElementById("id").focus();
				return;
			}
		if(!pwCheck(document.getElementById("id").value)){
				document.getElementById("id").focus();
				alert("���̵�� ����+���ڸ� �ּ��� ���� �̻� ������ 8�� �̻�, 12�� �̳��� �Է��Ͻñ� �ٶ��ϴ�.");
				return;
			}
		if(document.getElementById("approval").value == "N") {
			alert("���̵� �ߺ� üũ�� ���ּ���");
			document.getElementByid("id").focus();
			return;
		}

		if(!document.getElementById("pwd").value  || !document.getElementById("pwd2").value) {
			alert("��ȣ�� �Է����ּ���.");
			document.getElementById("pwd").focus();
			return;
		}else {
			if (document.getElementById("pwd").value != document.getElementById("pwd2").value) {
				alert("��ȣ�� ���� �ʽ��ϴ�. �ٽ� �Է����ּ���.");
				document.getElementById("pwd2").focus();
				return;
			}

			if(!pwCheck1(document.getElementById("pwd").value)){
				document.getElementById("pwd").focus();
				alert("����+����+Ư�� ���ڸ� �ּ��� ���� �̻� ������ 8�� �̻�, 12�� �̳��� �Է��Ͻñ� �ٶ��ϴ�.");
				return;
			}
		}

		if(!document.getElementById("name").value) {
			alert("�̸��� �Է����ּ���.");
			document.getElementById("name").focus();
			return;
		}

		if(!document.getElementById("email1").value || !document.getElementById("email2").value  || (document.getElementById("email2").value == "direct" && !document.getElementById("email3").value )) {
			alert("�̸����ּҸ� �Է����ּ���.");
			document.getElementById("email1").focus();
			return;
		}

		var email = document.getElementById("email1").value + "@" + document.getElementById("email2").value;
		if( document.getElementById("email2").value == 'direct') {
			email = document.getElementById("email1").value + "@" + document.getElementById("email3").value;
		}
		document.getElementById("email").value = email;

		if(!check_email(email)) {
			alert("�̸����ּҰ� �߸��Ǿ����ϴ�.");
			document.getElementById("email1").focus();
			return;
		}
		var tel = document.getElementById("tel1").value +"-"+  document.getElementById("tel2").value +"-"+ document.getElementById("tel3").value;
		document.getElementById("tel").value = tel;
		//var hp = document.getElementById("hp1").value +"-"+  document.getElementById("hp2").value +"-"+ document.getElementById("hp3").value;
		//document.getElementById("hp").value = hp;
		 
		if(confirm("�����Ͻðڽ��ϱ�?")){
			//member.js ���� ȣ��
			validateEncryptedForm();
		}
	}

	function length_check(){
 
			if(!pwCheck1(document.getElementById("id").value)){
				document.getElementById("id").focus();
				alert("���̵�� ����+���ڸ� �ּ��� ���� �̻� ������ 8�� �̻�, 12�� �̳��� �Է��Ͻñ� �ٶ��ϴ�.");
				return;
			}
	}

	function chk_id() {
 
		if(!document.getElementById("id").value) {
			alert("���̵� �Է����ּ���.");
			document.getElementById("id").focus();
			return;
		}

		if(!pwCheck(document.getElementById("id").value)){
				document.getElementById("id").focus();
				alert("���̵�� ����+���ڸ� �ּ��� ���� �̻� ������ 8�� �̻�, 12�� �̳��� �Է��Ͻñ� �ٶ��ϴ�.");
				return;
			}
		searchko = document.getElementById("id").value;
		
		for (i = 0 ; i < searchko.length ; i++) {
			sko = searchko.charAt(i);
			if ((sko < '0' || sko > '9')&&(sko < 'a' || sko > 'z')&&(sko < 'A' || sko > 'Z')) {
				alert("������ ���ڸ� �Է��ϼ���!");
				document.getElementById("id").value = "";
				document.getElementById("id").focus();
				return;
			}
		}
	
	
	
		if(!isNaN(searchko)){
			alert("���ڸ� �Է��� �� �����ϴ�!");
			document.getElementById("id").value="";
			document.getElementById("id").focus();
			return ;
		} else if(searchko.length <8 || searchko.length >12){
			alert("���̵�� 8~12�� ���̷� �Է��ϼ���!");
			document.getElementById("id").value = "";
			document.getElementById("id").focus();
			return ;
		}

		window.open("/vodman/member/search/pop_idCheck.jsp?fid=" + document.getElementById("id").value, 'id_check', 'width=550, height=220, scrollbars=no');
	}


	function find_zip(form) {
		window.open('/vodman/member/search/pop_zipCode.jsp','','width=550, height=350, scrollbars=no');
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
		<!-- ������ -->
		<div id="contents">
		<%
			if(mcode != null && mcode.equals("1003")){
			%>
			<h3><span>����͸���</span> ���</h3>
			<p class="location">������������ &gt; �����ڰ��� &gt; <span>����͸��� ���</span></p>
			<%
			}else{
			%>
			<h3><span>������</span> ���</h3>
			<p class="location">������������ &gt; ������ ���� &gt; <span>������ ���</span></p>
			<%
			}
			%>
			
			<div id="content">
				<table cellspacing="0" class="board_view" summary="������ ���">
				<caption>������ ���</caption>
				<colgroup>
					<col width="17%" class="back_f7"/>
					<col/>
				</colgroup>
				<input type="hidden" id="rsaPublicKeyModulus" value="<%=publicKeyModulus%>" />
            	<input type="hidden" id="rsaPublicKeyExponent" value="<%=publicKeyExponent%>" />
				<input type="hidden" name="mcode" id="mcode" value="<%=mcode%>">
				<input type="hidden" name="approval" id="approval" value="N" />
				<input type="hidden" name="email" id="email" value="" />
				<input type="hidden" name="ssn" id="ssn" value="" />
				<input type="hidden" name="tel" id="tel" value="" />
				<input type="hidden" name="hp" id="hp" value="" />
				<input type="hidden" name="sex" id="sex" value="M" />
				<input type="hidden" name="office_name" id="office_name" value="" />
<!-- 				<input type="hidden" name="level" id="level" value="9" /> -->
				<input type="hidden" name="use_mailling" id="use_mailling"  value="N" />
				<input type="hidden" name="auth_key" id="auth_key"  value="" />
			 
				<input type="hidden" name="member_group" id="member_group"  value="" />
				<input type="hidden" name="gray" id="gray"  value="" />
				<input type="hidden" name="zip" id="zip" value="" />
				<input type="hidden" name="address1" id="address1" value=""/> 
				<input type="hidden" name="address2" id="address2" value="" />
		 
				<tbody class="bor_top03 font_127">
					<tr>
						<th class="bor_bottom01"><strong>���̵�</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="id" id="id" maxlength="12" value="" class="input01" style="width:150px;" onkeyup="fc_chk_byte(this,12);" />&nbsp;<a href="javascript:chk_id()" title="�ߺ�üũ"><img src="/vodman/include/images/but_idcheck.gif" alt="�ߺ�üũ"/></a>&nbsp;[������ ����(8~12��)�� ����Ͻñ� �ٶ��ϴ�.]</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>��й�ȣ</strong></th>
						<td class="bor_bottom01 pa_left"><input type="password" name="pwd" id="pwd" maxlength="12" value="" class="input01" style="width:150px;" onkeyup="fc_chk_byte(this,12)"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��й�ȣ Ȯ�� <input type="password" name="pwd2" id="pwd2" value="" class="input01" style="width:150px;" maxlength="12" onkeyup="fc_chk_byte(this,12)" /><br> [��ȣ�� �ݵ�� ����+����+Ư������ ����, 8~12�ڷ� �Է�]</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>�̸�</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="name" id="name" value="" maxlength="20" class="input01" style="width:150px;" onkeyup="fc_chk_byte(this,20)"/></td>
					</tr>
				  
					<tr>
						<th class="bor_bottom01"><strong>����</strong></th>
						<td class="bor_bottom01 pa_left"><input type="radio" name="sex1" value="M" onclick="document.getElementById('sex').value='M';" checked/> ��&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sex1" value="F" onclick="document.getElementById('sex').value='F';"/> ��</td>
					</tr>
				 
<!--
					<tr>
						<th class="bor_bottom01"><strong>�������</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="ssn" id="ssn" value="" class="input01" style="width:100px;"  /> ��) 20110401</td>
					</tr>
-->
				 
					<tr>
						<th class="bor_bottom01"><strong>�̸����ּ�</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="email1"  id="email1" maxlength="30" value="" class="input01" style="width:150px;"  onkeyup="checkLength(this,30)"/> @
						<span id="dir" style="display: none">
							<INPUT type="text" name="email3" id="email3" class="text_field" maxlength="20" value="" style="width:30%">
						</span>
						<span id="dir1" style="display: inline">
							<select name="email2" id="email2" class="sec01" style="width:130px;" onChange="change(this.value);">
								<option value="naver.com" selected>naver.com</option>
								<option value="daum.net">daum.net</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="empas.com">empas.com</option>
								<option value="nate.com">nate.com</option>
								<option value="cyworld.com">cyworld.com</option>
								<option value="lycos.co.kr">lycos.co.kr</option>
								<option value="netsgo.com">netsgo.com</option>
								<option value="hotmail.com">hotmail.com</option>
								<option value="yahoo.co.kr">yahoo.co.kr</option>
								<option value="gmail.com">gmail.com</option>
								<option value="direct">�����Է�</option>
							</select>
						</span>
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>��й�ȣ ��߱� ����</strong></th>
						<td class="bor_bottom01 pa_left">
						<select name="pwd_ask_num" id="pwd_ask_num" class="sec01" style="width:200px;">
								<option value="1">�ڽ��� ������</option>
								<option value="2">���� ���� ��Ҵ�</option>
								<option value="3">���� ��￡ ���� ��Ҵ�</option>
								<option value="4">���� �λ��� �о��� å��</option>
								<option value="5">���� ��￡ ���� �ι���</option>
								<option value="6">���� �����ϴ� ĳ���ʹ�</option>
								<option value="7">�ڽ��� ���� 1ȣ��</option>
								<option value="8">�����ϴ� ������</option>
								<option value="9">���� ������ ������</option>
								<option value="10">���� �̸���</option>
								<option value="11">��Ÿ</option>
							</select>
							Ȥ�� ��й�ȣ�� �ؾ������ ��� ���⿡�� ������ ������ �ϰԵ˴ϴ�. 
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>��й�ȣ ��߱� �亯 </strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="pwd_answer" id="pwd_answer"  value="" class="input01" style="width:150px;" maxlength="30"  onkeyup="checkLength(this,30)"/>&nbsp;(�ѱ� 15������, ���� 30������ ���ܷ� �ۼ�)</td>
					</tr>
					
					<tr>
						<th class="bor_bottom01"><strong>ȸ�� ���� </strong></th>
						<td class="bor_bottom01 pa_left">
						<select name="level" id="level" class="sec01" style="width:200px;">
								<option value="1" <%if (request.getParameter("level") != null && request.getParameter("level").equals("1")) { out.print("selected"); }%>>�Ϲ�ȸ��</option>
								<option value="2" <%if (request.getParameter("level") != null && request.getParameter("level").equals("2")) { out.print("selected"); }%>>����͸���</option>
								<%
								if(mcode != null && !mcode.equals("1003")){
								%>
								<option value="9" <%if (request.getParameter("level") != null && request.getParameter("level").equals("9")) { out.print("selected"); }%>>������</option>
								<%
								}%>
							 
							</select>
						</td>
					</tr>
 
					<tr>
						<th class="bor_bottom01"><strong>�Ҽ�</strong></th>
						<td class="bor_bottom01 pa_left">
 
							<input type="text" name="buseo" id="buseo" value="" class="input01" style="width:150px;" maxlength="30" onkeyup="checkLength(this,30)" />  
					 
						</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>��ȭ��ȣ</strong></th>
						<td class="bor_bottom01 pa_left">
 
							<input type="text" name="tel1" id="tel1" value="" class="input01" style="width:50px;" maxlength="4"  onKeyDown="onlyNumber(this);"/> - 
							<input type="text" name="tel2" id="tel2" value="" class="input01" style="width:50px;" maxlength="4"  onKeyDown="onlyNumber(this);"/> - 
							<input type="text" name="tel3" id="tel3" value="" class="input01" style="width:50px;" maxlength="4"  onKeyDown="onlyNumber(this);"/>
						</td>
					</tr>
 <%-- 
					<tr>
						<th class="bor_bottom01"><strong>�޴���</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="hp1" id="hp1" class="sec01" style="width:50px;">
								<option value='' >����</option>
								<option value="010" >010</option>
								<option value="011" >011</option>
								<option value="016" >016</option>
								<option value="017" >017</option>
								<option value="018" >018</option>
								<option value="019" >019</option>
							</select> - 
							<input type="text" name="hp2"  id="hp2" value="" class="input01" style="width:50px;" maxlength="4" onkeyup="onlyNumber();"/> - 
							<input type="text" name="hp3"  id="hp3" value="" class="input01" style="width:50px;" maxlength="4" onkeyup="onlyNumber();"/>
						</td>
					</tr>
 
 
					<tr>
						<th class="bor_bottom01"><strong>�����ּ�</strong></th>
						<td class="bor_bottom01 pa_left">
							<input type="text" name="zip" id="zip" value="" class="input01" style="width:100px;" readonly/>&nbsp;<a href="javascript:find_zip(document.frmMember);" title="�����ȣã��"><img src="/vodman/include/images/but_zipcheck.gif" alt="�����ȣã��"/></a>&nbsp;<br/>
							<input type="text" name="address1" id="address1" value="" class="input01" style="width:250px;" readonly/>&nbsp;
							<input type="text" name="address2" id="address2" value="" class="input01" style="width:200px;"/>
						</td>
					</tr>
					--%>
					
<%--
					 <%
					  BuseoManager Bmgr = BuseoManager.getInstance();
					  BuseoInfoBean b_info = new BuseoInfoBean();

					  Vector b_vt = Bmgr.getBuseo_ListAll();
					  %>
 					<tr>
						<th class="bor_bottom01"><strong>�μ�</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="buseo" id="buseo" class="sec01" style="width:130px;">
								<option value="">�μ�����</option>
								<%
								if ( b_vt != null && b_vt.size() > 0){
									for(int i = 0;i<b_vt.size(); i++ ){
										com.yundara.beans.BeanUtils.fill(b_info, (Hashtable)b_vt.elementAt(i));
										%>
										<option value='<%=b_info.getBuseo_code()%>' ><%=b_info.getBuseo_name()%></option>
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
						<th class="bor_bottom01"><strong>����</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="gray" id="gray" class="sec01" style="width:130px;">
								<option value="">���޼���</option>
								<%
								if ( g_vt != null && g_vt.size() > 0){
									for(int i = 0;i<g_vt.size(); i++ ){
										com.yundara.beans.BeanUtils.fill(g_info, (Hashtable)g_vt.elementAt(i));
										%>
										<option value='<%=g_info.getGray_code()%>'><%=g_info.getGray_name()%></option>
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
					<a href="javascript:chkForm();" title="����"><img src="/vodman/include/images/but_save.gif" alt="����"/></a>
					<a href="mng_memberList.jsp?mcode=<%=mcode%>" title="���"><img src="/vodman/include/images/but_cancel.gif" alt="���"/></a>
				</div>	
				
				<br/><br/>
			 
				 <form id="securedLoginForm" name="securedLoginForm" action="proc_memberAdd_new.jsp" method="post" style="display: none;">
			 
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

		        </form>
			</div>
		</div>	
<%@ include file="/vodman/include/footer.jsp"%>