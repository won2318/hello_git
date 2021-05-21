<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.hrlee.sqlbean.*, com.vodcaster.sqlbean.*, com.yundara.util.*"%>
<%@ include file = "/vodman/include/auth.jsp"%>

<%
if(!chk_auth(vod_id, vod_level, "b_list")) {
    out.println("<script language='javascript'>\n" +
                "alert('ȸ�������� ������ �ֽ��ϴ�. ������������ �̵��մϴ�.');\n" +
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
			ans=confirm('�����Ͻðڽ��ϱ�? �����Ͻ� �Խ����� �Խù� ��ü�� �����˴ϴ�.')
		if (ans==true){
			//document.location='proc_boardDelete.jsp?board_id='+id+"&mcode=<%=mcode%>";
			document.boardList.board_id.value = id;
			document.boardList.action = "proc_boardDelete.jsp?board_id="+id+"&mcode=<%=mcode%>";
			document.boardList.submit();
		}
		return
	}
</script>
		<!-- ������ -->
		<div id="contents">
			<h3><span>�Խ���</span> ����</h3>
			<p class="location">������������ &gt; �Խ��ǰ��� &gt; <span>�Խ��� ����</span></p>
			<div id="content">
				<!-- ���� -->
				<p class="to_page">Total<b><%=v_list!= null&& v_list.size()>0?v_list.size():0%></b></p>
				<table cellspacing="0" class="board_list" summary="�Խ��� ����">
				<caption>�Խ��� ����</caption>
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
						<th>��ȣ</th>
						<th>����</th>
						<th>�켱����</th>
						<th>�Խù���</th>
						<th>������</th>
						<th>����</th>
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
						<td class="bor_bottom01"><a href="frm_boardUpdate.jsp?board_id=<%=board_id%>&mcode=0901" title="����"><img src="/vodman/include/images/but_edit.gif" alt="����"/></a>&nbsp;<a href="javascript:boardDelete(<%=board_id%>);" title="����"><img src="/vodman/include/images/but_del.gif" alt="����"/></a></td>
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
                                        <td colspan="6" align=center class="bor_bottom01">������ �Խ�����  �����ϴ�.</td>
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