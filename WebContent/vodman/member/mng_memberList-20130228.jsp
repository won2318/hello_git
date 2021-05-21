<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
if(!chk_auth(vod_id, vod_level, "m_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 최희성
	 *
	 * @description : 회원의 전체정보를 보여줌.
	 * date : 2005-01-07
	 */
	

    int pg = 0;
	String sex = "";
	String level = "";
	String useMailling = "";
	String joinDate1 = "";
	String joinDate2 = "";
	String searchField = "";
	String searchString = "";
	String approval = "";

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

	if(request.getParameter("ssex") != null && request.getParameter("ssex").length()>0 && !request.getParameter("ssex").equals("null"))
		sex = request.getParameter("ssex");

	if(request.getParameter("slevel") != null && request.getParameter("slevel").length()>0 && !request.getParameter("slevel").equals("null"))
		level = request.getParameter("slevel");

	if(request.getParameter("useMailling") != null && request.getParameter("useMailling").length()>0 && !request.getParameter("useMailling").equals("null"))
		useMailling = request.getParameter("useMailling");

	if(request.getParameter("joinDate1") != null && request.getParameter("joinDate1").length()>0 && !request.getParameter("joinDate1").equals("null"))
		joinDate1 = request.getParameter("joinDate1");

	if(request.getParameter("joinDate2") != null && request.getParameter("joinDate2").length()>0 && !request.getParameter("joinDate2").equals("null"))
		joinDate2 = request.getParameter("joinDate2");

	if(request.getParameter("searchField") != null && request.getParameter("searchField").length()>0 && !request.getParameter("searchField").equals("null"))
		searchField = request.getParameter("searchField");

	if(request.getParameter("searchString") != null && request.getParameter("searchString").length()>0 && !request.getParameter("searchString").equals("null"))
		searchString = CharacterSet.toKorean(request.getParameter("searchString"));
	
	if(request.getParameter("approval") != null)
		approval = com.vodcaster.utils.TextUtil.getValue(request.getParameter("approval"));


	String strtmp = "";
    String strLink = "&page=" +pg+ "&ssex=" +sex+ "&slevel=" +level+ "&useMailling=" +useMailling+ "&joinDate1=" +joinDate1+ "&joinDate2=" +joinDate2+ "&searchField=" +searchField+ "&searchString=" +searchString+ "&approval=" +approval;

	//strtmp = "sex:<font color=red>" +sex+ "</font>|level:<font color=red>" +level+ "</font>|useMailling:<font color=red>" +useMailling+ "</font>|joinDate1:<font color=red>" +joinDate1+ "</font>|joinDate2:<font color=red>" +joinDate2+ "</font>|searchField:<font color=red>" +searchField+ "</font>|searchString:<font color=red>" +searchString;

    MemberManager mgr = MemberManager.getInstance();
	Hashtable result_ht = null;
    result_ht = mgr.getMemberListAll(sex, level, useMailling, joinDate1, joinDate2, searchField, searchString, pg, approval);
	int iTotalCount = 0;
	int iTotalPage = 0;
    Vector vt = null;
    com.yundara.util.PageBean pageBean = null;
    if(!result_ht.isEmpty()) {
        vt = (Vector)result_ht.get("LIST");
        pageBean = (com.yundara.util.PageBean)result_ht.get("PAGE");
        if(vt != null && pageBean != null){
        	pageBean.setPagePerBlock(10);
        	pageBean.setPage(pg);
			iTotalCount = pageBean.getTotalRecord();
			iTotalPage = pageBean.getTotalPage();
        }
    }

%>

<%@ include file="/vodman/include/top.jsp"%>

<script language="javascript">
<!--



function send_email(mode) {
    document.search.action = "./sendmail/frm_sendmail.jsp";
	document.search.submit();
}

function search() {
    document.search.action = "mng_memberList.jsp?mcode=<%=mcode%>";
    document.search.submit();
}

function viewStat() {
    document.search.action = "mng_vodMemberExcel.jsp";
    document.search.target="_blank";
    document.search.submit();
}

function watchPop(user_id){
	var oio = window.open("mng_viewWatchList.jsp?user_id="+user_id,"watchingLog","width=630,height=500");
	oio.focus();
}

function sendmail() {
	var form = document.search;
	form.action = "/vodman/member/sendmail/frm_sendMail.jsp";
	form.submit();
}

function change_level(cObject, id) {
	if(confirm('레벨을 변경하시겠습니까?')) {
		var level = cObject.options[cObject.selectedIndex].value;
		var url = "./proc_levelUpdate.jsp?id=" + id + "&level=" + level + "&page=<%=pg%>&sex=<%=sex%>&&useMailling=<%=useMailling%>&joinDate1=<%=joinDate1%>&joinDate2=<%=joinDate2%>&searchField=<%=searchField%>&searchString=<%=searchString%>";
		var form = document.search;
		form.action = url;
		form.submit();
	}
}

function change_approval(cObject, id) {
	if(confirm('승인상태를 변경하시겠습니까?')) {
		var approval = cObject.options[cObject.selectedIndex].value;
		var url = "./proc_ApprovalUpdate.jsp?id=" + id + "&slevel=<%=level%>" +
				  "&page=<%=pg%>&sex=<%=sex%>&&useMailling=<%=useMailling%>&joinDate1=<%=joinDate1%>" +
				  "&joinDate2=<%=joinDate2%>&searchField=<%=searchField%>&searchString=<%=searchString%>&approval=" + approval;
		location.href = url;
	}
}
//-->
</script>
<%@ include file="/vodman/member/member_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>관리자</span> 목록</h3>
			<p class="location">관리자페이지 &gt; 관리자관리 &gt; <span>관리자 목록</span></p>
			<div id="content">
				<!-- 내용 -->
				<form name="search" method="post">
				<input type="hidden" name="mode" value="" />
				<table cellspacing="0" class="log_list" summary="관리자 검색">
				<caption>관리자 검색</caption>
				<colgroup>
					<col width="15%" class="back_f7"/>
					<col width="30%"/>
					<col width="15%" class="back_f7"/>
					<col/>
				</colgroup>
				<tbody>
				<input type="hidden" name="approval" value="" />
						<input type="hidden" name="approval" value="all" />
						<%--
					<tr>
						<!-- 승인구분 주석처리 후 input hidden처리
						<th class="bor_bottom01"><strong>승인구분</strong></th>
						<td class="bor_bottom01 pa_left">
							<select name="approval" class="sec01" style="width:80px;">
								<option value='all' selected <%=(approval.equals("all"))?"selected":""%>>전체</option>
							    <option value='Y' <%=(approval.equals("Y"))?"selected":""%>>정회원</option>
							    <option value='N' <%=(approval.equals("N"))?"selected":""%>>대기회원</option>
							</select>
						</td>
						 -->
						
						
						<th class="bor_bottom01"><strong>레벨</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
							<select name="slevel" class="sec01" style="width:80px;">
								<option value='all' <%if(level.equals("") || level.equals("all") || level.equals("0")){out.println("selected");}%>>전체</option>
								<option value='1' <%if(level.equals("1") ){out.println("selected");}%>>일반회원</option>
								<option value='9' <%if(level.equals("9") ){out.println("selected");}%>>관리자</option>
								
							</select>
						</td>
																					
					</tr>
					--%>
					<tr>
					   <th class="bor_bottom01"><strong>성별</strong></th>
						<td class="bor_bottom01 pa_left font_127">
						<input name="ssex" type="radio" value='M' <% if(sex!=null && sex.equals("M")) out.println("checked"); %>>남자
                        <input name="ssex" type="radio" value="F"<% if(sex!=null && sex.equals("F")) out.println("checked"); %>>여자</td>
						<th class="bor_bottom01"><strong>가입일</strong></th>
						<td class="bor_bottom01 pa_left font_127"><input type="text" name="joinDate1" value="<%=joinDate1%>" class="input01" style="width:80px;"/> - <input type="text" name="joinDate2" value="<%=joinDate2%>" class="input01" style="width:80px;"/> 예) 2010-11-12</td>
					</tr>
					<tr>
						<th class="bor_bottom01"><strong>분류</strong></th>
						<td class="bor_bottom01 pa_left" colspan="3">
							<select name="searchField" class="sec01" style="width:80px;">
								<option value="id" selected <%=(searchField.equals("id"))?"selected":""%>>
								  아이디</option>
								  <option value="name" <%=(searchField.equals("name"))?"selected":""%>>
								  이름</option>
								  <option value="email" <%=(searchField.equals("email"))?"selected":""%>>
								  이메일</option>
								   
							</select>
							<input type="text" name="searchString" class="input01" style="width:150px;" value="<%=searchString%>" /></td>
					</tr>
					<tr>
					 
						<td class="bor_bottom01 pa_left" colspan="4" height="25" align="center">
							<a href="javascript:search();"><img src="/vodman/include/images/but_search.gif" alt="검색" border="0"></a>
						</td>
					</tr>
					
				</tbody>
				</table>
				</form>
				<br/>
				<p class="to_page">Total<b> <%= iTotalCount%></b>Page<b><%=pg%>/<%=iTotalPage%></b></p>
				<table cellspacing="0" class="board_list" summary="게시판 정보">
				<caption>게시판 정보</caption>
				<colgroup>
					<col width="7%"/>
					<col/>
					<col width="28%"/>
					<col width="9%"/>
					<%-- <col width="7%"/> --%>
<!--					<col width="7%"/> -->
					<col width="19%"/>
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>아이디</th>
						<th>이름</th>
						<th>가입일</th>
					<%--	<th>접속수</th> 
						<th>레벨</th>--%>
<!--						<th>승인</th>-->
						<th>관리</th>
					</tr>
				</thead>
				<tbody>

				<%
						MemberInfoBeanRsa info = new MemberInfoBeanRsa();
						int list = 0;
						if(vt != null && vt.size()>0){
							for(int i = pageBean.getStartRecord()-1 ; (i<pageBean.getEndRecord()) && (list<vt.size()) ; i++, list++){
								com.yundara.beans.BeanUtils.fill(info, (Hashtable)vt.elementAt(list));

								String addr = info.getAddress1() + " " + info.getAddress2();

								if(TextUtil.length(addr) > 35) {
									addr = TextUtil.getLimitedString(35, addr) + "...";
								}

								//out.println(info.showData());

								//out.println(String.valueOf(vt.elementAt(0)));
					%>
					<tr class="height_25 font_127">
						<td class="bor_bottom01"><%=pageBean.getTotalRecord()-i%></td>
						<td class="bor_bottom01"><%=info.getId()%></td>
						<td class="bor_bottom01"><%=info.getName()%></td>
						<td class="bor_bottom01"><%=String.valueOf(info.getJoin_date()).length()>10?String.valueOf(info.getJoin_date()).substring(0,10):String.valueOf(info.getJoin_date())%></td>
					<%--	<td class="bor_bottom01"><%=info.getLogin_count()%></td> --%>
					<%--	
						<td class="bor_bottom01">
							<select id="f_level<%=i%>" name="f_level" class="sec01" style="width:85px;" onChange="return change_level(this, '<%=info.getId()%>','<%=info.getLevel()%>')">
								<option value='1' <%if(info.getLevel() == 1){out.println("selected");}%>>일반회원</option>
								<option value='9' <%if(info.getLevel() == 9 ){out.println("selected");}%>>관리자</option> 

							</select>
						</td> --%>
<!--						<td class="bor_bottom01">-->
<!--							<select name="f_approval" class="sec01" style="width:90px;" onChange="return change_approval(this, '<%=info.getId()%>')">-->
<!--								<option value='Y' <%=(info.getApproval().equals("Y")) ? "selected" : ""%>>정회원</option>-->
<!--								<option value='N' <%=(info.getApproval().equals("N")) ? "selected" : ""%>>대기회원</option>-->
<!--							</select>-->
<!--						</td>-->
						<td class="bor_bottom01"><a href="frm_memberUpdate_new.jsp?mcode=<%=mcode%>&id=<%=info.getId()%><%=strLink%>" title="수정"><img src="/vodman/include/images/but_edit.gif" alt="수정"/></a>&nbsp;<a href="proc_memberDel.jsp?mcode=<%=mcode%>&id=<%=info.getId()%><%=strLink%>" title="삭제"  onClick="return confirm('정말 삭제하시겠습니까?')"><img src="/vodman/include/images/but_del.gif" alt="삭제"/></a></td>
					</tr>

					<%
								}
							} else {
					%>
					<tr class="height_25 font_127">
						<td class="bor_bottom01" colspan='6'> 등록된 정보가 없습니다.</td>
					
					</tr>
					<% }%>
					
				</tbody>
				</table>
				<%
				if(vt != null && vt.size()>0){
				String jspName = "mng_memberList.jsp";
				%>
				 <%@ include file="page_link.jsp" %>
				 <%}%>
				<br/><br/>
			</div>
		</div>	
<%@ include file="/vodman/include/footer.jsp"%>