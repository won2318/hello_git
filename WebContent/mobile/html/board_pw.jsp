<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.security.*" %>
 


<%@ include file = "../include/head.jsp"%>

<%
  
String ocode = request.getParameter("ocode").replaceAll("<","").replaceAll(">","");
String flag = request.getParameter("flag").replaceAll("<","").replaceAll(">","");
String board_id = request.getParameter("board_id").replaceAll("<","").replaceAll(">","");
 
%>


<script type="text/javascript">
function memo_del() {
 
	if (confirm("�޸� �����Ͻðڽ��ϱ�")) {
		if (document.getElementById('password').value=="") {
			alert('��й�ȣ�� �Է��ϼ���!');
		} else {
			document.memo_form.submit();
		}
 		
	}
}

</script>
	
 
		<section>
			<div id="container">
			<form name="memo_form" method="post" action="./comment.jsp">
			<input type="hidden" name="ocode" value="<%=ocode%>" />
			<input type="hidden" name="jaction" value="del" />
			<input type="hidden" name="muid" value="<%=muid %>" />
			<input type="hidden" name="flag" value="<%=flag %>" />
			<input type="hidden" name="board_id" value="<%=board_id %>" />
 
			 
				<div class="content_inner">
					<div class="boardPw">
						<span class="nameInfo">��й�ȣ�� �Է��ϼž� ������ �����մϴ�.</span>				
						<dl>
							<dt><label for="password">��й�ȣ</label></dt>
							<dd><input type="password" name="pwd" value="" id="password" size="30" title="��й�ȣ"/></dd>
						</dl>
					</div>
					<div class="btn1 btn-03">
						<a href="javascript:memo_del();">Ȯ��</a> 
					</div>
				</div>		
				</form>			
			</div>
			 
		</section><!--//�������κ�:section-->    
	<%@ include file = "../include/foot.jsp"%>	
	 