<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "b_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('회원레벨에 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}


%>
<jsp:useBean id="BoardInfoSQLBean" class="com.vodcaster.sqlbean.BoardInfoSQLBean"/>

<%
	Vector v_list = null;

	try{
		v_list = BoardInfoSQLBean.getAllBoardInfoList();
	}catch(ArrayIndexOutOfBoundsException e){
		System.out.println("No search Data");
	}
%>
<%@ include file="/vodman/include/top.jsp"%>

<%@ include file="/vodman/board/board_left.jsp"%>
<script language='javascript'>
	function boardDelete(id){
			ans=confirm('삭제하시겠습니까? 선택하신 게시판의 게시물 전체가 삭제됩니다.')
		if (ans==true){
			//document.location='proc_boardDelete.jsp?board_id='+id+"&mcode=<%=mcode%>";
			document.boardList.board_id.value = id;
			document.boardList.action = "proc_boardDelete.jsp?board_id="+id+"&mcode=<%=mcode%>";
			document.boardList.submit();
		}
		return
	}
</script>
		<!-- 컨텐츠 -->
		<div id="contents">
			<h3><span>게시판</span> 정보</h3>
			<p class="location">관리자페이지 &gt; 게시판관리 &gt; <span>게시판 정보</span></p>
			<div id="content">
				<!-- 내용 -->
				<p class="to_page">Total<b><%=v_list!= null&& v_list.size()>0?v_list.size():0%></b></p>
				<table cellspacing="0" class="board_list" summary="게시판 정보">
				<caption>게시판 정보</caption>
				<colgroup>
					<col width="7%"/>
					<col/>
					<col width="7%"/>
					<col width="7%"/>
					<col width="9%"/> 
					<col width="12%"/>
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>우선순위</th>
						<th>게시물수</th>
						<th>생성일</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
				 <!-- list start -->
                             <%	if(v_list !=null && v_list.size()>0){
										int board_id = 0;
										String title = "";
										String priority = "";
										String date = "";
										String count_board = "";
										int count = v_list.size();
										int b_count = 0;
										int iLeftMenuCnt2 = 1;
																
										try{
											for(int i=0; i < v_list.size(); i++){
												try{
													board_id = Integer.parseInt(String.valueOf(((Vector)(v_list.elementAt(i))).elementAt(0)));
												}catch(Exception e){
													board_id = 0;
												}
												board_id = Integer.parseInt(String.valueOf(((Vector)(v_list.elementAt(i))).elementAt(0)));
												title = String.valueOf(((Vector)(v_list.elementAt(i))).elementAt(1));
												priority = String.valueOf(((Vector)(v_list.elementAt(i))).elementAt(2));
												date = String.valueOf(((Vector)(v_list.elementAt(i))).elementAt(3));
												if(date != null && date.length()>10){
													date = date.substring(0,10);
												}
												
												count_board = String.valueOf(((Vector)(v_list.elementAt(i))).elementAt(4));
												if(count_board.equals("null") || count_board.equals("-1") ) count_board = "0";
												try{
													b_count = Integer.parseInt(count_board);
												}catch(Exception e){
													b_count = 0;
												}
												iLeftMenuCnt2 ++;
								%>
					<tr class="height_25 font_127">
						<td class="bor_bottom01"><%=count%></td>
						<td class="align_left bor_bottom01"><a href="mng_boardListList.jsp?board_id=<%=board_id%>&mcode=09<%=iLeftMenuCnt2 <=9?"0"+iLeftMenuCnt2:iLeftMenuCnt2%>" title="<%=title%>"><%=title%></a></td>
						<td class="bor_bottom01"><%=priority%></td>
						<td class="bor_bottom01"><%=count_board%></td>
						<td class="bor_bottom01"><%=date%></td>
						<td class="bor_bottom01"><a href="frm_boardUpdate.jsp?board_id=<%=board_id%>&mcode=0901" title="수정"><img src="/vodman/include/images/but_edit.gif" alt="수정"/></a>&nbsp;<a href="javascript:boardDelete(<%=board_id%>);" title="삭제"><img src="/vodman/include/images/but_del.gif" alt="삭제"/></a></td>
					</tr>
										 <%
												count--;
											}//end for
										}catch(Exception e){
											System.out.println(e);
										}
									}else{
								%>
                                      <tr  class="height_25 font_127"> 
                                        <td colspan="6" align=center class="bor_bottom01">생성된 게시판이  없습니다.</td>
                                      </tr>
                                  <%}%>
				</tbody>
				</table>
				
				<br/><br/>
			</div>
		</div>	
		<form name="boardList">
				<input type="hidden" name="board_id" value="">
				<input type="hidden" name="mcode" value="<%=mcode%>">
				</form>
	<%@ include file="/vodman/include/footer.jsp"%>