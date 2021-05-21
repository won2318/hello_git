<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*,  com.vodcaster.sqlbean.*,com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "cate_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>
<%
	/**
	 * @author 박종성
	 *
	 * @description :메뉴의 전체정보를 보여줌.
	 * date : 2009-10-19
	*/

	String strTitle = "";
	int num = 1;

	

	MenuManager mgr = MenuManager.getInstance();
	Vector vt = mgr.getMenuListALL2("A");
	
%>

<%@ include file="/vodman/include/top.jsp"%>
<%mcode="0301"; %>
<%@ include file="/vodman/menu/menu_left.jsp"%>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>메뉴</span> 목록</h3>
			<p class="location">관리자페이지 &gt; 메뉴관리 &gt; <span>메뉴 목록</span></p>
			<div id="content">
				
				<table cellspacing="0" class="menu_list" summary="메뉴 목록">
				<caption>메뉴 목록</caption>
				<colgroup>
					<col width="19%"/>
					<col class="back_f7" width="19%"/>
					<col width="19%"/>
					<col class="back_f7" width="19%" />
					<col/>
					<col class="back_f7" width="9%"/>
					<col/>
				</colgroup>
				<thead>
					<tr>
						<th>1단메뉴</th>
						<th>2단메뉴</th>
						<th>3단메뉴</th>
						<th>4단메뉴</th>
						<th>순서</th>
						<th>접근권한</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
<%
	MenuInfoBean info = new MenuInfoBean();

	for(Enumeration e = vt.elements(); e.hasMoreElements();) {
		com.yundara.beans.BeanUtils.fill(info, (Hashtable)e.nextElement());
%>
					<tr>
						<td class="bor_bottom01 align_left"><b><%=info.getMtitle()%></b><br/><%=info.getMcode()%></td>
						<td class="bor_bottom01 align_left">&nbsp;</td>
						<td class="bor_bottom01 align_left">&nbsp;</td>
						<td class="bor_bottom01 align_left">&nbsp;</td>
						<td class="bor_bottom01"><%=info.getMorder()%></td>
						<td class="bor_bottom01"><%=info.getMlevel()%></td>
						<td class="bor_bottom01"><a href="frm_menuUpdate.jsp?muid=<%=info.getMuid()%>" title="수정"><img src="/vodman/include/images/but_edit.gif" alt="수정"/></a>&nbsp;<a href="proc_menuDel.jsp?muid=<%=info.getMuid()%>" onClick="return confirm('정말 삭제하시겠습니까?')" title="삭제"><img src="/vodman/include/images/but_del.gif" alt="삭제"/></a></td>
					</tr>
<%
		Vector vtB = mgr.getMenuListALL2("B",info.getMcode());

		for (Enumeration eb = vtB.elements(); eb.hasMoreElements();){
			com.yundara.beans.BeanUtils.fill(info, (Hashtable)eb.nextElement());
%>
					<tr>
						<td class="bor_bottom01 align_left">&nbsp;</td>
						<td class="bor_bottom01 align_left"><b><%=info.getMtitle()%></b><br/><%=info.getMcode()%></td>
						<td class="bor_bottom01 align_left">&nbsp;</td>
						<td class="bor_bottom01 align_left">&nbsp;</td>
						<td class="bor_bottom01"><%=info.getMorder()%></td>
						<td class="bor_bottom01"><%=info.getMlevel()%></td>
						<td class="bor_bottom01"><a href="frm_menuUpdate.jsp?muid=<%=info.getMuid()%>" title="수정"><img src="/vodman/include/images/but_edit.gif" alt="수정"/></a>&nbsp;<a href="proc_menuDel.jsp?muid=<%=info.getMuid()%>" onClick="return confirm('정말 삭제하시겠습니까?')" title="삭제"><img src="/vodman/include/images/but_del.gif" alt="삭제"/></a></td>
					</tr>
<%

			Vector vtC = mgr.getMenuListALL2("C",info.getMcode());
			for (Enumeration ec = vtC.elements(); ec.hasMoreElements();){
				com.yundara.beans.BeanUtils.fill(info, (Hashtable)ec.nextElement());
%>
					<tr>
						<td class="bor_bottom01 align_left">&nbsp;</td>
						<td class="bor_bottom01 align_left">&nbsp;</td>
						<td class="bor_bottom01 align_left"><b><%=info.getMtitle()%></b><br/><%=info.getMcode()%></td>
						<td class="bor_bottom01 align_left">&nbsp;</td>
						<td class="bor_bottom01"><%=info.getMorder()%></td>
						<td class="bor_bottom01"><%=info.getMlevel()%></td>
						<td class="bor_bottom01"><a href="frm_menuUpdate.jsp?muid=<%=info.getMuid()%>" title="수정"><img src="/vodman/include/images/but_edit.gif" alt="수정"/></a>&nbsp;<a href="proc_menuDel.jsp?muid=<%=info.getMuid()%>" onClick="return confirm('정말 삭제하시겠습니까?')" title="삭제"><img src="/vodman/include/images/but_del.gif" alt="삭제"/></a></td>
					</tr>
<%
				Vector vtD = mgr.getMenuListALL2("D",info.getMcode());
				for (Enumeration ed = vtD.elements(); ed.hasMoreElements();){
					com.yundara.beans.BeanUtils.fill(info, (Hashtable)ed.nextElement());
%>
					<tr>
						<td class="bor_bottom01 align_left">&nbsp;</td>
						<td class="bor_bottom01 align_left">&nbsp;</td>
						<td class="bor_bottom01 align_left">&nbsp;</td>
						<td class="bor_bottom01 align_left"><b><%=info.getMtitle()%></b><br/><%=info.getMcode()%></td>
						<td class="bor_bottom01"><%=info.getMorder()%></td>
						<td class="bor_bottom01"><%=info.getMlevel()%></td>
						<td class="bor_bottom01"><a href="frm_menuUpdate.jsp?muid=<%=info.getMuid()%>" title="수정"><img src="/vodman/include/images/but_edit.gif" alt="수정"/></a>&nbsp;<a href="proc_menuDel.jsp?muid=<%=info.getMuid()%>" onClick="return confirm('정말 삭제하시겠습니까?')" title="삭제"><img src="/vodman/include/images/but_del.gif" alt="삭제"/></a></td>
					</tr>
<%
				}
			}
		}
	}
%>
				</tbody>
				</table>
				<br/><br/>
			</div>
		</div>
<%@ include file="/vodman/include/footer.jsp"%>