<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	String sex = "";
	String level = "";
	String useMailling = "";
	String joinDate1 = "";
	String joinDate2 = "";
	String searchField = "";
	String searchString = "";
	
	if(request.getParameter("sex") != null)
		sex = request.getParameter("sex");
	
	if(request.getParameter("level") != null)
		level = request.getParameter("level");
	
	if(request.getParameter("useMailling") != null)
		useMailling = request.getParameter("useMailling");
	
	if(request.getParameter("joinDate1") != null)
		joinDate1 = request.getParameter("joinDate1");
	
	if(request.getParameter("joinDate2") != null)
		joinDate2 = request.getParameter("joinDate2");
	
	if(request.getParameter("searchField") != null)
		searchField = request.getParameter("searchField");
	
	if(CharacterSet.toKorean(request.getParameter("searchString")) != null)
		searchString = CharacterSet.toKorean(request.getParameter("searchString"));
	
	MemberManager mgr = MemberManager.getInstance();
	Vector vt = mgr.getMemberInfo(vod_id);
	MemberInfoBean info = new MemberInfoBean();
	
	try {

		Enumeration e = vt.elements();
		com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());

	} catch (Exception e) {}
%>

<%@ include file="/vodman/include/top.jsp"%>

<script language="javascript">
<!--

function check_mail() {
	var form = document.sendMail;
	if(form.title.value == "") {
		alert("제목을 입력하세요.");
		return;
	}

	if(form.message.value == "") {
		alert("내용을 입력하세요.");
		return;
	}

	if(confirm("메일을 보내시겠습니까?")) {
		form.action="proc_emailRequest.jsp";
		form.submit();
	}
	
}
//-->
</script>

<%@ include file="/vodman/member/member_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>메일</span>보내기</h3>
			<p class="location">관리자페이지 &gt; 회원관리 &gt; <span>메일보내기</span></p>
			<div id="content">
				<!-- 내용 -->
				<form name="sendMail" method="post" >
					 <input type="hidden" name="sex" value="<%=sex%>">
                     <input type="hidden" name="level" value="<%=level%>">
                     <input type="hidden" name="useMailling" value="Y">
                     <input type="hidden" name="joinDate1" value="<%=joinDate1%>">
                     <input type="hidden" name="joinDate2" value="<%=joinDate2%>">
                     <input type="hidden" name="searchField" value="<%=searchField%>">
                     <input type="hidden" name="searchString" value="<%=searchString%>">
				<table cellspacing="0" class="board_view" summary="메일보내기">
				<caption>메일보내기</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody class="font_127">
 					<tr>
						<th class="bor_bottom01"><strong>보내는사람</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="from_name" value="꽃동네 인터넷방송" class="input01" style="width:300px;"/></td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>보내는주소</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="from_email" value="<%=info.getEmail()%>" class="input01" style="width:300px;"/></td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>제목</strong></th>
						<td class="bor_bottom01 pa_left"><input type="text" name="title" value="" class="input01" style="width:300px;"/></td>
					</tr>

					<tr>
						<th class="bor_bottom01"><strong>내용</strong></th>
						<td class="bor_bottom01 pa_left">
<!--							<input type="checkbox" name="chkFlag" value="1" />&nbsp;html 사용시 체크하세요!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/> -->
							<textarea name="message" class="input01" style="width:600px;height:200px;" cols="100" rows="100"></textarea></td>
					</tr>
				</tbody>
				</table>
				</form>
				<div class="but01">
					<a href="javascript:check_mail();" title="메일보내기"><img src="/vodman/include/images/but_mail.gif" alt="메일보내기"/></a>
<!-- 					<a href="javascript:preview();" title="미리보기"><img src="/vodman/include/images/but_view2.gif" alt="미리보기"/></a> -->
					<a href="/vodman/member/mng_memberList.jsp?mcode=1001" title="취소"><img src="/vodman/include/images/but_cancel.gif" alt="취소"/></a>
				</div>	
				<br/><br/>
			</div>
		</div>
<%@ include file="/vodman/include/footer.jsp"%>